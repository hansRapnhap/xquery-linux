let $documentContent := (doc("resources/cwTraining/SAP_Invoice.xml")/ZINV_ARDO/IDOC)  
for $E in $documentContent  

(:Party segment processing:)
let $partySegment :=
  let $partnerRoles :=
    if ($E//E1EDKA1[PARVW = 'ZE'])
    then ('RE', 'RS', 'ZE', 'RG')
    else ('RE', 'RS', 'AG', 'RG')

  for $partner in $E/E1EDKA1[PARVW = $partnerRoles]
  return
    <Party>
      <iDocQual>{
        if ($partner/PARVW = 'AG') then 'BY'
        else if ($partner/PARVW = 'RS') then 'SU'
        else if ($partner/PARVW = 'RE') then 'IV'
        else if ($partner/PARVW = 'RG') then 'PR'
        else if ($partner/PARVW = 'ZE') then 'BY'
        else () (: Handle other roles if needed :)
      }</iDocQual>
      <iDocGLN>{data($partner/ILNNR)}</iDocGLN>
      <iDocName>{string-join(($partner/NAME1, $partner/NAME2), ' ')}</iDocName>
      <iDocStreet>{data($partner/STRAS)}</iDocStreet>
      <iDocPostcode>{data($partner/PSTLZ)}</iDocPostcode>
      <iDocCity>{data($partner/ORT01)}</iDocCity>
      <iDocCountry>{data($partner/LAND1)}</iDocCountry>
      <iDocVATRegNumber>{
        if ($partner/PARVW = 'BY' or $partner/PARVW = 'IV' or $partner/PARVW = 'PR')
        then data($E//E1EDK01/KUNDEUINR)
        else if ($partner/PARVW = 'SU')
        then data($E//E1EDK01/EIGENUINR)
        else ()
      }</iDocVATRegNumber>
    </Party>

return
<Message>
  <Parties>
    {$partySegment}
  </Parties>
</Message>