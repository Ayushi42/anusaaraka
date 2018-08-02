
(defrule jingle0
(declare (salience 5000))
(id-root ?id jingle)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id noun)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id JanaJanAhata))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  jingle.clp 	jingle0   "  ?id "  JanaJanAhata )" crlf))
)

(defrule jingle1
(declare (salience 4900))
(id-root ?id jingle)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id KanaKanA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  jingle.clp 	jingle1   "  ?id "  KanaKanA )" crlf))
)

;"jingle","V","1.KanaKanAnA"
;He jingled his bunch of keys.
;
;