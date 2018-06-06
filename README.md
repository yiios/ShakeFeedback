<p align="right"><b>Github 点个赞↑👍,感谢您的支持!</b></p>

# ShakeFeedback
[![CI Status](https://travis-ci.org/yiios/ShakeFeedback.svg?branch=master)](https://travis-ci.org/yiios/ShakeFeedback)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/ShakeFeedback.svg?style=flat)](http://cocoapods.org/pods/ShakeFeedback)
[![License](https://img.shields.io/cocoapods/l/ShakeFeedback.svg?style=flat)](http://cocoapods.org/pods/ShakeFeedback)
[![Platform](https://img.shields.io/cocoapods/p/ShakeFeedback.svg?style=flat)](http://cocoapods.org/pods/ShakeFeedback)

**ShakeFeedback**是一个应用内的反馈和 BUG 报告的工具包。 用户只需要摇一摇自己的手机，就能报告程序错误、发送反馈，甚至不需要离开正在使用的应用。此外，用户还可以附上屏幕截图、图片~~以及语音注释~~。接着，**ShakeFeedback** 会一步步重现问题，并提供关于设备的其他所有信息，让开发者能够更迅速地修复错误。

> 英文介绍暂缺，希望懂英语的朋友掏出你的PR


# 安装

有三种方法可以在您的项目中使用 **ShakeFeedback** :

* 使用 CocoaPods

* 手动

* ~~使用 Carthage~~


## CocoaPods
    
CocoaPods是Objective-C的依赖管理器，可以自动化并简化项目中使用第三方库的过程。


### Podfile

    platform :ios, '8.0'
    pod 'ShakeFeedback', '~> 0.0.1'

## 手动

下载 repo 的 zip 文件，并将 ShakeFeedback 文件夹中的**所有**文件拖放到您的项目中。


## Carthage

[Carthage](https://github.com/Carthage/Carthage) 是一个去中心化的依赖管理器，可以建立你的依赖并为你提供二进制框架。

您可以使用以下命令安装Carthage with [Homebrew](http://brew.sh/)：

    $ brew update
    $ brew install carthage
        
        
要使用 Carthage 将 **ShakeFeedback** 集成到您的Xcode项目中，请在Cartfile中指定它：

    github "yiios/ShakeFeedback"

运行carthage来构建框架，并根据需要将适当的框架（ShakeFeedback.framework）拖到您的Xcode项目中。

# Usage 

您可以运行 **ShakeFeedbackDemo** 以获取更多详细信息。

# Communication

当然，如果你愿意，你可以随时为这个项目做出贡献。


- 如果您 **需要帮助或提出一般性问题** ，只需发送邮件到 limo@yiios 。

- 如果你发现了一个 **bug** ，只需要创建一个 **issue**  。

- 如果您希望增加 **新功能** ，请创建一个 **issue**。

- 如果您想 **参与开发** ，请 **fork** 此存储库，然后提交**pull request**。


# 许可证

ShakeFeedback 使用 MIT 许可证，详情见 LICENSE 文件。


