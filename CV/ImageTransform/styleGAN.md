# styleGAN

- [paper](https://arxiv.org/abs/1812.04948)
- [code](https://github.com/rosinality/style-based-gan-pytorch)

参考：

- [styleGAN理解](https://zhuanlan.zhihu.com/p/54995816)
- [论文阅读-styleGAN](https://zhuanlan.zhihu.com/p/62119852)
- [Explained:GAN](https://towardsdatascience.com/explained-a-style-based-generator-architecture-for-gans-generating-and-tuning-realistic-6cb2be0f431)

StyleGAN基于proGAN， 重点关注生成器网络。它不仅可以生成高质量的和逼真的图像，而且还可以对生成的图像进行较好的控制和理解，甚至使生成可信度较高的假图像变得比以前更加的容易。在StyleGAN中提出的一些技术，特别是映射网络和自适应实例标准化（AdaIN），可能是未来许多在GAN方面创新的基础。

- ProGAN overview

![](https://miro.medium.com/max/875/0*UhDrzVxA5pKhxYaP.png)

- StyleGAN overview

![](https://miro.medium.com/max/626/0*KRsNSyVZSb5qAPVu.png)



## 概念

### latent code 

lantent code 这个概念来自**infoGAN** ， GAN通过generator和discriminator的对抗学习， 最终得到与real data分布一致的fake data， 但generator产生的z是一个连续信号，无任何约束，使得GAN无法利用z， z不是一个可解释的表示（interpretable representation）， **infoGAN**利用z， 寻找一个可解释的表达，它将z拆解为：1. 不可拆解的噪声z， 2.可解释的隐变量c（称为latent code）。我们希望可以通过约束c与生成数据的关系，使得c中包含对数据的可解释信息。

例如，MINIST数据中，c可以分为：

- categorical latent code： 数字种类信息（1-9）
- continuous latent code： 数字特征， 倾斜度、笔画粗细等。



#### more about GAN:[七种常见的GAN](https://blog.csdn.net/qq_39521554/article/details/84675582)



### 特征

本文将特征分为三类：

- 粗糙的：影响姿势、一般发型、面部形状等
- 中等的：影响更精细的面部特征、发型、眼睛的睁开或是闭合等
- 高质的：影响颜色方案（眼睛、头发和皮肤）和微观特征



### 映射网络

- 映射网络的目标：将输入向量编码为中间向量，中间向量的不同元素控制不同的视觉特征。（仅仅使用输入向量来控制视觉特征的能力是有限的）

- 特征纠缠：模型无法将部分输入映射到特征上
- 映射网络结构：8个全连接层，输出输入均为512.

通过使用映射网络， 该模型生成了一个**不必遵循训练数据分布的向量**，并且**可以减少特征之间的相关性**。



![](https://miro.medium.com/max/875/0*6lEwRXKiA8WGRlEc.png)

### 样式模块（AdaIN）

[AdaIN](https://arxiv.org/abs/1703.06868)（自适应实例标准化）模块将映射网络编码的信息传送到生成图像中。该模块被添加到合成网络的**每个分辨率级别中**，并定义该级别中特征的可视化表达式：

1. 卷积层的输出先进行标准化，确保3的缩放和切换有效果；
2. 中间向量w使用另一个全连接的网络层（A）**转换每个通道的比例和偏差**；
3. 比例和偏差的向量切换卷积输出的每个通道，从而定义每个卷积的重要性



![](https://miro.medium.com/max/875/0*uqn4slMHrFYkFmjS.png)

### 输入

大多数模型使用随机输入来创建生成器的初始图像。**StyleGAN团队发现图像特征是由ⱳ和AdaIN控制的，因此可以忽略初始输入，并用常量值替代。**（假设是它减少了特征纠缠）



![](https://miro.medium.com/max/553/0*8TIREj1JVUT_IF4W.png)



### 随机变化（Stochastic variation）

人们的脸上有许多小的特征，可以看作是随机的，例如：雀斑、发髻线的准确位置、皱纹、使图像更逼真的特征以及各种增加输出的变化。**将这些小特征插入GAN图像的常用方法是在输入向量中添加随机噪声。**



StyleGAN中的噪声以类似于AdaIN机制的方式添加，在AdaIN模块之前向每个通道添加一个**缩放过的噪声**，并稍微**改变其操作的分辨率级别**特征的视觉表达方式。

![](https://miro.medium.com/max/875/1*GwchALioRMC1xlj7Bh0ZMg.png)

### 样式混合

StyleGAN生成器在合成网络的每个级别中使用了中间向量，这有可能导致网络学习到这些级别是相关的。为了降低相关性，**模型随机选择两个输入向量**，并为它们生成了中间向量w。然后它用第一个输入向量来训练网络级别，然后在一个随机点切换输入网络来训练其余的级别。以此来消除网络级别之间的相关性。



### 特征分离

本文提出了两种新的特征分离的测量方法:

1. 感知路径长度（perceptual path length ）：当在两个随机输入之间插入时，测量两个连续图像（它们的VGG16嵌入）之间的差异。剧烈的变化意味着多个特性已经同时改变了，它们有可能会被纠缠；
2. 线性可分离性（linear separability）：是将输入按照二进制类进行分类的能力，如男性和女性。分类越好，特征就越容易区分。



### W的截取

为了避免生成较差的图像，StyleGAN截断了中间向量W，迫使它保持接近“平均”的中间向量。



### An overview of StyleGAN

![](https://miro.medium.com/max/875/0*ANwSHXJDmwqjNSxi.png)

