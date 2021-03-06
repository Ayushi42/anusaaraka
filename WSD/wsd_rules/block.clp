
(defrule block0
(declare (salience 5000))
(id-root ?id block)
?mng <-(meaning_to_be_decided ?id)
(id-word ?id1 out)
(kriyA-out_saMbanXI ?id ?) ;Automatically modified kriyA-upasarga to kriyA-prep_saMbanXI by Sukhada's program. 
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id roka));Automatically modified 'affecting_id-affected_ids-wsd_group_root_mng ?id ?id1' to 'id-wsd_root_mng ?id ' by Sukhada's program. 
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng  " ?*wsd_dir* " block.clp block0 " ?id "  roka )" crlf)) 
)

(defrule block1
(declare (salience 4900))
(id-root ?id block)
?mng <-(meaning_to_be_decided ?id)
(id-word ?id1 out)
(kriyA-upasarga ?id ?id1)
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (affecting_id-affected_ids-wsd_group_root_mng ?id ?id1 roka))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-affecting_id-affected_ids-wsd_group_root_mng   " ?*wsd_dir* " block.clp	block1  "  ?id "  " ?id1 "  roka  )" crlf))
)

;@@@ Added by Garima Singh(M.Tech-C.S) 17-jan-2014
;I think the kitchen drain is blocked.[cambridge]
;मुझे लगता है कि रसोईघर नाली रुकी हुई है . 
(defrule block4
(declare (salience 5000))
(id-root ?id block)
?mng <-(meaning_to_be_decided ?id)
(kriyA-subject  ?id ?sub)
(id-root ?sub pipe|drain)
(not(kriyA-object ?id ?obj))
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id ruka))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  block.clp 	block4   "  ?id "  ruka )" crlf))
)

;@@@ Added by Garima Singh(M.Tech-C.S) 17-jan-2014
;An ugly new building blocked the view from the window.[oald]
;एक कुरूप नयी इमारत ने खिडकी से दृष्य में बाधा डाली .  
(defrule block5
(declare (salience 5000))
(id-root ?id block)
?mng <-(meaning_to_be_decided ?id)
(kriyA-object  ?id ?obj)
(id-root ?obj view)
(kriyA-subject  ?id ?sub)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id bAXA_dAla))
(assert (kriyA_id-object_viBakwi ?id meM))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  block.clp 	block5   "  ?id "  bAXA_dAla )" crlf)
(printout wsd_fp "(dir_name-file_name-rule_name-kriyA_id-object_viBakwi   " ?*wsd_dir* " block.clp    block5   "  ?id " meM )" crlf)
)
)

;@@@ Added by Garima Singh(M.Tech-C.S) 17-jan-2014
;One door had been blocked up.[oald]
;My nose is blocked up.[oald]
(defrule block6
(declare (salience 1000))
(id-root ?id block)
?mng <-(meaning_to_be_decided ?id)
(or
(kriyA-object  ?id ?id1)
(kriyA-subject  ?id ?id1)
)
(id-root ?id1 way|path)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id roka))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  block.clp 	block6   "  ?id "  roka )" crlf))
)


;***************************DEFAULT RULES****************************************

(defrule block2
(declare (salience 0))
(id-root ?id block)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id noun)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id KaNda))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  block.clp 	block2   "  ?id "  KaNda )" crlf))
)

;$$$ Modified by Garima Singh(M.Tech-C.S, Banasthali Vidyapith) 17-jan-2014
;After today's heavy snow, many roads are still blocked.[oald]
;आज की भारी बरफ के बाद, बहुत सारी सडकें अभी भी बन्द हैं . 
(defrule block3
(declare (salience 0))
(id-root ?id block)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id banxa));changed the meaning from roka to banxa by Garima
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  block.clp 	block3   "  ?id "  banxa )" crlf))
)

;"block","VT","1.rokanA/banxa_karanA"
;Block the way
;His brother blocked him at every turn
;Block trains
;Block a nerve
;Block an attack
;--"2.bAXA_dAlanA"
;The thick curtain blocked the action on the stage
;--"3.blAka_banAnA{priMtiMga_kA}"
;Block the book cover
;Block a plate for printing
;--"4.blOYka_banAnA"
;Block the graphs so one can see the results clearly
;
;LEVEL 
;
;
;Headword : block
;
;
;Examples --
;`block' Sabxa ke viviXa prayoga--
;-------------------------  
;
;"block","N","1.blOYka" 
;               ---- < KaNda`{badZAcapatA}
;The pyramids were built with large stone blocks
;--"2.KaNda{samUha}" 
;	       ---- < --kI rUpa-sAmyawA < KaNda`{badZAcapatA}
;He lives in the next block
;There is a block of classrooms in the west wing
;since blocks are often defined as a single sector, the terms `block' && `sector' are sometimes used interchangeably
;He reserved a large block of seats
;--"3.roka"
;              ---- < kArya-viSeRa hewu --kA prayoga < KaNda`{badZAcapatA}
;I knew his name perfectly well but I had a temporary block
;We had to call a plumber to clear out the blockage in the drain pipe
;--"4.kunxA"   
;              ---- < KaNda`{badZAcapatA}   
;The engine had to be replaced because the block was cracked
;--"5.kIla"
;              ---- < KaNda`{badZAcapatA}
;They put their paintings on the block
;--"6.gutakA"
;              ---- < KaNda`{badZAcapatA}
;He threw a rolling block into the line backer
;
;
;"block","VT","1.rokanA/banxa_karanA"
;              ---- < kArya viSeRa hewu --kA prayoga < KaNda`{badZAcapatA}
;Block the way
;His brother blocked him at every turn
;Block trains
;Block a nerve
;Block an attack
;--"2.bAXA_dAlanA"
;              ---- < rokanA yA banxa karanA < kArya viSeRa hewu --kA prayoga 
;                                              < KaNda`{badZAcapatA}
;The thick curtain blocked the action on the stage
;--"3.blAka_banAnA{priMtiMga_kA}"
;              ---- < AkAra viSeRa kA prawIka rUpa < KaNda`{badZAcapatA}
;Block the book cover
;Block a plate for printing
;--"4.blOYka_banAnA"
;              ---- < blAka_banAnA{priMtiMga_kA} < AkAra viSeRa kA prawIka rUpa 
;                                             < KaNda`{badZAcapatA}
;Block the graphs so one can see the results clearly
;----------------------------------------------------------
;
;sUwra : KaNda`{badZA_capatA}^rodZA
;----------------
;
;   `block' Sabxa ke alaga-alaga arWoM meM eka-samAnawA `KaNda`(kisI vaswu kA eka badZA capatA tukadZA)' meM
;sWiwa arWa se xeKA jA sakawA hE . KaNda kisI BI paxArWa kA saGanIBUwa AkAra-viSiRta
;wawwva mAnA jAwA hE . ukwa Sabxa ke isa pariBARAmUlaka arWa ke viswAra-rUpa meM 
;`block' Sabxa ke arWa-viswAra ko parigaNiwa kiyA jA sakawA hE . aba yahAz xeKawe hEM ki
;kisa prakAra isa sUwra meM `block' ke arWa-viswAra ko samaJA jA sakawA hE . 
;
;--  blAka, kIla, kunxA, gutakA, ye arWa tippaNiyoM va KaNda kI xI gaI pariBARA se 
;awi spaRta hEM . ye saBI kisI na kisI ke KaNda-viSeRa hEM . 
;
;-- KaNda va samUha . KaNda kisI AkAra-viSeRa KaNda kI ikAI hE . jabaki samUha 
;kisI AkAra-viSiRta KaNda kI bahuwAyawa kI sWiwi hE . isa arWa-rUpa Sabxa ke
;arWa-viswAra meM rUpa-sAmyawA kI muKya-BUmikA prawIwa howI hE .
;
;-- roka sambanXiwa arWa va bAXA ke lie socA jA sakawA hE ki sAXAraNa loka-vyavahAra meM
;kisI ko rokawe hEM yA bAXA uwpanna karawe hEM wo KaNdIBUwa kisI paxArWa kA upayoga 
;kiyA jAwA hE . uxAharaNawaH pAnI rokanA, Cixra pade kisI barawana Axi ko TIka karanA
;iwyAxi se isako samaJA jA sakawA hE . isase vEcArika kRewra meM yA anya sanxarBoM
;meM isakA pracalana . isa arWa meM 'rodZA' atakAnA liyA jA sakawA hE. 
;
;-- blAka banAnA (priMtiMga kA) . kisI AkAra-viSeRa ke sAmya se isako soca sakawe hEM
;yA isa kArya hewu prayukwa sAmagrI kI KaNdIBUwawA se arWa-viswAra huA ho sakawA 
;hE . mohara(prAcIna kAla ke) Axi meM KaNdawA kI Jalaka spaRta xeKI jA sakawI hE . 
;
;-- blAka banAnA (priMtiMga kA ) kA arWa-viswAra `blAka banAnA' huA hE . priMtiMga 
;ke kArya kI sAmyawA blAka banAne meM hE . isameM BI kisI kI CapAI vixyamAna hE . 
;
;
