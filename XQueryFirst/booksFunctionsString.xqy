(: fn:string-length
   ---------------- 
WRONG
for $x in doc("books.xml")/bookstore/book  
return
  <book>
    {data($x/title)}
    {fn:string-length($x/title as xs:string) cast as xs:integer}
  </book>

WORKS : The cast as xs:string is placed inside parentheses

for $x in doc("books.xml")/bookstore/book  
return
  <book>
    {data($x/title)} - {fn:string-length($x/title cast as xs:string) cast as xs:integer}
  </book>
:)

  
(: fn:string-concat
   ---------------- 
for $x in doc("books.xml")/bookstore/book  
return
  <book>
    {fn:concat(($x/title cast as xs:string),  " - ", ($x/price cast as xs:string))}
  </book>
:)


(: fn:string-join
   ---------------- 
THIS RETURNS LINES
for $title in doc("books.xml")/bookstore/book/title  
return
  <titles>{fn:string-join($title, ",")}</titles>
 

THIS RETURNS a String collection that can be concatenated
let $titles := doc("books.xml")/bookstore/book/title
return
  <titles>{fn:string-join($titles, ",")}</titles>
:) 

(: returns false
let $boolean := fn:boolean(1 = 2)
return $boolean
:)

(: returns true
let $boolean := fn:boolean(1 = 1)
return $boolean
:)

(: returns false
let $boolean := fn:not(1 = 1)
return $boolean
:)

(: returns true
let $boolean := fn:true()
return $boolean
:)

(: returns false
let $boolean := fn:false()
return $boolean
:)


(: returns 2023-12-14+01:00
let $current-date := fn:current-date()
return $current-date
:)

(: ERROR - NOT SUPPORTED
Static error on line 76 at column 27 of  near {...fn:current-datetime() retur...} 
  XPST0017: Unknown system function current-datetime()
    let $current-datetime := fn:current-datetime()
    return $current-datetime

SOLVED : 2023-12-14T15:43:47.381+01:00 using fn:current-dateTime() instead of fn:current-datetime()
    let $current-datetime := fn:current-dateTime()
    return $current-datetime
:)



(: returns 15:34:46.89+01:00
    let $current-time := fn:current-time()
    return $current-time
:)

(:
let $test = "Test"  
return $test
:)  