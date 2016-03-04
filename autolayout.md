## AutoLayout是什么？
使用一句Apple的官方定义的话

>AutoLayout是一种基于约束的，描述性的布局系统。 Auto Layout Is a Constraint-Based, Descriptive Layout System.

每一个Constraint 都是一个表达式,Apple的官方文档定义
> firstItem.firstAttribute {==,<=,>=} secondItem.secondAttribute * multiplier + constant
> If your equation does not have a second view and attribute, use nil and NSLayoutAttributeNotAnAttribute.
> Constraint satisfaction is not all or nothing.  If a constraint 'a == b' is optional, that means we will attempt to minimize 'abs(a-b)'.


## 布局过程

和 springs，struts 比起来，在视图被显示之前，自动布局引入了两个额外的步骤：更新约束 (updating constraints) 和布局视图 (laying out views)。每一步都是依赖前一步操作的；显示依赖于布局视图，布局视图依赖于更新约束。


第一步：update constraints，可以被认为是一个“计量传递 (measurement pass)”。这是自下而上（从子视图到父视图）发生的，它为布局准备好必要的信息，而这些布局将在实际设置视图的 frame 时被传递过去并被使用。你可以通过调用 setNeedsUpdateConstraints 来触发这个操作，同时，你对约束条件系统做出的任何改变都将自动触发这个方法。无论如何，通知自动布局关于自定义视图中任何可能影响布局的改变是非常有用的。谈到自定义视图，你可以在这个阶段重写 updateConstraints 来为你的视图增加需要的本地约束。

第二步：layout，这是个自上而下（从父视图到子视图）的过程，这种布局操作实际上是通过设置 frame（在 OS X 中）或者 center 和 bounds（在 iOS 中）将约束条件系统的解决方案应用到视图上。你可以通过调用 setNeedsLayout 来触发一个操作请求，这并不会立刻应用布局，而是在稍后再进行处理。因为所有的布局请求将会被合并到一个布局操作中去，所以你不需要为经常调用这个方法而担心。你可以调用 `layoutIfNeeded` / `layoutSubtreeIfNeeded`（分别针对 iOS / OS X）来强制系统立即更新视图树的布局。如果你下一步操作依赖于更新后视图的 frame，这将非常有用。在你自定义的视图中，你可以重写 `layoutSubviews` / `layout` 来获得控制布局变化的所有权，我们稍后将展示使用方法。

最终，不管你是否用了自动布局，显示器都会自上而下将渲染后的视图传递到屏幕上，你也可以通过调用 `setNeedsDisplay` 来触发，这将会导致所有的调用都被合并到一起推迟重绘。重写熟悉的 `drawRect:`能够让我们获得自定义视图中显示过程的所有权。

既然每一步都是依赖前一步操作的，如果有任何布局的变化还没实行的话，显示操作将会触发一个布局行为。类似地，如果约束条件系统中存在没有实行的改变，布局变化也将会触发更新约束条件。

需要牢记的是，这三步并不是单向的。基于约束条件的布局是一个迭代的过程，布局操作可以基于之前的布局方案来对约束做出更改，而这将再次触发约束的更新，并紧接另一个布局操作。这可以被用来创建高级的自定义视图布局，但是如果你每一次调用的自定义 `layoutSubviews` 都会导致另一个布局操作的话，你将会陷入到无限循环的麻烦中去。


例如，如果视图变得太窄的话，将原来排成一行的子视图转变成两行。

见[Demo:TagListView](https://github.com/asiainfomobile/iOS-style-guide/blob/master/demo/demo/demo/Views/TagListView.swift#L54)

```
- layoutSubviews
{
    [super layoutSubviews];
    if (self.subviews[0].frame.size.width <= MINIMUM_WIDTH)
    {
        [self removeSubviewConstraints];
        self.layoutRows += 1; 
        [super layoutSubviews];
    }
}

- updateConstraints
{
    // 根据 self.layoutRows 添加约束...
    [super updateConstraints];
}
```

## 动画

Apple 官方文档

```
[containerView layoutIfNeeded]; // Ensures that all pending layout operations have been completed
[UIView animateWithDuration:1.0 animations:^{
     // Make all constraint changes here
     [containerView layoutIfNeeded]; // Forces the layout of the subtree animation block and then captures all of the frame changes
}];
```

## Priority
`public typealias UILayoutPriority = Float`

* UILayoutPriorityRequired 			1000
* UILayoutPriorityDefaultHigh			750 // button 的内容抗拒压缩的优先级
* UILayoutPriorityDefaultLow 			250 // button 的内容抗拒水平方向拉伸的优先级



## 压缩阻力 (Compression Resistance) 和 内容吸附 (Content Hugging)

在后台中，固有内容尺寸和这些优先值被转换为约束条件。一个固有内容尺寸为 {100，30} 的 label，水平/垂直压缩阻力优先值为 750，水平/垂直的内容吸附性优先值为 250，这四个约束条件将会生成：

```
H:[label(<=100@250)]
H:[label(>=100@750)]
V:[label(<=30@250)]
V:[label(>=30@750)]
```

如果你不熟悉上面约束条件所使用的`Visual Format Language`，你可以到 [Apple](https://developer.apple.com/library/prerelease/ios/documentation/UserExperience/Conceptual/AutolayoutPG/VisualFormatLanguage.html) 文档 中了解。记住，这些额外的约束条件对了解自动布局的行为产生了隐式的帮助，同时也更好理解它的错误信息。

快速理解 压缩阻力 (Compression Resistance) 和 内容吸附 (Content Hugging)

* Content  Hugging => 内容不想被拉伸
* Compression Resistance => 内容不想被压缩

例如，这是一个button

```
[       Click Me      ]

```

拉伸superview

如果 Hugging priority > 500，button就会像这样

```
[Click Me]
```

如果 Hugging priority < 500，button就会像这样
```
[       Click Me      ]
```
如果superview现在缩小
如果 Compression Resistance priority > 500，button就会像这样
```
[Click Me]
```
如果 Compression Resistance priority < 500，button就会像这样
```
[Cli..]
```



## 固有内容尺寸（Intrinsic Content Size ）
固有内容尺寸是一个视图期望为其显示特定内容得到的大小。比如，`UILabel` 有一个基于字体的首选高度，一个基于字体和显示文本的首选宽度。`UIProgressView` 仅有一个基于其插图的首选高度，但没有首选宽度。一个没有格式的 `UIView` 既没有首选宽度也没有首选高度。

为了在自定义视图中实现固有内容尺寸，你需要做两件事：重写 `intrinsicContentSize` 为内容返回恰当的大小，无论何时有任何会影响固有内容尺寸的改变发生时，调用 `invalidateIntrinsicContentSize`。如果这个视图只有一个方向的尺寸设置了固有尺寸，那么为另一个方向的尺寸返回 `UIViewNoIntrinsicMetric` / `NSViewNoIntrinsicMetric`。


## Debug

```
// 官方方法
extension NSLayoutConstraint {
    /* For ease in debugging, name a constraint by setting its identifier, which will be printed in the constraint's description.
     Identifiers starting with UI and NS are reserved by the system.
     */
    @available(iOS 7.0, *)
    public var identifier: String?
}

// UIView 调试歧义约束
extension UIView {
	func exerciseAmiguityInLayoutRepeatedly(recursive: Bool = false) {
		if (self.hasAmbiguousLayout()) {
			NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "exerciseAmbiguityInLayout", userInfo: nil, repeats: true)
		}
		if (recursive) {
			for subview in subviews {
				subview.exerciseAmiguityInLayoutRepeatedly(true)
			}
		}
	}
}
	
	// add this func in AppDelegate.swift
	override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
		if motion == .MotionShake {
			window?.exerciseAmiguityInLayoutRepeatedly(true)
		}
	}
```


## Tips

* 自定义View不能对自己添加 size constraints
* 自定义View不能对自己的superview添加 constraints
* updateConstraints 是用来更新约束
* 更新约束的constant 开销低于 remove constraints 再 add constraints(后者无法做动画)
* 

绝对不要这么做
```
- (void)updateConstraints {
  [self removeConstraints:self.constraints];
  /*
  create the constraint here
  */
  [super updateConstraints]; 
}
```
因为`[self removeConstraints:self.constraints];`会删除`xib`和`storyboard`创造的`constraint`

正确的应该是

```
- (void)updateConstraints {
  if (!didSetConstraints) {
     didSetConstraints = YES;
  //create the constraint here
  }
  
  //Update the constraints if needed
  [super updateConstraints];
}
```

## 参考
* [Adaptive Auto Layout](https://www.youtube.com/watch?v=taWaW2GzfCI)
* [Advanced Auto Layout Toolbox](http://www.objc.io/issue-3/advanced-auto-layout-toolbox.html)
	
主流Autolayout helper框架

* [Cartography](https://github.com/robb/Cartography)
* [SnapKit](https://github.com/SnapKit/SnapKit)
* [PureLayout](https://github.com/PureLayout/PureLayout)
