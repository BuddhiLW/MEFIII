(ns incanter-plots.core
  (:require [incanter.core]))

(defn foo
  "I don't do a whole lot."
  [x]
  (println x "Hello, World!"))

(use '(incanter core io))

;; (map (derivative #(* % %)) [2 4 6])

;; --- Data labels ----

;; tempo	B	tempo	Vs
;; (s)	(T)	(s)	(V)
;; voltagem solenoide (bobina primária)

;; --- Bringing data to plot ---
(def sem-nucleo
  (read-dataset "../../dados/FeAlB_Bin_sem núcleo.dat"
                :header false
                :delim \tab))


