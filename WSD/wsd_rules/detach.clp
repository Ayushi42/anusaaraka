
(defrule detach0
(declare (salience 5000))
(id-root ?id detach)
?mng <-(meaning_to_be_decided ?id)
(id-word ?id detached )
(id-cat_coarse ?id adjective)
=>
(retract ?mng)
(assert (id-wsd_word_mng ?id alaga_huA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_word_mng  " ?*wsd_dir* "  detach.clp  	detach0   "  ?id "  alaga_huA )" crlf))
)

;"detached","Adj","1.alaga_[huA]"
;A detached part of the body can't be attached again.
;So many  detached houses are there in the town. 
;The detached shutter fell on him

(defrule detach1
(declare (salience 4000))
(id-root ?id detach)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id pqWaka_kara))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  detach.clp 	detach1   "  ?id "  pqWaka_kara )" crlf))
)

;@@@ Added by Pramila(Banasthali University) on 13-12-2013
;The police was detached to apprehend the culprit.          ;sentence of this file
;aBiyukwa ko pakadZane ke lie pulisa Beja xI gayI.
(defrule detach2
(declare (salience 5000))
(id-root ?id detach)
?mng <-(meaning_to_be_decided ?id)
(kriyA-kriyArWa_kriyA  ?id ?id1)
(to-infinitive  ?id2 ?id1)
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id Beja))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  detach.clp 	detach2   "  ?id "  Beja )" crlf))
)

;@@@ Added by Pramila(Banasthali University) on 13-12-2013
;She detached herself from his embrace.      ;oald
;उसने उसके आग़ोश से स्वयं को अलग किया.
(defrule detach3
(declare (salience 5000))
(id-root ?id detach)
?mng <-(meaning_to_be_decided ?id)
(kriyA-object  ?id ?id1)
(id-word ?id1 myself|herself|themselves|ourselves|himself|itself)
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id alag_kara))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  detach.clp 	detach3   "  ?id "  alag_kara )" crlf))
)

;"detach","VT","1.pqWaka_karanA"
;Detach the attachments from the application form && fill it.
;His retina detached && he had to be rushed into surgery
;--"2.Beja xenA
;Detach a regiment in the front to fight.
;
;LEVEL 
;Headword : detach
;
;Examples --
;
;"detach","V","1.pqWaka karanA" 
;They detach the coach from the train at Kazipet station.
;ve kAjZIpeta steSana para dibbe ko trena se alaga kara xewe hEM.
;--"2.alaga_karanA" 
;Meera detached herself from that group.
;mIrA ne apane Apa ko grupa se alaga kara liyA.
;--"3.tukadZI_BejanA"
;The police was detached to apprehend the culprit.
;aBiyukwa ko pakadZane ke lie pulisa kI tukadI BejI gayI.
;
;"detached","nirapekRa"
;Mani remained completely detached in his assessment of the situation.
;sWiwi ke bAre meM apane mUlyAMkana meM maNi pUrNawaH nirapekRa rahA. <--kisI pakRa se judA nahIM rahA <-- alaga rahA
;
;anwarnihiwa sUwra ;
;
;pqWaka_karanA -- pqWaka_kiyA huA hissA(tukadZA) -tukadZe ko BejanA 
;  |-nirapekRa_honA
;            
;sUwra : pqWaka_kara`  
;
;
;
;
