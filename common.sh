#!/bin/sh

author="lmas"
repo="github.com/lmas/kalender"
version="0.1"
today=$(date -u +"%Y%m%dT%H%M%SZ")

# Print error msg and exit
error() {
    echo "Error: $1"
    exit 1
}

# Check if date is valid
validdate() {
    date="$1"
    # Check exit condition
    if ! validate=$(date -jf "%Y-%m-%d" +"" "$date" 2>&1); then
        error "$date is not valid"
    fi

    # Check for any warnings
    if [ -n "$validate" ]; then
        error "$date is not valid"
    fi
}

# Check if year is within range
validyearrange() {
    year="$1"
    if [ "$year" -lt 2000 ]; then
        error "Year before 2000 not supported: $year"
    fi
    if [ "$year" -gt 2099 ]; then
        error "Year after 2000 not supported: $year"
    fi
}

# Print the ical header to stdout (notice that lines needs to end with CRLF)
printhead() {
    cat << eof
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//$author//NONSGML $repo v$version//EN
eof
}

# Print the ical footer
printfoot() {
    echo "END:VCALENDAR
}

# Print a formatted ical event
printevent() {
    date="$1"
    title="$2"
    validdate "$date"
    start=$(date -jf "%Y-%m-%d" +"%Y%m%d" "$date")
    stop=$(date -v+1d -jf "%Y-%m-%d" +"%Y%m%d" "$date")
    uuid=$(uuidgen -r)

    cat << eof
BEGIN:VEVENT
CLASS:PUBLIC
DTEND;VALUE=DATE:$stop
DTSTAMP:$today
DTSTART;VALUE=DATE:$start
SUMMARY:$title
TRANSP:TRANSPARENT
UID:$uuid
END:VEVENT
eof
}

springequinox() {
    echo "$_spring"  | grep -oe "$1-[0-9][0-9]-[0-9][0-9]"
}

summersolstice() {
    echo "$_summer"  | grep -oe "$1-[0-9][0-9]-[0-9][0-9]"
}

fallequinox() {
    echo "$_fall"  | grep -oe "$1-[0-9][0-9]-[0-9][0-9]"
}

wintersolstice() {
    echo "$_winter"  | grep -oe "$1-[0-9][0-9]-[0-9][0-9]"
}

easterday() {
    echo "$_easter"  | grep -oe "$1-[0-9][0-9]-[0-9][0-9]"
}

################################################################################

# Precomputed dates for spring/fall equinox, summer/winter solstice and easter.
# (Solstice and Equinox Table Courtesy of Fred Espenak)
# sources:
# - https://www.astropixels.com/ephemeris/soleq2001.html
# - https://sv.m.wikipedia.org/wiki/P%C3%A5skdagen

# Spring equinox
_spring="  2000-03-20 2001-03-20 2002-03-20 2003-03-21 2004-03-20 2005-03-20
2006-03-20 2007-03-21 2008-03-20 2009-03-20 2010-03-20 2011-03-20 2012-03-20
2013-03-20 2014-03-20 2015-03-20 2016-03-20 2017-03-20 2018-03-20 2019-03-20
2020-03-20 2021-03-20 2022-03-20 2023-03-20 2024-03-20 2025-03-20 2026-03-20
2027-03-20 2028-03-20 2029-03-20 2030-03-20 2031-03-20 2032-03-20 2033-03-20
2034-03-20 2035-03-20 2036-03-20 2037-03-20 2038-03-20 2039-03-20 2040-03-20
2041-03-20 2042-03-20 2043-03-20 2044-03-19 2045-03-20 2046-03-20 2047-03-20
2048-03-19 2049-03-20 2050-03-20 2051-03-20 2052-03-19 2053-03-20 2054-03-20
2055-03-20 2056-03-19 2057-03-20 2058-03-20 2059-03-20 2060-03-19 2061-03-20
2062-03-20 2063-03-20 2064-03-19 2065-03-20 2066-03-20 2067-03-20 2068-03-19
2069-03-20 2070-03-20 2071-03-20 2072-03-19 2073-03-20 2074-03-20 2075-03-20
2076-03-19 2077-03-19 2078-03-20 2079-03-20 2080-03-19 2081-03-19 2082-03-20
2083-03-20 2084-03-19 2085-03-19 2086-03-20 2087-03-20 2088-03-19 2089-03-19
2090-03-20 2091-03-20 2092-03-19 2093-03-19 2094-03-20 2095-03-20 2096-03-19
2097-03-19 2098-03-20 2099-03-20"

# Summer solstice
_summer="  2000-06-21 2001-06-21 2002-06-21 2003-06-21 2004-06-21 2005-06-21
2006-06-21 2007-06-21 2008-06-21 2009-06-21 2010-06-21 2011-06-21 2012-06-20
2013-06-21 2014-06-21 2015-06-21 2016-06-20 2017-06-21 2018-06-21 2019-06-21
2020-06-20 2021-06-21 2022-06-21 2023-06-21 2024-06-20 2025-06-21 2026-06-21
2027-06-21 2028-06-20 2029-06-21 2030-06-21 2031-06-21 2032-06-20 2033-06-21
2034-06-21 2035-06-21 2036-06-20 2037-06-21 2038-06-21 2039-06-21 2040-06-20
2041-06-20 2042-06-21 2043-06-21 2044-06-20 2045-06-20 2046-06-21 2047-06-21
2048-06-20 2049-06-20 2050-06-21 2051-06-21 2052-06-20 2053-06-20 2054-06-21
2055-06-21 2056-06-20 2057-06-20 2058-06-21 2059-06-21 2060-06-20 2061-06-20
2062-06-21 2063-06-21 2064-06-20 2065-06-20 2066-06-21 2067-06-21 2068-06-20
2069-06-20 2070-06-20 2071-06-21 2072-06-20 2073-06-20 2074-06-20 2075-06-21
2076-06-20 2077-06-20 2078-06-20 2079-06-21 2080-06-20 2081-06-20 2082-06-20
2083-06-21 2084-06-20 2085-06-20 2086-06-20 2087-06-21 2088-06-20 2089-06-20
2090-06-20 2091-06-21 2092-06-20 2093-06-20 2094-06-20 2095-06-21 2096-06-20
2097-06-20 2098-06-20 2099-06-20"

# Fall equinox
_fall="    2000-09-22 2001-09-22 2002-09-23 2003-09-23 2004-09-22 2005-09-22
2006-09-23 2007-09-23 2008-09-22 2009-09-22 2010-09-23 2011-09-23 2012-09-22
2013-09-22 2014-09-23 2015-09-23 2016-09-22 2017-09-22 2018-09-23 2019-09-23
2020-09-22 2021-09-22 2022-09-23 2023-09-23 2024-09-22 2025-09-22 2026-09-23
2027-09-23 2028-09-22 2029-09-22 2030-09-22 2031-09-23 2032-09-22 2033-09-22
2034-09-22 2035-09-23 2036-09-22 2037-09-22 2038-09-22 2039-09-23 2040-09-22
2041-09-22 2042-09-22 2043-09-23 2044-09-22 2045-09-22 2046-09-22 2047-09-23
2048-09-22 2049-09-22 2050-09-22 2051-09-23 2052-09-22 2053-09-22 2054-09-22
2055-09-23 2056-09-22 2057-09-22 2058-09-22 2059-09-23 2060-09-22 2061-09-22
2062-09-22 2063-09-22 2064-09-22 2065-09-22 2066-09-22 2067-09-22 2068-09-22
2069-09-22 2070-09-22 2071-09-22 2072-09-22 2073-09-22 2074-09-22 2075-09-22
2076-09-22 2077-09-22 2078-09-22 2079-09-22 2080-09-22 2081-09-22 2082-09-22
2083-09-22 2084-09-22 2085-09-22 2086-09-22 2087-09-22 2088-09-22 2089-09-22
2090-09-22 2091-09-22 2092-09-21 2093-09-22 2094-09-22 2095-09-22 2096-09-21
2097-09-22 2098-09-22 2099-09-22"

# Winter solstice
_winter="  2000-12-21 2001-12-21 2002-12-22 2003-12-22 2004-12-21 2005-12-21
2006-12-22 2007-12-22 2008-12-21 2009-12-21 2010-12-21 2011-12-22 2012-12-21
2013-12-21 2014-12-21 2015-12-22 2016-12-21 2017-12-21 2018-12-21 2019-12-22
2020-12-21 2021-12-21 2022-12-21 2023-12-22 2024-12-21 2025-12-21 2026-12-21
2027-12-22 2028-12-21 2029-12-21 2030-12-21 2031-12-22 2032-12-21 2033-12-21
2034-12-21 2035-12-22 2036-12-21 2037-12-21 2038-12-21 2039-12-22 2040-12-21
2041-12-21 2042-12-21 2043-12-22 2044-12-21 2045-12-21 2046-12-21 2047-12-21
2048-12-21 2049-12-21 2050-12-21 2051-12-21 2052-12-21 2053-12-21 2054-12-21
2055-12-21 2056-12-21 2057-12-21 2058-12-21 2059-12-21 2060-12-21 2061-12-21
2062-12-21 2063-12-21 2064-12-21 2065-12-21 2066-12-21 2067-12-21 2068-12-21
2069-12-21 2070-12-21 2071-12-21 2072-12-21 2073-12-21 2074-12-21 2075-12-21
2076-12-21 2077-12-21 2078-12-21 2079-12-21 2080-12-20 2081-12-21 2082-12-21
2083-12-21 2084-12-20 2085-12-21 2086-12-21 2087-12-21 2088-12-20 2089-12-21
2090-12-21 2091-12-21 2092-12-20 2093-12-21 2094-12-21 2095-12-21 2096-12-20
2097-12-21 2098-12-21 2099-12-21"

# Easter
_easter="  2000-04-23 2001-04-15 2002-03-31 2003-04-20 2004-04-11 2005-03-27
2006-04-16 2007-04-08 2008-03-23 2009-04-12 2010-04-04 2011-04-24 2012-04-08
2013-03-31 2014-04-20 2015-04-05 2016-03-27 2017-04-16 2018-04-01 2019-04-21
2020-04-12 2021-04-04 2022-04-17 2023-04-09 2024-03-31 2025-04-20 2026-04-05
2027-03-28 2028-04-16 2029-04-01 2030-04-21 2031-04-13 2032-03-28 2033-04-17
2034-04-09 2035-03-25 2036-04-13 2037-04-05 2038-04-25 2039-04-10 2040-04-01
2041-04-21 2042-04-06 2043-03-29 2044-04-17 2045-04-09 2046-03-25 2047-04-14
2048-04-05 2049-04-18 2050-04-10 2051-04-02 2052-04-21 2053-04-06 2054-03-29
2055-04-18 2056-04-02 2057-04-22 2058-04-14 2059-03-30 2060-04-18 2061-04-10
2062-03-26 2063-04-15 2064-04-06 2065-03-29 2066-04-11 2067-04-03 2068-04-22
2069-04-14 2070-03-30 2071-04-19 2072-04-10 2073-03-26 2074-04-15 2075-04-07
2076-04-19 2077-04-11 2078-04-03 2079-04-23 2080-04-07 2081-03-30 2082-04-19
2083-04-04 2084-03-26 2085-04-15 2086-03-31 2087-04-20 2088-04-11 2089-04-03
2090-04-16 2091-04-08 2092-03-30 2093-04-12 2094-04-04 2095-04-24 2096-04-15
2097-03-31 2098-04-20 2099-04-12"
