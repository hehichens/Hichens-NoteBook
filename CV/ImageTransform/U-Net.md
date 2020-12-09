# U-Net

- [paper](https://arxiv.org/abs/1505.04597)
- [U-Net Pytorch](https://github.com/milesial/Pytorch-UNet)

参考：

- [图像分割之U-Net](https://zhuanlan.zhihu.com/p/43927696)



U-Net是比较早的使用全卷积网络进行语义分割的算法之一，论文中使用包含压缩路径和扩展路径的对称U形结构在当时非常具有创新性，且一定程度上影响了后面若干个分割网络的设计，该网络的名字也是取自其U形形状。





## 内容

### 网络结构



![](https://lmb.informatik.uni-freiburg.de/people/ronneber/u-net/u-net-architecture.png)

如图1中所示，网络的输入图片的尺寸是 ![[公式]](https://www.zhihu.com/equation?tex=572%5Ctimes572) ，而输出Feature Map的尺寸是 ![[公式]](https://www.zhihu.com/equation?tex=388%5Ctimes388) ，这两个图像的大小是不同的，无法直接计算损失函数