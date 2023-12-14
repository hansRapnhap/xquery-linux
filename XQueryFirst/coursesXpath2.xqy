    (: read all courses :)  
    let $courses := doc("courses.xml")/courses/course  
      
    for $x in $courses  
    where $x/fees > 2000  
    return $x/title  