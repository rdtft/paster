(in-package :paster)

(defvar *ht-server*)

(defun paster-start ()
    (setf *ht-server*
	  (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 5000))))

(defun paster-stop ()
  (progn
    (hunchentoot:stop *ht-server*)
    (setf *ht-server* nil)))

(defun return-404 ()
    (setf (hunchentoot:return-code*) hunchentoot:+http-not-found+))
