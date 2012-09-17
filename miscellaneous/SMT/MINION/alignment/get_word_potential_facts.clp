;This file is written by Maha Laxmi and Shirisha Manju

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

(defrule get_hnd_dic
(declare (salience 2001))
(manual_id-mng ?mapped_id $?mng)
(manual_id-mapped_id ?mid ?mapped_id)
(test (eq (numberp (implode$ (create$ $?mng))) FALSE ))
(test (neq (gdbm_lookup "restricted_hnd_words.gdbm" (implode$ (create$ $?mng))) "FALSE"))
=>
	(bind $?dic_list (create$ ))
        (bind ?new_mng (gdbm_lookup "restricted_hnd_words.gdbm" (implode$ (create$ $?mng))))
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
;yaha vahI UrjA hE jo nABikIya Sakwi janana waWA nABikIya kispotoM meM mukwa howI hE
;This is the energy which is released in a nuclear power generation and nuclear explosions.
;The reflected ray simply retraces the path. -- parAvarwiwa kiraNa kevala [apanA] paWa punaH anureKiwa karawI hE .
;Imagine the world without a pair of functional eyes. -- jarA [isa] saMsAra kI kalpanA binA kriyAwmaka newroM ke yugala ke kIjie.
(defrule potential_facts_for_eng
(declare (salience 2000))
(id-word ?aid ?wrd)
(manual_id-mng ?mapped_id $?man_mng)
(manual_id-mapped_id ?mid ?mapped_id)
(hindi_id_order $?hin_order)
(anu_id-word-possible_mngs ?aid ?wrd $?pos_mngs)
(test (subsetp $?man_mng $?pos_mngs))
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
(declare (salience 1000))
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
(declare (salience 1000))
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
(declare (salience 1000))
(or (potential_assignment_vacancy_id-candidate_id ?aid ?mid1) (anu_id-man_id ?aid ?mid1)(anu_id-anu_mng-sep-man_id-man_mng ?aid $? - ?mid $?))
;(or (potential_assignment_vacancy_id-candidate_id ?aid ?mid2) (anu_id-man_id ?aid ?mid2))
;(test (neq ?mid1 ?mid2))
(not (anu_id-candidate_ids ?aid $?))
;(id-word ?aid ?word)
;(test (neq (gdbm_lookup "restricted_eng_words.gdbm" ?word) "FALSE") )
=>
        (assert (anu_id-candidate_ids ?aid))
)
;------------------------------------------------------------------------------------------------------------
(defrule potential_count_of_anu_id1
(declare (salience 1000))
(or (potential_assignment_vacancy_id-candidate_id ?aid ?mid) (anu_id-man_id ?aid ?mid)(anu_id-anu_mng-sep-man_id-man_mng ?aid $? - ?mid $?))
?f<-(anu_id-candidate_ids ?aid $?mem)
(test (eq (member$ ?mid $?mem) FALSE))
(id-word ?aid ?word)
;(test (neq (gdbm_lookup "restricted_eng_words.gdbm" ?word) "FALSE") )
=>
        (retract ?f)
        (bind $?mem (sort > (create$ $?mem ?mid)))
        (assert (anu_id-candidate_ids ?aid $?mem))
)
;------------------------------------------------------------------------------------------------------------
(defrule get_fact_name_and_mapped_ids_for_column
(declare (salience 800))
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
		(bind ?mapped_id (member$ ?pos $?mapped_id_list))
		(bind $?mapped_list (create$ $?mapped_list ?mapped_id))
	)
	(if (neq (gdbm_lookup "restricted_eng_words.gdbm" ?word) "FALSE") then	
		 (assert (fact_name-slot_id-word_ids restricted_eq_or_sumleq ?slot_id $?mapped_list))
	else
	(assert (fact_name-slot_id-word_ids eq_or_sumleq ?slot_id $?mapped_list)))
)
;------------------------------------------------------------------------------------------------------------
(defrule get_fact_name_anu_slot_ids_for_row
(declare (salience 800))
(man_id-candidate_ids ?mid $?aids)
(hindi_id_order $?hin_order)
(manual_id-mapped_id ?mid ?mapped_id)
(manual_id-mng ?mapped_id $?mng)
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
        	(assert (fact_name-man_id-slot_ids eq_or_sumleq ?mapped_id $?slot_ids)))
)
;------------------------------------------------------------------------------------------------------------
(defrule potential_count_of_manual_verb_id
(declare (salience 800))
(man_verb_count-verbs ?man_verb_count&~0 $? ?man_verb $?)
(anu_verb_count-verbs ?anu_verb_count&~0 $?anu_verbs)
(manual_id-mapped_id ?man_verb ?mapped_id)
(hindi_id_order $?hin_order)
=>
	(assert (man_id-candidate_ids ?man_verb $?anu_verbs))
)
;------------------------------------------------------------------------------------------------------------
(defrule get_fact_name_for_no_mng_for_eng_word
(declare (salience 100))
(id-word ?aid ?wrd)
(not (anu_id-candidate_ids ?aid $?))
(not (man_id-candidate_ids ? $? ?aid $?))
(anu_id-word-possible_mngs ?aid ?wrd $?pos_mngs)
(not (manual_id-mng ? $?man_mng&:(subsetp $?man_mng $?pos_mngs)))
(hindi_id_order $?hin_order)
(test (neq (member$ ?aid $?hin_order) FALSE))
=>
        (bind ?slot_id (member$ ?aid $?hin_order))
        (assert (fact_name-slot_id sumleq ?slot_id))
)
;------------------------------------------------------------------------------------------------------------
(defrule get_fact_name_for_no_mng_for_man_word
(declare (salience 100))
(manual_id-mng ?mapped_id $?man_mng)
(manual_id-mapped_id ?mid ?mapped_id)
(not (anu_id-candidate_ids ? $? ?mid $?))
(not (man_id-candidate_ids ?mid $?))
(man_id-word-possible_mngs ?mid $?man_mng $?pos_mngs)
(not (id-word ? ?wrd&:(member$ ?wrd $?pos_mngs)))
=>
        (assert (fact_name-word_id sumleq ?mapped_id))
)
;------------------------------------------------------------------------------------------------------------

;This is the energy which is released in a nuclear power generation and nuclear explosions. --- yaha vahI UrjA hE jo nABikIya Sakwi janana waWA nABikIya kispotoM meM mukwa howI hE ---
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

