(ns incanter-plots.test-plots
  (:require [incanter.core]
            [incanter.charts]
            [incanter.stats]
            [incanter.latex]
            [sicmutils.env :as env]))

(use '(incanter core io charts stats datasets))

(def data (get-dataset :airline-passengers))
(view data)
(def years (sel data :cols 0))
(def months (sel data :cols 2))
(def passengers (sel data :cols 1))
(view (line-chart years passengers
                  :group-by months
                  :legend true))
(view (line-chart months passengers :group-by years :legend true))


(def seasons (mapcat identity (repeat 3 ["winter" "spring" "summer" "fall"])))
(def years (mapcat identity (repeat 4 [2007 2008 2009])))
(def x (sample-uniform 12 :integers true :max 100))
(view (line-chart years x :group-by seasons :legend true))

(view (line-chart ["a" "b" "c" "d" "e" "f"] [10 20 30 10 40 20]))

(view (line-chart (sample "abcdefghij" :size 10 :replacement true)
                  (sample-uniform 10 :max 50) :legend true))

  ;; add a series label
  (def plot (line-chart ["a" "b" "c"] [10 20 30] :legend true :series-label "s1"))
  (view plot)
  (add-categories plot ["a" "b" "c"] [5 25 40] :series-label "s2")


  (view (line-chart :year :passengers :group-by :month :legend true :data data))

  (view (line-chart :month :passengers :group-by :year :legend true :data data))

(with-data data
  (view (line-chart :month :passengers :group-by :year :legend true)))

(with-data (->> ($rollup :sum :passengers :year (get-dataset :airline-passengers))
                ($order :year :asc))
  (view (line-chart :year :passengers)))

(with-data (->> ($rollup :sum :passengers :month (get-dataset :airline-passengers))
                ($order :passengers :asc))
  (view (line-chart :month :passengers)))


  (with-data ($rollup :sum :passengers :month (get-dataset :airline-passengers))
    (view (line-chart :month :passengers)))

(use '(incanter latex))
(doto (function-plot sin -10 10)
  (add-subtitle "subtitle")
  (add-subtitle (latex " \\frac{(a+b)^2} {(a-b)^2}"))
  view)

(def plot (area-chart ["a" "b" "c"] [10 20 30] :legend true :series-label "s1"))
  (view plot)
(add-categories plot ["a" "b" "c"] [5 25 40] :series-label "s2")
