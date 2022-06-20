# Mercgen

Mercgen is a small series of ruby scripts to generate several random mercenary
companies for the game Dominions 5 by Illwinter and output them as a mod file.

To use:

Requires Ruby 3.0.1 and bundler installed. Run bundle install to install all the
needed gems.

Set environment variables for the mercenary mod name, the number of companies
(optional) and the name of the file where you want it to be output (including
the .dm filetype) (also optional)

```
MOD_NAME=my_merc_list bin/mercgen_runner

or

MOD_NAME=my_merc_list TOTAL_COMPANIES=200 OUTPUT_PATH='./custom/path/here.dm' bin/mercgen_runner
```
