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

;; --- Bringing data to the program ---

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

;; --- PLOTS ---

;; --- Sem Núcleo ---

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


;; --- Justaposição dos gráficos de V(t), B(t) vs t. ---

(def V-sem (scatter-plot time-data Vs-data
                    :title "Justaposição V(t) e B(t)"
                    :x-label "Tempo (s)"
                    :y-label "V(t), B(t)"
                    :series-label "V(t)"
                    :legend true))

(doto (add-points V-sem time-data B-data
                  :series-label "B(t)")
  (set-stroke :width 3 :dash 5))



;; --- Com núcleo ---
(view (scatter-plot time-data-com B-data-com
                    :title "Experimento com núcleo"
                    :x-label "Tempo (s)"
                    :y-label "Campo Magnético (B)"
                    :legend "B(t)"))

(view (scatter-plot time-data-com Vs-data-com
                    :title "Experimento com núcleo"
                    :x-label "Tempo (s)"
                    :y-label "Voltagem (V)"
                    :legend "Vs(t)"))

;; --- Justaposição com núcleo---
(def V-com (scatter-plot time-data-com Vs-data-com
                    :title "Justaposição V(t), B(t)"
                    :x-label "Tempo (s)"
                    :y-label "Voltagem (V)"
                    :series-label "V(t)"
                    :legend true))

(doto (add-points V-com time-data-com B-data-com
                  :series-label "B(t)")
  (set-stroke :width 3 :dash 5)
  (add-subtitle "Com núcleo Fe-Si")
  view)


;; --- Histerese ---

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

;; --- Justaposição Histerese---
(def V-histerese (scatter-plot time-data-histerese Vs-data-histerese
                    :title "Justaposição V(t), B(t)"
                    :x-label "Tempo (s)"
                    :y-label "Voltagem (V)"
                    :series-label "V(t)"
                    :legend true))

(doto (add-points V-histerese time-data-histerese B-data-histerese
                  :series-label "B(t)")
  (set-stroke :width 3 :dash 5)
  (add-subtitle "Histerese")
  view)
