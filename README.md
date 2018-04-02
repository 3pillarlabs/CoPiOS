# Self sizing table view cells

## Overview

Prior to AutoLayout the layout of cells was done with frames, springs and struts. There was a little strugle for calculating the height of a cell before setting the data on the cell.

Now we can layout the content in the cell and let the scrollable views (table view and collection view as well) calculate height of cells. We only need to use constraints to layout the subviews of cells.

## References

[What's New in Table and Collection Views](https://developer.apple.com/videos/play/wwdc2014/226/)

[Self sizing collection view cells](https://developer.apple.com/videos/play/wwdc2016/219/)

[AutoLayout guide for self sizing cells](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithSelf-SizingTableViewCells.html)


