declare namespace my = "http://example.com";

let $input := 5

return
if ($input < 10) then
  fn:error(xs:QName("my:error-code"), "Input value must be greater than or equal to 10")
else
  $input
