psopen
======

A powershell profile script that finds and opens your solution file in visual studio.


Most of time, we do things in the shell, whther it’s bash, powershell, or command prompt. We do git pull and run go.bat. Then, to open the solution, we have to launch Windows Explorer and rummage through folders to find the solution file, which often hides itself behind the project file. It’s often frustrating and painful (not physically, though). This is a solution to that problem. Thanks to Jon (https://github.com/jonfinerty) for the idea.

Installing
----------

1. Clone the psopen repository to your local machine
2. Start powershell prompt (of course, :-) )
3. From the psopen repository directory, run .\Install.ps1
4. Reload powershell profile by running . $profile
4. Now it's ready. Enjoy!


How to use
----------

### In the project direcotory
Type `Open-Solution` and press Enter. It will try to find and open your solution file in the current directory and subdirectories recursively. 

### In the direcotry where you have multiple solution files
e.g. `Open-Solution yoursolution`

It will search for yoursolution.sln recursively and open it, if it finds it

### Tab completion.
Once the script opens a solution file, it stores its path in `favs.xml`. `Open-Solution ` and press Tab. Then it will auto-complete the name of each stored solution file. If you manuall updates the file, please reload profile by typing `. $profile` and press ENTER.

