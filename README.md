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
