
(defrule minor0
(declare (salience 5000))
(id-root ?id minor)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id noun)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id gONa))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  minor.clp 	minor0   "  ?id "  gONa )" crlf))
)

(defrule minor1
(declare (salience 4900))
(id-root ?id minor)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id adjective)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id nAbAliga))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  minor.clp 	minor1   "  ?id "  nAbAliga )" crlf))
)

;"minor","Adj","1.nAbAliga"
;He was still a minor when he performed the fabulous deed.

;@@@ Added by Nandini (3-1-2014)
;I had a minor stomach upset. [merriam webster]
;merA WodA peta KarAba WA.
(defrule minor2
(declare (salience 4900))
(id-root ?id minor)
?mng <-(meaning_to_be_decided ?id)
(viSeRya-viSeRaNa  ?id1 ?id)
(id-cat_coarse ?id adjective)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id WodA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  minor.clp 	minor2   "  ?id "  WodA )" crlf))
)


;
;
