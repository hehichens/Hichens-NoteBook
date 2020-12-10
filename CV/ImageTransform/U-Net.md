# U-Net

- [paper](https://arxiv.org/abs/1505.04597)
- [U-Net Pytorch](https://github.com/milesial/Pytorch-UNet)

参考：

- [图像分割之U-Net](https://zhuanlan.zhihu.com/p/43927696)



U-Net是比较早的使用全卷积网络进行语义分割的算法之一，论文中使用包含压缩路径和扩展路径的对称U形结构在当时非常具有创新性，且一定程度上影响了后面若干个分割网络的设计，该网络的名字也是取自其U形形状。





## 内容

### 网络结构

- 输入：![[公式]](https://www.zhihu.com/equation?tex=572%5Ctimes572) 的边缘经过**镜像操作**的图片
- 左侧为压缩路径（contracting path）：4个block组成，每个block使用了3个有效卷积和1个Max Pooling降采样，每次降采样之后Feature Map的个数乘2。最终得到了尺寸为 ![[公式]](https://www.zhihu.com/equation?tex=32%5Ctimes32) 的Feature Map。
- 右侧为扩展路径（expansive path）：4个block组成，个block开始之前通过反卷积将Feature Map的尺寸乘2，同时将其个数减半（最后一层稍微不同），然后和左侧对称的压缩路径的Feature Map合并。由于左右尺寸不一样， U-Net是通过将**压缩路径的Feature Map裁剪到和扩展路径相同尺寸的Feature Map**进行归一化的。最终得到的Feature Map的尺寸是 ![[公式]](https://www.zhihu.com/equation?tex=388%5Ctimes388)。
- 由于该任务是一个二分类任务，所以网络有两个输出Feature Map。

![](https://lmb.informatik.uni-freiburg.de/people/ronneber/u-net/u-net-architecture.png)

如图中所示，网络的输入图片的尺寸是 ![[公式]](https://www.zhihu.com/equation?tex=572%5Ctimes572) ，而输出Feature Map的尺寸是 ![[公式]](https://www.zhihu.com/equation?tex=388%5Ctimes388) ，这两个图像的大小是不同的，无法直接计算损失函数



### 输入

- 原始图像的尺寸： ![[公式]](https://www.zhihu.com/equation?tex=512%5Ctimes512)
- 镜像操作（Overlay-tile Strategy）：为了更好的处理图像的边界像素。镜像操作即是**给输入图像加入一个对称的边**。

![](https://img-blog.csdn.net/20181003233611327?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2R1Z3VkYWlibw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

如果我们要预测黄色框内区域（即对黄色的内的细胞进行分割，获取它们的边缘），需要将蓝色框内部分作为输入。缺失的数据使用镜像进行补充。因为进行的是 valid 卷积（即上文讲的只取有效部分，可以理解为 0 padding），所以**需要取比黄色框大的图像来保证上下文的信息**是有意义的，缺失的部分用镜像的方法补充是填充上下文信息最好的方法了



### 损失函数

U-Net使用的是带边界权值的损失函数：

![[公式]](https://www.zhihu.com/equation?tex=E+%3D+%5Csum_%7B%5Cmathbf%7Bx%7D%5Cin+%5COmega%7D+w%28%5Cmathbf%7Bx%7D%29+%5Ctext%7Blog%7D%28p_%7B%5Cell%28%5Cmathbf%7Bx%7D%29%7D%28%5Cmathbf%7Bx%7D%29%29+%5Ctag%7B2%7D)

其中 ![[公式]](https://www.zhihu.com/equation?tex=p_%7B%5Cell%28%5Cmathbf%7Bx%7D%29%7D%28%5Cmathbf%7Bx%7D%29) 是$softmax$损失函数， ![[公式]](https://www.zhihu.com/equation?tex=%5Cell%3A+%5COmega+%5Crightarrow+%5C%7B1%2C...%2CK%5C%7D) 是像素点的标签值， ![[公式]](https://www.zhihu.com/equation?tex=w%3A+%5COmega+%5Cin+%5Cmathbb%7BR%7D) 是像素点的权值，目的是为了给图像中贴近边界点的像素更高的权值。

![[公式]](https://www.zhihu.com/equation?tex=w%28%5Cmathbf%7Bx%7D%29+%3D+w_c%28%5Cmathbf%7Bx%7D%29+%2B+w_0+%5Ccdot+%5Ctext%7Bexp%7D%28-%5Cfrac%7B%28d_1%28%5Cmathbf%7Bx%7D%29%2B+d_2%28%5Cmathbf%7Bx%7D%29%29%5E2%7D%7B2%5Csigma%5E2%7D%29+%5Ctag%7B3%7D)

其中 ![[公式]](https://www.zhihu.com/equation?tex=w_c%3A+%5COmega+%5Cin+%5Cmathbb%7BR%7D) 是平衡类别比例的权值， ![[公式]](https://www.zhihu.com/equation?tex=d_1%3A+%5COmega+%5Cin+%5Cmathbb%7BR%7D) 是像素点到距离其最近的细胞的距离， ![[公式]](https://www.zhihu.com/equation?tex=d_2%3A+%5COmega+%5Cin+%5Cmathbb%7BR%7D) 则是像素点到距离其第二近的细胞的距离。 ![[公式]](https://www.zhihu.com/equation?tex=w_0) 和 ![[公式]](https://www.zhihu.com/equation?tex=%5Csigma) 是常数值，在实验中 ![[公式]](https://www.zhihu.com/equation?tex=w_0+%3D+10) ， ![[公式]](https://www.zhihu.com/equation?tex=%5Csigma%5Capprox+5) 。

 

### 数据扩充

作者指出任意的弹性形变对训练非常有帮助。

显微图像一般需要旋转平移不变性，弹性形变和灰度值变化鲁棒性。训练样本的随机弹性形变似乎是训练之后少量标注图像的分割网络的关键。

此外在收缩路径的最后加入了 Drop-out，隐式地加强了数据增强。