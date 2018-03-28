.csv.standardize_cols:{`${ssr[;"#";"Num"] ssr[;"(";"_"] ssr[;" ";"_"] ssr[;".";"_"] ssr[;"\"";""] trim x} each x};

.csv.guess_type:{[tbl]
    guess:{[x]
        n:0; tlist:"IJFDTP";
        while[n < count tlist;
            if[not any null tlist[n]$x except ("";"nan";"-nan");:tlist[n]];
            n+:1;
            ];
        : "C"
        };

    guess_if_symbol:{$[1=count distinct x;"S";"C"]};
    typedict:guess each flip tbl;
    a:where "C"=typedict;
    typedict,: a!guess_if_symbol each tbl each a;
    typedict: _[;typedict] where typedict = "C";
    typedict:(key typedict)!(key typedict) {(y$;x)}' value typedict;
    : ![tbl;();0b;typedict]
    };

.csv.read:{[csvfile;has_hdr]
    colnames:`$ $[has_hdr;::;{"c",'string til count x}] "," vs $[-11h=type csvfile;first system "head -n 1 ",1 _ string csvfile;csvfile[0]];

    hdr:(count colnames)#"*";
    tbl:flip colnames!(hdr;",")0:csvfile;

    if[has_hdr; tbl:1 _ (.csv.standardize_cols value raze 1#tbl) xcol tbl;];
    : tbl
    };
