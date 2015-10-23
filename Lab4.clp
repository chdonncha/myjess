(clear)

(deftemplate person "People in actuarial database"
    (slot age)
    (slot name)
    (slot gender))


(assert (person (name "Bob Smith") (age 34) (gender Male)))
(assert (person (gender Male) (name "Tom Smith") (age 32) (gender Male)))
(assert (person (name "Mary Smith") (age 34) (gender Female)))
(assert (person (gender Female)))


(defrule male-ages
    (person (name ?n) (age ?a) (gender Male) )
    =>
    (printout t ?n " is " ?a " years old " crlf))

(defglobal ?*c* = 0)
(defglobal ?*count* = 0 ?*sum* = 0)

(defrule  count-male-rule
	(person (gender Male))
	=>
	(bind ?*c* (+ ?*c* 1)))

(defrule process-males
	(person (gender Male) (age ?a))
	=>
	(bind ?*count* (+ ?*count* 1))
	(bind ?*sum* (+ ?*sum* ?a)))

(deffunction show-avg ()
	(bind ?avg (/ ?*sum* ?*count*))
	(printout t "The average male age is " ?avg))

(run)
(show-avg)