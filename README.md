
# Kalender

POSIX-compatible shell scripts to generate holiday calendars in iCalendar format.

## Status

Currently generated calendar, for 2023:

- Sweden

## Usage

To generate a new calendar file for a specific year, run:

    ./holidays/swedish.sh <YEAR>

## License

The shell scripts are licensed under GPL, See the [LICENSE](LICENSE) file for details.

## Sources

Swedish holidays and common traditions:

- https://sv.m.wikipedia.org/wiki/Helgdagar_i_Sverige
- https://sv.m.wikipedia.org/wiki/Svenska_h%C3%B6gtider_och_traditioner

Solstice and Equinox Table Courtesy of Fred Espenak:

- https://www.astropixels.com/ephemeris/soleq2001.html

iCalendar format:

- https://en.wikipedia.org/wiki/ICalendar
- https://datatracker.ietf.org/doc/html/rfc5545

Validators:

- https://icalendar.org/validator.html
- https://icalvalidator.com/index.html

## TODO

- Add CI pipeline to generate new calendars every 31 december.
- Add event descriptions and info links?
