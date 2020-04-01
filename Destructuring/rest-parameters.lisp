(cl:in-package #:concrete-syntax-tree)

(defmethod rest-parameter-bindings
    (client (parameter simple-variable) argument-variable)
  `((,(raw (name parameter)) ,argument-variable)))

(defmethod rest-parameter-bindings
    (client (parameter destructuring-lambda-list) argument-variable)
  (destructuring-lambda-list-bindings client parameter argument-variable))

(defmethod parameter-group-bindings
    (client (parameter-group destructuring-rest-parameter-group)
     argument-variable)
  (rest-parameter-bindings client (parameter parameter-group)
                           argument-variable))
