(cl:in-package #:concrete-syntax-tree-lambda-list-test)

(defun assert-success (parser)
  (let ((item (cst::find-final-item parser)))
    (assert (not (null item)))
    (car (cst::parse-trees item))))

(defun test-ordinary (lambda-list)
  (let* ((p (make-instance 'cst::parser
              :rules cst::*ordinary-lambda-list-grammar*
              :input lambda-list
              :lambda-list (make-instance 'cst::ordinary-lambda-list)
              :client nil)))
    (cst::parse p)
    (let ((result (assert-success p)))
      (compare-parse-trees result (parse-ordinary-lambda-list lambda-list)))))

(defun test-generic-function (lambda-list)
  (let* ((p (make-instance 'cst::parser
              :rules cst::*generic-function-lambda-list-grammar*
              :input lambda-list
              :lambda-list
              (make-instance 'cst::generic-function-lambda-list)
              :client nil)))
    (cst::parse p)
    (let ((result (assert-success p)))
      (compare-parse-trees
       result (parse-generic-function-lambda-list lambda-list)))))

(defun test-specialized (lambda-list)
  (let* ((p (make-instance 'cst::parser
              :rules cst::*specialized-lambda-list-grammar*
              :input lambda-list
              :lambda-list
              (make-instance 'cst::specialized-lambda-list)
              :client nil)))
    (cst::parse p)
    (let ((result (assert-success p)))
      (compare-parse-trees
       result (parse-specialized-lambda-list lambda-list)))))

(defun test-defsetf (lambda-list)
  (let* ((p (make-instance 'cst::parser
              :rules cst::*defsetf-lambda-list-grammar*
              :input lambda-list
              :lambda-list
              (make-instance 'cst::defsetf-lambda-list)
              :client nil)))
    (cst::parse p)
    (let ((result (assert-success p)))
      (compare-parse-trees
       result (parse-defsetf-lambda-list lambda-list)))))

(defun test-define-modify-macro (lambda-list)
  (let* ((p (make-instance 'cst::parser
              :rules cst::*define-modify-macro-lambda-list-grammar*
              :input lambda-list
              :lambda-list
              (make-instance 'cst::define-modify-macro-lambda-list)
              :client nil)))
    (cst::parse p)
    (let ((result (assert-success p)))
      (compare-parse-trees
       result (parse-define-modify-macro-lambda-list lambda-list)))))

(defun test-define-method-combination (lambda-list)
  (let* ((p (make-instance 'cst::parser
              :rules cst::*define-method-combination-lambda-list-grammar*
              :input lambda-list
              :lambda-list
              (make-instance 'cst::define-method-combination-lambda-list)
              :client nil)))
    (cst::parse p)
    (let ((result (assert-success p)))
      (compare-parse-trees
       result (parse-define-method-combination-lambda-list lambda-list)))))

(defun test-destructuring (lambda-list)
  (let* ((p (make-instance 'cst::parser
              :rules cst::*destructuring-lambda-list-grammar*
              :input lambda-list
              :lambda-list
              (make-instance 'cst::destructuring-lambda-list)
              :client nil)))
    (cst::parse p)
    (let ((result (assert-success p)))
      (compare-parse-trees
       result (parse-destructuring-lambda-list lambda-list)))))

(defun test-ordinary-lambda-lists ()
  (assert (test-ordinary '()))
  (assert (test-ordinary '(a)))
  (assert (test-ordinary '(a b)))
  (assert (test-ordinary '(&optional)))
  (assert (test-ordinary '(&optional a)))
  (assert (test-ordinary '(&optional a b)))
  (assert (test-ordinary '(&optional (a (f x)))))
  (assert (test-ordinary '(&optional (a (f x)) b)))
  (assert (test-ordinary '(&optional (a (f x) supplied-p))))
  (assert (test-ordinary '(a &optional)))
  (assert (test-ordinary '(a &optional b)))
  (assert (test-ordinary '(a &optional (b (f x)))))
  (assert (test-ordinary '(&rest a)))
  (assert (test-ordinary '(a &rest b)))
  (assert (test-ordinary '(a b &rest c)))
  (assert (test-ordinary '(&optional a &rest b)))
  (assert (test-ordinary '(&optional a (b) &rest c)))
  (assert (test-ordinary '(a &optional b &rest c)))
  (assert (test-ordinary '(&key)))
  (assert (test-ordinary '(&key a)))
  (assert (test-ordinary '(&key a b)))
  (assert (test-ordinary '(&key (a (f x)))))
  (assert (test-ordinary '(&key (a (f x) supplied-p))))
  (assert (test-ordinary '(&key ((:a a) (f x) supplied-p))))
  (assert (test-ordinary '(a &key)))
  (assert (test-ordinary '(a &key b)))
  (assert (test-ordinary '(b &key ((:a a) (f x) supplied-p))))
  (assert (test-ordinary '(b &optional c &key ((:a a) (f x) supplied-p))))
  (assert (test-ordinary '(&key &allow-other-keys)))
  (assert (test-ordinary '(&aux)))
  (assert (test-ordinary '(&aux a)))
  (assert (test-ordinary '(&aux (a (f x)))))
  (assert (test-ordinary '(&aux b (a (f x)))))
  (assert (test-ordinary '(b &aux a)))
  (assert (test-ordinary '(b &optional c &aux a)))
  (assert (test-ordinary '(b &optional c &key d &aux a)))
  (assert (test-ordinary '(b &optional c &key d &allow-other-keys &aux a))))

(defun test-generic-function-lambda-lists ()
  (assert (test-generic-function '()))
  (assert (test-generic-function '(a)))
  (assert (test-generic-function '(a b)))
  (assert (test-generic-function '(&optional)))
  (assert (test-generic-function '(&optional a)))
  (assert (test-generic-function '(&optional a b)))
  (assert (test-generic-function '(a &optional)))
  (assert (test-generic-function '(a &optional b)))
  (assert (test-generic-function '(&rest a)))
  (assert (test-generic-function '(a &rest b)))
  (assert (test-generic-function '(a b &rest c)))
  (assert (test-generic-function '(&optional a &rest b)))
  (assert (test-generic-function '(&optional a (b) &rest c)))
  (assert (test-generic-function '(a &optional b &rest c)))
  (assert (test-generic-function '(&key)))
  (assert (test-generic-function '(a &key b)))
  (assert (test-generic-function '(b &key ((:a a)))))
  (assert (test-generic-function '(b &optional c &key ((:a a)))))
  (assert (test-generic-function '(&key &allow-other-keys))))

(defun test-specialized-lambda-lists ()
  (assert (test-specialized '()))
  (assert (test-specialized '(a)))
  (assert (test-specialized '((a class))))
  (assert (test-specialized '((a (eql hello)))))
  (assert (test-specialized '(a b)))
  (assert (test-specialized '((a class) b)))
  (assert (test-specialized '((a (eql hello)) b)))
  (assert (test-specialized '(&optional)))
  (assert (test-specialized '(&optional a)))
  (assert (test-specialized '(&optional a b)))
  (assert (test-specialized '(&optional (a (f x)))))
  (assert (test-specialized '(&optional (a (f x)) b)))
  (assert (test-specialized '(&optional (a (f x) supplied-p))))
  (assert (test-specialized '(a &optional)))
  (assert (test-specialized '((a class) &optional)))
  (assert (test-specialized '((a (eql hello)) &optional)))
  (assert (test-specialized '(a &optional b)))
  (assert (test-specialized '(a &optional (b (f x)))))
  (assert (test-specialized '(&rest a)))
  (assert (test-specialized '(a &rest b)))
  (assert (test-specialized '(a b &rest c)))
  (assert (test-specialized '(&optional a &rest b)))
  (assert (test-specialized '(&optional a (b) &rest c)))
  (assert (test-specialized '(a &optional b &rest c)))
  (assert (test-specialized '(&key)))
  (assert (test-specialized '(&key a)))
  (assert (test-specialized '(&key a b)))
  (assert (test-specialized '(&key (a (f x)))))
  (assert (test-specialized '(&key (a (f x) supplied-p))))
  (assert (test-specialized '(&key ((:a a) (f x) supplied-p))))
  (assert (test-specialized '(a &key)))
  (assert (test-specialized '(a &key b)))
  (assert (test-specialized '(b &key ((:a a) (f x) supplied-p))))
  (assert (test-specialized '(b &optional c &key ((:a a) (f x) supplied-p))))
  (assert (test-specialized '(&key &allow-other-keys)))
  (assert (test-specialized '(&aux)))
  (assert (test-specialized '(&aux a)))
  (assert (test-specialized '(&aux (a (f x)))))
  (assert (test-specialized '(&aux b (a (f x)))))
  (assert (test-specialized '(b &aux a)))
  (assert (test-specialized '(b &optional c &aux a)))
  (assert (test-specialized '(b &optional c &key d &aux a)))
  (assert (test-specialized '(b &optional c &key d &allow-other-keys &aux a))))

(defun test-defsetf-lambda-lists ()
  (assert (test-defsetf '()))
  (assert (test-defsetf '(&environment a)))
  (assert (test-defsetf '(a)))
  (assert (test-defsetf '(a &environment a)))
  (assert (test-defsetf '(a b)))
  (assert (test-defsetf '(a b &environment a)))
  (assert (test-defsetf '(&optional)))
  (assert (test-defsetf '(&optional &environment a)))
  (assert (test-defsetf '(&optional a)))
  (assert (test-defsetf '(&optional a &environment a)))
  (assert (test-defsetf '(&optional a b)))
  (assert (test-defsetf '(&optional a b &environment a)))
  (assert (test-defsetf '(&optional (a (f x)))))
  (assert (test-defsetf '(&optional (a (f x)) &environment a)))
  (assert (test-defsetf '(&optional (a (f x)) b)))
  (assert (test-defsetf '(&optional (a (f x)) b &environment a)))
  (assert (test-defsetf '(&optional (a (f x) supplied-p))))
  (assert (test-defsetf '(&optional (a (f x) supplied-p) &environment a)))
  (assert (test-defsetf '(a &optional)))
  (assert (test-defsetf '(a &optional &environment a)))
  (assert (test-defsetf '(a &optional b)))
  (assert (test-defsetf '(a &optional b &environment a)))
  (assert (test-defsetf '(a &optional (b (f x)))))
  (assert (test-defsetf '(a &optional (b (f x)) &environment a)))
  (assert (test-defsetf '(&rest a)))
  (assert (test-defsetf '(&rest a &environment a)))
  (assert (test-defsetf '(a &rest b)))
  (assert (test-defsetf '(a &rest b &environment a)))
  (assert (test-defsetf '(a b &rest c)))
  (assert (test-defsetf '(a b &rest c &environment a)))
  (assert (test-defsetf '(&optional a &rest b)))
  (assert (test-defsetf '(&optional a &rest b &environment a)))
  (assert (test-defsetf '(&optional a (b) &rest c)))
  (assert (test-defsetf '(&optional a (b) &rest c &environment a)))
  (assert (test-defsetf '(a &optional b &rest c)))
  (assert (test-defsetf '(a &optional b &rest c &environment a)))
  (assert (test-defsetf '(&key)))
  (assert (test-defsetf '(&key &environment a)))
  (assert (test-defsetf '(&key a)))
  (assert (test-defsetf '(&key a &environment a)))
  (assert (test-defsetf '(&key a b)))
  (assert (test-defsetf '(&key a b &environment a)))
  (assert (test-defsetf '(&key (a (f x)))))
  (assert (test-defsetf '(&key (a (f x)) &environment a)))
  (assert (test-defsetf '(&key (a (f x) supplied-p))))
  (assert (test-defsetf '(&key (a (f x) supplied-p) &environment a)))
  (assert (test-defsetf '(&key ((:a a) (f x) supplied-p))))
  (assert (test-defsetf '(&key ((:a a) (f x) supplied-p) &environment a)))
  (assert (test-defsetf '(a &key)))
  (assert (test-defsetf '(a &key &environment a)))
  (assert (test-defsetf '(a &key b)))
  (assert (test-defsetf '(a &key b &environment a)))
  (assert (test-defsetf '(b &key ((:a a) (f x) supplied-p))))
  (assert (test-defsetf '(b &key ((:a a) (f x) supplied-p) &environment a)))
  (assert (test-defsetf '(b &optional c &key ((:a a) (f x) supplied-p))))
  (assert (test-defsetf '(b &optional c &key ((:a a) (f x) supplied-p) &environment a)))
  (assert (test-defsetf '(&key &allow-other-keys)))
  (assert (test-defsetf '(&key &allow-other-keys &environment a))))

(defun test-define-modify-macro-lambda-lists ()
  (assert (test-define-modify-macro '()))
  (assert (test-define-modify-macro '(a)))
  (assert (test-define-modify-macro '(a b)))
  (assert (test-define-modify-macro '(&optional)))
  (assert (test-define-modify-macro '(&optional a)))
  (assert (test-define-modify-macro '(&optional a b)))
  (assert (test-define-modify-macro '(&optional (a (f x)))))
  (assert (test-define-modify-macro '(&optional (a (f x)) b)))
  (assert (test-define-modify-macro '(&optional (a (f x) supplied-p))))
  (assert (test-define-modify-macro '(a &optional)))
  (assert (test-define-modify-macro '(a &optional b)))
  (assert (test-define-modify-macro '(a &optional (b (f x)))))
  (assert (test-define-modify-macro '(&rest a)))
  (assert (test-define-modify-macro '(a &rest b)))
  (assert (test-define-modify-macro '(a b &rest c)))
  (assert (test-define-modify-macro '(&optional a &rest b)))
  (assert (test-define-modify-macro '(&optional a (b) &rest c)))
  (assert (test-define-modify-macro '(a &optional b &rest c))))

(defun test-define-method-combination-lambda-lists ()
  (assert (test-define-method-combination '()))
  (assert (test-define-method-combination '(a)))
  (assert (test-define-method-combination '(a b)))
  (assert (test-define-method-combination '(&optional)))
  (assert (test-define-method-combination '(&optional a)))
  (assert (test-define-method-combination '(&optional a b)))
  (assert (test-define-method-combination '(&optional (a (f x)))))
  (assert (test-define-method-combination '(&optional (a (f x)) b)))
  (assert (test-define-method-combination '(&optional (a (f x) supplied-p))))
  (assert (test-define-method-combination '(a &optional)))
  (assert (test-define-method-combination '(a &optional b)))
  (assert (test-define-method-combination '(a &optional (b (f x)))))
  (assert (test-define-method-combination '(&rest a)))
  (assert (test-define-method-combination '(a &rest b)))
  (assert (test-define-method-combination '(a b &rest c)))
  (assert (test-define-method-combination '(&optional a &rest b)))
  (assert (test-define-method-combination '(&optional a (b) &rest c)))
  (assert (test-define-method-combination '(a &optional b &rest c)))
  (assert (test-define-method-combination '(&key)))
  (assert (test-define-method-combination '(&key a)))
  (assert (test-define-method-combination '(&key a b)))
  (assert (test-define-method-combination '(&key (a (f x)))))
  (assert (test-define-method-combination '(&key (a (f x) supplied-p))))
  (assert (test-define-method-combination '(&key ((:a a) (f x) supplied-p))))
  (assert (test-define-method-combination '(a &key)))
  (assert (test-define-method-combination '(a &key b)))
  (assert (test-define-method-combination '(b &key ((:a a) (f x) supplied-p))))
  (assert (test-define-method-combination '(b &optional c &key ((:a a) (f x) supplied-p))))
  (assert (test-define-method-combination '(&key &allow-other-keys)))
  (assert (test-define-method-combination '(&aux)))
  (assert (test-define-method-combination '(&aux a)))
  (assert (test-define-method-combination '(&aux (a (f x)))))
  (assert (test-define-method-combination '(&aux b (a (f x)))))
  (assert (test-define-method-combination '(b &aux a)))
  (assert (test-define-method-combination '(b &optional c &aux a)))
  (assert (test-define-method-combination '(b &optional c &key d &aux a)))
  (assert (test-define-method-combination '(b &optional c &key d &allow-other-keys &aux a)))
  (assert (test-define-method-combination '(&whole x )))
  (assert (test-define-method-combination '(&whole x a)))
  (assert (test-define-method-combination '(&whole x a b)))
  (assert (test-define-method-combination '(&whole x &optional)))
  (assert (test-define-method-combination '(&whole x &optional a)))
  (assert (test-define-method-combination '(&whole x &optional a b)))
  (assert (test-define-method-combination '(&whole x &optional (a (f x)))))
  (assert (test-define-method-combination '(&whole x &optional (a (f x)) b)))
  (assert (test-define-method-combination '(&whole x &optional (a (f x) supplied-p))))
  (assert (test-define-method-combination '(&whole x a &optional)))
  (assert (test-define-method-combination '(&whole x a &optional b)))
  (assert (test-define-method-combination '(&whole x a &optional (b (f x)))))
  (assert (test-define-method-combination '(&whole x &rest a)))
  (assert (test-define-method-combination '(&whole x a &rest b)))
  (assert (test-define-method-combination '(&whole x a b &rest c)))
  (assert (test-define-method-combination '(&whole x &optional a &rest b)))
  (assert (test-define-method-combination '(&whole x &optional a (b) &rest c)))
  (assert (test-define-method-combination '(&whole x a &optional b &rest c)))
  (assert (test-define-method-combination '(&whole x &key)))
  (assert (test-define-method-combination '(&whole x &key a)))
  (assert (test-define-method-combination '(&whole x &key a b)))
  (assert (test-define-method-combination '(&whole x &key (a (f x)))))
  (assert (test-define-method-combination '(&whole x &key (a (f x) supplied-p))))
  (assert (test-define-method-combination '(&whole x &key ((:a a) (f x) supplied-p))))
  (assert (test-define-method-combination '(&whole x a &key)))
  (assert (test-define-method-combination '(&whole x a &key b)))
  (assert (test-define-method-combination '(&whole x b &key ((:a a) (f x) supplied-p))))
  (assert (test-define-method-combination '(&whole x b &optional c &key ((:a a) (f x) supplied-p))))
  (assert (test-define-method-combination '(&whole x &key &allow-other-keys)))
  (assert (test-define-method-combination '(&whole x &aux)))
  (assert (test-define-method-combination '(&whole x &aux a)))
  (assert (test-define-method-combination '(&whole x &aux (a (f x)))))
  (assert (test-define-method-combination '(&whole x &aux b (a (f x)))))
  (assert (test-define-method-combination '(&whole x b &aux a)))
  (assert (test-define-method-combination '(&whole x b &optional c &aux a)))
  (assert (test-define-method-combination '(&whole x b &optional c &key d &aux a)))
  (assert (test-define-method-combination '(&whole x b &optional c &key d &allow-other-keys &aux a))))

(defun test-destructuring-lambda-lists ()
  (assert (test-destructuring '()))
  (assert (test-destructuring '(a)))
  (assert (test-destructuring '(a b)))
  (assert (test-destructuring '(&optional)))
  (assert (test-destructuring '(&optional a)))
  (assert (test-destructuring '(&optional a b)))
  (assert (test-destructuring '(&optional (a (f x)))))
  (assert (test-destructuring '(&optional (a (f x)) b)))
  (assert (test-destructuring '(&optional (a (f x) supplied-p))))
  (assert (test-destructuring '(a &optional)))
  (assert (test-destructuring '(a &optional b)))
  (assert (test-destructuring '(a &optional (b (f x)))))
  (assert (test-destructuring '(&rest a)))
  (assert (test-destructuring '(a &rest b)))
  (assert (test-destructuring '(a b &rest c)))
  (assert (test-destructuring '(&optional a &rest b)))
  (assert (test-destructuring '(&optional a (b) &rest c)))
  (assert (test-destructuring '(a &optional b &rest c)))
  (assert (test-destructuring '(&key)))
  (assert (test-destructuring '(&key a)))
  (assert (test-destructuring '(&key a b)))
  (assert (test-destructuring '(&key (a (f x)))))
  (assert (test-destructuring '(&key (a (f x) supplied-p))))
  (assert (test-destructuring '(&key ((:a a) (f x) supplied-p))))
  (assert (test-destructuring '(a &key)))
  (assert (test-destructuring '(a &key b)))
  (assert (test-destructuring '(b &key ((:a a) (f x) supplied-p))))
  (assert (test-destructuring '(b &optional c &key ((:a a) (f x) supplied-p))))
  (assert (test-destructuring '(&key &allow-other-keys)))
  (assert (test-destructuring '(&aux)))
  (assert (test-destructuring '(&aux a)))
  (assert (test-destructuring '(&aux (a (f x)))))
  (assert (test-destructuring '(&aux b (a (f x)))))
  (assert (test-destructuring '(b &aux a)))
  (assert (test-destructuring '(b &optional c &aux a)))
  (assert (test-destructuring '(b &optional c &key d &aux a)))
  (assert (test-destructuring '(b &optional c &key d &allow-other-keys &aux a)))
  (assert (test-destructuring '(())))
  (assert (test-destructuring '((a))))
  (assert (test-destructuring '((a b))))
  (assert (test-destructuring '((&optional))))
  (assert (test-destructuring '((&optional a))))
  (assert (test-destructuring '((&optional a b))))
  (assert (test-destructuring '((&optional (a (f x))))))
  (assert (test-destructuring '((&optional (a (f x)) b))))
  (assert (test-destructuring '((&optional (a (f x) supplied-p)))))
  (assert (test-destructuring '((a &optional))))
  (assert (test-destructuring '((a &optional b))))
  (assert (test-destructuring '((a &optional (b (f x))))))
  (assert (test-destructuring '((&rest a))))
  (assert (test-destructuring '((a &rest b))))
  (assert (test-destructuring '((a b &rest c))))
  (assert (test-destructuring '((&optional a &rest b))))
  (assert (test-destructuring '((&optional a (b) &rest c))))
  (assert (test-destructuring '((a &optional b &rest c))))
  (assert (test-destructuring '((&key))))
  (assert (test-destructuring '((&key a))))
  (assert (test-destructuring '((&key a b))))
  (assert (test-destructuring '((&key (a (f x))))))
  (assert (test-destructuring '((&key (a (f x) supplied-p)))))
  (assert (test-destructuring '((&key ((:a a) (f x) supplied-p)))))
  (assert (test-destructuring '((a &key))))
  (assert (test-destructuring '((a &key b))))
  (assert (test-destructuring '((b &key ((:a a) (f x) supplied-p)))))
  (assert (test-destructuring '((b &optional c &key ((:a a) (f x) supplied-p)))))
  (assert (test-destructuring '((&key &allow-other-keys))))
  (assert (test-destructuring '((&aux))))
  (assert (test-destructuring '((&aux a))))
  (assert (test-destructuring '((&aux (a (f x))))))
  (assert (test-destructuring '((&aux b (a (f x))))))
  (assert (test-destructuring '((b &aux a))))
  (assert (test-destructuring '((b &optional c &aux a))))
  (assert (test-destructuring '((b &optional c &key d &aux a))))
  (assert (test-destructuring '((b &optional c &key d &allow-other-keys &aux a))))
  (assert (test-destructuring '((())))))

(defun test ()
  (test-ordinary-lambda-lists)
  (test-generic-function-lambda-lists)
  (test-specialized-lambda-lists)
  (test-defsetf-lambda-lists)
  (test-define-modify-macro-lambda-lists)
  (test-define-method-combination-lambda-lists)
  (test-destructuring-lambda-lists))
