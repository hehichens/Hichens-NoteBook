# 1.学习指标

## 1.1 **混淆矩阵**

- True Positive(真正，TP)：将正类预测为正类数

- True Negative(真负，TN)：将负类预测为负类数

- False Positive(假正，FP)：将负类预测为正类数误报 (Type I error)

- False Negative(假负，FN)：将正类预测为负类数→漏报 (Type II error)

  ![](https://img-blog.csdn.net/20170426204250714)

## 1.2 常见指标

- **准确率（Accuracy）**

$$
ACC = \frac{TP + FN}{TP + TN + FP + FN}
$$

- **错误率（Error）**
$$
ER = \frac{TN + FP}{TP + TN + FP + FN} = 1 - ACC
$$

- **精确率、精度（Precision）**

$$
P = \frac{TP}{TP + FP}
$$

- **召回率、查全率（Recall）**

$$
R = \frac{TP}{TP+FN}
$$

- **综合评价指标（F-Measure）**

$$
F = \frac{(\alpha^2 + 1 )P*R }{\alpha^2(P+R)} \\
F1 = \frac{2*P*R }{P+R} (\alpha = 1)
$$