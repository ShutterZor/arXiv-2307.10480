/*
Author:      Shutter Zor
Affiliation: School of Management, Xiamen University
Email:       Shutter_Z@outlook.com
*/



/* Stata Code for Text Analysis */
*- Reading .txt text
import delimited "TestFile.txt", delimiter("shutterzor", asstring) varnames(nonames) clear

*- Converting all letters to lower case
replace v1 = lower(v1)

*- Replacing punctuation marks with spaces
local punctuation "! # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ { | } ~ " `" 
foreach marks of local punctuation{
	replace v1 = subinstr(v1, "`marks'", " ", .)
}
replace v1 = ustrregexra(v1, "\t", " ")
replace v1 = ustrregexra(v1, "\n", " ")

*- Splitting words and counting the frequency of words
split v1, parse(" ")
drop v1
local Num = 1
foreach variable of varlist _all {
	/*
	   Saving the frequency for each line (text) in a separate temporary file.
	   Such as file1, file2, ..., fileN
	*/
	tempfile file`Num'
	preserve
		keep `variable'
		bys `variable': egen Count = count(`variable') 
		rename `variable' Word
		duplicates drop Word, force
		save "`file`Num''"
	restore
	local Num = `Num' + 1
}

	*- appending these temporary files as one comprehensive file
	clear
	gen Word = ""
	gen Count = .

	local fileNum = `Num' - 1
	forvalues i = 1/`fileNum' {
		append using "`file`i''"
	}
	drop if Word == ""
	bys Word: egen Total = sum(Count)
	duplicates drop Word, force
	keep Word Total
	save "wordCountResult.dta", replace


