rebol []

testing: does [ print "it worked" ] 

parse-math: funct [
    {Turn a math expression like "4+4*4/(a+4)" into a rebol block}
    str
] [
    op: charset "*/+-^^()e<>=" 
    nop: complement op 
    out: copy [] 
    a: none 
    parse str [
        some [
            copy a some nop (append out a) 
            | copy a some op (append out a)
        ] 
        end
    ] 
    out: form out 
    foreach [a b] [
        "--" "+" 
        "+-" "-" 
        "*-" " * - " 
        "/-" " / - " 
        " e " "e" 
        " e- " "e-" 
        "^^" "** "
    ] [
        replace/all out a b
    ] 
    out
]

comment {
Parse-math parses regular math expressions as they appear in other languages and outputs a rebol block.

Examples
"2*3^2"                     [2 * 3 ** 2]
"2.3*54^p*23"       [2.3 * 54 ** p * 23]
"-32.45e65+45"      [- 32.45e+65 + 45]
"1e-1"                  [0.1]
"(4+a)*(a+234)"     [(4 + a) * (a + 234)]
}  

