; ./aeval-unsafe/./unsafe/s_split_01_000.smt2
(set-logic HORN)

(declare-fun |inv| ( (Array Int Int) (Array Int Int) Int Int ) Bool)
(declare-fun |check| ( (Array Int Int) (Array Int Int) Int ) Bool)

(assert
  (forall ( (a (Array Int Int)) (l Int) ) 
    (=>
      (and (<= 0 l))
      (inv a a 0 10000)
    )
  )
)

(assert
  (forall ( (a (Array Int Int)) (b (Array Int Int)) (x Int) (l Int) ) 
    (=>
      (and
        (inv a b x l)
        (< x l)
      )
      (inv (store (store a x (select a (+ x 1))) (+ x 1) (select a x)) b (+ x 1) l)
    )
  )
)

(assert
  (forall ( (a (Array Int Int)) (b (Array Int Int)) (x Int) (l Int) ) 
    (=>
      (and
        (inv a b x l)
        (>= x l)
      )
      (check a b l)
    )
  )
)

(assert
  (forall ( (a (Array Int Int)) (b (Array Int Int)) (y Int) (l Int) ) 
    (=>
      (and
        (check a b l)
        (>= y 0)
        (< y l)
        (= (select a y) (select b (+ y 1)))
      )
      false
    )
  )
)

(assert
  (forall ( (a (Array Int Int)) (b (Array Int Int)) (l Int) ) 
    (=>
      (and
        (check a b l)
        (distinct (select a l) (select b 0))
      )
      false
    )
  )
)

(check-sat)
(exit)
