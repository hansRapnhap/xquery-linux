(: THIS WORKS
for $book in doc("books.xml")/bookstore/book 
return if ($book/price >100)  
then $book else "None"
 :)
(:
XPST0008: Unresolved reference to variable $book
for $book in doc("books.xml")//book
return $book/title, $book/price castable as xs:decimal and xs:decimal($book/price) lt 10
:)

(: THIS WORKS :)
(:
for $book in doc("books.xml")//book
return $book/price castable as xs:decimal and xs:decimal($book/price) lt 10
:)

for $book in doc("books.xml")//book
where xs:decimal($book/price) gt 200
return <res>{$book/title, $book/price}</res> 


