#!/bin/sh

# Official holidays and other common traditions in Sweden,
# sources:
# - Official: https://sv.m.wikipedia.org/wiki/Helgdagar_i_Sverige
# - Extra:    https://sv.m.wikipedia.org/wiki/Svenska_h%C3%B6gtider_och_traditioner

# Exit on cmd errors and handle unset vars
set -eu # set -e infers with the year validator!

# Include common functions and data tables
. common.sh

# First and only argument to script is expected to be a year.
YEAR="$1"
validdate "$YEAR-01-01"
validyearrange "$YEAR"
spring=$(springequinox "$YEAR")
summer=$(summersolstice "$YEAR")
fall=$(  fallequinox "$YEAR")
winter=$(wintersolstice "$YEAR")
easter=$(easterday "$YEAR")

printhead
printevent "$YEAR-01-01" "Nyårsdagen"
printevent "$YEAR-01-05" "Trettondagsafton"
printevent "$YEAR-01-06" "Trettondedag jul"
printevent "$YEAR-02-06" "Samernas nationaldag"
printevent "$YEAR-02-14" "Alla hjärtans dag"

day=$(date -v-47d -jf "%Y-%m-%d" +"%Y-%m-%d" "$easter")
printevent "$day" "Fettisdagen"

printevent "$spring" "Vårdagjämning"
printevent "$YEAR-03-25" "Våffeldagen"

day=$(date -v-1d -v-sun -jf "%Y-%m-%d" +"%Y-%m-%d" "$YEAR-04-01")
printevent "$day" "Sommartid"

day=$(date -v-thu -jf "%Y-%m-%d" +"%Y-%m-%d" "$easter")
printevent "$day" "Skärtorsdagen"

day=$(date -v+1d -jf "%Y-%m-%d" +"%Y-%m-%d" "$day")
printevent "$day" "Långfredagen"

day=$(date -v+1d -jf "%Y-%m-%d" +"%Y-%m-%d" "$day")
printevent "$day" "Påskafton"
printevent "$easter" "Påskdagen"

day=$(date -v+1d -jf "%Y-%m-%d" +"%Y-%m-%d" "$easter")
printevent "$day" "Annandag påsk"

printevent "$YEAR-04-30" "Valborgsmässoafton" ""
printevent "$YEAR-05-01" "Första maj"

day=$(date -v+1d -v+thu -v+5w -jf "%Y-%m-%d" +"%Y-%m-%d" "$easter")
printevent "$day" "Kristi himmelsfärdsdag"

day=$(date -v+1d -v+sun -v+6w -v-1d -jf "%Y-%m-%d" +"%Y-%m-%d" "$easter")
printevent "$day" "Pingstafton"

day=$(date -v+1d -jf "%Y-%m-%d" +"%Y-%m-%d" "$day")
printevent "$day" "Pingstdagen"

day=$(date -v-sun -jf "%Y-%m-%d" +"%Y-%m-%d" "$YEAR-06-01")
printevent "$day" "Mors dag"

printevent "$YEAR-06-06" "Sveriges nationaldag"
printevent "$summer" "Sommarsolståndet"

day=$(date -v+fri -jf "%Y-%m-%d" +"%Y-%m-%d" "$YEAR-06-19")
printevent "$day" "Midsommarafton"

day=$(date -v+1d -jf "%Y-%m-%d" +"%Y-%m-%d" "$day")
printevent "$day" "Midsommardagen"

printevent "$fall" "Höstdagjämning"
printevent "$YEAR-10-04" "Kanelbullens dag"
printevent "$YEAR-10-24" "FN-dagen"

day=$(date -v-1d -v-sun -jf "%Y-%m-%d" +"%Y-%m-%d" "$YEAR-11-01")
printevent "$day" "Vintertid"

day=$(date -v+fri -jf "%Y-%m-%d" +"%Y-%m-%d" "$YEAR-10-30")
printevent "$day" "Allhelgonaafton"

day=$(date -v+1d -jf "%Y-%m-%d" +"%Y-%m-%d" "$day")
printevent "$day" "Alla helgons dag"

day=$(date -v+sun -v+1w -jf "%Y-%m-%d" +"%Y-%m-%d" "$YEAR-11-01")
printevent "$day" "Fars dag"

day=$(date -v+sun -jf "%Y-%m-%d" +"%Y-%m-%d" "$YEAR-11-27")
printevent "$day" "Första advent"

day=$(date -v+1d -v+sun -jf "%Y-%m-%d" +"%Y-%m-%d" "$day")
printevent "$day" "Andra advent"

day=$(date -v+1d -v+sun -jf "%Y-%m-%d" +"%Y-%m-%d" "$day")
printevent "$day" "Tredje advent"

day=$(date -v+1d -v+sun -jf "%Y-%m-%d" +"%Y-%m-%d" "$day")
printevent "$day" "Fjärde advent"

printevent "$YEAR-12-13" "Lucia"
printevent "$winter" "Vintersolståndet"
printevent "$YEAR-12-24" "Julafton"
printevent "$YEAR-12-25" "Juldagen"
printevent "$YEAR-12-26" "Annandag jul"
printevent "$YEAR-12-31" "Nyårsafton"
printfoot
