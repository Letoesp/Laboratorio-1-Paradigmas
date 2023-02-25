#lang racket
(provide (all-defined-out))
(require "TDAPixel_20424317_Espinoza.rkt")
;Se necesita de TDA pixel para la construcción y funcionalidades de TDA IMAGE
;TDA IMAGE
;Representación-----------------------------------------------------
;Este TDA corresponde a la representación de una imagen, en donde su estructura será mediante listas.


;Contructores-----------------------------------------------

;Dominio: Se pide un tamaño de imagen (ancho y largo) y una cantidad de pixeles de forma homogénea 
;Recorrido: image
;Descripción : Función que construye imagenes con bitmaps, hexmaps o pixmaps. Se
;incluye información de profundidad de cada pixel

(define(imagen ancho largo . pixel) (list ancho largo pixel))


;Funciones de pertenencia-----------------------------------

;Dominio: image
;Recorrido: boolean
;Descripción: función que permite determinar si la imagen corresponde a un bitmap
(define bitmap?(lambda(imagen)
  (and(eq? (length (car(caddr(car(list imagen)))))4)(eq? (caddr(car(getpixeles imagen)))(or 1 0)))))

;Dominio: image
;Recorrido: boolean
;Descripción: función que permite determinar si la imagen corresponde a un pixmap
(define pixmap? (lambda(imagen)
  (eq? (length (car(caddr(car(list imagen))))) 6)))

;Dominio: image
;Recorrido: boolean
;Descripción: función que permite determinar si la imagen corresponde a un hexmap-d
(define hexmap?(lambda(imagen)
  (and (eq?(length (car(caddr(car(list imagen)))))4)(string?(caddr(car(getpixeles imagen)))))))


;Dominio: image
;Recorrido: boolean
;Descripción: función que determina si una imagen está comprimida.
(define compressed? (lambda (imagen)
  (if (< (length(getpixeles imagen))(* (getancho imagen)(getlargo imagen)))(display #t)(display #f))))

;Selectores-------------------------------------------------
;; Dominio: image
;; Recorrido: list
;; Descripcion: función que permite obtener los pixeles de una imagen.

(define (getpixeles imagen) (car(cdr(cdr imagen))))

;; Dominio: image
;; Recorrido: ancho
;; Descripción : función que permite obtener el ancho de una imagen.

(define (getancho imagen) (cadr imagen))
  
;; Dominio: image
;; Recorrido: largo
;; Descripción :función que permite obtener el largo de una imagen

(define (getlargo imagen) (car imagen))

;; Dominio: pixrgb
;; Recorrido: entero
;; Descripción: función que permite obtener el valor de Red de una imagen RGB

(define (getRed pixel) (caddr(pixel)))

;; Dominio: pixrgb
;; Recorrido: entero
;; Descripción: función que permite obtener el valor de Green de una imagen RGB

(define (getGreen pixel) (cadddr(pixel)))

;; Dominio: pixrgb
;; Recorrido: entero
;; Descripción: función que permite obtener el valor de Azul de una imagen RGB

(define (getBlue pixel) (cadr(cdddr(pixel))))

;; Dominio: pixrgb
;; Recorrido: entero
;; Descripción: función que permite obtener el valor de Profundidad de una imagen RGB

(define (getProf pixel) (caddr(cdddr(pixel))))


;Modificadores----------------------------------------------

;; Dominio: pixrgb
;; Recorrido: entero
;; Descripción :función que permite seleccionar el valor de Rojo de una imagen RGB

(define setRed (lambda (valor) valor))

;; Dominio: pixrgb
;; Recorrido: entero
;; Descripción : función que permite seleccionar el valor de Verde de una imagen RGB

(define setGreen (lambda (valor) valor))

;; Dominio: pixrgb
;; Recorrido: entero
;; Descripción : función que permite seleccionar el valor de Azul de una imagen RGB

(define setBlue (lambda (valor) valor))


;Dominio: image
;Recorrido: image
;Descripción: Función que permite invertir una imagen horizontalmente
(define flipH (lambda (imagen) (list (getancho imagen) (getlargo imagen) (map (lambda (pixel)
                                                               (cond [(> (length pixel) 5)(list(car pixel)(+(- (cadr pixel)(cadr pixel))(getlargo pixel))(caddr pixel)(cadddr pixel)(cadr (cdddr pixel))(caddr (cdddr pixel)))]
                                                                     [(< (length pixel) 5)(list (car pixel)(+(-(cadr pixel)(cadr pixel))(getlargo pixel))(caddr pixel)(cadddr pixel))]))
                                                             (getpixeles imagen)))))
;Dominio: image
;Recorrido: image
;Descripción: Función que permite invertir una imagen verticalmente
(define flipV (lambda (imagen) (list (getancho imagen) (getlargo imagen) (map (lambda (pixel)
                                                               (cond [(> (length pixel) 5)(list (+(- (car pixel)(car pixel))(getlargo pixel))(cadr pixel)(caddr pixel)(cadddr pixel)(cadr (cdddr pixel))(caddr (cdddr pixel)))]
                                                                     [(< (length pixel) 5)(list (+(- (car pixel)(car pixel))(getlargo pixel))(cadr pixel)(caddr pixel)(cadddr pixel))]))
                                                             (getpixeles imagen)))))

;Dominio: image X x1 (int) X y1 (int) X x2 (int) X y2 (int)
;Recorrido: image
;Descripción: función que permite recortar una imagen a partir de un cuadrante
(define crop (lambda (imagen x1 y1 x2 y2) (list (getancho imagen) (getlargo imagen) (map (lambda (pixel)
                                                                          (cond[(> (length pixel) 5)(list (+ (- (car pixel)(car pixel))(getlargo pixel))(cadr pixel)(caddr pixel)(cadddr pixel)(cadr (cdddr pixel))(caddr (cdddr pixel)))]
                                                                     [(< (length pixel) 5)(list (+ (- (car pixel)(car pixel))(getlargo pixel))(cadr pixel)(caddr pixel)(cadddr pixel))]))
                                                                        (getpixeles imagen)))))
;Dominio: image
;Recorrido: image
;Descripción: función que transforma una imagen desde una representación RGB a una
;representación HEX.
(define imgRGB->imgHex (lambda (imagen)
                         (list (getlargo imagen) (getancho imagen)
                               (map (lambda (pixel)
                         (pixhex (car pixel) (cadr pixel)
                                 (string-append "#"(hexa(caddr pixel))(hexa(cadddr pixel))(hexa(cadddr(cdr pixel))))(cadddr(cddr pixel))))(car(cdr(cdr imagen)))))))
;Dominio: image
;Recorrido: image
;Descripción: función que rota la imagen 90 grados a la derecha
(define rotate90 (lambda (imagen) (list (getancho imagen) (getlargo imagen)
                                        (map (lambda (pixel)
                                        (cond [(> (length pixel) 5) (list (+ (- (car pixel) (car pixel)) (getlargo pixel)) (cadr pixel) (caddr pixel) (cadddr pixel) (cadr (cdddr pixel)) (caddr (cdddr pixel)))]
                                        [(< (length pixel) 5) (list (+ (- (car pixel) (car pixel)) (getlargo pixel)) (cadr pixel) (caddr pixel) (cadddr pixel))]))
                                        (getpixeles imagen)))))

;Dominio: image
;Recorrido: image
;Descripción: función que comprime una imagen eliminando aquellos pixeles con el color
;más frecuente
(define compress (lambda (imagen) (list (getancho imagen) (getlargo imagen) (map (lambda (pixel)
                                                               (cond [(> (length pixel) 5) (list (+ (- (car pixel) (car pixel)) (getlargo pixel)) (cadr pixel) (caddr pixel) (cadddr pixel) (cadr (cdddr pixel)) (caddr (cdddr pixel)))]
                                                                     [(< (length pixel) 5) (list (+ (- (car pixel) (car pixel)) (getlargo pixel)) (cadr pixel) (caddr pixel) (cadddr pixel))]))
                                                             (getpixeles imagen)))))

;Dominio: f x image
;Recorrido: image
;Descripción:función que permite aplicar funciones especiales a las imagenes.
(define edit (lambda (funcion imagen)(imagen (getlargo imagen)(getancho imagen)(map funcion (getpixeles imagen)))))
;Otras Funciones--------------------------------------------
;Dominio:
;Recorrido
;Descripción: función que permite transformar un entero a string hexadecimal
(define hexa (lambda(entero)
              (string-append (cond [(< (truncate(/ entero 16)) 10) (number->string (truncate(/ entero 16)))]
                                   [(= (truncate(/ entero 16)) 10) "A"]
                                   [(= (truncate(/ entero 16)) 11) "B"]
                                   [(= (truncate(/ entero 16)) 12) "C"]
                                   [(= (truncate(/ entero 16)) 13) "D"]
                                   [(= (truncate(/ entero 16)) 14) "E"]
                                   [(= (truncate(/ entero 16)) 15) "F"])                                                 
                             (cond [(< (remainder entero 16) 10) (number->string (remainder entero 16))]
                                   [(= (remainder entero 16) 10) "A"]
                                   [(= (remainder entero 16) 11) "B"]
                                   [(= (remainder entero 16) 12) "C"]
                                   [(= (remainder entero 16) 13) "D"]
                                   [(= (remainder entero 16) 14) "E"]
                                   [(= (remainder entero 16) 15) "F"]))))

;Dominio: pixbit-d
;Recorrido: pixbit-d
;Descripción: función que permite obtener el valor del bit opuesto

;Dominio: pixrgb-d
;Recorrido:pixrgb-d
;Descripción: función que permite obtener el color simetricamente opuesto en cada
;canal dentro de un pixel

;Dominio: f1 X F2 x F3 x pixrgb-d
;Recorrido: pixrgb-d
;Descripción: función que permite ajustar cualquier canal de una imagen con pixeles
;pixrgb-d, incluido el canal de profundidad d.

;Dominio:image X f
;Recorrido: string
;Descripción: función que transforma una imagen a una representación string.

;Dominio: image
;Recorrido: image list
;Descripción: función que permite separar una imagen en capas en base a la profundidad
;que se situan los pixeles

;Dominio: image
;Recorrido: image
;Descripción: función que permite descomprimir una imagen comprimida.

;Dominio:image
;Recorrido: histogram
;Descripción: función que retorna un histograma a partir de los colores en cada una
; de las imagenes.
(define histogram (lambda (imagen) (imagen (cond
                                      [(pixmap? imagen) (map (lambda (pixel) (list pixel)) ((getpixeles imagen)))]
                                      [(bitmap? imagen) (map (lambda (pixel) (list (caddr pixel))) ((getpixeles imagen)))]
                                      [(hexmap? imagen) (map (lambda (pixel) (list pixel)) ((getpixeles imagen)))]))))
