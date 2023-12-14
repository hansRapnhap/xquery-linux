    (: read the entire xml document :)  
    let $courses := doc("courses.xml")  
      
    for $x in $courses/courses/course  
    where $x/fees > 2000  
    return $x/title  