# YOLOv1

## 1.1 输入输出

- 输入：(batch_size, channels, 448, 448)
- 输出：(S, S, (C+5*B)) # S:7; 

![](https://pic4.zhimg.com/80/v2-33df11dea3ad6ba31fccb709f26fc1d3_720w.jpg)

**30维向量： C + 5*B**

- 20个对象的概率：该网格位置存在任一种对象的概率
$$
P(C_i | Objects)
$$
-  2个bounding box的置信度：置信度 = 该bounding box内存在对象的概率 * 该bounding box与该对象实际bounding box的IOU

$$
Confidence = Pr(Objects) * IOU^{truth}_{pred}
$$

-  2个bounding box的位置:(c_x, c_y, w, h)

![](https://pic1.zhimg.com/80/v2-6c421d06d70a1906b12ca057dfa92d0c_720w.jpg)

## 1.2 损失函数

如图

![](https://pic4.zhimg.com/80/v2-b5dcfc68cab66010a12fb375fcc1ea5b_720w.jpg)

公式

![](https://pic1.zhimg.com/80/v2-e09d0d22173276a231c310d93617fc24_720w.jpg)

## 1.3 网络结构

![](https://www.maskaravivek.com/post/yolov1/featured_hu2959f475cef1ef9098f72ca1a1294bd8_186245_720x0_resize_lanczos_2.png)

YOLO的最后一层采用线性激活函数，其它层都是Leaky ReLU。训练中采用了drop out和数据增强（data augmentation）来防止过拟合。

## 1.4 NMS（非极大值抑制）



```python
# INPUT：所有预测出的bounding box (bbx)信息（坐标和置信度confidence），　IOU阈值（大于该阈值的bbx将被移除）
for object in all objects:
	(1) 获取当前目标类别下所有bbx的信息
	(2) 将bbx按照confidence从高到低排序,并记录当前confidence最大的bbx
	(3) 计算最大confidence对应的bbx与剩下所有的bbx的IOU,移除所有大于IOU阈值的bbx
	(4) 对剩下的bbx，循环执行(2)和(3)直到所有的bbx均满足要求（即不能再移除bbx）

```



## 1.5 关于使用YOLO

**文件目录**

- cfg
  - yolo.names # 保存对象名字
  - yolo.cfg # yolo 网络结构， 修改[yolo]前的filter和]yolo]中的classes
- data
  - yolo.data # 加载数据和配置文件
- datasets
  - 数据保存位置

 

参考 [link](https://github.com/ultralytics/yolov3/wiki/Train-Custom-Data)



## 1.6 关于数据

```python
# 自定义迭代器
class my_iter():
    def __init__(self, csv_path, batch_size=1):
        self.df = pd.read_csv(csv_path)
        self.batch_size = batch_size
        self.nF = len(self.df)
        self.nB = math.ceil(self.nF / batch_size)
        
    def __iter__(self):
        self.count = -1
        return self
    
    def __next__(self):
    	self.count += 1
        if self.count == self.nB:
			raise StopIteration
        ...
        return imgs, labels
        
    def __len__(self):
        return len(self.data)
```

