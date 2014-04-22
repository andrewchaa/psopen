psopen
======

A simple powershell profile script that recursively finds a solution file and open it in visual studio


Most of time, we do things in the shell, whther it’s bash, powershell, or command prompt. We do git pull and run go.bat. Then, to open the solution, we have to launch Windows Explorer and rummage through folders to find the solution file, which often hides itself behind the project file. It’s often frustrating and painful (not physically, though). This is a solution to that problem. Thanks to Jon (https://github.com/jonfinerty) for the idea.

Installing
----------

1. Clone the psopen repository to your local machine
2. Start powershell prompt (of course, :-) )
3. From the psopen repository directory, run .\install.ps1
4. Reload powershell profile by running . $profile
4. Now it's ready. Enjoy!


How to use
----------
In powershell, in your project directory, type `Open-Solution` and press Enter. It should find your solution file in the current directory and subdirectories and start it in Visual Studio. Optionally you can specify a solution name for the command to search for, e.g. `Open-Solution mysolution` would open any mysolution.sln files it finds.

