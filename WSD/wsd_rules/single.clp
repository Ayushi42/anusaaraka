
(defrule single0
(declare (salience 5000))
(id-root ?id single)
?mng <-(meaning_to_be_decided ?id)
(id-word =(- ?id 1) a )
(id-cat_coarse ?id noun)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id eka_hI))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  single.clp 	single0   "  ?id "  eka_hI )" crlf))
)

(defrule single1
(declare (salience 4900))
(id-root ?id single)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id noun)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id eka))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  single.clp 	single1   "  ?id "  eka )" crlf))
)
;$$$ Modified by jagriti(3.4.2014)..eka_hI instead of ekamAwra
;At a single Halloween party one can see many weird faces.[news-dev]
;इस तरह एक ही हैलोवीन पार्टी में आपको ढेरों अजीबोगरीब चेहरे दिख जाएंगे।
(defrule single2
(declare (salience 4800))
(id-root ?id single)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id adjective)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id eka_hI))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  single.clp 	single2   "  ?id "  eka_hI )" crlf))
)

;default_sense && category=adjective	eka/eka_hI/ekamAwra	0
;"single","Adj","1.eka/eka hI/ekamAwra"
;Please give me a single piece of paper.
;
;
