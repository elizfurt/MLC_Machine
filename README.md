# MLC_Machine
Program uses MS-DOS and OCR to automate scanning and filing of Municipal Lien Certificates. Can be adapted for any type of document. 

## Required File Organization/Structure
<img width="415" alt="Screen Shot 2023-01-13 at 11 25 53 AM" src="https://user-images.githubusercontent.com/81473881/212370091-c8aa7a48-ae6c-4422-b81c-4e47f4e13808.png">

## Optional/recommended programs:
[Autophile, by David Khann](http://davidkann.blogspot.com/2014/07/autophile-automatically-sort-files-into.html)
This program allows you to automatically sort files into folders based on the folder names. 
[Bat to Exe Converter](https://www.battoexeconverter.com/)
This program will allow you to convert the bat file into an exe.

## Instructions
1. Set Local Drive R as the folder you want the MLC Machine to search in. 
2. Replace "MLC" with whatever kind of document you are looking for. Ex. Contract and Contract Request or Certificate and Certificate Request. 
3. If your folder has several folders that you do not want the Machine to search in, use *findstr /I /V /C:"**folder 1 to exclude**" /I /V /C:"**folder 2 to exclude**"*. (I did not need the program to search in Archive, Pending Files, Misc, Docs, etc., or any file listed as a Seller Rep as there would be no files with outstanding MLCs in them.)
4. If you're fun, download the Trivia file and place it into a new folder called "Morning". Replace "C:\Users\***Liz Furtado\Databases\Supporting Objects\*** Morning" with the folder the Trivia file is in. 
5. Download the Batch file, run it to ensure everything works.
6. *Optional: Convert Bat to Exe. Set the program to "Start Invisible" and set it to run in "Documents" (or whatever folder you'd like.)
7. Move the file (either bat or exe) to your start-up folder to have it run on start-up. 

## License
© Liz Furtado 2022

## Bugs and Issues
Please feel free to reach out via email with any bugs or issues. 
