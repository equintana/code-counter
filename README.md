Code counter
====
- By Erlinis Quintana 
- erlinis.quintana@koombea.com

What is code counter?
--
This is a script read the file that you pass by as first argument in the terminal and tell you how many line of code have that file.

	You entered my_file.rb
	13 LOC

 If don't provide any file it will print the number of lines of code that my own script

How to use
--
	ruby code_counter.rb my_file.rb

What is not a line of code?
--
- In line comments. Every line  start with #
- Empty lines
- Block comments. Everything between =begin and =end

--


Stats
==

What is code counter?
--
Stats is a script which given a CSV file compound for 2 columns with samples data, where first one means 'x' and second one is means 'y' is capable to calculate:
- Regression parameters: βo and β₁
- Improved prediction: P,  where P = βo + β₁ * E ( E=386 )
- Correlation coefficient: r

How to use
--
	ruby stats.rb data.csv

where 'data.csv' is like this:

	130,186
	650,699
	99,132
	150,272
	128,291
	302,331
	95,199
	945,1890
	368,788
	961,1601

Output:

	Test data_1.csv> b0: -22.5401, b1: 1.7279, r: 0.9545, r2: 0.9111, p:644.4293



