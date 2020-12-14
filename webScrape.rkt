#lang racket
(provide (all-defined-out))

(require "constants.rkt")
(require (planet neil/html-parsing:2:0)
         net/url)


;;Web scrape to obtain HTML of the official WECHU website of current schools that are closed
;; ... I hope this doesn't change on Monday ...
(define html (port->string
 (get-pure-port (string->url "https://www.wechu.org/cv/covid-19-school-outbreak"))))

;; Recursive function to match a list of schools to those on the website
(define (getSchools schools)
      (if (string-contains? html (car schools))(car schools) (getSchools (cdr schools))))


;; Get Lockdown status
(define lockdownHTML (port->string
 (get-pure-port (string->url "https://www.wechu.org/cv/local-updates"))))


(define (getLockdownStatus)
      (cond [(string-contains? (string-downcase lockdownHTML) "red") red]
            [(string-contains? (string-downcase lockdownHTML) "orange") orange]
            [(string-contains? (string-downcase lockdownHTML) "green") green]
            [(string-contains? (string-downcase lockdownHTML) "yellow") yellow]
            [(string-contains? (string-downcase lockdownHTML) "gray") gray]))
            
