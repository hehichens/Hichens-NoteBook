[TOC]

# 实现功能
- 首页
	- 文章列表
	- 排序方式　最新/最热
	- 搜索文章
	- 个人账户 登录/未登录
	- 文章分页

- 个人账户
	- 写文章
		- 支持markdown
	- 个人信息
		- 头像、电话、简介
	- 删除账户
	- 退出登录

- 阅读正文 
	- 目录
	- 发表评论



# Django基础
## 基本命令
```python

django-admin startproject project_name # 新建项目

python manage.py runserver 
python manage.py startapp app_name
python manage.py makemigrations
python mange.py migrate
python mange.py shell
python manage.py createsuperuser

```

## 基本流程
### 1. 创建项目
### 2. 创建并注册App
```python
# 创建
python manage.py startapp app_name

# 注册， 在project_name/setting.py 下
INSTALLED_APPS  =  [
App_name,
]
```
### 3. 配置访问路径
```python
# 在project_name/urls.py 下添加一级路由
urlpaterns  = [
    path('App_name/', inclue(App_name.urls, name_sapce="space_name")),
]

# 在App_name/urls.py下添加二级路由
urlpaterns  = [
    path('route_path/', inclue(App_name.method, name_sapce="space_name")),
]

```
### 4. 编写Model

   ```python
   # 数据库配置， project_name/settings.py 下
   DATABASES = {}
   
   # Django内置的字段类型
   AutoField # 自动增加的整数类型字段, 只允许一个且必须是主键
   BooleanField 
   CharField(max_length) 
   DateField() # auto_now, auto_now_add
   EmailField
   FileField # upload_to: 保存路径; 需在  project_name/settings.py 下 配置MEDIA_ROOT(保存)，MEDIA_URL (调用)
   ImageField # 同上
   TextField
   
   # 关系
   ForeignKey　# 多对一
   ManyToManyField # 多对多
   OneToOneField　# 一对一
   
   # Meta 元数据
   class Meta:
       ordering[] # -:降序
   
   ```

   

### 5. 编写views

   ```python
   # view 函数模板
   def func(request, *args):
       ...
       return render/HttpRenspose/redirect
   
   # example
   def article_safe_delete(request, id):
       if request.method == "POST":
           article = ArticlePost.objects.get(id=id)
           article.delete()
           return redirect('article:article_list')
       else:
           return HttpResponse('仅允许post请求')
   ```

   

###  6. 编写Templates

   ```python
   # 在project_name/settings.py 下添加模板位置
   TEMPLATES = [
       {
           ...
           # 定义模板位置
           'DIRS': [os.path.join(BASE_DIR, 'templates')],
           ...
       },
   ]
   
   # 在templates文件下写html文件
   
   ```

 # 博客功能实现
 ## 首页

```python
def article_list(request):
    search = request.GET.get('search') # 搜索关键字
    order = request.GET.get('order') # 排序方式： 浏览量（热度）、时间

    if search:
        if request.GET.get('order') == 'total_view':
            article_list = ArticlePost.objects.filter(
                Q(title__icontains=search) | # 标题匹配
                Q(body__icontains=search) # 正文匹配
            ).order_by('-total_view') # 按照热度排序
        else:
            article_list = ArticlePost.objects.filter(
                Q(title__icontains=search) |
                Q(body__icontains=search)
            )
    else:
        search = ''
        if order == 'total_view':
            article_list = ArticlePost.objects.all().order_by('-total_view')
        else:
            article_list = ArticlePost.objects.all()

      # 文章分页
    paginator = Paginator(article_list, 2)
    page = request.GET.get('page')
    articles = paginator.get_page(page)

    context = {'articles': articles, 'order': order, 'search': search}
    return render(request, 'article/list.html', context)

```



```python
def article_detail(request, id):
    article = ArticlePost.objects.get(id=id) # 正文
    comments = Comment.objects.filter(article=id) # 评论

    article.total_view += 1 # 浏览数
    article.save(update_fields=['total_view']) # 保存浏览数
    # markdown 配置
    md = markdown.Markdown(
        extensions=[
            'markdown.extensions.extra',
            'markdown.extensions.codehilite',
            'markdown.extensions.toc',
        ]
    )
    article.body = md.convert(article.body) # 更新的正文
    context = {'article': article, 'toc': md.toc, 'comments': comments}

    return render(request, 'article/detail.html', context)
```

 

