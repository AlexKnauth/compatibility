#lang info
(define collection 'multi)
(define deps '("scheme-lib"
               ["base" #:version "9.1.0.7"]
               "net-lib"
               "sandbox-lib"))

(define pkg-desc "implementation (no documentation) part of \"compatibility\"")

(define pkg-authors '(eli mflatt robby samth))

(define version "1.1")

(define license
  '(Apache-2.0 OR MIT))
