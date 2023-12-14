for $x in doc("courses.xml")/courses/course  
where $x/fees>5000  
order by $x/title  
return $x/title  