(ns parser)

;; Define the AST data structure
(defprotocol ASTNode
  (visit [this visitor]))

(deftype NumberNode [value]
  ASTNode
  (visit [this visitor]
    (visitor/visitNumberNode this)))

(deftype AddNode [left right]
  ASTNode
  (visit [this visitor]
    (visitor/visitAddNode this)))

(deftype SubtractNode [left right]
  ASTNode
  (visit [this visitor]
    (visitor/visitSubtractNode this)))

;; Define the parser functions
(defn parse-number [tokens]
  (NumberNode. (first tokens)))

(defn parse-add [tokens]
  (let [left (parse-number (next tokens))
        right (parse-number (nthrest tokens 2))]
    (AddNode. left right)))

(defn parse-subtract [tokens]
  (let [left (parse-number (next tokens))
        right (parse-number (nthrest tokens 2))]
    (SubtractNode. left right)))

(defn parse-expression [tokens]
  (cond
    (empty? tokens) nil
    (= (count tokens) 1) (parse-number tokens)
    (= (count tokens) 3) (if (= (second tokens) "+")
                           (parse-add tokens)
                           (parse-subtract tokens))))

(defn parse [input]
  (let [tokens (clojure.string/split input #" ")]
    (parse-expression tokens)))
