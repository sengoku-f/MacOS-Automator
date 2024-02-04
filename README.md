# MacOS-Automator
🚀 自用 Mac Automator 服务；提高工作效率。
## 安装
1. 安装所需依赖

2. 下载 [`zip` 文件](https://github.com/sengoku-f/MacOS-Automator/archive/master.zip)，进入`服务`文件夹，双击安装Automator服务。

### 依赖:

部分工作流程需要使用以下依赖，MacOS 可以使用[Homebrew](https://brew.sh/)安装
``` bash
brew install 'ffmpeg' 'ImageMagick' 'gifsicle' 'rename' 'youtube-dl' 'parallel' 'potrace' 'exiftool' 'p7zip' 'media-info'
```
部分工作流程使用了[Fred's ImageMagick Scripts](http://www.fmwconcepts.com/imagemagick/index.php)

下载 `imagemagick_scripts` 文件夹放入 `用户文件夹下`，进入该目录运行以下命令，并将其目录添加到你的 `PATH`

``` bash
# 给脚本赋予权限
sudo chmod 777 *

# 添加环境变量
echo 'export PATH="~/Applications/imagemagick_scripts/:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
```

## 使用方法

### 快速入门

1. 对着文件或文件夹`右键` → `服务` →  `工作流程`，根据提示操作即可。
2. 可以选择多个文件或文件夹进行操作，导出的文件放置在文件或文件夹所在的目录。

### 注意事项

- 序列帧请选择文件夹

- 序列帧的命名请注意补零，量化对齐最大那个数字，例如假设有 200 张图，需要在个位前补 2 个 0，十位前补 1 个 0，即命名为 000.png，001。 png…010.png，011.png…199.png，**不要**命名为 0.png，1.png…

- 如果运行出错，请检查文件名或者路径是否含有特殊的字符包括（但不限于）：

  ```
  ? * / \ < > : " | 空格符、制表符、退格符和字符 @ # $ & ( ) - 等
  ```
  
- 服务安装路径 `~/Library/Services`

### 卸载

你只需要在 `~/Library/Services` 中删除服务文件即可。

### 界面

<img src="https://wx2.sinaimg.cn/large/b85b28acgy1gbh36w85vkj20yy0u00vg.jpg" alt="1" style="zoom:100%;" />

<img src="https://wx3.sinaimg.cn/large/b85b28acgy1gbh36uy2iwj20u00u4jul.jpg" alt="2" style="zoom:100%;" />

<img src="https://wx2.sinaimg.cn/large/b85b28acgy1gbh36w7021j20u00ui775.jpg" alt="2" style="zoom:100%;" />

<img src="https://wx4.sinaimg.cn/large/b85b28acgy1gbh36vsfo7j20iw0samyg.jpg" alt="2" style="zoom:100%;" />

<img src="https://wx1.sinaimg.cn/large/b85b28acgy1gbh36vu5pcj20iw0sat9x.jpg" alt="2" style="zoom:100%;" />

### TODO

不定期更新，有问题或者有想法可以联系我。

## 作者
* SENGOKU i.donxj@gmail.com