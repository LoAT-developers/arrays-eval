(set-logic HORN)

(declare-fun |inv| ( (Array Int Int) (Array Int Int) Int Int ) Bool)
(declare-fun |check| ( (Array Int Int) (Array Int Int) Int ) Bool)

(assert
  (forall ( (a (Array Int Int)) (k Int) ) 
    (=>
      true
      (inv a a 0 10000)
    )
  )
)

(assert
  (forall ( (a (Array Int Int)) (b (Array Int Int)) (i Int) (k Int) ) 
    (=>
      (and
        (inv a b i k)
        (< i k)
      )
      (inv (store (store a i (select a (+ i 1))) (+ i 1) (select a i)) b (+ i 1) k)
    )
  )
)

(assert
  (forall ( (a (Array Int Int)) (b (Array Int Int)) (i Int) (k Int) ) 
    (=>
      (and
        (inv a b i k)
        (>= i k)
      )
      (check a b k)
    )
  )
)

(assert
  (forall ( (a (Array Int Int)) (b (Array Int Int)) (y Int) (k Int) ) 
    (=>
      (and
        (check a b k)
        (>= y 0)
        (< y k)
        (distinct (select a y) (select b (+ y 1)))
      )
      false
    )
  )
)

(assert
  (forall ( (a (Array Int Int)) (b (Array Int Int)) (k Int) ) 
    (=>
      (and
        (check a b k)
        (distinct (select a k) (select b 0))
      )
      false
    )
  )
)

(check-sat)
(exit)
