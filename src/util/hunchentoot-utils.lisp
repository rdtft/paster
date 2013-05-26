(in-package :paster)

(defparameter *htoot-server* nil)
(defparameter *htoot-port* 5000)

(defun start-http-server ()
  (when *htoot-server*
    (hunchentoot:stop *htoot-server*))
  (setf *htoot-server* (make-instance 'hunchentoot:easy-acceptor :port *htoot-port*))
  (hunchentoot:start *htoot-server*))

(defun stop-http-server ()
  (when *htoot-server*
    (hunchentoot:stop *htoot-server*)
    (setf *htoot-server* nil)))

(defun return-404 ()
  (setf (hunchentoot:return-code*) hunchentoot:+http-not-found+))
