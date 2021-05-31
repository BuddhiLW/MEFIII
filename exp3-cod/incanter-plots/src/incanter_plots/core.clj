(ns incanter-plots.core
  (:require [incanter.core]
            [incanter.charts]
            [incanter.stats]
            [sicmutils.env :as env]))

(use '(incanter core io charts stats datasets))
(env/bootstrap-repl!)
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

(def com-nucleo
  (read-dataset "../../dados/FeAlB_Bin_com núcleo.dat"
                :header false
                :delim \tab))
(def time-data-com ($ :col0 com-nucleo))
(def B-data-com ($ :col1 com-nucleo))
(def Vs-data-com ($ :col3 com-nucleo))


(def histerese
  (read-dataset "../../dados/FeAlB-Histerese.dat"
                :header false
                :delim \tab))
(def time-data-histerese ($ :col0 histerese))
(def B-data-histerese ($ :col1 histerese))
(def Vs-data-histerese ($ :col3 histerese))


;; (with-data histerese
   ;; (view $data))

;;save-dir => "~/PP/Faculdade/MEFIII/exp3/img-plots/img-plots.png"
(view (scatter-plot time-data B-data
                    :title "Experimento sem núcleo"
                    :x-label "Tempo (s)"
                    :y-label "Campo Magnético (B)"
                    :legend "B(t)"))

(view (scatter-plot time-data Vs-data
                    :title "Experimento sem núcleo"
                    :x-label "Tempo (s)"
                    :y-label "Voltagem (V)"
                    :legend "Vs(t)"))

(view (scatter-plot time-data-com B-data-com
                    :title "Experimento com núcleo"
                    :x-label "Tempo (s)"
                    :y-label "Campo Magnético (B)"
                    :legend "B(t)"))

(view (scatter-plot time-data-com Vs-data-com
                    :title "Experimento com núcleo"
                    :x-label "Tempo (s)"
                    :y-label "Voltagem (B)"
                    :legend "Vs(t)"))

(view (scatter-plot time-data-histerese B-data-histerese
                    :title "Experimento sem núcleo"
                    :x-label "Tempo (s)"
                    :y-label "Campo Magnético (B)"
                    :legend "B(t)"))

(view (scatter-plot time-data-histerese Vs-data-histerese
                    :title "Experimento sem núcleo"
                    :x-label "Tempo (s)"
                    :y-label "Voltagem (V)"
                    :legend "Vs(t)"))
