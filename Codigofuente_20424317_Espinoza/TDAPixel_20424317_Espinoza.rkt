#lang racket
(provide (all-defined-out))
;TDA PIXEL

;Representación---------------------------------
;Este TDA corresponde a los pixeles, donde cada pixel tendrá información adicional para
;ser utilizado en la creación de imagenes.



;Contructores

;Dominio: pixel

;Recorrido: pixel

;Descripción: función constructora de pixeles.

;Pixbit
(define(pixbit . bit)bit)

;Pixrgb
(define(pixrgb . rgb)rgb)

;Pixhex
(define(pixhex . hex)hex)

;Funciones de pertenencia
;Selectores
;Modificadores
;Otras Funciones