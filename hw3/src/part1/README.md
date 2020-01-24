# HW2

### Compie
```shell
make
```

### Clean
```shell
make clean
```

### Run
```shell
make run
```

> Hello,
>
> I have the following grammar,
>
> %skeleton "lalr1.cc"
> %require "3.0.2"
> %defines
> %define api.value.type variant
> %define api.token.constructor
> %define parse.assert
> %define api.token.prefix {TOK_}
> %locations
> %define parse.trace
>
> %token
>   END 0 "end of file"
>   ASSIGN ":="
>   MINUS  "-"
>   PLUS   "+"
>   STAR   "*"
>   SLASH  "/"
>   LP     "("
>   RP     ")"
>
> %token <int> NUMBER "number"
> %type  <int> exp
>
> %%
>
> %start unit;
>
> unit: exp { driver.result = $1; };
>
> %left "+" "-";
>
> %left "*" "/";
>
> exp:
>
> exp "+" exp { $$ = $1 + $3; }
>
> | exp "-" exp { $$ = $1 - $3; }
>
> | exp "*" exp { $$ = $1 - $3; }
>
> | exp "/" exp { $$ = $1 - $3; }
>
> | "(" exp ")" { $$ = $1; }
>
> | "number" { std::swap($$, $1); }
>
>
> %%
>
> When I try to create a parser from it, I get,
>
> $ bison testcase.yy
> testcase.yy:40.22-23: error: $1 of ‘exp’ has no declared type
>  | "(" exp ")" { $$ = $1; }
>
> I was following the C++ tutorial in the manual. I've checked my work  a
> couple of times, I don't see what I've done different from the tutorial in
> this example.
> I've clearly defined a type for "exp":
> %type  <int> exp
>
> So why the error message?
>
> Thank you for Bison!
> -Simbad.
>