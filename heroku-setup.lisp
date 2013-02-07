(in-package :cl-user)

(print ">>> Building system....")

(load (merge-pathnames "paster.asd" *build-dir*))

(ql:quickload :paster)

;;; Redefine / extend heroku-toplevel here if necessary.

(print ">>> Done building system")
