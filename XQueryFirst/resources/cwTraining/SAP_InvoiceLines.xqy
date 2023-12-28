let $documentContent := (doc("resources/cwTraining/SAP_Invoice.xml")/ZINV_ARDO/IDOC)  
for $E in $documentContent  

(:Lines processing:)

for $e1edp01 in $E/E1EDP01
return
<Message>
  <Lines>
    <Line>
	    <iDocLineId>{data($e1edp01/POSEX)}</iDocLineId>
	    <iDocGTINArticle>{data($e1edp01/ZMARM1[ALTERNATIVEUNIT = 'TU']/EAN)}</iDocGTINArticle>
	    <iDocBuyerArticleCode>{data($e1edp01/E1EDP19[QUALF = '001']/IDTNR)}</iDocBuyerArticleCode>
	    <iDocDeliveredQty>{data($e1edp01/MENGE)}</iDocDeliveredQty>
	    <iDocInvoicedQty>{data($e1edp01/MENGE)}</iDocInvoicedQty>
	    <iDocInvoicedUOM>{data($e1edp01/MENEE)}</iDocInvoicedUOM>
	    <iDocPrice>{data($e1edp01/E1EDP05[1]/BETRG) div data($e1edp01/MENGE)}</iDocPrice>
	    <iDocLineTotal>
	      {
        let $total := xs:decimal($e1edp01/E1EDP26[QUALF = '002']/BETRG + $e1edp01/E1EDP04/MWSBT)
        return format-number(round($total, 4), '0.0000')
        }
      </iDocLineTotal>
	    <iDocVatPct>{data($e1edp01/E1EDP04/MSATZ)}</iDocVatPct>
  	</Line>
  </Lines>
</Message>
  