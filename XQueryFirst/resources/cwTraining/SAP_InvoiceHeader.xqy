let $documentContent := (doc("resources/cwTraining/SAP_Invoice.xml")/ZINV_ARDO/IDOC)  
for $E in $documentContent  

(:Header variables:)
let $iDocInvoiceType:=
  if (some $qualf in ('G2', 'RE', 'S1') satisfies $E/E1EDK14[QUALF = '015' and ORGID = $qualf])
  then 'CN'
  else 'IV'
let $iDocInvoiceTypeEancom:=
  if (some $qualf in ('G2', 'RE', 'S1') satisfies $E/E1EDK14[QUALF = '015' and ORGID = $qualf])
  then '381'
  else '380'
let $iDocInvoiceDt:= 
 data($E/E1EDK02[QUALF = '009']/DATUM)
let $iDocBuyerOrderDt:= 
 data($E/E1EDK02[QUALF = '002']/DATUM)
let $iDocDeliveryDt :=
  data($E/E1EDP01[1]/E1EDP03[IDDAT = '027']/DATUM )
let $iDocInvoiceDueDt:= 
 data($E/E1EDK03[IDDAT = '028']/DATUM)  
let $iDocDeliveryNote:= 
 data($E/E1EDK02[QUALF = '012']/BELNR)  
 
(:Payment terms :)
let $iDocPaymentTerms :=
  for $segment in $E/E1EDK18
  return
    <PaymentTerm>
      <Qual>{if ($segment/QUALF = '001') then 'DEF' else 'EXT'}</Qual>
	    {
	    if ($segment/PRZNT)
	    then <DiscountPct>{data($segment/PRZNT)}</DiscountPct>
	    else (),
	    if ($segment/TAGE)
	    then <NumDays>{data($segment/TAGE)}</NumDays>
	    else (),
	    if ($segment/ZTERM_TXT)
	    then <Remarks>{data($segment/ZTERM_TXT)}</Remarks>
	    else ()
	    }
    </PaymentTerm> 

return 
<Message>
	<Header>
		<iDocInvoiceNr>{data($E/E1EDK01/BELNR)}</iDocInvoiceNr>
		<iDocInvoiceType>{$iDocInvoiceType}</iDocInvoiceType>
		<iDocInvoiceTypeEancom>{$iDocInvoiceTypeEancom}</iDocInvoiceTypeEancom>
		<iDocInvoiceDt>{$iDocInvoiceDt}</iDocInvoiceDt>
		<iDocBuyerOrderDt>{$iDocBuyerOrderDt}</iDocBuyerOrderDt>
		<iDocDeliveryDt>{$iDocDeliveryDt}</iDocDeliveryDt>
		<iDocInvoiceDueDt>{$iDocInvoiceDueDt}</iDocInvoiceDueDt>
		<iDocCurrency>{data($E/E1EDK01/CURCY)}</iDocCurrency>
		<iDocDeliveryNote>{$iDocDeliveryNote}</iDocDeliveryNote>
	</Header>
	<PaymentTerms>
	  {$iDocPaymentTerms}
	</PaymentTerms>
</Message>
