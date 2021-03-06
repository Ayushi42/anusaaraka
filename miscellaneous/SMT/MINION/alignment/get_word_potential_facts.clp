;This file is written by Maha Laxmi and Shirisha Manju

 (deffacts dummy_facts
 (count_of_inserted_word-position)
 )

 ;Domain physics
 (defrule load_phy_multi_wrd_file
 (declare (salience 9000))
 (Domain physics)
 =>
         (load-facts "phy_multi_word_expressions.dat")
 )
;------------------------------------------------------------------------------------------------------------
(deffunction remove_character(?char ?str ?replace_char)
	(bind ?new_str "")
        (bind ?index (str-index ?char ?str))
        (if (neq ?index FALSE) then
        	(while (neq ?index FALSE)
                	(bind ?new_str (str-cat ?new_str (sub-string 1 (- ?index 1) ?str) ?replace_char))
                        (bind ?str (sub-string (+ ?index 1) (length ?str) ?str))
                        (bind ?index (str-index ?char ?str))
                )
        )
        (bind ?new_str (explode$ (str-cat ?new_str (sub-string 1 (length ?str) ?str))))
)
;------------------------------------------------------------------------------------------------------------
;Added by Shirisha Manju (16-04-13)
;The name electricity is coined from the Greek word elektron meaning amber.
(defrule rm_aligned_verb_id_from_verb_list
(declare (salience 2002))
(anu_id-anu_mng-sep-man_id-man_mng ?aid $? - ?mid $?)
?f0<-(man_verb_count-verbs ?c $?pre ?mid $?post)
=>
	(retract ?f0)
	(bind ?c (- ?c 1))
	(assert (man_verb_count-verbs ?c $?pre $?post))
)
;------------------------------------------------------------------------------------------------------------
;Added by Shirisha Manju(29-05-13)
;In our experience, force is needed to push, carry or throw objects, deform or break them.--- hama saBI kA yaha anuBava [hE] ki vaswuoM ko Xakelane, le jAne aWavA Pefkane , nirUpiwa karane aWavA unheM wodane ke lie bala kI AvaSyakawA howI hE. 
(defrule rm_LWG_grouped_id_from_restricted_word
(declare (salience 2002))
(root-verbchunk-tam-chunkids ? ? ? ?id ? $?)
?f0<-(id-word ?id ?wrd&is|are)
=>
	(retract ?f0)
)
;------------------------------------------------------------------------------------------------------------
;Added by Shirisha Manju(7-03-13)
; if eng multi mng and manual multi mng is same then rm the ids from order excluding the head
;The choice of a set of axes in a frame of reference depends upon the situation.
;First, that it travels with enormous speed and second, that it travels in a straight line.
(defrule rm_comp_ids_from_order
(declare (salience 2001))
(or (ids-phy_cmp_mng-eng_mng $? ?phy_mng ?)(ids-cmp_mng-eng_mng $? ?phy_mng ?))
(or (ids-phy_cmp_mng-head-cat-mng_typ-priority $?ids ?phy_mng ?head ? ? ?)(ids-cmp_mng-head-cat-mng_typ-priority $?ids ?phy_mng ?head ? ? ?))
?f0<-(hindi_id_order $?order)
(not (removed_id_for_phy_mng ?phy_mng))
=>
	(retract ?f0)
	(loop-for-count(?i 1 (length $?ids))
        	(bind ?id (nth$ ?i $?ids))
		(if (neq ?id (nth$ ?head $?ids)) then
			(bind $?order (delete-member$ $?order ?id))
		)
	)
	(assert (hindi_id_order $?order))
	(assert (removed_id_for_phy_mng ?phy_mng))
)
;------------------------------------------------------------------------------------------------------------
(defrule manul_id_mapped_list
(declare (salience 2000))
(manual_id-mapped_id ?mid ?mapped_id)
?f<-(index ?mapped_id)
?f1<-(manual_mapped_ids_list $?mapped_id_list)
?f2<-(manual_ids_list $?man_id_list)
=>
        (retract ?f ?f1 ?f2)
        (bind ?next_mid (+ ?mapped_id 1))
        (bind $?mapped_id_list (create$ $?mapped_id_list ?mapped_id))
        (bind $?man_id_list (create$ $?man_id_list ?mid))
        (assert (index  ?next_mid))
        (assert (manual_mapped_ids_list $?mapped_id_list))
        (assert (manual_ids_list $?man_id_list))
)

;------------------------------------------------------------------------------------------------------------
(defrule get_eng_dic
(declare (salience 2001))
(id-word ?aid ?wrd)
(test (eq (numberp ?wrd) FALSE ))
(test (neq (gdbm_lookup "restricted_eng_words.gdbm" ?wrd) "FALSE"))
=>
	(bind $?dic_list (create$ ))
	(bind ?new_mng (gdbm_lookup "restricted_eng_words.gdbm" ?wrd))
	(bind ?slh_index (str-index "/" ?new_mng))
        (if (and (neq (length ?new_mng) 0)(neq ?slh_index FALSE)) then
                (while (neq ?slh_index FALSE)
                        (bind ?new_mng1 (sub-string 1 (- ?slh_index 1) ?new_mng))
                        (bind ?new_mng1 (remove_character "_" ?new_mng1 " "))
                        (bind ?new_mng1 (remove_character "-" (implode$ (create$  ?new_mng1)) " "))
			(bind $?dic_list (create$ $?dic_list ?new_mng1 ,))
                        (bind ?new_mng (sub-string (+ ?slh_index 1) (length ?new_mng) ?new_mng))
                        (bind ?slh_index (str-index "/" ?new_mng))
                )
        )
	(bind ?new_mng1 (str-cat (sub-string 1 (length ?new_mng) ?new_mng)))
        (bind ?new_mng1 (remove_character "_" ?new_mng1 " "))
        (bind ?new_mng1 (remove_character "-" (implode$ (create$ ?new_mng1)) " "))
	(bind $?dic_list (create$ $?dic_list ?new_mng1))
	(assert (anu_id-word-possible_mngs ?aid ?wrd $?dic_list))
)
;------------------------------------------------------------------------------------------------------------
;Guard, stop this donkey and let [me] get off [his] back! I can not do without him.
(defrule get_hnd_dic
(declare (salience 2001))
(manual_id-mng ?mapped_id $?mng)
(manual_id-mapped_id ?mid ?mapped_id)
(manual_id-cat-word-root-vib-grp_ids ?mid ? $? - ?root - $?vib - $?)
(test (eq (numberp (implode$ (create$ $?mng))) FALSE ))
(test (or (neq (gdbm_lookup "restricted_hnd_words.gdbm" (implode$ (create$ $?mng))) "FALSE")(neq (gdbm_lookup "restricted_hnd_words.gdbm" ?root) "FALSE")))
=>
	(bind $?dic_list (create$ ))
        (bind ?new_mng (gdbm_lookup "restricted_hnd_words.gdbm" (implode$ (create$ $?mng))))
	(if (eq ?new_mng "FALSE") then
		(bind ?new_mng (gdbm_lookup "restricted_hnd_words.gdbm" ?root))
	)
        (bind ?slh_index (str-index "/" ?new_mng))
        (if (and (neq (length ?new_mng) 0)(neq ?slh_index FALSE)) then
                (while (neq ?slh_index FALSE)
                        (bind ?new_mng1 (sub-string 1 (- ?slh_index 1) ?new_mng))
                        (bind ?new_mng1 (remove_character "_" ?new_mng1 " "))
                        (bind ?new_mng1 (remove_character "-" (implode$ (create$  ?new_mng1)) " "))
			(bind $?dic_list (create$ $?dic_list ?new_mng1 ,))
                        (bind ?new_mng (sub-string (+ ?slh_index 1) (length ?new_mng) ?new_mng))
                        (bind ?slh_index (str-index "/" ?new_mng))
                )
		
        )
	(bind ?new_mng1 (str-cat (sub-string 1 (length ?new_mng) ?new_mng)))
        (bind ?new_mng1 (remove_character "_" ?new_mng1 " "))
        (bind ?new_mng1 (remove_character "-" (implode$ (create$ ?new_mng1)) " "))
	(bind $?dic_list (create$ $?dic_list ?new_mng1))
        (assert (man_id-word-possible_mngs ?mid $?mng $?dic_list))
)   
;------------------------------------------------------------------------------------------------------------
;yaha vahI UrjA hE jo nABikIya Sakwi janana waWA nABikIya visPotoM meM mukwa howI hE
;This is the energy which is released in a nuclear power generation and nuclear explosions.
;The reflected ray simply retraces the path. -- parAvarwiwa kiraNa kevala [apanA] paWa punaH anureKiwa karawI hE .
;Imagine the world without a pair of functional eyes. -- jarA [isa] saMsAra kI kalpanA binA kriyAwmaka newroM ke yugala ke kIjie.
;For this, we develop the concepts of velocity and acceleration. isake lie hameM vega waWA wvaraNa kI XAraNA ko samaJanA hogA
(defrule potential_facts_for_eng
(declare (salience 2000))
(id-word ?aid ?wrd)
(anu_id-word-possible_mngs ?aid ?wrd $?pos_mngs)
(manual_id-mapped_id ?mid ?mapped_id)
(or (manual_id-mng ?mapped_id $?man_mng)(manual_id-cat-word-root-vib-grp_ids ?mid ? $? - $?man_mng - $? - $?))
(test (subsetp $?man_mng $?pos_mngs))
(hindi_id_order $?hin_order)
(test (neq (member$ ?aid $?hin_order) FALSE))
=>
	(assert (anu_id-man_id ?aid ?mid))
)
;------------------------------------------------------------------------------------------------------------
(defrule potential_facts_for_hnd
(declare (salience 2000))
(manual_id-mng ?mapped_id $?man_mng)
(manual_id-mapped_id ?mid ?mapped_id)
(id-word ?aid ?wrd)
(man_id-word-possible_mngs ?mid $?man_mng $?pos_mngs)
(test (member$ ?wrd $?pos_mngs))
(hindi_id_order $?hin_order)
(test (neq (member$ ?aid $?hin_order) FALSE))
=>
	(assert (man_id-anu_id ?mid ?aid))
)
;------------------------------------------------------------------------------------------------------------
(defrule potential_count_of_manual_id
(declare (salience 1500))
(or (potential_assignment_vacancy_id-candidate_id ?aid1 ?mid) (man_id-anu_id ?mid ?aid1)(anu_id-anu_mng-sep-man_id-man_mng ?aid $? - ?mid $?))
(not (man_id-candidate_ids ?mid $?))
=>
        (assert (man_id-candidate_ids ?mid))
)
;(defrule potential_count_of_manual_id
;(declare (salience 1000))
;(or (potential_assignment_vacancy_id-candidate_id ?aid1 ?mid) (man_id-anu_id ?mid ?aid1))
;(or (potential_assignment_vacancy_id-candidate_id ?aid2 ?mid) (man_id-anu_id ?mid ?aid2))
;(test (neq ?aid1 ?aid2))
;(not (man_id-candidate_ids ?mid $?))
;=>
;        (assert (man_id-candidate_ids ?mid ?aid1 ?aid2))
;)
;------------------------------------------------------------------------------------------------------------
(defrule potential_count_of_manual_id1
(declare (salience 1500))
(or (potential_assignment_vacancy_id-candidate_id ?aid ?mid) (man_id-anu_id ?mid ?aid)(anu_id-anu_mng-sep-man_id-man_mng ?aid $? - ?mid $?))
?f<-(man_id-candidate_ids ?mid $?mem)
(test (eq (member$ ?aid $?mem) FALSE))
=>
        (retract ?f)
        (bind $?mem (sort > (create$ $?mem ?aid)))
        (assert (man_id-candidate_ids ?mid $?mem))
)
;------------------------------------------------------------------------------------------------------------
(defrule potential_count_of_anu_id
(declare (salience 1200))
(or (potential_assignment_vacancy_id-candidate_id ?aid ?mid1) (anu_id-man_id ?aid ?mid1)(anu_id-anu_mng-sep-man_id-man_mng ?aid $? - ?mid $?))
(not (anu_id-candidate_ids ?aid $?))
=>
        (assert (anu_id-candidate_ids ?aid))
)
;------------------------------------------------------------------------------------------------------------
(defrule potential_count_of_anu_id1
(declare (salience 1200))
(or (potential_assignment_vacancy_id-candidate_id ?aid ?mid) (anu_id-man_id ?aid ?mid)(anu_id-anu_mng-sep-man_id-man_mng ?aid $? - ?mid $?))
?f<-(anu_id-candidate_ids ?aid $?mem)
(test (eq (member$ ?mid $?mem) FALSE))
(id-word ?aid ?word)
=>
        (retract ?f)
        (bind $?mem (sort > (create$ $?mem ?mid)))
        (assert (anu_id-candidate_ids ?aid $?mem))
)
;------------------------------------------------------------------------------------------------------------
;For example, if the car starts from O, goes to P and then returns to O, the final position coincides with the initial position and the displacement is zero. --- Added if condition for pos 
;Fig. 3.2 (b) shows the position-time graph of such a motion. --- Added if condition for word [3.2]
(defrule get_fact_name_and_mapped_ids_for_column
(declare (salience 1100))
?f<-(anu_id-candidate_ids ?aid $?mids)
(hindi_id_order $?hin_order)
(test (member$ ?aid $?hin_order))
(manual_mapped_ids_list $?mapped_id_list)
(manual_ids_list $?man_id_list)
(id-word ?aid ?word)
=>
	(bind $?mapped_list (create$))
	(bind ?slot_id (member$ ?aid $?hin_order))
	(loop-for-count(?i 1 (length $?mids))
		(bind ?id (nth$ ?i $?mids))
		(bind ?pos (member$ ?id $?man_id_list))
		(if (neq ?pos FALSE) then
			(bind ?mapped_id (member$ ?pos $?mapped_id_list))
			(bind $?mapped_list (create$ $?mapped_list ?mapped_id))
		)
	)
	(if (eq (numberp ?word) FALSE) then
	 	(bind ?mng (gdbm_lookup "restricted_eng_words.gdbm" ?word))
		(if (neq ?mng "FALSE") then
		 	(assert (fact_name-slot_id-word_ids restricted_eq_or_sumleq ?slot_id $?mapped_list))
		else
			(assert (fact_name-slot_id-word_ids eq_or_sumleq ?slot_id $?mapped_list))
		)
	else	(assert (fact_name-slot_id-word_ids eq_or_sumleq ?slot_id $?mapped_list))
	)
)
;------------------------------------------------------------------------------------------------------------
(defrule get_fact_name_anu_slot_ids_for_row
(declare (salience 1000))
(man_id-candidate_ids ?mid $?aids)
(hindi_id_order $?hin_order)
(manual_id-mapped_id ?mid ?mapped_id)
(manual_id-mng ?mapped_id $?mng)
(manual_id-cat-word-root-vib-grp_ids ?mid ? $? - $?root - $?vib - $?ids)
=>
	(bind $?slot_ids (create$))
	(loop-for-count(?i 1 (length $?aids))
        	(bind ?id (nth$ ?i $?aids))
                (bind ?s_id (member$ ?id $?hin_order))
		(if (neq ?s_id FALSE) then
                        (bind $?slot_ids (create$ $?slot_ids ?s_id))
		)
        )
	(if (neq (gdbm_lookup "restricted_hnd_words.gdbm" (implode$ (create$ $?mng))) "FALSE") then
        	(assert (fact_name-man_id-slot_ids restricted_eq_or_sumleq ?mapped_id $?slot_ids))
	else
		(if (neq (gdbm_lookup "restricted_hnd_words.gdbm" (implode$ (create$ $?root))) "FALSE") then
			(assert (fact_name-man_id-slot_ids restricted_eq_or_sumleq ?mapped_id $?slot_ids))
        	else
        		(assert (fact_name-man_id-slot_ids eq_or_sumleq ?mapped_id $?slot_ids))
		)
	)
)
;------------------------------------------------------------------------------------------------------------
;Suggested by Chaitanya Sir  (least verb of anu == least verb of man)
(defrule potential_count_of_manual_verb_id
(declare (salience 900))
?f<-(man_verb_count-verbs ?man_verb_count&~0 $?man_verbs)
?f0<-(anu_verb_count-verbs ?anu_verb_count&~0 $?anu_verbs)
(test (and (neq (length $?man_verbs) 0) (neq (length $?anu_verbs) 0)))
=>
	(retract ?f ?f0)
	(bind ?mid (nth$ 1 (sort > $?man_verbs)))
	(bind ?aid (nth$ 1 (sort > $?anu_verbs)))
	(bind $?man_verbs (delete-member$ $?man_verbs ?mid))
	(bind $?anu_verbs (delete-member$ $?anu_verbs ?aid))
	(assert (anu_id-man_id ?aid ?mid))
	(assert (man_verb_count-verbs ?man_verb_count $?man_verbs))
	(assert (anu_verb_count-verbs ?anu_verb_count $?anu_verbs))	
)
;------------------------------------------------------------------------------------------------------------
(defrule potential_count_of_manual_verb_id1
(declare (salience 800))
(man_verb_count-verbs ?man_verb_count&~0 $? ?man_verb $?)
(anu_verb_count-verbs ?anu_verb_count&~0 $?anu_verbs)
(manual_id-mapped_id ?man_verb ?mapped_id)
=>
	(assert (man_id-candidate_ids ?man_verb $?anu_verbs))
        (assert (man_verb_id-mapped_id ?man_verb ?mapped_id))
)
;------------------------------------------------------------------------------------------------------------
;The nationalists were narrowly beaten in the local election.---rARtravAxI sWAnIya cunAva meM badZe hI kama aMwara se hAre.
; in the above sentence the word "the" is repeated twice and has no mng in manual sentence.
;We [all] have an intuitive notion of force. -- hama [saBI meM] bala ke bAre meM koI sahajAnuBUwa XAraNA hE.
(defrule get_fact_name_for_no_mng_for_eng_word
(declare (salience 100))
(id-word ?aid ?wrd)
(anu_id-word-possible_mngs ?aid ?wrd $?pos_mngs)
(hindi_id_order $?hin_order)
(test (neq (member$ ?aid $?hin_order) FALSE))
(not (manual_id-cat-word-root-vib-grp_ids ? ? $? - $?man_mng&:(subsetp $?man_mng $?pos_mngs) - $? - $?))
(not (manual_id-mng ? $?man_mng1&:(subsetp $?man_mng1 $?pos_mngs)))
=>
        (bind ?slot_id (member$ ?aid $?hin_order))
        (assert (fact_name-slot_id sumleq ?slot_id))
)
;------------------------------------------------------------------------------------------------------------
(defrule get_fact_name_for_no_mng_for_man_word
(declare (salience 100))
(manual_id-mng ?mapped_id $?man_mng)
(man_id-word-possible_mngs ?mid $?man_mng $?pos_mngs)
(not (id-word ? ?wrd&:(member$ ?wrd $?pos_mngs)))
=>
        (assert (fact_name-word_id sumleq ?mapped_id))
)
;------------------------------------------------------------------------------------------------------------
(defrule change_the_fact_name_if_two_words_pointing_to_same_slot
(declare (salience 90))
?f<-(fact_name-man_id-slot_ids ?f_n ?mid $?slot_id)
?f1<-(fact_name-man_id-slot_ids ?f_n1 ?mid1 $?slot_id)
(test (and  (neq ?f_n restricted_eq_or_sumleq) (neq ?f_n1 restricted_eq_or_sumleq)))
(test (neq ?mid ?mid1))
(not (man_verb_id-mapped_id ? $? ?mid $?))
(not (man_verb_id-mapped_id ? $? ?mid1 $?))
(not (slot_ids-man_ids $?slot_id - $?))
=>
	(assert (slot_ids-man_ids $?slot_id - ?mid ?mid1))
)
;------------------------------------------------------------------------------------------------------------
(defrule change_the_fact_name_if_two_words_pointing_to_same_slot1
(fact_name-man_id-slot_ids ?f_n ?mid $?slot_id)
?f<-(slot_ids-man_ids $?slot_id - $?mids)
(test (eq (member$ ?mid $?mids) FALSE))
(not (man_verb_id-mapped_id ? $? ?mid $?))
=>
        (retract ?f)
        (assert (slot_ids-man_ids $?slot_id - $?mids ?mid))
)
;------------------------------------------------------------------------------------------------------------
;Eng Sen  :: Automobiles and planes carry people from one [place] to the other.
;Man tran :: motaragAdI Ora vAyuyAna yAwriyoM ko eka [sWAna se] xUsare [sWAna ko] le jAwe hEM.
;Anu tran :: motara-gAdI Ora samawala xUsare ko eka sWAna se logoM ko uTA_le jAwe hEM.
(defrule change_the_fact_name_if_two_words_pointing_to_same_slot2
?f<-(fact_name-man_id-slot_ids ?f_n ?mid $?slot_id)
(slot_ids-man_ids $?slot_id - $?mids)
(test (neq (length $?slot_id) (length $?mids)))
(test (member$ ?mid $?mids))
(test (neq ?f_n restricted_eq_or_sumleq))
=>
	(retract ?f)
        (assert (fact_name-man_id-slot_ids restricted_eq_or_sumleq ?mid $?slot_id))
)
;------------------------------------------------------------------------------------------------------------
(defrule rm_repeated_facts
(declare (salience -100))
(fact_name-man_id-slot_ids eq_or_sumleq ?mid ?sid)
?f<-(fact_name-slot_id-word_ids eq_or_sumleq ?sid ?mid)
=>
	(retract ?f)
)
;------------------------------------------------------------------------------------------------------------
;;11_03_C => Eng sen :Think! ; Man sen :socie!  ; Anu sen :sociye!
;(defrule rm_repeated_fact
;(declare (salience 10))
;?f0<-(fact_name-slot_id-word_ids eq_or_sumleq ?id ?id1)
;(fact_name-man_id-slot_ids eq_or_sumleq ?id ?id1)
;=>
;	(retract ?f0)
;)


;This is the energy which is released in a nuclear power generation and nuclear explosions. --- yaha vahI UrjA hE jo nABikIya Sakwi janana waWA nABikIya visPotoM meM mukwa howI hE ---
;The reflected ray simply retraces the path. -- parAvarwiwa kiraNa kevala [apanA] paWa punaH anureKiwa karawI hE .
;Imagine the world without a pair of functional eyes. -- jarA [isa] saMsAra kI kalpanA binA kriyAwmaka newroM ke yugala ke kIjie.
;This is a situation where the principle of conservation of angular momentum is applicable. 
;Physicists try to discover the rules that are operating in nature, on the basis of observations, experimentation and analysis.
;There are also forces involving charged and magnetic bodies. 
;The angular acceleration is directly proportional to the applied torque and is inversely proportional to the moment of inertia of the body.
;In vacuum, of course, the speed of light is independent of wavelength. --- vAswava meM nirvAwa meM prakASa kI cAla warafgaxErGya para nirBara nahIM karawI 
; In fact, violet gets scattered even more than blue, having a shorter wavelength. --- vAswava meM bEfganI varNa kI warafgaxErGya Ora BI kama hone ke kAraNa yaha nIle varNa se [BI] aXika prabalawA se prakIrNa howA hE.
;Dispersion takes place because the refractive index of medium for different wavelengths (colors) [is] different. --- parikRepaNa kA kAraNa yaha [hE] ki kisI mAXyama kA apavarwanAfka viBinna warafgaxErGyoM (varNoM) ke lie Binna-Binna howA [hE].
;The size of the image relative to the size of the object is another important quantity to consider. --- vaswu ke sAija ke sApekRa prawibimba kA sAija BI eka mahawvapUrNa vicAraNIya rASi hE.


