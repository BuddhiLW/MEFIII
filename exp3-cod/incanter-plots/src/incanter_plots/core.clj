(ns incanter-plots.core
  (:require [incanter.core]
            [incanter.charts]
            [incanter.stats]))

(defn foo
  "I don't do a whole lot."
  [x]
  (println x "Hello, World!"))

(use '(incanter core io charts stats datasets))

;; (map (derivative #(* % %)) [2 4 6])

;; --- Data labels ----

;; (s)	(T)	(s)	(V)
;; voltagem solenoide (bobina primária)

;; --- Bringing data to plot ---
(def sem-nucleo
  (read-dataset "../../dados/FeAlB_Bin_sem núcleo.dat"
                :header false
                :delim \tab))

(def time-data ($ :col0 sem-nucleo))
(def B-data ($ :col1 sem-nucleo))
(def Vs-data ($ :col3 sem-nucleo))

;; (with-data sem-nucleo
;;    (view $data))

;;save-dir => "~/PP/Faculdade/MEFIII/exp3/img-plots/img-plots.png"
(view (scatter-plot time-data B-data
                    :title "Experimento sem núcleo"
                    :x-label "Tempo (s)"
                    :y-label "Campo Magnético"
                    :legend "B(t)"))

