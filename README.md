## iOS FFmpeg 安装编译脚本，以及示例


##一、安装依赖脚本文件 gas-preprocessor

下载 [gas-preprocessor](https://github.com/yuvi/gas-preprocessor) 

	1、切换到gas-preprocessor目录
	
	cd gas-preprocessor/
	
	2、拷贝gas-preprocessor.pl到/usr/local/bin/目录
	
	sudo cp -p gas-preprocessor.pl /usr/local/bin/
	
	3、修改gas-preprocessor.pl权限
	
	sudo chmod a+rwx gas-preprocessor.pl 

##二、安装 yasm
1、使用 [Homebrew](http://brew.sh/) 安装 yasm

	brew install yasm
	
##三、编译FFmpeg
首先下载 [FFmpeg-iOS-build-script](https://github.com/kewlbear/FFmpeg-iOS-build-script) 脚本

	1、安装 FFmpeg	
	
	brew reinstall -v ffmpeg --with-libass
	
	2、切换到 FFmpeg-iOS-build-script 目录
	
	cd FFmpeg-iOS-build-script/
	
	3、运行脚本
	
	sudo ./build-ffmpeg.sh
	
