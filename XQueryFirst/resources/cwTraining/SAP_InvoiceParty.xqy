let $documentContent := (doc("resources/cwTraining/SAP_Invoice.xml")/ZINV_ARDO/IDOC)  
for $E in $documentContent  

(:Party segment processing:)
let $partnerSegment :=
  let $partnerRoles :=
    if ($E//E1EDKA1[PARVW = 'ZE'])
    then ('RE', 'RS', 'ZE', 'RG')
    else ('RE', 'RS', 'AG', 'RG')

  for $partner in $E/E1EDKA1[PARVW = $partnerRoles]
  return
    <GenericParty>
      <Role>{
        if ($partner/PARVW = 'AG') then 'BY'
        else if ($partner/PARVW = 'RS') then 'SU'
        else if ($partner/PARVW = 'RE') then 'IV'
        else if ($partner/PARVW = 'RG') then 'PR'
        else if ($partner/PARVW = 'ZE') then 'BY'
        else () (: Handle other roles if needed :)
      }</Role>
      <VATNumber>{
        if ($partner/PARVW = 'BY' or $partner/PARVW = 'IV' or $partner/PARVW = 'PR')
        then data($E//E1EDK01/KUNDEUINR)
        else if ($partner/PARVW = 'SU')
        then data($E//E1EDK01/EIGENUINR)
        else ()
      }</VATNumber>
      <GLN>{data($partner/ILNNR)}</GLN>
      <Name>{string-join(($partner/NAME1, $partner/NAME2), ' ')}</Name>
      <Street>{data($partner/STRAS)}</Street>
      <Postcode>{data($partner/PSTLZ)}</Postcode>
      <City>{data($partner/ORT01)}</City>
      <Country>{data($partner/LAND1)}</Country>
    </GenericParty>

return
<Message>
  <partnerSegment>
    <Partners>{$partnerSegment}</Partners>
  </partnerSegment>
</Message>