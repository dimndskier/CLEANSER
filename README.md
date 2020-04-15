# CLEANSER

## OVERVIEW
This suite of applications aides the user to build a tool for themselves to aid in the masking of certain details, such as:
* TO_Email,
* FROM_Email,
* The_Server's_Name
* Each IP Address

## Program Description
This program suite has two script that help to make a backup copy of the original file, and determine based on criteria established what patterns to seek out; these will be captured into a <file>.out copy that shows everything of relevance.  Using the results in the .out file set the sed script (cleanser.sed) up with all of the appropriate scripting; to be used by cleanser.sh which generates a totally new file ending in the .filtered extension.



# ChangeLog
date project-version-release -Author;
>      Comments

04/08/2020	-__CLEANSER-0.1.2__   `Issues={}` 	-WFrench;
>	Added vars4CLEANSER to centralize variables to have scripts source where needed.
>	Altered paths to be configured with variable, APPHome, so that this suite of software can be altered as necessary.


04/07/2020	-__CLEANSER-0.1.1__   `Issues={}`   -WFrench;
>	Added subdirectory creation to patt_finder.sh script, to ensure success.

04/07/2020	 -__CLEANSER-0.1.0__  `Issues={}`   -WFrench;
>	Initial scripting works pretty well.  This may be evolved later at some point.

