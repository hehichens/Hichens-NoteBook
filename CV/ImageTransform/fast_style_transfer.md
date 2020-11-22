- [论文](https://arxiv.org/pdf/1603.08155.pdf)

- [论文读后感](https://blog.csdn.net/kid_14_12/article/details/85871965)
- [源码地址](https://github.com/abhiskk/fast-neural-style)



# 内容摘要

## 1. 网络结构

![](https://img-blog.csdnimg.cn/20190106195709967.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2tpZF8xNF8xMg==,size_16,color_FFFFFF,t_70)

## 2. Perceptual Loss 函数

- **特征重建loss**:尽可能地生成与原图像相似的特征表示
$$
  \varphi_j 是第j层网络激活层
$$


![](https://img-blog.csdnimg.cn/20190114155713692.png)

- **风格重建loss**

定义Gram 矩阵：

![](https://img-blog.csdnimg.cn/2019011416444720.png)

风格重建loss等于输出与目标破图像的Gram矩阵的差值的F范数的平方

![](https://img-blog.csdnimg.cn/2019011416564820.png)

# 源代码笔记

## 1. 求Gram矩阵

```python 
def gram_matrix(y):
    (b, ch, h, w) = y.size() # batch_size, channels, height, width
    features = y.view(b, ch, w * h)
    features_t = features.transpose(1, 2)
    gram = features.bmm(features_t) / (ch * h * w)
    return gram
```

## 2.各种归一化

[参考](https://blog.csdn.net/liuxiao214/article/details/81037416)

- batchNorm是在batch上，对NHW做归一化，对小batchsize效果不好；
- layerNorm在通道方向上，对CHW归一化，主要对**RNN**作用明显；
- instanceNorm在图像像素上，对HW做归一化，用在**风格化迁移**；
- GroupNorm将channel分组，然后再做归一化；
- SwitchableNorm是将BN、LN、IN结合，赋予权重，让网络自己去学习归一化层应该使用什么方法。

## 3. Upsample ConvLayer:

[参考](https://distill.pub/2016/deconv-checkerboard/)

```python
class UpsampleConvLayer(torch.nn.Module):
    def __init__(self, in_channels, out_channels, kernel_size, stride, upsample=None):
        super(UpsampleConvLayer, self).__init__()
        self.upsample = upsample
        reflection_padding = kernel_size // 2
        self.reflection_pad = torch.nn.ReflectionPad2d(reflection_padding)
        self.conv2d = torch.nn.Conv2d(in_channels, out_channels, kernel_size, stride)

    def forward(self, x):
        x_in = x
        if self.upsample:
            x_in = torch.nn.functional.interpolate(x_in, mode='nearest', scale_factor=self.upsample)
        out = self.reflection_pad(x_in)
        out = self.conv2d(out)
        return out
```

