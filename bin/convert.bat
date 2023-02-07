::========================================================::
:: Script to convert from XML to Tipo Record C1 format.   ::
:: Created by Fabio Noris <https://github.com/fabionoris> ::
::========================================================::

@echo off
chcp 65001 > NUL

:: Script path.
set SCRIPTPATH=%~dp0

:: Filename of the output file.
set RESULT=RESULT.txt

:: File containing the format.
set FORMATFILE=template.txt

:: Format extracted from the FORMATFILE.
set /p FORMATLINE=< %SCRIPTPATH%%FORMATFILE%

:: Location of the xml files.
set XMLLOCATION=xml\

:: Level of the user according to sript path.
set USERLEVEL=..\


if exist %SCRIPTPATH%\res\header.dat (
    type %SCRIPTPATH%\res\header.dat
) else (
    echo #########################################
    echo ##   XML to Tipo Record C1 Converter   ##
    echo ##        github.com/fabionoris        ##
    echo #########################################
    echo.
)

if not exist %SCRIPTPATH%%USERLEVEL%%XMLLOCATION%*.xml (
	echo Attenzione: nessun file xml trovato!
    echo Inserisci tutti i file XML che vuoi convertire nella cartella %XMLLOCATION%.
    echo Si noti che i filename devono tutti essere nel formato "nomefile.xml"
    echo.
    pause
    exit
)

if exist %SCRIPTPATH%%USERLEVEL%%RESULT%* (
	echo Attenzione: %RESULT% risulta presente nella cartella!
    echo Premi un tasto per aggiungere le conversioni allo stesso file,
    echo altrimenti chiudi la finestra per terminare il programma.
    echo.
    pause
    echo.
)

for %%f in (%SCRIPTPATH%%USERLEVEL%%XMLLOCATION%*.xml) do (
	echo Converto %%~nf
	%SCRIPTPATH%\lib\xmllint.exe --xpath "concat(%FORMATLINE%)" "%SCRIPTPATH%\..\xml\%%~nf.xml" >> %SCRIPTPATH%%USERLEVEL%%RESULT%
	echo. >> %SCRIPTPATH%%USERLEVEL%%RESULT%
)

echo.
echo %RESULT% creato
echo.

::notepad %RESULT%
pause