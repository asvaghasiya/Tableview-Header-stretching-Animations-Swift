#  How to create a stretchable TableViewHeader in iOS ??

You might have seen a collapsable or stretchable tableview header in android. If you check the whatsapp profile/ group settings page , you can see this. If you are using jioSaavn app, you might have seen a zoom in effect in the album play screen as well. Well, if you ever wondered how to do this in iOS, I will give a simple solution.

![](Tableview-Header-stretching-Animations-Swift.gif)

**Note:** I have mentioned TableViewHeader above. But I am not actually using TableViewHeader for this article.

For understanding what I am doing here, you should be familiar with UIScrollView and its delegate methods. You also need to know about UIScrollView contentInset property.

## Now we can create a stretchable TableViewHeader

Create a tableview with the basic datasource and delegate methods which are required to simply load the table with some data.
Set the tableview’s contentInset property:
```swift
var topViewSize:CGFloat = 318//Topview height
var navigationHeight:CGFloat = 82//Headerview height

tableView.contentInset = UIEdgeInsetsMake(topViewSize, 0, 0, 0)
```
Here, I set the top value as 318 which is a calculated number which I will set as the initial normal height for the header imageview. Now, that we set the contentInset , the tableview’s frame will start at (0,0) and the first cell will start at (0,318).

Now, create an UIView with height 318 and add it to the current View above the tableview.

```swift
let view = Bundle.main.loadNibNamed("TopView", owner: self, options: nil)![0] as! TopView
view.frame = CGRect(x: 0, y: statusHeight, width: self.view.frame.width, height: self.view.frame.width)
self.view.addSubview(view)
topView = view
tableView.estimatedRowHeight = 50
tableView.contentInset = UIEdgeInsetsMake(topViewSize, 0, 0, 0)
```

Then, add the following code in the scrollview delegate method scrollViewDidScroll which gets called every time the tableview is scrolled.

```swift
func scrollViewDidScroll(_ scrollView: UIScrollView){
        let y = topViewSize - (scrollView.contentOffset.y + topViewSize)
        let newHeaderViewHeight = topView.frame.height - scrollView.contentOffset.y
        
        if(y >= navigationHeight){
            if(y<=148 && y >= navigationHeight){
                let percent:Float = (Float((148-y) / y));
                topView.albumTopButton.alpha = CGFloat(percent)
            }else{
                topView.albumTopButton.alpha = 0
            }
            
            topView.albumTopButton.frame.origin.y = y
            
            if(isOpenButton == 1){
                isOpenButton = 0
                UIView.animate(withDuration: 0.1, animations: {
                    self.topView.btnAlbum.frame.origin.x = self.topView.btnAlbum.frame.origin.x + 5
                    self.topView.btnMusic.frame.origin.x = self.topView.btnMusic.frame.origin.x - 5
                }) { (Bool) in
                    self.shakeAnimation()
                }
            }
        }else{
            if(isOpenButton == 0){
                isOpenButton = 1
                UIView.animate(withDuration: 0.1, animations: {
                    self.topView.btnAlbum.frame.origin.x = self.topView.btnAlbum.frame.origin.x - 5
                    self.topView.btnMusic.frame.origin.x = self.topView.btnMusic.frame.origin.x + 5
                }) { (Bool) in
                    self.shakeAnimation()
                }
            }
            topView.albumTopButton.alpha = 1
            topView.albumTopButton.frame.origin.y = 100
        }
        
        let height = min(max(y, navigationHeight), 800)
        topView.frame = CGRect(x: 0, y: statusHeight, width: UIScreen.main.bounds.size.width, height: height)
        
        if(y >= topViewSize){
            topView.albumimage.transform = CGAffineTransform(scaleX: (y/topViewSize), y: (y/topViewSize))
            topView.albumTop.constant = 25
        }else{
            topView.albumTop.constant = (y-(topViewSize-25))+((y-topViewSize)*0.6)
        }
        
        if(y >= topViewSize){
            let final = ((450)-y) / ((450) - topViewSize)
            topView.albumButton.alpha = CGFloat(final)
        }else if (newHeaderViewHeight > topViewSize){
            let alphavalue = (newHeaderViewHeight/topViewSize) - 1
            topView.albumButton.alpha = CGFloat(alphavalue)
        }
    }
```
