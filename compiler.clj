(ns web-lisp.compiler
  (:require [clojure.tools.cli :refer [cli]]
            [org.antlr.v4.runtime :as antlr]
            [web-lisp.compiler.parser :as parser]))

(defn tree-shape-listener []
  (reify parser/LispListener
    (enterEveryRule [this ctx]
      (let [rule-name (parser/rule-names (:type ctx))]
        (println (str "Entering rule " rule-name))))))

(defn -main [& args]
  (let [[options arguments banner]
        (cli args [["-h" "--help"]])]
    (if help
      (println banner)
      (let [input (antlr/CharStreams/fromString "(+ 2 2)")
            lexer (parser/LispLexer. input)
            tokens (antlr/CommonTokenStream. lexer)
            parser (parser/LispParser. tokens)
            listener (tree-shape-listener)]
        (antlr/walk listener parser (parser/start))))))

