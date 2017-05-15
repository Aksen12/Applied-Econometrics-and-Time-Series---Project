*Summarize the variables to get the descriptive statistics

Sum

*variable transformation

gen vfrall=mrall*10000
gen mmiles=vmiles/1000
gen lnperinc=ln(perinc)

*Correlation Test

corr mrall unrate perinc beertax mlda vmiles jaild comserd

*dry Regression model 1

reg vfrall unrate lnperinc beertax mlda mmiles i.jaild i.comserd

*PANEL DATA (Fixed effect State fixed) model 2

xtset state year
xtreg vfrall unrate lnperinc beertax mlda mmiles i.jaild i.comserd, fe
estimates store fixed
areg vfrall unrate lnperinc beertax mlda mmiles i.jaild i.comserd, absorb(state)

*PANEL DATA (Random effect)

xtreg vfrall unrate lnperinc beertax mlda mmiles i.jaild i.comserd, re
estimates store random

*HAUSMAN TEST

hausman fixed random

*PANEL DATA (Fixed effectState and Time fixed) model 3

xtreg vfrall unrate lnperinc beertax mlda mmiles i.jaild i.comserd i.year ,fe
testparm i.year
areg vfrall unrate lnperinc beertax mlda mmiles i.jaild i.comserd i.year, absorb(state)

*NO ECONOMIC CONDITION model 4

xtreg vfrall beertax mlda mmiles i.jaild i.comserd i.year, fe
areg vfrall beertax mlda mmiles i.jaild i.comserd i.year, absorb(state)

*JAIL OR COMMUNITY model 5

gen jailcoms=1jaild*
comserd
xtreg vfrall unrate lnperinc beertax mlda mmiles jailcoms i.year, fe
areg vfrall unrate lnperinc beertax mlda mmiles jailcoms i.year, absorb (state)

*SIGNIFICANT VARIABLES model 6

xtreg vfrall unrate lnperinc beertax i.year, fe
areg vfrall unrate lnperinc beertax i.year, absorb (state)