(deftemplate manual_word_info (slot head_id (default 0))(multislot word (default 0))(multislot root (default 0))(multislot vibakthi (default 0))(multislot group_ids (default 0)))

(defglobal ?*count* = 0)

 
(deffacts dummy_facts
	(id-confidence_level)
)
;-------------------------------------------------------------------------------------
(deffunction assert_control_fact(?fact_name $?ids)
                (loop-for-count (?i 1 (length $?ids))
                                (bind ?j (nth$ ?i $?ids))
                                (if (eq ?fact_name delete_manual_fact) then
                                        (assert (delete_manual_fact ?j))
                                )
                 )
)
;-------------------------------------------------------------------------------------
(defrule get_current_word
(manual_word_info (head_id ?mid))
(not (manual_word_info (head_id ?mid1&:(< ?mid1 ?mid))))
=>
        (assert (current_id ?mid))
)
;-------------------------------------------------------------------------------------
(defrule remove_manual_punct_facts
(declare (salience 1001))
?f<-(manual_word_info (head_id ?mid) (word $? ?punc&@PUNCT-Comma|@PUNCT-Dot|@PUNCT-QuestionMark|@PUNCT-DoubleQuote|@PUNCT-DoubleQuote|@PUNCT-Semicolon|@PUNCT-Colon|@PUNCT-SingleQuote|@PUNCT-OpenParen|@PUNCT-ClosedParen|@PUNCT-Exclamation|@SYM-Dollar|@PUNCT-LeftSquareBracket|@PUNCT-RightSquareBracket|SYM))
=>
        (retract ?f)
)
;-------------------------------------------------------------------------------------
(defrule rule1
(declare (salience 900))
?f0<-(current_id ?mid)
?f<-(anu_id-anu_mng-sep-man_id-man_mng ? $? - ?h_id $?grp)
(test (member$ ?mid $?grp))
=>
        (retract ?f0 ?f)
	(bind ?*count* (+ ?*count* 1))
	(assert (manual_id-mng ?*count* $?grp))
        (assert_control_fact delete_manual_fact $?grp)
	(assert (manual_id-mapped_id ?h_id ?*count*))
)

;-------------------------------------------------------------------------------------
(defrule rule2
(declare (salience 900))
?f0<-(current_id ?mid)
?f<-(manual_word_info (head_id ?h_id) (group_ids $?grp))
(test (member$ ?mid $?grp))
(test (eq (member$ - $?grp ) FALSE))
=>
        (retract ?f ?f0)
	(bind ?*count* (+ ?*count* 1))
        (assert (manual_id-mng ?*count* $?grp))
	(assert (manual_id-mapped_id ?h_id ?*count*))
)
;-------------------------------------------------------------------------------------
(defrule delete_manual_fact
(declare (salience 2000))
?f1<-(delete_manual_fact ?mid)
?f2<-(manual_word_info (head_id ?mid))
=>
	(retract ?f1 ?f2)
)
;-------------------------------------------------------------------------------------
;Eng sen :: The near point may be as close as about 7 to 8 cm in a child ten years of age, and may increase to as much as 200 cm at 60 years of age.
;Man tran :: 10 varRa ke bAlaka ke newra kA nikata binxu lagaBaga 7 se 8 bau waka howA hE jabaki 60 varRa kI Ayu waka pahuzcane para yaha lagaBaga 200 bau waka pahuzca sakawA hE.
;++++++++[Should improve this rule]+++++++++
(defrule replace_id_with_word_for_nos
(declare (salience -5))
?f<-(manual_id-mng ?mid $?pre ?id $?pos)
?f1<-(manual_id-word ?id ?h_mng)
(test (numberp ?h_mng))
=>
        (retract ?f ?f1)
	(bind ?h_mng (string-to-field (str-cat ?h_mng "-REPLACE_NO")))
        (assert (manual_id-mng ?mid $?pre ?h_mng $?pos))
)
;-------------------------------------------------------------------------------------
(defrule replace_id_with_word
(declare (salience -10))
?f<-(manual_id-mng ?mid $?pre ?id $?pos)
?f1<-(manual_id-word ?id ?h_mng)
=>
        (retract ?f ?f1)
        (if (member$ ?h_mng (create$ @PUNCT-Comma @PUNCT-Dot @PUNCT-QuestionMark @PUNCT-DoubleQuote @PUNCT-DoubleQuote @PUNCT-Semicolon @PUNCT-Colon @PUNCT-SingleQuote @PUNCT-OpenParen @PUNCT-ClosedParen @PUNCT-Exclamation @SYM-Dollar -)) then
        (assert (manual_id-mng ?mid $?pre $?pos))
        else
        (assert (manual_id-mng ?mid $?pre ?h_mng $?pos)))
)
;-------------------------------------------------------------------------------------
;Eng sen : This problem is discussed in detail in Chapter 6.
;Man sen : isa samasyA para aXyAya 6 meM viswAra se carcA kI gaI hE
(defrule rm_REPLACE_NO_from_num
(declare (salience -11))
?f<-(manual_id-mng ?mid $?pre ?mng $?post)
(test (neq (str-index "-" (implode$ (create$ ?mng))) FALSE))
(test (eq (sub-string (str-index "-" (implode$ (create$ ?mng))) (length ?mng) ?mng) "-REPLACE_NO"))
=>
	(retract ?f)
	(bind ?mng (string-to-field (sub-string 1 (- (str-index "-" ?mng) 1) ?mng)))
	(assert (manual_id-mng ?mid $?pre ?mng $?post))
)
;-------------------------------------------------------------------------------------
