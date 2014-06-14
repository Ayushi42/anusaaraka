
;@@@ Added by Garima Singh(M.Tech- C.S, Banasthali Vidyapith) 27/03/2014
;spectacles held on the bridge.[shiksharthi]
;bAzse para WamI Enaka
(defrule bridge2
(declare (salience 3000))
(id-root ?id bridge)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id noun)
(kriyA-on_saMbanXI ?kri ?id)
(kriyA-subject ?kri ?id1)
(id-word ?id1 spectacles)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id bAzsA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  bridge.clp 	bridge2   "  ?id "  bAzsA )" crlf))
)


(defrule bridge0
(declare (salience 0));salience reduced by Garima Singh
(id-root ?id bridge)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id noun)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id pula))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  bridge.clp 	bridge0   "  ?id "  pula )" crlf))
)

(defrule bridge1
(declare (salience 0));salience reduced by Garima Singh
(id-root ?id bridge)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id milA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  bridge.clp 	bridge1   "  ?id "  milA )" crlf))
)

;default_sense && category=verb	pula_bAzXa	0
;"bridge","VT","1.pula_bAzXanA"
;Bridge a river
;--"2.aMwara_mitAnA"
;For the relationship to continue it is important for them to bridge their differences.
;
;
