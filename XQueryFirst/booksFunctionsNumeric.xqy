(: Returns the positive value 3.14
let $value := fn:abs(3.14)
return $value
:)

(: Returns the positive value 3.14
let $value := fn:abs(-3.14)
return $value
:)

(: returns 4
let $value := fn:ceiling(3.14)
return $value
:)

(:returns -4
let $value := fn:floor(-3.14)
return $value
:)

(:returns -3
let $value := fn:round(-3.14)
return $value
:)

(:returns 0
let $value := fn:round-half-to-even(0.5)
return $value
:)

(: returns 2
let $value := fn:round-half-to-even(1.5)
return $value
:)

(: returns 2
let $value := fn:round-half-to-even(2.5)
return $value
:)