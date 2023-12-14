let $input := 5
let $result := 
  if ($input < 10) then
    fn:trace($input, "Input is less than 10")
  else
    $input
return $result
