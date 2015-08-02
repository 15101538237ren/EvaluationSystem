# EvaluationSystem
华博人才测评系统，外包项目

# 系统配置以及密码等相关内容

## 说明
关于开发的一些接口之类的东西可以写这个wiki上，wiki支持的语是markdown语法

## 测试机地址
http://115.159.2.182/accounts/login

## 腾讯云服务器
```
ip:115.159.2.182
密码:harry123
```
## 阿里云数据库
```
host:renhongleiz.mysql.rds.aliyuncs.com:3306
username:ren
password:Harry123
```
## Django Admin
```
username:root
password:evaluationsystem
```

## 重启测试机器上的web(一般不需要重启服务)
```
cd ~/Projects/EvaluationSystem/scripts
sudo sh start.sh
```

# 系统环境以及开发说明

## 注意事项
1. 提交代码时一定要提交到自己的分支，master分支由我(翁学平)来维护，定期合并其他分支上的内容，分支如下：
```
阿杜: dujunyi
小白：jiahuanyu
红雷：renhonglei
学平：wengxueping
```
2. 关于git的使用，可以参照[GitHub入门教程][2]和[Git详细命令][1]使用。
3. 目录下的docs文件夹是文档目录，以后文档可以放置在该目录下。
4. 项目采用的是python2.7版本的django，请注意一下！目前python3在支持django方面还有很多缺陷，我们统一使用python2.7的版本。
5. [Django入门教程][3]，从part1到part6,都看一下吧。
6. 在本地开发需要安装配置的环境：
  ```
  python 2.7
  MySQL-Python
  django_bootstrap3
  python-docx
  django-ckeditor
```
  建议安装Python包管理工具pip或者easy_install，具体安装方法百度或者google
   之后就可以使用sudo pip install MySQL-Python(django_bootstrap3) 或者 sudo easy_install install MySQL-Python(django_bootstrap3)安装必要的包
7. View和逻辑代码显示方式
```
1. 在本地配置好环境之后，访问临时页面http://127.0.0.1:8000/accounts/register/，查看渲染的页面效果
2. 在页面里使用bootstrap3以及基本view tag使用方式参见templates/account目录下的页面
3. login是临时目录，之后会用accout代替，先暂时不删除
4. 腾讯云暂时登陆不上去，先只能在本地搭建环境，不需要安装mysql，但是需要安装6中的内容。因为使用的是统一数据库，
所以settings.py可以提交到git上了直接pull覆盖就行。
```
8. Python编码规范
Python编码规范采用的是[Google Python Style][5]，有兴趣的可以去完整查看一下，这是中文版本的。简单来说，规则如下:
```
1. 函数名、文件名，普通变量名全部小写，单词之间采用“_”连接。类的全局变量名全部大小。
   比如“def get_user_name()”, "login_form.html", "username"等
   比如SUPERADMIN = 1等
2. 类名采用单词首字母大小，其余字母小写，单词之间直接连接。
   比如ExamQuizRelation, LoginForm等。
3. 引入新的文件时，指明需要引入的内容，尽量避免使用"import *","from xxx import *"引入方式。
   比如 from quesions.models import Question, Option
4. 文件都采用utf-8格式，方便阅览中文和英文注释，在文件头部加入如下的代码，声明文件内容。
   # -*- coding: utf-8 -*-
(暂时想到这么多了，以后再有再补充)
```
9. 静态资源使用示例(css,js,images)
```
#css
<link rel="stylesheet" type="text/css" href="{% static "bootstrap/css/bootstrap.css" %}" /> 
#js
<script type="text/javascript" src="{% static "bootstrap/js/bootstrap.js" %}"></script> 
#image
<image src="{% static "image/star.png" %}"></script> 

需要说明的地方：static URL路径是在EvaluationSystem/static/下，后面路径根据需要自己添加静态资源的地址即可。
```
10.url使用示例 
```
#目前在EvaluationSystem里的urls.py增加了namespace属性，这样做的好处就是可以通过namespace和name使用url，避免在页面里面把url写死，在有改动的时候就会很方便。之前的url使用方式已经不能再使用了，这次改动需要把之前写的url都重写，很抱歉，我也是边学边写的.......

#application中的urlpattern的声明方式，相比之前增加了name字段，可以通过namespace和name进行调用
url(r'^login$', auth_views.login, name='login_name') 
#在页面中调用url，在设置中，每个application的namespace和名字是一致的，调用方式为
namespace:name
比如{% url 'account:login_name' %}
```
## 提交代码示例
1. 初始化使用
```
# 配置全局用户名和邮箱
git config --global user.name xxxxx
git config --global user.email "xxxxx@xxxxx"

# 新建项目文件夹
mkdir EvaluationSystem
cd EvaluationSystem
git init
git remote add origin git@github.com:Talus715/EvaluationSystem.git
git pull origin "自己的分支"
```

2. 日常工作流程
```
git pull origin master
写代码....
git add --all
git commit -m "替换成你修改或者添加的内容，能让别人理解"
git push origin "自己的分支"
```

# 开发内容相关

## 内容说明
1. question模块和quiz模块之间是循环依赖，因此把Question的quiz_type字段断开，需要手动做外键查询
2. User类是系统默认的类，扩展User类成Profile类，在调用User相关信息时，采用如下的方式：
```
    # 调用User类本身的属性，如
    user.username
    # 调用Profile里属性，如
    user.profile.foreword
```

## 用户权限一览表

### 权限验证方式
```
先空着
```

### 权限名称对应
```
中文名称              permission_name
查看测试列表          can_view_tests_lsit
参加答题              can_take_test
查看报告              can_view_report
查看进度              can_view_process
生成报表              can_generate_report
查看报表              can_view_report_form
生成报告              can_generate_report_form
下载报告              can_download_report_form
查看标准化维度分数    can_view_standardized_dimension_score
选择测验              can_select_quiz
定制宣传页面          can_customize_page
选择个人信息          can_select_personal_info
生成密码              can_generate_password
管理题库              can_manage_question
管理普通管理员        can_manage_general_administrator
管理维度              can_manage_dimensions
管理报告模板          can_manage_report_template
管理测验              can_manage_quiz
管理个人信息选项      can_manage_personal_info_option
管理公司信息选项      can_manage_company_info_option
选择横排竖排          can_select_quiz_arrangement
查看原始答题内容      can_view_raw_answer
查看原始得分          can_view_raw_score
查看原始维度          can_view_raw_dimension
选择测验报告模板      can_select_quiz_report_template
```

[1]: https://app.yinxiang.com/shard/s14/res/10040787-ede4-4367-8d76-807a6280899a/git%E6%90%AD%E5%BB%BA.pdf?search=git
[2]: http://m.blog.csdn.net/blog/u011449127/17013723
[3]: https://docs.djangoproject.com/en/1.8/intro/tutorial01/
[4]: http://pan.baidu.com/s/1qW5fNU8
[5]: http://www.elias.cn/Python/PythonStyleGuide?from=Develop.PythonStyleGuide
