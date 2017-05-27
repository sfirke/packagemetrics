tableSample
================
rTables-Group
May 26, 2017

------------------------------------------------------------------------

------------------------------------------------------------------------

Selected Tables packages with sample code
-----------------------------------------

As a proof of concept, below is the List of 5 Table packages we considered today:

### 1: Arsenal

An Arsenal of 'R' functions for large-scale statistical summaries, which are streamlined to work within the latest reporting tools in 'R' and 'RStudio' and which use formulas and versatile summary statistics for summary tables and model.

[Documentation](https://www.rdocumentation.org/packages/arsenal/versions/0.2.0)

#### Example

``` r
#install.packages("arsenal")
library(arsenal)
library(dplyr)

data(mockstudy)
tab1 <- tableby(arm ~ sex + age, data=mockstudy)
mylabels <- list(sex = "SEX", age ="Age, yrs")
summary(tab1, labelTranslations = mylabels, text=TRUE)
```

    ## 
    ## ---------------------------------------------------------------------------------------------------------------------------
    ##                          A: IFL (N=428)      F: FOLFOX (N=691)   G: IROX (N=380)     Total (N=1499)      p value           
    ## ----------------------- ------------------- ------------------- ------------------- ------------------- -------------------
    ## SEX                                                                                                                   0.190
    ##    Male                 277 (64.7%)         411 (59.5%)         228 (60%)           916 (61.1%)        
    ##    Female               151 (35.3%)         280 (40.5%)         152 (40%)           583 (38.9%)        
    ## Age, yrs                                                                                                              0.614
    ##    Mean (SD)            59.7 (11.4)         60.3 (11.6)         59.8 (11.5)         60 (11.5)          
    ##    Q1, Q3               53, 68              52, 69              52, 68              52, 68             
    ##    Range                27 - 88             19 - 88             26 - 85             19 - 88            
    ## ---------------------------------------------------------------------------------------------------------------------------

``` r
#freqlist() is a function to approximate the output from SAS's PROC FREQ procedure when using the /list option of the TABLE statement.
# load mockstudy data
data(mockstudy)
tab.ex <- table(mockstudy[, c("arm", "sex", "mdquality.s")], useNA = "ifany")
noby <- freqlist(tab.ex, na.options = "include")
summary(noby)
```

    ## 
    ## 
    ## arm         sex      mdquality.s    Freq   cumFreq   freqPercent   cumPercent
    ## ----------  -------  ------------  -----  --------  ------------  -----------
    ## A: IFL      Male     0                29        29          1.93         1.93
    ##                      1               214       243         14.28        16.21
    ##                      NA               34       277          2.27        18.48
    ##             Female   0                12       289          0.80        19.28
    ##                      1               118       407          7.87        27.15
    ##                      NA               21       428          1.40        28.55
    ## F: FOLFOX   Male     0                31       459          2.07        30.62
    ##                      1               285       744         19.01        49.63
    ##                      NA               95       839          6.34        55.97
    ##             Female   0                21       860          1.40        57.37
    ##                      1               198      1058         13.21        70.58
    ##                      NA               61      1119          4.07        74.65
    ## G: IROX     Male     0                17      1136          1.13        75.78
    ##                      1               187      1323         12.47        88.26
    ##                      NA               24      1347          1.60        89.86
    ##             Female   0                14      1361          0.93        90.79
    ##                      1               121      1482          8.07        98.87
    ##                      NA               17      1499          1.13       100.00

------------------------------------------------------------------------

------------------------------------------------------------------------

### 2: condformat

Prints a data frame with cells formatted according to several rules or criteria. It is integrated with the RStudio Viewer or a web browser, and it supports knitr and rmarkdown outputs using both HTML and PDF output formats.

[Documentation](https://cran.r-project.org/web/packages/condformat/vignettes/introduction.html)

#### Example

``` r
data(iris)
#install.packages("condformat")
library(condformat)
condformat(iris[c(1:5,70:75, 120:125),]) +
  rule_fill_discrete(Species) + 
  rule_fill_discrete(Sepal.Width, Sepal.Length,
                     expression = Sepal.Width > Sepal.Length - 2.25,
                     colours = c("TRUE" = "#7D00FF")) + 
  rule_fill_gradient2(Petal.Length)
```

<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">
<thead>
<tr>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey;">
</th>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;">
Sepal.Length
</th>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;">
Sepal.Width
</th>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;">
Petal.Length
</th>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;">
Petal.Width
</th>
<th style="border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;">
Species
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: left;">
1
</td>
<td style="; background-color: #7D00FF; text-align: center;">
5.1
</td>
<td style="; background-color: #7D00FF; text-align: center;">
3.5
</td>
<td style="; background-color: #872B29; text-align: center;">
1.4
</td>
<td style="; background-color:; text-align: center;">
0.2
</td>
<td style="; background-color: #F8766D; text-align: center;">
setosa
</td>
</tr>
<tr>
<td style="text-align: left;">
2
</td>
<td style="; background-color: #7D00FF; text-align: center;">
4.9
</td>
<td style="; background-color: #7D00FF; text-align: center;">
3.0
</td>
<td style="; background-color: #872B29; text-align: center;">
1.4
</td>
<td style="; background-color:; text-align: center;">
0.2
</td>
<td style="; background-color: #F8766D; text-align: center;">
setosa
</td>
</tr>
<tr>
<td style="text-align: left;">
3
</td>
<td style="; background-color: #7D00FF; text-align: center;">
4.7
</td>
<td style="; background-color: #7D00FF; text-align: center;">
3.2
</td>
<td style="; background-color: #832424; text-align: center;">
1.3
</td>
<td style="; background-color:; text-align: center;">
0.2
</td>
<td style="; background-color: #F8766D; text-align: center;">
setosa
</td>
</tr>
<tr>
<td style="text-align: left;">
4
</td>
<td style="; background-color: #7D00FF; text-align: center;">
4.6
</td>
<td style="; background-color: #7D00FF; text-align: center;">
3.1
</td>
<td style="; background-color: #8C322F; text-align: center;">
1.5
</td>
<td style="; background-color:; text-align: center;">
0.2
</td>
<td style="; background-color: #F8766D; text-align: center;">
setosa
</td>
</tr>
<tr>
<td style="text-align: left;">
5
</td>
<td style="; background-color: #7D00FF; text-align: center;">
5.0
</td>
<td style="; background-color: #7D00FF; text-align: center;">
3.6
</td>
<td style="; background-color: #872B29; text-align: center;">
1.4
</td>
<td style="; background-color:; text-align: center;">
0.2
</td>
<td style="; background-color: #F8766D; text-align: center;">
setosa
</td>
</tr>
<tr>
<td style="text-align: left;">
6
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
5.6
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
2.5
</td>
<td style="; background-color: #E7CAC6; text-align: center;">
3.9
</td>
<td style="; background-color:; text-align: center;">
1.1
</td>
<td style="; background-color: #00BA38; text-align: center;">
versicolor
</td>
</tr>
<tr>
<td style="text-align: left;">
7
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
5.9
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
3.2
</td>
<td style="; background-color: #F9F9FC; text-align: center;">
4.8
</td>
<td style="; background-color:; text-align: center;">
1.8
</td>
<td style="; background-color: #00BA38; text-align: center;">
versicolor
</td>
</tr>
<tr>
<td style="text-align: left;">
8
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
6.1
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
2.8
</td>
<td style="; background-color: #EAD0CD; text-align: center;">
4.0
</td>
<td style="; background-color:; text-align: center;">
1.3
</td>
<td style="; background-color: #00BA38; text-align: center;">
versicolor
</td>
</tr>
<tr>
<td style="text-align: left;">
9
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
6.3
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
2.5
</td>
<td style="; background-color: #F4F2F9; text-align: center;">
4.9
</td>
<td style="; background-color:; text-align: center;">
1.5
</td>
<td style="; background-color: #00BA38; text-align: center;">
versicolor
</td>
</tr>
<tr>
<td style="text-align: left;">
10
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
6.1
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
2.8
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
4.7
</td>
<td style="; background-color:; text-align: center;">
1.2
</td>
<td style="; background-color: #00BA38; text-align: center;">
versicolor
</td>
</tr>
<tr>
<td style="text-align: left;">
11
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
6.4
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
2.9
</td>
<td style="; background-color: #F3E4E2; text-align: center;">
4.3
</td>
<td style="; background-color:; text-align: center;">
1.3
</td>
<td style="; background-color: #00BA38; text-align: center;">
versicolor
</td>
</tr>
<tr>
<td style="text-align: left;">
12
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
6.0
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
2.2
</td>
<td style="; background-color: #EEECF6; text-align: center;">
5.0
</td>
<td style="; background-color:; text-align: center;">
1.5
</td>
<td style="; background-color: #619CFF; text-align: center;">
virginica
</td>
</tr>
<tr>
<td style="text-align: left;">
13
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
6.9
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
3.2
</td>
<td style="; background-color: #C8C1E1; text-align: center;">
5.7
</td>
<td style="; background-color:; text-align: center;">
2.3
</td>
<td style="; background-color: #619CFF; text-align: center;">
virginica
</td>
</tr>
<tr>
<td style="text-align: left;">
14
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
5.6
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
2.8
</td>
<td style="; background-color: #F4F2F9; text-align: center;">
4.9
</td>
<td style="; background-color:; text-align: center;">
2.0
</td>
<td style="; background-color: #619CFF; text-align: center;">
virginica
</td>
</tr>
<tr>
<td style="text-align: left;">
15
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
7.7
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
2.8
</td>
<td style="; background-color: #9085C3; text-align: center;">
6.7
</td>
<td style="; background-color:; text-align: center;">
2.0
</td>
<td style="; background-color: #619CFF; text-align: center;">
virginica
</td>
</tr>
<tr>
<td style="text-align: left;">
16
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
6.3
</td>
<td style="; background-color: #FFFFFF; text-align: center;">
2.7
</td>
<td style="; background-color: #F4F2F9; text-align: center;">
4.9
</td>
<td style="; background-color:; text-align: center;">
1.8
</td>
<td style="; background-color: #619CFF; text-align: center;">
virginica
</td>
</tr>
<tr>
<td style="border-bottom: 2px solid grey; text-align: left;">
17
</td>
<td style="; background-color: #FFFFFF; border-bottom: 2px solid grey; text-align: center;">
6.7
</td>
<td style="; background-color: #FFFFFF; border-bottom: 2px solid grey; text-align: center;">
3.3
</td>
<td style="; background-color: #C8C1E1; border-bottom: 2px solid grey; text-align: center;">
5.7
</td>
<td style="; background-color:; border-bottom: 2px solid grey; text-align: center;">
2.1
</td>
<td style="; background-color: #619CFF; border-bottom: 2px solid grey; text-align: center;">
virginica
</td>
</tr>
</tbody>
</table>

------------------------------------------------------------------------

------------------------------------------------------------------------

### 3: desctable

A comprehensive descriptive and comparative tables generator for R.

[Documentation](https://cran.r-project.org/web/packages/desctable/vignettes/desctable.html)

#### Example

``` r
#install.packages("desctable")
library(desctable)

iris %>%
  desctable
```

    ##                         N    Mean/%        sd  Med IQR
    ## 1        Sepal.Length 150        NA        NA 5.80 1.3
    ## 2         Sepal.Width 150  3.057333 0.4358663   NA  NA
    ## 3        Petal.Length 150        NA        NA 4.35 3.5
    ## 4         Petal.Width 150        NA        NA 1.30 1.5
    ## 5             Species 150        NA        NA   NA  NA
    ## 6     Species: setosa  50 33.333333        NA   NA  NA
    ## 7 Species: versicolor  50 33.333333        NA   NA  NA
    ## 8  Species: virginica  50 33.333333        NA   NA  NA

``` r
#The object produced by desctable is in fact a list of data.frames, with a "desctable" class. Methods for reduction to a simple dataframe (as.data.frame, automatically used for printing), conversion to markdown (pander

mtcars %>%
  desctable %>%
  datatable
```

![](tableGallery_files/figure-markdown_github/desctable-1.png)

------------------------------------------------------------------------

------------------------------------------------------------------------

### 4: expss

Provides tabulation functions with support of SPSS-style labels, multiple / nested banners, weights and multiple-response variables.

[Documentation](https://cran.r-project.org/web/packages/expss/vignettes/TablesWithLabelsInR.html)

#### Example

``` r
#install.packages("expss")
library(expss)
data(mtcars)
mtcars = apply_labels(mtcars,
                      mpg = "Miles/(US) gallon",
                      cyl = "Number of cylinders",
                      disp = "Displacement (cu.in.)",
                      hp = "Gross horsepower",
                      drat = "Rear axle ratio",
                      wt = "Weight (1000 lbs)",
                      qsec = "1/4 mile time",
                      vs = "Engine",
                      vs = c("V-engine" = 0,
                             "Straight engine" = 1),
                      am = "Transmission",
                      am = c("Automatic" = 0,
                             "Manual"=1),
                      gear = "Number of forward gears",
                      carb = "Number of carburetors"
)

#For quick cross-tabulation there are fre and cro family of function. For simplicity we demonstrate here only cro_cpct which caluclates column percent. Documentation for other functions, such as cro_cases for counts, cro_rpct for row percent, cro_tpct for table percent and cro_fun for custom summary functions can be seen by typing ?cro and ?cro_fun in the console.

# 'cro' examples
# multiple banners
mtcars %>% 
    calculate(cro_cpct(cyl, list(total(), am, vs))) %>% 
    htmlTable(caption = "Table with multiple banners (column %).")
```

<!--html_preserve-->
<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">
<thead>
<tr>
<td colspan="8" style="text-align: left;">
Table with multiple banners (column %).
</td>
</tr>
<tr>
<th style="border-top: 2px solid grey;">
</th>
<th colspan="1" style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;">
 \#Total 
</th>
<th style="border-top: 2px solid grey;; border-bottom: hidden;">
 
</th>
<th colspan="2" style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;">
 Transmission 
</th>
<th style="border-top: 2px solid grey;; border-bottom: hidden;">
 
</th>
<th colspan="2" style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;">
 Engine 
</th>
</tr>
<tr>
<th style="font-weight: 900; border-bottom: 1px solid grey; text-align: center;">
</th>
<th style="border-bottom: 1px solid grey; text-align: center;">
</th>
<th style="border-bottom: 1px solid grey;" colspan="1">
 
</th>
<th style="border-bottom: 1px solid grey; text-align: center;">
 Automatic 
</th>
<th style="border-bottom: 1px solid grey; text-align: center;">
 Manual 
</th>
<th style="border-bottom: 1px solid grey;" colspan="1">
 
</th>
<th style="border-bottom: 1px solid grey; text-align: center;">
 V-engine 
</th>
<th style="border-bottom: 1px solid grey; text-align: center;">
 Straight engine 
</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="8" style="font-weight: 900;">
 Number of cylinders 
</td>
</tr>
<tr>
<td style="text-align: left;">
   4 
</td>
<td style="text-align: right;">
34.4
</td>
<td style colspan="1">
 
</td>
<td style="text-align: right;">
15.8
</td>
<td style="text-align: right;">
61.5
</td>
<td style colspan="1">
 
</td>
<td style="text-align: right;">
5.6
</td>
<td style="text-align: right;">
71.4
</td>
</tr>
<tr>
<td style="text-align: left;">
   6 
</td>
<td style="text-align: right;">
21.9
</td>
<td style colspan="1">
 
</td>
<td style="text-align: right;">
21.1
</td>
<td style="text-align: right;">
23.1
</td>
<td style colspan="1">
 
</td>
<td style="text-align: right;">
16.7
</td>
<td style="text-align: right;">
28.6
</td>
</tr>
<tr>
<td style="text-align: left;">
   8 
</td>
<td style="text-align: right;">
43.8
</td>
<td style colspan="1">
 
</td>
<td style="text-align: right;">
63.2
</td>
<td style="text-align: right;">
15.4
</td>
<td style colspan="1">
 
</td>
<td style="text-align: right;">
77.8
</td>
<td style="text-align: right;">
</td>
</tr>
<tr>
<td style="border-bottom: 2px solid grey; text-align: left;">
   \#Total cases 
</td>
<td style="border-bottom: 2px solid grey; text-align: right;">
32
</td>
<td style="border-bottom: 2px solid grey;" colspan="1">
 
</td>
<td style="border-bottom: 2px solid grey; text-align: right;">
19
</td>
<td style="border-bottom: 2px solid grey; text-align: right;">
13
</td>
<td style="border-bottom: 2px solid grey;" colspan="1">
 
</td>
<td style="border-bottom: 2px solid grey; text-align: right;">
18
</td>
<td style="border-bottom: 2px solid grey; text-align: right;">
14
</td>
</tr>
</tbody>
</table>
<!--/html_preserve-->

------------------------------------------------------------------------

------------------------------------------------------------------------

### 5: formattable

Designed for applying formatting on vectors and data frames to make data presentation easier, richer, more flexible and hopefully convey more information.

[Documentation](https://cran.r-project.org/web/packages/formattable/vignettes/introduction.html)

#### Example

``` r
#install.packages("formattable")
library(formattable)
p <- percent(c(0.1, 0.02, 0.03, 0.12))      # display values in percent format
p
```

    ## [1] 10.00% 2.00%  3.00%  12.00%

``` r
#works with arithmetic operations and other common functions and preserves its formatting.
p + 0.05
```

    ## [1] 15.00% 7.00%  8.00%  17.00%

------------------------------------------------------------------------

------------------------------------------------------------------------

### 6: kableExtra

Designed to help build common complex tables and manipulate table style. Comes with hoverable html tables, multi-column header and footnotes capabilities.

[Documentation](https://cran.r-project.org/web/packages/kableExtra/vignettes/awesome_table_in_html.html)

#### Example

``` r
#install.packages(knitr)
#install.packages("kableExtra")
library(knitr)
library(kableExtra)

dt <- mtcars[1:5, 1:6]

#Basic HTML Table
kable(dt)
```

|                   |   mpg|  cyl|  disp|   hp|  drat|     wt|
|-------------------|-----:|----:|-----:|----:|-----:|------:|
| Mazda RX4         |  21.0|    6|   160|  110|  3.90|  2.620|
| Mazda RX4 Wag     |  21.0|    6|   160|  110|  3.90|  2.875|
| Datsun 710        |  22.8|    4|   108|   93|  3.85|  2.320|
| Hornet 4 Drive    |  21.4|    6|   258|  110|  3.08|  3.215|
| Hornet Sportabout |  18.7|    8|   360|  175|  3.15|  3.440|

``` r
#HTML hoverable tables 
kable(dt, "html") %>%
   kable_styling(bootstrap_options = c("striped", "hover"))
```

<?xml version="1.0" encoding="UTF-8"?>
<table class="table table-striped table-hover" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
mpg
</th>
<th style="text-align:right;">
cyl
</th>
<th style="text-align:right;">
disp
</th>
<th style="text-align:right;">
hp
</th>
<th style="text-align:right;">
drat
</th>
<th style="text-align:right;">
wt
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Mazda RX4
</td>
<td style="text-align:right;">
21.0
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
160
</td>
<td style="text-align:right;">
110
</td>
<td style="text-align:right;">
3.90
</td>
<td style="text-align:right;">
2.620
</td>
</tr>
<tr>
<td style="text-align:left;">
Mazda RX4 Wag
</td>
<td style="text-align:right;">
21.0
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
160
</td>
<td style="text-align:right;">
110
</td>
<td style="text-align:right;">
3.90
</td>
<td style="text-align:right;">
2.875
</td>
</tr>
<tr>
<td style="text-align:left;">
Datsun 710
</td>
<td style="text-align:right;">
22.8
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
108
</td>
<td style="text-align:right;">
93
</td>
<td style="text-align:right;">
3.85
</td>
<td style="text-align:right;">
2.320
</td>
</tr>
<tr>
<td style="text-align:left;">
Hornet 4 Drive
</td>
<td style="text-align:right;">
21.4
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
258
</td>
<td style="text-align:right;">
110
</td>
<td style="text-align:right;">
3.08
</td>
<td style="text-align:right;">
3.215
</td>
</tr>
<tr>
<td style="text-align:left;">
Hornet Sportabout
</td>
<td style="text-align:right;">
18.7
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:right;">
360
</td>
<td style="text-align:right;">
175
</td>
<td style="text-align:right;">
3.15
</td>
<td style="text-align:right;">
3.440
</td>
</tr>
</tbody>
</table>
``` r
# Add Extra Header Rows
dt %>%
  kable("html") %>%
  kable_styling("striped") %>%
  add_header_above(c(" " = 1, "Group 1" = 2, "Group 2" = 2, "Group 3" = 2))
```

<?xml version="1.0" encoding="UTF-8"?>
<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="border-bottom:hidden"/>
<th style="text-align:center;" colspan="2">
Group 1
</th>
<th style="text-align:center;" colspan="2">
Group 2
</th>
<th style="text-align:center;" colspan="2">
Group 3
</th>
</tr>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
mpg
</th>
<th style="text-align:right;">
cyl
</th>
<th style="text-align:right;">
disp
</th>
<th style="text-align:right;">
hp
</th>
<th style="text-align:right;">
drat
</th>
<th style="text-align:right;">
wt
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Mazda RX4
</td>
<td style="text-align:right;">
21.0
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
160
</td>
<td style="text-align:right;">
110
</td>
<td style="text-align:right;">
3.90
</td>
<td style="text-align:right;">
2.620
</td>
</tr>
<tr>
<td style="text-align:left;">
Mazda RX4 Wag
</td>
<td style="text-align:right;">
21.0
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
160
</td>
<td style="text-align:right;">
110
</td>
<td style="text-align:right;">
3.90
</td>
<td style="text-align:right;">
2.875
</td>
</tr>
<tr>
<td style="text-align:left;">
Datsun 710
</td>
<td style="text-align:right;">
22.8
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
108
</td>
<td style="text-align:right;">
93
</td>
<td style="text-align:right;">
3.85
</td>
<td style="text-align:right;">
2.320
</td>
</tr>
<tr>
<td style="text-align:left;">
Hornet 4 Drive
</td>
<td style="text-align:right;">
21.4
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
258
</td>
<td style="text-align:right;">
110
</td>
<td style="text-align:right;">
3.08
</td>
<td style="text-align:right;">
3.215
</td>
</tr>
<tr>
<td style="text-align:left;">
Hornet Sportabout
</td>
<td style="text-align:right;">
18.7
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:right;">
360
</td>
<td style="text-align:right;">
175
</td>
<td style="text-align:right;">
3.15
</td>
<td style="text-align:right;">
3.440
</td>
</tr>
</tbody>
</table>
``` r
# Add footnote
dt %>%
  kable("html", caption = "Demo Table[note]") %>%
  kable_styling("striped") %>%
  add_header_above(c(" ", "Group 1[note]" = 3, "Group 2[note]" = 3)) %>%
  add_footnote(c("This table is from mtcars", 
                 "Group 1 contains mpg, cyl and disp", 
                 "Group 2 contains hp, drat and wt"), 
               notation = "symbol")
```

<?xml version="1.0" encoding="UTF-8"?>
<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<caption>
Demo Table<sup>\*</sup>
</caption>
<thead>
<tr>
<th style="border-bottom:hidden"/>
<th style="text-align:center;" colspan="3">
Group 1<sup>†</sup>
</th>
<th style="text-align:center;" colspan="3">
Group 2<sup>‡</sup>
</th>
</tr>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
mpg
</th>
<th style="text-align:right;">
cyl
</th>
<th style="text-align:right;">
disp
</th>
<th style="text-align:right;">
hp
</th>
<th style="text-align:right;">
drat
</th>
<th style="text-align:right;">
wt
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Mazda RX4
</td>
<td style="text-align:right;">
21.0
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
160
</td>
<td style="text-align:right;">
110
</td>
<td style="text-align:right;">
3.90
</td>
<td style="text-align:right;">
2.620
</td>
</tr>
<tr>
<td style="text-align:left;">
Mazda RX4 Wag
</td>
<td style="text-align:right;">
21.0
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
160
</td>
<td style="text-align:right;">
110
</td>
<td style="text-align:right;">
3.90
</td>
<td style="text-align:right;">
2.875
</td>
</tr>
<tr>
<td style="text-align:left;">
Datsun 710
</td>
<td style="text-align:right;">
22.8
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
108
</td>
<td style="text-align:right;">
93
</td>
<td style="text-align:right;">
3.85
</td>
<td style="text-align:right;">
2.320
</td>
</tr>
<tr>
<td style="text-align:left;">
Hornet 4 Drive
</td>
<td style="text-align:right;">
21.4
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
258
</td>
<td style="text-align:right;">
110
</td>
<td style="text-align:right;">
3.08
</td>
<td style="text-align:right;">
3.215
</td>
</tr>
<tr>
<td style="text-align:left;">
Hornet Sportabout
</td>
<td style="text-align:right;">
18.7
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:right;">
360
</td>
<td style="text-align:right;">
175
</td>
<td style="text-align:right;">
3.15
</td>
<td style="text-align:right;">
3.440
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td style="padding: 0; border:0;" colspan="100%">
<sup>\*</sup> This table is from mtcars
</td>
</tr>
<tr>
<td style="padding: 0; border:0;" colspan="100%">
<sup>†</sup> Group 1 contains mpg, cyl and disp
</td>
</tr>
<tr>
<td style="padding: 0; border:0;" colspan="100%">
<sup>‡</sup> Group 2 contains hp, drat and wt
</td>
</tr>
</tfoot>
</table>

------------------------------------------------------------------------

------------------------------------------------------------------------

### 7: tableby

Provides similar functionality as the SAS macros %table and %summary.

[Documentation](https://cran.r-project.org/web/packages/arsenal/vignettes/tableby.html)

#### Example

``` r
# install.packages("arsenal")
# install.packages("knitr")
# install.packages("survival")

require(arsenal)
require(knitr)
require(survival)
data(mockstudy) ##load data
#dim(mockstudy)  ##look at how many subjects and variables are in the dataset 

#Create a table stratified by treament arm, use a formula statement to specify the variables that you want summarized. The example below uses age (a continuous variable) and sex (a factor).

tab1 <- tableby(arm ~ sex + age, data=mockstudy)

summary(tab1, text=TRUE)
```

    ## 
    ## ---------------------------------------------------------------------------------------------------------------------------
    ##                          A: IFL (N=428)      F: FOLFOX (N=691)   G: IROX (N=380)     Total (N=1499)      p value           
    ## ----------------------- ------------------- ------------------- ------------------- ------------------- -------------------
    ## Sex                                                                                                                   0.190
    ##    Male                 277 (64.7%)         411 (59.5%)         228 (60%)           916 (61.1%)        
    ##    Female               151 (35.3%)         280 (40.5%)         152 (40%)           583 (38.9%)        
    ## Age in Years                                                                                                          0.614
    ##    Mean (SD)            59.7 (11.4)         60.3 (11.6)         59.8 (11.5)         60 (11.5)          
    ##    Q1, Q3               53, 68              52, 69              52, 68              52, 68             
    ##    Range                27 - 88             19 - 88             26 - 85             19 - 88            
    ## ---------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------

------------------------------------------------------------------------

### 8: Huxtable

A package for creating HTML and LaTeX tables. It provides similar functionality to xtable, but more, with a simpler interface.

[Documentation](https://hughjonesd.github.io/huxtable/)

#### Example

``` r
#install.packages("psych")
#install.packages("dplyr")
#install.packages("magrittr")
#install.packages("huxtable")

library(psych)
library(dplyr)
library(magrittr)
library(huxtable)

data(attitude)
att_corr <- corr.test(as.matrix(attitude))

as_hux(att_corr$r)                                                             %>%
      set_background_color(where(att_corr$p < 0.05), 'yellow')                 %>%
      set_background_color(where(att_corr$p < 0.01), 'orange')                 %>%
      set_background_color(where(row(att_corr$p) == col(att_corr$p)), 'white') %>%
      huxtable::add_rownames(colname = '')                                     %>%
      huxtable::add_colnames()                                                 %>%
      set_all_borders(1)
```

|          rating complaints privileges learning raises critical advance          |
|:-------------------------------------------------------------------------------:|
| | | rating | complaints | privileges | learning | raises | critical | advance | |

| | rating | 1.00 | 0.83 | 0.43 | 0.62 | 0.59 | 0.16 | 0.16 |     |
|-----------------------------------------------------------------|
| | complaints | 0.83 | 1.00 | 0.56 | 0.60 | 0.67 | 0.19 | 0.22 | |

| | privileges | 0.43 | 0.56 | 1.00 | 0.49 | 0.45 | 0.15 | 0.34 | |
|-----------------------------------------------------------------|
| | learning | 0.62 | 0.60 | 0.49 | 1.00 | 0.64 | 0.12 | 0.53 |   |

| | raises | 0.59 | 0.67 | 0.45 | 0.64 | 1.00 | 0.38 | 0.57 |   |
|---------------------------------------------------------------|
| | critical | 0.16 | 0.19 | 0.15 | 0.12 | 0.38 | 1.00 | 0.28 | |

| advance | 0.16 | 0.22 | 0.34 | 0.53 | 0.57 | 0.28 | 1.00 | ------------------------------------------------------------------------------------------

------------------------------------------------------------------------

------------------------------------------------------------------------

### 9: Others

List of tabling packages to be considered later

1.  [ascii](https://cran.r-project.org/web/packages/ascii/index.html)
2.  [ezsummary](https://cran.r-project.org/web/packages/ezsummary/index.html) (<https://cran.r-project.org/web/packages/ezsummary/README.html>)
3.  [gmodels::CrossTable()](https://www.rdocumentation.org/packages/gmodels/versions/2.16.2/topics/CrossTable)
4.  [Gtable with grid.draw, grid.table and tableGrob](https://cran.r-project.org/web/packages/gridExtra/vignettes/tableGrob.html)
5.  [Hmisc::latex](https://www.rdocumentation.org/packages/Hmisc/versions/4.0-3)
6.  [htmlTable](https://cran.r-project.org/web/packages/htmlTable/vignettes/tables.html)
7.  [janitor](https://cran.r-project.org/web/packages/janitor/vignettes/introduction.html)
8.  [kable](https://www.rdocumentation.org/packages/knitr/versions/1.16/topics/kable)
9.  [pander](https://www.r-project.org/nosvn/pandoc/pander.html)
10. [pixiedust](https://cran.r-project.org/web/packages/pixiedust/vignettes/advancedMagic.html)
11. [ReporteRs](http://www.sthda.com/english/wiki/create-and-format-word-documents-using-r-software-and-reporters-package)
12. [stargazer](https://www.r-statistics.com/2013/01/stargazer-package-for-beautiful-latex-tables-from-r-statistical-models-output/)
13. [Tableone](https://cran.r-project.org/web/packages/tableone/vignettes/introduction.html)
14. [tables](http://www.cyclismo.org/tutorial/R/tables.html)
15. [Tabular](https://cran.r-project.org/web/packages/tables/vignettes/tables.pdf)
16. [tangram](https://github.com/spgarbet/tangram/blob/master/vignettes/example.Rmd)
17. [texreg](https://diffuseprior.wordpress.com/2013/01/20/texreg-a-package-for-beautiful-and-easily-customizable-latex-regression-tables-from-r/)
18. [xtable](https://cran.r-project.org/web/packages/xtable/vignettes/OtherPackagesGallery.pdf)
19. [Ztable](https://cran.r-project.org/web/packages/ztable/vignettes/ztable.html)
