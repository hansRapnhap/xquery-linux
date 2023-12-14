    
    (:
    let $items := ('orange', <apple/>, <fruit type="juicy"/>, <vehicle type="car">sentro</vehicle>, 1,2,3,'a','b',"abc")  
    :)
    let $items := (1,2,3,4,5,6)  
    
    let $count := count($items)  
    
    let $sum := sum($items)  
    
    let $avg := avg($items)  
    
    
    return  
    <result>  
       <count>{$count}</count>     
       <sum>{$sum}</sum>     
       <avg>{$avg}</avg>     
       <items>  
          {  
             for $item in $items  
             return <item>{$item}</item>  
          }  
       </items>     
    </result>  