.csv.standardize_cols:{`${ssr[;"#";"Num"] ssr[;")";"_"] ssr[;"(";"_"] ssr[;" ";"_"] ssr[;".";"_"] ssr[;"\"";""] trim x} each x};

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
    tbl:$[-11h=type csvfile;read0 csvfile;csvfile];
    colnames:$[has_hdr;.csv.standardize_cols;{`$"c",'string til count x}] "," vs tbl[0];

    hdr:(count colnames)#"*";
    tbl:flip colnames!(hdr;",")0:tbl;

    : $[has_hdr;1_tbl;tbl]
    };
