#lang racket
(provide (all-defined-out))
(require "TDAPixel_20424317_Espinoza.rkt")
(require "TDAImage_20424317_Espinoza.rkt")
;Archivo Script de pruebas que también servirá como main

;; Scripts de pruebas:

; Funcionalidad 2: constructor
(define img4 (imagen 2 2 (pixbit  0 1 0 10) (pixbit  0 0 1 10) (pixbit 1 1 0 20) (pixbit 1 0 1 6)))
(define img5 (imagen 2 2 (pixrgb  0 0  20 30 10)(pixrgb  0 0 20 40 20 10) (pixrgb  0 1 10 10 30 20) (pixrgb 1 0 40 20 10 20) (pixrgb 1 1 30 20 15 10)))
(define img6 (imagen 2 2 (pixhex  0 0 "#FF8532" 10) (pixbit  0 1 "#FF8532" 20) (pixbit 1 0 "#FF8532" 20) (pixbit 1 1 "#FF8532" 20)))

; Funcionalidad 3:

(bitmap? img4)
;#true
(bitmap? img5)
;#false
(bitmap? img6)
;#false


; Funcionalidad 4:
(pixmap? img4)
; #false
(pixmap? img5)
; #true
(pixmap? img6)
; #false

; Funcionalidad 5:

(hexmap? img4)
; #false
(hexmap? img5)
; #false
(hexmap? img6)
;  #true

;Funcionalidad 6:

;(compressed? img4)
;  #false
;(compressed? img5)
;  #false
;(compressed? img6)
; #false

;Funcionalidad 7:
(flipH img4)
(flipH img5)
(flipH img6)

; Funcionalidad 8:
(flipV img4)
(flipV img5)
(flipV img6)

; Funcionalidad 9:
(crop img4 10 10 40 40)
(crop img5 10 20 40 40)
(crop img6 10 10 40 40)


;Funcionalidad 10:
;(imgRGB->imgHex img4)
;(imgRGB->imgHex (imagen 2 2 (pixrgb  0 0 0 0 1 10) (pixrgb  0 1 2 3 4 20) (pixrgb 1 0 2 0 0 30) (pixrgb 1 1 0 1 1 40)))
;(imgRGB->imgHex (imagen 2 2 (pixrgb  0 0 120 120 10 10) (pixrgb  0 1 255 200 120 20) (pixrgb 1 0 150 120 120 30) (pixrgb 1 1 140 140 140 20)))

;Funcionalidad 14:
;Función implementada pero no está implementada la función para aplicar dentro del edit

;Algunas funciones no fueron agregadas debido a que funcionan de forma parcial / no completa.

;img1

;Creación de una imagen de 2 x 2 del tipo pixmap
(define img1 (imagen 2 2
                  (pixrgb 0 0 255 0 0 10)
                  (pixrgb 0 1 0 255 0 20)
                  (pixrgb 1 0 0 0 255 10)
                  (pixrgb 1 1 255 255 255  1)
 ))

;img2

;Creación de una imagen de 2 x 2 del tipo bitmap
(define img2 (imagen 2 2
                  (pixbit 0 0 0 10)
                  (pixbit 0 1 1 20)
                  (pixbit 1 0 1 10)
                  (pixbit 1 1 0 255))
 )

(define img3 (imgRGB->imgHex img1))



;output:
; #FF0000 #00FF00
; #0000FF #FFFFFF


;output:
;0 1
;1 0
 

(bitmap? img1) ; la respuesta debería ser #f
(bitmap? img2)  ; la respuesta debería ser #t
(bitmap? img3)  ; la respuesta debería ser #f

(pixmap? img1) ; la respuesta debería ser #t
(pixmap? img2)  ; la respuesta debería ser #f
(pixmap? img3)  ; la respuesta debería ser #f

(hexmap? img1) ; la respuesta debería ser #f
(hexmap? img2)  ; la respuesta debería ser #f
(hexmap? img3)  ; la respuesta debería ser #t

(compressed? img1) ; la respuesta debería ser #f
(compressed? img2) ; la respuesta debería ser #f
(compressed? img3) ; la respuesta debería ser #f

(flipH img1)
(flipH img2)
(flipH img3)

(flipV img1)
(flipV img2)
(flipV img3)



(define img18 (rotate90 img1))
(define img19 (rotate90 img2))
(define img20 (rotate90 img3))


(define img8 (compress img1))
(define img9 (compress img2))
(define img10 (compress img3))


(compressed? img8) 
(compressed? img9)  
(compressed? img10)  

;(define img15 (edit invertColorBit img2))
;(define img16 (edit invertColorRGB img1))

