<style type="text/css">

  .reveal p{
    line-height: 50%;
    font-size: 0.67em;
    font-family: 'Helvetica';
    white-space: pre-wrap;
  }
  .reveal ul{
    font-size: 0.67em;
    font-family: 'Helvetica';
  }
  .withcode .reveal code{
    font-size: 0.75em;
  }
  
  .twocols .reveal p{
    line-height: 100%;
    font-size: 0.67em;
    font-family: 'Helvetica';
    white-space: pre-wrap;
  }
  .twocols .reveal ul{
    font-size: 0.67em;
    font-family: 'Helvetica';
  }
  .twocols .reveal section img {
    width: 1;
    height: 50%;
  }

</style>

Course Project
Tip Calculator
========================================================
author: Alper Gondiken

2014-07-27

Executive Summary
========================================================

<br>
**Scenario**: You go to a restaurant and don't know how much you should tip

<br>

This application helps you to calculate the tip you could leave, based on:
   - Your bill
   - Size of your group (# of people)
   - Your thoughts about the restaurant

<br>

[Access to application](https://algons.shinyapps.io/shiny_try1)

How it works
========================================================
type: twocols
left:64%

<br>
You input your bill amount on the slider in the sidebar

<br>
You input number of people dining on the second slider in the sidebar

<br>
Then you input your thoughts about the place by checking out the boxes in the sidebar
   - Was the waitress a smiling person?
   - Did the food arrive on time?
   - Was the overall service high quality?
   - Was the food delicious?

***
![bill](https://raw.githubusercontent.com/algons/coursera/master/Developing%20Data%20Products/Rpres/bill.png)


![size](https://raw.githubusercontent.com/algons/coursera/master/Developing%20Data%20Products/Rpres/size.png)

![feedback](https://raw.githubusercontent.com/algons/coursera/master/Developing%20Data%20Products/Rpres/feedback.png)

Example
========================================================
type: withcode

<br>
You and your three friends had dinner and your bill is £72

Your feedbacks are "Waitress was a smiling person" and "Service quality was high"


```r
bill <- 72
size <- 4
feedback <- c("Smiling","High-quality")
```

![allpage](https://raw.githubusercontent.com/algons/coursera/master/Developing%20Data%20Products/Rpres/all_page.png)


Model in the background
========================================================
type: withcode

<br>
Each positive feedback results in additional *5%* tip on top of the min *5%* (social norm)

Each additional person in the dining group will decrease the tip by 1%*

As the bill increases, tips tend to decrease percentage-wise*

*: [Information comes from the research](http://www.info.univ-angers.fr/~gh/Datasets/tips_cs503.pdf)


```r
tipModel <- function(bill,feedback,size){
  #Every positive feedback counts for 5% tip on top of 5% minimum
  feedback.reward <- length(feedback)*0.05 + 0.05
  #Every incremental person in the group reduces the bill by 1%
  size.penalty <- (1 - size*0.01)
  #People tend to pay percentage-wise less tips when the bill is higher
  bill.penalty <- (1 - bill*0.001)
  tip <- round(bill*feedback.reward*size.penalty*bill.penalty,1)
  tip
}
```

In the example from previous page, calculate the tip amount and total payment amount:


```r
tipModel(bill,feedback,size) #Tip amount
```

```
[1] 9.6
```

```r
bill + tipModel(bill,feedback,size) #Total payment
```

```
[1] 81.6
```

