@echo off
setlocal EnableDelayedExpansion
title BAT-STATION
color 0A
mode con: cols=70 lines=32

:: ---------- load save ----------
set coins=100
if exist save.dat set /p coins=<save.dat
set "s0=7  "
set "s1=BAR"
set "s2=CHR"
set "s3=STR"

set "VERSION=1.0"
set "UPDATE_URL=https://raw.githubusercontent.com/pygame-developer/BAT-STATION/main"
if "%UPDATE_URL:YOURNAME=%"=="%UPDATE_URL%" call :checkupdate

:: ---------- boot screen ----------
cls
echo.
echo.
echo        ____    _  _____       ____ _____  _  _____ ___ ___  _   _
echo       ^| __ )  / \^|_   _^|     / ___^|_   _^|/ \^|_   _^|_ _/ _ \^| \ ^| ^|
echo       ^|  _ \ / _ \ ^| ^|  ____ \___ \ ^| ^| / _ \ ^| ^|  ^| ^| ^| ^| ^|  \^| ^|
echo       ^| ^|_) / ___ \^| ^| ^|____^| ___) ^|^| ^|/ ___ \^| ^|  ^| ^| ^|_^| ^| ^|\  ^|
echo       ^|____/_/   \_\_^|       ^|____/ ^|_/_/   \_\_^| ^|___\___/^|_^| \_^|
echo.
echo                       [ booting game system... ]
echo.
echo.
<nul set /p "=        Checking memory             ["
for /l %%i in (1,1,20) do (
    <nul set /p "=#"
    ping -n 1 -w 30 127.0.0.1 >nul
)
echo ]
timeout /t 1 /nobreak >nul
<nul set /p "=        Loading graphics driver     ["
for /l %%i in (1,1,20) do (
    <nul set /p "=#"
    ping -n 1 -w 30 127.0.0.1 >nul
)
echo ]
timeout /t 1 /nobreak >nul
<nul set /p "=        Mounting save data          ["
for /l %%i in (1,1,20) do (
    <nul set /p "=#"
    ping -n 1 -w 30 127.0.0.1 >nul
)
echo ]
timeout /t 1 /nobreak >nul
<nul set /p "=        Warming up the slot reels   ["
for /l %%i in (1,1,20) do (
    <nul set /p "=#"
    ping -n 1 -w 30 127.0.0.1 >nul
)
echo ]
timeout /t 1 /nobreak >nul
<nul set /p "=        Shuffling the dice          ["
for /l %%i in (1,1,20) do (
    <nul set /p "=#"
    ping -n 1 -w 30 127.0.0.1 >nul
)
echo ]
timeout /t 1 /nobreak >nul
<nul set /p "=        Scanning game library       ["
for /l %%i in (1,1,20) do (
    <nul set /p "=#"
    ping -n 1 -w 30 127.0.0.1 >nul
)
echo ]
timeout /t 1 /nobreak >nul
<nul set /p "=        Calibrating controllers     ["
for /l %%i in (1,1,20) do (
    <nul set /p "=#"
    ping -n 1 -w 30 127.0.0.1 >nul
)
echo ]
timeout /t 1 /nobreak >nul
<nul set /p "=        Ready                       ["
for /l %%i in (1,1,20) do (
    <nul set /p "=#"
    ping -n 1 -w 30 127.0.0.1 >nul
)
echo ]
timeout /t 1 /nobreak >nul
timeout /t 1 >nul

:: ---------- main menu ----------
:menu
>save.dat echo !coins!
cls
echo ======================================================================
echo   BAT-STATION                                      COINS: !coins!
echo ======================================================================
echo.
echo        [1]  Guess the Number
echo        [2]  Rock Paper Scissors
echo        [3]  Slot Machine         (10 coins per spin)
echo        [4]  Dice Duel            (bet 10 coins)
echo        [5]  Game Library         (launch .exe/.lnk/.bat in \games)
echo.
echo        [R]  Reset coins          [Q]  Power off
echo.
echo ======================================================================
choice /c 12345RQ /n /m "  Select: "
set sel=%errorlevel%
if %sel%==7 goto quit
if %sel%==6 (set coins=100 & goto menu)
if %sel%==5 goto library
if %sel%==4 goto dice
if %sel%==3 goto slots
if %sel%==2 goto rps
if %sel%==1 goto guess
goto menu

:: ---------- 1. guess ----------
:guess
cls
echo ===== GUESS THE NUMBER =====
echo I'm thinking of a number from 1 to 100.
set /a secret=%random% %% 100 + 1
set tries=0
:guessloop
set "g="
set /p "g=Your guess: "
set /a gv=0+!g! 2>nul
set /a tries+=1
if !gv! LSS !secret! echo   Higher...& goto guessloop
if !gv! GTR !secret! echo   Lower...& goto guessloop
set /a reward=60-tries*5
if !reward! LSS 5 set reward=5
set /a coins+=reward
echo.
echo   CORRECT in !tries! tries!  +!reward! coins
pause >nul
goto menu

:: ---------- 2. rock paper scissors ----------
:rps
cls
echo ===== ROCK PAPER SCISSORS (win = +10 coins) =====
echo.
choice /c RPSB /n /m "  [R]ock  [P]aper  [S]cissors  [B]ack: "
set me=%errorlevel%
if %me%==4 goto menu
set /a cpu=%random% %% 3 + 1
set "n1=Rock"& set "n2=Paper"& set "n3=Scissors"
echo.
echo   You: !n%me%!    CPU: !n%cpu%!
if %me%==%cpu% (echo   Draw.) else (
    set /a r=^(me-cpu+3^) %% 3
    if !r!==1 (echo   YOU WIN  +10 & set /a coins+=10) else (echo   You lose.)
)
pause >nul
goto rps

:: ---------- 3. slots ----------
:slots
cls
echo ===== SLOT MACHINE =====
if !coins! LSS 10 (echo   Not enough coins. & pause >nul & goto menu)
set /a coins-=10
set /a r1=%random% %% 4, r2=%random% %% 4, r3=%random% %% 4
call set "a=%%s!r1!%%"
call set "b=%%s!r2!%%"
call set "c=%%s!r3!%%"
echo.
echo        +-----+-----+-----+
echo        ^| !a! ^| !b! ^| !c! ^|
echo        +-----+-----+-----+
echo.
if !r1!==!r2! if !r2!==!r3! (echo   JACKPOT!  +100 & set /a coins+=100 & goto slotsend)
if !r1!==!r2! (echo   Pair!  +20 & set /a coins+=20 & goto slotsend)
if !r2!==!r3! (echo   Pair!  +20 & set /a coins+=20 & goto slotsend)
if !r1!==!r3! (echo   Pair!  +20 & set /a coins+=20 & goto slotsend)
echo   No luck.
:slotsend
echo   Coins: !coins!
choice /c YN /n /m "  Spin again? [Y/N] "
if %errorlevel%==1 goto slots
goto menu

:: ---------- 4. dice duel ----------
:dice
cls
echo ===== DICE DUEL (bet 10, higher total wins) =====
if !coins! LSS 10 (echo   Not enough coins. & pause >nul & goto menu)
set /a coins-=10
set /a p=%random% %% 6 + 1 + %random% %% 6 + 1
set /a d=%random% %% 6 + 1 + %random% %% 6 + 1
echo.
echo   You rolled: !p!     Dealer rolled: !d!
if !p! GTR !d! (echo   YOU WIN  +20 & set /a coins+=20) else if !p!==!d! (echo   Push, bet returned. & set /a coins+=10) else (echo   Dealer wins.)
pause >nul
goto menu

:: ---------- 5. library ----------
:library
cls
echo ===== GAME LIBRARY =====
if not exist games mkdir games
set n=0
for %%f in ("games\*.exe" "games\*.lnk" "games\*.bat") do (
    set /a n+=1
    set "g!n!=%%~ff"
    echo   [!n!] %%~nf
)
if !n!==0 (
    echo   Empty. Drop shortcuts or games into the "games" folder.
    pause >nul
    goto menu
)
echo.
set "pick="
set /p "pick=  Number to launch (Enter = back): "
if not defined pick goto menu
if defined g!pick! start "" "!g%pick%!"
goto library

:: ---------- quit ----------
:quit
>save.dat echo !coins!
cls
echo.
echo   Saving... Thanks for playing. Final coins: !coins!
timeout /t 2 >nul
endlocal
exit /b

:: ---------- auto update ----------
:checkupdate
set "latest="
curl -s -f -m 4 "%UPDATE_URL%/version.txt" -o "%temp%\bs_ver.txt" 2>nul
if not exist "%temp%\bs_ver.txt" exit /b
set /p latest=<"%temp%\bs_ver.txt"
del "%temp%\bs_ver.txt" >nul 2>&1
if not defined latest exit /b
if "!latest!"=="!VERSION!" exit /b
cls
echo.
echo   UPDATE AVAILABLE:  v!VERSION!  -^>  v!latest!
echo.
choice /c YN /n /m "  Install now? [Y/N] "
if errorlevel 2 exit /b
curl -s -f -m 30 "%UPDATE_URL%/BAT-STATION.bat" -o "%~dp0BAT-STATION.new"
if errorlevel 1 (
    echo   Download failed, continuing with current version.
    pause >nul
    exit /b
)
(
echo @echo off
echo timeout /t 1 /nobreak ^>nul
echo move /y "%~dp0BAT-STATION.new" "%~f0" ^>nul
echo start "" "%~f0"
echo del "%%~f0"
) > "%temp%\bs_update.bat"
start "" "%temp%\bs_update.bat"
exit
