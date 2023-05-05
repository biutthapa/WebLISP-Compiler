(ns compiler.optimizer
  (:require [compiler.ast :as ast]
            [compiler.wasm :as wasm]))

(defn optimize [ast]
  "Optimizes the given AST."
  (optimize-constants ast))

(defn optimize-constants [ast]
  "Folds constants in the AST where possible."
  (ast/rewrite ast
               {:num (fn [n] (wasm/const n))
                :add (fn [& args] (if (= (count args) 1)
                                     (first args)
                                     (wasm/add args)))
                :sub (fn [& args] (if (= (count args) 1)
                                     (wasm/neg (first args))
                                     (wasm/sub args)))
                :mul (fn [& args] (if (some zero? args)
                                     (wasm/const 0)
                                     (if (= (count args) 1)
                                       (first args)
                                       (wasm/mul args))))
                :div (fn [& args] (if (some zero? args)
                                     (wasm/const 0)
                                     (if (= (count args) 1)
                                       (wasm/const 1)
                                       (wasm/div args))))}))
