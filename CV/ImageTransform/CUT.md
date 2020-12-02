# CUT
[contrastive-unpaired-translation](https://github.com/taesungp/contrastive-unpaired-translation)

## 功能

- horse<->zebra
- cat <->grumpy cat
- painting<->photo（`monet2photo`, `vangogh2photo`, `ukiyoe2photo`, `cezanne2photo`）
- summer<->winter
- apple<->orange





## expriment 
- man<->woman 
- young<->old



## 论文笔记
[参考](https://blog.csdn.net/kingsleyluoxin/article/details/107828908)



# 知识点
## 对抗损失（DAN Loss）
[](https://neptune.ai/blog/gan-loss-functions)
### min-max loss
$$
E_x[log(D(x))] + E_z[log(1 - D(G(z)))]
$$
Generator试图最小化该函数， Discriminator试图最大化该函数

### Discriminator Loss
Discriminator 对真实数据（real data）和生成的（fake data）进行分类, 通过最大化如下函数实现：
![](https://lh4.googleusercontent.com/yAT4vN1GFT8D0QUDMAReZS0BLD_vi7KZc-AE02RFWI9ZVSQHLqKTTthtgx_BK-DlKOeFDgtkA3byl9VMHPEI0r5ZTn1nKYLbeEflJuspuykXcNMOmEmXomWZzMwdzUBbxf-BlkjJ)
- $log(D(x))$ 真实数据的正确分类
- $log(1 - D(G(z)))$ 将来自生成器的假数据正确分类

### Generator Loss
Generator 从随机噪声生成结果来欺骗Discriminator， 因此，如果Generator欺骗了Discriminator则得到奖励，反之则被惩罚。通过最小化如下函数实现：
![](https://lh6.googleusercontent.com/HELs4L-7j4GKYHus3PNWUuWxd5MhoOiY1Gp0MDB71QHi4_2WueJZYApJE2Emsk6SHEdgSTjd0f_ey9OcYAOY2mfMsQb5m37zHrypxml46_6i510NPKVPxUyfEAdRHuCatnfmeNe_)



## 对比学习(Contrastive Learning)
[链接](https://zhuanlan.zhihu.com/p/141172794)
### 自监督学习
直接使用数据本身来提供监督信息来指导学习

- Generative Methods（生成式方法）：以自编码器为代表，主要关注 pixel label 的 loss
- Contrastive Methods（对比式方法）：通过将数据分别与正例样本和负例样本在特征空间进行对比
egg:画一张美元，根据印象画出来的和对照着美元画出来的结果中，前者虽然不够详细， 但是能够辨识，所以识别美元只需要一些关键特征就可以了。
**相比起 Generative Methods 需要对像素细节进行重构来学习到样本特征，Contrastive Methods 只需要在特征空间上学习到区分性**

![](https://pic2.zhimg.com/v2-1ea66426d44cf9a71ba6917e56076ad9_r.jpg)

### 对比学习一般范式
对任意数据  ，对比学习的目标是学习一个编码器$f$使得
$$
score(f(x), f(x^+)) >> score(f(x), f(x^-)）
$$
其中$x^+$  是和 $x$ 相似的正样本，$x^-$  是和 $x$ 不相似的负样本，score 是一个度量函数来衡量样本间的相似度



## UNIT
- [link](https://zhuanlan.zhihu.com/p/52583263)
- [source code](https://github.com/NVlabs/MUNIT)
latent space 为假设，并在 Coupled GAN 的基础上提出 Unsupervised image-to-image translation 的新的 framework。
两个 domain 间的转化其实是两个 domain 的联合分布$P_{X1, x2}(x_1, x_2)$, 我们需要用已知的 domain 的边缘分布$P_{X1, x2}(x_1, x_2)$推导这个联合分布。由于两个 domain 间有无数个联合分布，因此从边缘分布推导联合分布其实是个病态的过程。解决这问题需要增加更多的假设，本文就假设输入到生成器的 latent code 是共享的。
![](https://pic1.zhimg.com/v2-32de461cd96b8ff13d3e33709e17b224_b.jpg)
假设这两个 domain 共享同一个 latent code。为了保证两个 domain 中的图像来自于同一个 latent code， 需要加一个编码器。生成器的作用是把 latent code 变成图像，那编码器的作用就是把图像还原成 latent code。
共享 latent code 其实就是：
$$
E_1(x_1) = E_2(x_2)
$$
网络架构和VAE损失参考原文。


## MUNIT
- [link](https://zhuanlan.zhihu.com/p/52583263)
- [source code](https://github.com/NVlabs/MUNIT)
把 unsupervised image to image translation 看成图像求联合概率分布，但重点解决多对多的问题。
本文在 UNIT 提出的共享 latent code 的基础上进一步假设 latent code = content code + style code。然后不同 domain 的图像共享 content code 独享 style code。此外， image translation 是多对多的，也就是一张图片对应不同风格的转换图片。

在 UNIT 的基础上，MUNIT 认为：latent code 可以进一步细化为内容编码$c$  和风格编码$s$  。不同 domain 的图像共享内容编码空间$C$  而独享风格编码空间$S$。

内容的含义大概接近于图片中物体的一些 low level 的信息，比如朝向，边缘等。而风格则描述图片中物体的一些 high-level 的属性如颜色、纹理、样式等。

图像的风格编码应该属于一个高斯分布，图像的不同风格就是高斯分布的一些点。

![](https://pic4.zhimg.com/v2-39bc46e9c47ff1698132d49a24727f17_r.jpg)


















