
(let ([load (current-load)]
      [load-extension (current-load-extension)]
      [tab ""])
  (let ([mk-chain
	 (lambda (load)
	   (lambda (filename)
	     (fprintf (current-error-port)
		      "~aloading ~a at ~a~n" 
		      tab filename (current-process-milliseconds))
	     (begin0
	      (let ([s tab])
		(dynamic-wind
		 (lambda () (set! tab (string-append " " tab)))
		 (lambda () 
		   (if (regexp-match "_loader" filename)
		       (let ([f (load filename)])
			 (lambda (sym)
			   (fprintf (current-error-port)
				    "~atrying ~a~n" tab sym)
			   (let ([loader (f sym)])
			     (and loader
				  (lambda ()
				    (fprintf (current-error-port)
					     "~astarting ~a at ~a~n" tab sym
					     (current-process-milliseconds))
				    (let ([s tab])
				      (dynamic-wind
				       (lambda () (set! tab (string-append " " tab)))
				       (lambda ()
					 (begin0
					  (loader)
					  (fprintf (current-error-port)
						   "~adone ~a at ~a~n"
						   tab sym
						   (current-process-milliseconds))))
				       (lambda () (set! tab s)))))))))
		       (load filename)))
		 (lambda () (set! tab s))))
	      (fprintf (current-error-port)
		       "~adone ~a at ~a~n"
		       tab filename (current-process-milliseconds)))))])
    (current-load (mk-chain load))
    (current-load-extension (mk-chain load-extension))))