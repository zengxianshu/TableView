HVTableView
===========
###### UITableView with expand/collapse feature
by Hamidreza Vakilian

------

![Screenshot](http://www.infracyber.com/private/github/HVTableView/screenshot.jpg)

###Summary
This is a subclass of **UITableView** with expand/collapse feature that may come so handy in many apps.	The developer can save a lot of time using an expand/collapse tableView instead of creating a detail viewController for every cell. This means that the details of each cell can be displayed immediately on the same table without switching to another view. On the other hand, in my opinion it's far more impressive and eye-catching in compare to the traditional master details tableview.

###Usage
To create an instance of **HVTableView** you go by code. (currently you can't create it from interface builder - I will work on that later). That's simple as:

	HVTableView* myTable = [[HVTableView alloc] initWithFrame:CGRectMake(84, 250, 600, 600) expandOnlyOneCell:NO enableAutoScroll:YES];
	myTable.HVTableViewDelegate = self;
	myTable.HVTableViewDataSource = self;
	[myTable reloadData];
	[self.view addSubview:myTable];

Two important parameters when initializing the **HVTableView**

	if expandOnlyOneCell==TRUE: Just one cell will be expanded at a time.
	if expandOnlyOneCell==FALSE: multiple cells can be expanded at a time

	if enableAutoScroll==TRUE: when the user touches a cell, the HVTableView will automatically scroll to it
	if enableAutoScroll==FALSE: when the user touches a cell, the HVTableView won't scroll. but the if the cell was close to the bottom of the table; the lower part of it may go invisible because it grows


Your viewController must conform to **HVTableViewDelegate** and **HVTableViewDataSource** protocols. Just like the regular UITableView.
Like before you implement these familiar delegate functions:

		-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
		-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

I added a boolean parameter the **heightForRowAtIndexPath** function so you will have to calculate different values for expand and collapse states.

	-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isexpanded
	(isExpanded==TRUE: return the size of the cell in expanded state)
	(isExpanded==FALSE: return the size of the cell in collapsed (initial) state)

I also added a boolean parameter to the **cellForRowAtIndexPath** function too. update the cell's content respecting it's state (isExpanded):

		-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isExpanded


Now the interesting functions are here. Implement this function and it will be fired when a cell is going to expand. You can perform your drawings, animations, etc. in this function:

		-(void)tableView:(UITableView *)tableView collapseCell: (UITableViewCell*)cell withIndexPath:(NSIndexPath*) indexPath;

The counterpart comes here. It will be fired when a cell is going to collapse. You can perform your drawings, animations, etc. or clearing up the cell in this function:

		-(void)tableView:(UITableView *)tableView expandCell: (UITableViewCell*)cell withIndexPath:(NSIndexPath*) indexPath;

*IMPORTANT NOTE: there are some delegate functions from UITableViewDelegate that I have commented their forwarding in **HVTableView.m**. If you need to implement those on your viewController or something, go to **HVTableView.m** and uncomment those delegate functions. If you don't uncomment them; your delegate functions won't fire up.*

###Final Words
This code may contain bugs. I don't garauntee its functionality, but use it at your own risk. I also tried to craft it with best performance, yet it can be optimized.

Please don't hesitate to mail me your feedbacks and suggestions or a bug report. I would be very thankful of your responses.

<u>ON THE BOTTOM LINE: </u> I allow you to use my code in your applications with freedom in making any modifications, but if you are going to do so, or you just like it and want further updates and bug fixes please consider donating me via this url:

[Donate me!](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=xerxes235%40yahoo%2ecom&lc=AE&item_name=Hamidreza%20Vakilian&item_number=HVTableView%20donation&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted)



Hamidreza,


License
=========

The MIT License (MIT)

Copyright (c) 2013 Hamidreza Vakilian (xerxes235@yahoo.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

