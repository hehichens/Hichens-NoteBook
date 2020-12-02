# pix2pix
- [paper](https://arxiv.org/abs/1611.07004)
- [source code](https://github.com/junyanz/pytorch-CycleGAN-and-pix2pix)

## 参考
- [Pix2Pix GAN](
    https://medium.com/@yaoyaowd/%E8%AF%BB%E8%AE%BA%E6%96%87%E4%B9%9F%E8%AF%BB%E4%BB%A3%E7%A0%81-cycle-gan%E4%B8%8Epix2pix-gan-24e36fce71ed)

## 网络整体结构
Pix2Pix的模型框架与cGAN类似，判别网络的输入是将两张图片组合到一起的pair，输入就从rgb的三通道图像变成了6通道两个图像的叠加图.
![](https://miro.medium.com/max/640/0*mviygBs40SvA2xZM.)


## U-Net 
- 作者引入了L1 Loss帮助减少误差，L1 Loss能够很大程度上减少图像的模糊度，这点比L2 Loss要做的好.
- 作者在Pix2Pix的生成网络中引入了U-Net这个概念。因为在图像翻译的任务当中，输入图片和输出图片会共享很多信息。
如果只是使用卷积神经网络，那么每一层都要保存非常多的信息，变得难以训练。作者使用了skip-connection，将原图不同的卷积层合并到生成图不同的卷积层上，帮助扩充信息，从而减轻训练负担。
- U-Net的思想和Residual Network的思想非常类似，都是借用之前的信息来帮助训练的一种办法。
- 引入了patch

![](https://www.researchgate.net/profile/Alan_Jackson9/publication/323597886/figure/fig2/AS:601386504957959@1520393124691/Convolutional-neural-network-CNN-architecture-based-on-UNET-Ronneberger-et-al.png)