# 1. 数据处理

## 1.1 自定义迭代器

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

## 1.2 map 数据格式

```python
# 定义map data
from torch.utils.data import Dataset
class dataset(Dataset):
    def __init__(self, data_path):
        pass
    def __len__(self):
        return len(data)
   	def __getitem__(self, index):
        return single_data
    
```




# 2. 代码设计

## 2.1 命令参数

```python
import argparse

parser = argparse.ArgumentParser(description)
parser.add_argument("--image", help="image path", default=path, type=str)
args = parser.parse_args()
"""
>>> python main.py --param *
"""


# subparser
main_arg_parser = argparse.ArgumentParser(description="parser for fast-neural-style")
subparsers = main_arg_parser.add_subparsers(title="subcommands", dest="subcommand")
train_arg_parser = subparsers.add_parser("train", help="parser for training arguments")
train_arg_parser.add_argument()
test_arg_parser = subparsers.add_parser("train", help="parser for training arguments")
test_arg_paerser.add_argument()
args = main_arg_parser.parse_args()
"""
>>> python main.py train --param *
"""
```



## 2.2 文件操作

```python
# 目录下所有文件
from imutils import paths
img_paths = [el for el in paths.list_images(img_dir)]
file_paths = [el for el in paths.list_files(img_dir)]

# os.path 基本用法
os.path.basename # 获取文件名
os.path.join(dir, filename)
os.mkdir(dir) # 如果目录有多级，则创建最后一级，如果最后一级目录的上级目录有不存在的，则会抛出一个 OSError
os.makedirs(dir, exist_ok=True) # 递归的创建文件
os.path.exists(dir)

```



## 2.3 动态导入

- importlib[[example](https://blog.csdn.net/xie_0723/article/details/78004649)]

```python
importlib.import_module('dir.filename') # 绝对导入
importlib.import_module('.filename', package='dir') # 相对导入
```



# 3. pytorch 语法

```python
# 控制是否使用梯度, phase in ['train', 'eval']
torch.set_grad_enabled(phase == 'train')

```



# 4. 其他

##  ssh

```bash
# 远程使用tensorboard， visdom
# ssh -L 18097:127.0.0.1:8097 sym_ll@10.16.34.231
ssh port:adress_port hostname@ip_adress
```

