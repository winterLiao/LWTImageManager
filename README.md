### 图片截取
![截取图片](http://ok841h9gr.bkt.clouddn.com/cropImage.png)
```
CGPoint point1 = CGPointMake(30, 150);
CGPoint point2 = CGPointMake(130, 150);
CGPoint point3 = CGPointMake(80, 50);
NSArray *pointArray = @[[NSValue valueWithCGPoint:point1],[NSValue valueWithCGPoint:point2],[NSValue valueWithCGPoint:point3]];
UIImage *cropImage = [ImageManager cropImage:image pointArray:pointArray];
```
### 拉伸图片
![图片拉伸](http://ok841h9gr.bkt.clouddn.com/stretchImage.png)     

```
    UIImage *image = [ImageManager stretchImage:stretchImage edgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
```
### 图片打码
![打码图片](http://ok841h9gr.bkt.clouddn.com/masicImage.png)       
```
    _mosaicImagView = [[MosaicView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - image.size.width) / 2.0, 100, image.size.width, image.size.height)];
    _mosaicImagView.surfaceImage = image;
    _mosaicImagView.mosaicImage = [ImageManager mosaicImage:image level:0];
```
