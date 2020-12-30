# cycleGAN
- [paper](https://arxiv.org/abs/1703.10593)
- [source code](https://github.com/junyanz/pytorch-CycleGAN-and-pix2pix)


## 参考
- [Understanding and Implementing CycleGAN in TensorFlow](https://hardikbansal.github.io/CycleGANBlog/)

## 循环一致性(Cycle-Consistency)

在CycleGAN中， 没有配对数据的情况下实现两个 domain 的 Image-to-Image Translation。
假设一张$X_domain$的图片$x$  翻译到 $Y_domain$  得到图片$F(x)$  ，再从$Y_domain$ 翻译回$X_domain$ 得到 $G(F(x))$ ，类似地有图片$y$  和$F(G(y))$  ；那么$x$ 和$G(F(x))$  ，$y$  和 $F(G(x))$  应该是一模一样的。它们之间的差异就可以作为一个监督信号：

![](https://www.zhihu.com/equation?tex=%5Cmathcal%7BL%7D_%7B%5Ctext%7Bcyc%7D%7D%3D%5Cmathbb%7BE%7D_%7Bx+%5Csim+p_%5Ctext%7Bdata%7D%28x%29%7D%5B%5Cleft%5C%7C+G%28F%28x%29%29-x+%5Cright%5C%7C%5D+%2B+%5Cmathbb%7BE%7D_%7By+%5Csim+p_%5Ctext%7Bdata%7D%28y%29%7D%5B%5Cleft%5C%7C+F%28G%28y%29%29-y+%5Cright%5C%7C%5D)

单独的对抗损失并不能保证能将$x_i$ 映射到 $y_i$  Cycle Loss可以进一步减少映射函数的空间。

 ## 网络结构
 ![](https://hardikbansal.github.io/CycleGANBlog/images/model.jpg)
 ![](https://hardikbansal.github.io/CycleGANBlog/images/model1.jpg)

 ## Generator 
 ![](https://hardikbansal.github.io/CycleGANBlog/images/Generator.jpg)

## Disciminator 
![](https://hardikbansal.github.io/CycleGANBlog/images/discriminator.jpg)

