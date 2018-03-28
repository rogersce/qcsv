# qcsv
My q csv reader.

To read a csv file to a table:

```
tbl:.csv.guess_type .csv.read[;1b] `:myfile.csv;
```

The optional function .csv.guess_type falls back to type "C" if it cannot convert all values in a column to one of "IJFDTP". It will also convert char columns with a single value to "S".
