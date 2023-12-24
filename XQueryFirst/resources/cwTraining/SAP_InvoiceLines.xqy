let $documentContent := (doc("resources/cwTraining/SAP_Invoice.xml")/ZINV_ARDO/IDOC)  
for $E in $documentContent  

(:Lines processing:)

for $e1edp01 in $E/E1EDP01
return
<Message>
  <Lines>
    <Line>
	    <LineId>{data($e1edp01/POSEX)}</LineId>
	    <GTINArticle>{data($e1edp01/ZMARM1[ALTERNATIVEUNIT = 'TU']/EAN)}</GTINArticle>
	    <BuyerArticleCode>{data($e1edp01/E1EDP19[QUALF = '001']/IDTNR)}</BuyerArticleCode>
	    <DeliveredQty>{data($e1edp01/MENGE)}</DeliveredQty>
	    <InvoicedQty>{data($e1edp01/MENGE)}</InvoicedQty>
	    <InvoicedUOM>{data($e1edp01/MENEE)}</InvoicedUOM>
	    <Price>{data($e1edp01/E1EDP05[1]/BETRG) div data($e1edp01/MENGE)}</Price>
	    <LineTotal>
	      {
        let $total := xs:decimal($e1edp01/E1EDP26[QUALF = '002']/BETRG + $e1edp01/E1EDP04/MWSBT)
        return format-number(round($total, 4), '0.0000')
        }
      </LineTotal>
	    <VatPct>{data($e1edp01/E1EDP04/MSATZ)}</VatPct>
  	</Line>
  </Lines>
</Message>
  