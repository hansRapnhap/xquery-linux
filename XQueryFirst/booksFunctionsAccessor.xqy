(: fn:node-name - return the node name
   ------------

for $x in doc("books.xml")/bookstore/book
order by $x/title  
return fn:node-name($x/title)
:)


(: fn:nilled DOES NOT WORK - whether the argument node is nil
   ---------
not all XQuery processors support the fn:nilled function, and its behavior may vary. 

for $x in doc("books.xml")/bookstore/book
order by $x/title  
return fn:nilled($x/title)
WORKAROUND:
:)
for $x in doc("books.xml")/bookstore/book
order by $x/title  
return exists($x/title/@xsi:nil) and $x/title/@xsi:nil = "true"



(: fn:data - return a sequence of atomic values.
   ------- 
for $x in doc("books.xml")/bookstore/book
order by $x/title  
return fn:data($x/title)
:)


(: base-uri
   --------
   file:/home/hanscardoen/eclipse-2312/initial-workspace/XQueryFirst/books.xml

for $x in doc("books.xml")/bookstore/book
order by $x/title  
return fn:base-uri($x/title)
:)

(: document-uri - DOES NOT WORK on tag level
   --------
for $x in doc("books.xml")/bookstore/book
order by $x/title  
return fn:document-uri($x/title)     
 
for $x in doc("books.xml")/bookstore
order by $x/title  
return fn:document-uri($x)  

THIS WORKS:

for $x in doc("books.xml")
order by $x/title  
return fn:document-uri($x) 
:)









