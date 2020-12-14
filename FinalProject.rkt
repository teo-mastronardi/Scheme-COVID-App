#lang racket
(require "webScrape.rkt"
         "constants.rkt"
         net/sendurl
         net/url)



;; Display the constants for meanings of restrictions
(define (showCodes)
  (display green)
  (display yellow)
  (display red)
  (display orange)
  (display gray))

;; Send User to Website To Make Testing Appointment
(define (you-might-have-the-vid)
  (display symptom)
  (send-url link-to-test-center))


;; Make-shift, not really NLP but NLP for finding symptoms in a sentence from user
(define (symptom-checker param)
  (cond
        [(empty? param) "Incorrect value. Please tell us how you're feeling"]
        [(or (and (string-contains? param "severe") (or(string-contains? param "cough")
              (string-contains? param "chest pain") (string-contains? param "breath")))
              (string-contains? param "confus") (string-contains? param "conscious")) emergency]
        
        [(or (string-contains? param "sore throat")(string-contains? param "37.8 degrees")
             (string-contains? param "shortness of breath") (string-contains? param "chills")
             (string-contains? param "cough") (string-contains? param "difficulty swallowing")
             (string-contains? param "hard swallow") (string-contains? param "sense of taste")
             (string-contains? param "sense of smell") (string-contains? param "pink eye")
             (string-contains? param "nausea")(string-contains? param "vomiting")
             (string-contains? param "diarrhea") (string-contains? param "stomach pain")
             (string-contains? param "tiredness") (string-contains? param "fatigue")
             (string-contains? param "fever"))
             (you-might-have-the-vid)]
        [else "You seem healthy with no symptoms of COVID-19! Remember to practice social distancing
and wear a mask!"]))


;; Main code of the program
(define (parser param)
  (cond [(string=? param "1") (display "Please tell us how you are feeling in a sentence or words.
")(symptom-checker(string-downcase (read-line)))]
        [(string=? param "2") (getLockdownStatus)]
        [(string=? param "3") (showCodes)]
        [(string=? param "4") (getSchools lstSchools)]))
        


(display "What would you like to do today?
1. Check Symptoms
2. Check Current Area Restrictions
3. What do the colour codes represent?
4. What Local Schools are closed?
")
 (parser(read-line))