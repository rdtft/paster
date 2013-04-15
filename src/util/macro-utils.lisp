(in-package :paster)

(defmacro read-file-into-list (path)
  (let ((p (gensym "path")))
    `(let ((,p ,path))
       (cl-ppcre:split "\\s+" (read-file-into-string ,p :external-format :utf-8)))))

(defmacro with-open-or-create-file (path stream &rest body)
  (let ((p (gensym "path")))
    `(let ((,p ,path))
       (with-open-file (,stream (ensure-directories-exist ,p) :direction :output :external-format :utf-8 :if-exists :supersede)
         ,@body))))

(defmacro with-create-or-append-file (path stream &rest body)
  (let ((p (gensym "path")))
    `(let ((,p ,path))
       (with-open-file (,stream (ensure-directories-exist ,p)
                                :direction :output :if-does-not-exist :create :external-format :utf-8 :if-exists :append)
         ,@body))))
