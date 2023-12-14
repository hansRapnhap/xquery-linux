    (: read courses with fees > 2000 :)  
    let $courses := doc("courses.xml")/courses/course[fees > 20]  
      
    for $x in $courses  
    return $x/title  