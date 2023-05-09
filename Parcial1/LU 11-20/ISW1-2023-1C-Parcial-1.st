!classDefinition: #TestDePerforación category: 'ISW1-2023-1C-Parcial-1'!
TestCase subclass: #TestDePerforación
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!TestDePerforación methodsFor: 'test' stamp: 'JFOE 5/8/2023 19:25:10'!
assertCantidadDeCapasEn: unSuelo Hasta: unaCapa es: unaCantidad

	| excavadora |

	excavadora := Perforadora sobreSuelo: unSuelo.
	
	self assert: unaCantidad equals: (excavadora contarCapas: unaCapa).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'JFOE 5/8/2023 19:48:25'!
assertLaCapaDeSueloInmediataDespuesDeGolpearConMechaWidia: unaCantidadDeGolpes ElSuelo: sueloAExcavar Es: unaCapa

	| excavadora |
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: unaCapa equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'JFOE 5/8/2023 19:30:40'!
assertProfundidadDelSuelo: unSuelo Hasta: unaCapa Es: unaAltura

	| excavadora |
	
	excavadora := Perforadora sobreSuelo: unSuelo.
	
	self assert: unaAltura equals: (excavadora calcularProfundidadDelSueloHasta: unaCapa).
	


	! !

!TestDePerforación methodsFor: 'test' stamp: 'JFOE 5/8/2023 19:38:22'!
darGolpeConMechaSoftEn: sueloAExcavar

	| excavadora |
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	^excavadora darGolpeDeTaladro.
	
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'JFOE 5/8/2023 19:18:01'!
generarSueloDeArenosoConAltura2TierraConAltura40ArenosoYConcretoConResistencia10

	^{ CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }	! !

!TestDePerforación methodsFor: 'test' stamp: 'JFOE 5/8/2023 19:38:50'!
test01CuandoExcavaSueloArenosoConMechaSoftRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := self darGolpeConMechaSoftEn: sueloAExcavar.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'JFOE 5/8/2023 19:42:20'!
test02CuandoExcavaSueloTierraConMechaSoftNoModificaElSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := self darGolpeConMechaSoftEn: sueloAExcavar.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:02:52'!
test03CuandoExcavaConcretoConMechaSoftSeRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierra.} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.].
	! !

!TestDePerforación methodsFor: 'test' stamp: 'JFOE 5/8/2023 19:49:46'!
test04CuandoExcavaSueloArenosoConMechaWidiaRemueveCapaArenosa

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	self assertLaCapaDeSueloInmediataDespuesDeGolpearConMechaWidia: 1 ElSuelo: sueloAExcavar Es: CapaDeSuelo tierra

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'JFOE 5/8/2023 19:49:14'!
test05CuandoExcavaSueloTierraConMechaWidiaEnDosImpactosTransformaLaCapaEnArenoso

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	self assertLaCapaDeSueloInmediataDespuesDeGolpearConMechaWidia: 2 ElSuelo: sueloAExcavar Es: CapaDeSuelo arenoso

	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:02:45'!
test06CuandoExcavaSueloConcretoConMechaWidiaEnTresImpactosRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.	
			CapaDeSuelo tierra.
} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:03:00'!
test07CuandoExcavaSueloArenosoConMechaDiamanteRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota ].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/8/2023 13:10:43'!
test08CuandoExcavaSueloTierraConMechaDiamanteRemueveCapa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	excavadora darGolpeDeTaladro.
	
	self assert: (CapaDeSuelo concretoConResistencia: 5) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/8/2023 13:10:48'!
test09CuandoExcavaSueloConcretoConMechaDiamanteBajaUnDecimoDeResistencia

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierra.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: (CapaDeSuelo concretoConResistencia: 4) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 4/27/2023 21:54:59'!
test10CuandoRemueveLaCapaYHayPiedrasLasRecolectaEnSuContainer

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			'Mica'.
			'Marmol'
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: {	'Mica'. 'Marmol'} equals: excavadora elementsInContainer
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/3/2023 22:34:18'!
test11CuandoRemueveLaCapaYNoHayNadaNoRecogeNada

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: excavadora elementsInContainer isEmpty
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:03:09'!
test12NoPuedePerforarSinMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
		
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'No puede perforar' equals: unError messageText.
			self assert: (CapaDeSuelo arenoso) equals: excavadora capaDeSueloInmediata ].	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'JFOE 5/8/2023 19:20:53'!
test13PuedeCalcularProfundidadDelSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 42 equals: excavadora calcularProfundidadDelSuelo.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'JFOE 5/8/2023 19:51:11'!
test14PuedeContarLasCapasDeTipoArenoso

	| sueloAExcavar |
	
	sueloAExcavar := self generarSueloDeArenosoConAltura2TierraConAltura40ArenosoYConcretoConResistencia10.
	
	self assertCantidadDeCapasEn: sueloAExcavar Hasta: #Arenoso es: 2

	! !

!TestDePerforación methodsFor: 'test' stamp: 'JFOE 5/8/2023 19:28:05'!
test15PuedeContarLasCapasDeTipoTierra

	| sueloAExcavar |
	
	sueloAExcavar := self generarSueloDeArenosoConAltura2TierraConAltura40ArenosoYConcretoConResistencia10.
	
	self assertCantidadDeCapasEn: sueloAExcavar Hasta: #Tierra es: 1


	! !

!TestDePerforación methodsFor: 'test' stamp: 'JFOE 5/8/2023 19:28:29'!
test16PuedeContarLasCapasDeTipoConcreto

	| sueloAExcavar |
	
	sueloAExcavar := self generarSueloDeArenosoConAltura2TierraConAltura40ArenosoYConcretoConResistencia10 .
	
	self assertCantidadDeCapasEn: sueloAExcavar Hasta: #Concreto es: 1
! !

!TestDePerforación methodsFor: 'test' stamp: 'JFOE 5/8/2023 19:51:11'!
test17PuedeCalcularProfundidadHastaPrimerCapaDeTipoArenoso

	| sueloAExcavar |
	
	sueloAExcavar := self generarSueloDeArenosoConAltura2TierraConAltura40ArenosoYConcretoConResistencia10.
	
	self assertProfundidadDelSuelo: sueloAExcavar Hasta: #Arenoso Es: 0.
	


	! !

!TestDePerforación methodsFor: 'test' stamp: 'JFOE 5/8/2023 19:31:50'!
test18PuedeCalcularProfundidadHastaPrimerCapaDeTipoTierra

	| sueloAExcavar |
	
	sueloAExcavar := self generarSueloDeArenosoConAltura2TierraConAltura40ArenosoYConcretoConResistencia10.
	
	self assertProfundidadDelSuelo: sueloAExcavar Hasta: #Tierra Es: 2.
	

	! !

!TestDePerforación methodsFor: 'test' stamp: 'JFOE 5/8/2023 19:32:10'!
test19PuedeCalcularProfundidadHastaPrimerCapaDeTipoConcreto

	| sueloAExcavar |
	
	sueloAExcavar := self generarSueloDeArenosoConAltura2TierraConAltura40ArenosoYConcretoConResistencia10.
	
	self assertProfundidadDelSuelo: sueloAExcavar Hasta: #Concreto Es: 42.
	

	! !


!classDefinition: #CapaDeSuelo category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #CapaDeSuelo
	instanceVariableNames: 'tipo resistencia altura'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaDeSuelo methodsFor: 'initialization' stamp: 'JFOE 5/8/2023 19:51:11'!
initializeArenoso
	
	tipo := #Arenoso.
	altura := 0.! !

!CapaDeSuelo methodsFor: 'initialization' stamp: 'JFOE 5/8/2023 18:44:51'!
initializeConcretoConResistencia: resistenciaInicial 

	resistencia := resistenciaInicial.
	tipo := #Concreto.
	altura := 0.! !

!CapaDeSuelo methodsFor: 'initialization' stamp: 'JFOE 5/8/2023 18:44:47'!
initializeTierra
	
	tipo := #Tierra.
	altura := 0.! !


!CapaDeSuelo methodsFor: 'tipo' stamp: 'JFOE 5/8/2023 18:37:06'!
esArenoso
	^self subclassResponsibility! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'JFOE 5/8/2023 18:36:57'!
esConcreto
	^self subclassResponsibility! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'JFOE 5/8/2023 18:36:47'!
esTierra
	^self subclassResponsibility! !


!CapaDeSuelo methodsFor: 'comparing' stamp: 'ARM 5/8/2023 13:10:22'!
= unaCapaDeSuelo

	^(unaCapaDeSuelo isKindOf: self class) and: [ tipo = unaCapaDeSuelo tipo and: [resistencia = unaCapaDeSuelo resistencia]]! !

!CapaDeSuelo methodsFor: 'comparing' stamp: 'JFOE 5/8/2023 21:10:29'!
esDeTipo: unTipoDeCapa

	^self tipo = unTipoDeCapa! !

!CapaDeSuelo methodsFor: 'comparing' stamp: 'ARM 5/8/2023 13:10:22'!
hash

	^tipo hash + resistencia hash! !


!CapaDeSuelo methodsFor: 'bajar resistencia' stamp: 'ARM 5/8/2023 13:10:22'!
bajaUnDecimoDeResistencia
	resistencia := resistencia - 1! !

!CapaDeSuelo methodsFor: 'bajar resistencia' stamp: 'ARM 5/8/2023 13:10:22'!
sinResistencia
	^resistencia = 0! !


!CapaDeSuelo methodsFor: 'accessing' stamp: 'FRT 5/5/2023 16:48:52'!
altura

	^ altura.! !

!CapaDeSuelo methodsFor: 'accessing' stamp: 'JFOE 5/8/2023 17:50:21'!
recibirGolpeDeTaladro: unTaladro conMecha: unaMecha

	^self subclassResponsibility ! !

!CapaDeSuelo methodsFor: 'accessing' stamp: 'ARM 5/8/2023 13:10:35'!
resistencia

	^ resistencia.! !

!CapaDeSuelo methodsFor: 'accessing' stamp: 'JFOE 5/8/2023 20:34:22'!
tipo

	^self subclassResponsibility ! !


!CapaDeSuelo methodsFor: 'scan' stamp: 'JFOE 5/8/2023 18:39:50'!
scan

	self subclassResponsibility ! !


!CapaDeSuelo methodsFor: 'setters' stamp: 'FRT 5/5/2023 16:07:55'!
setAltura: unaAltura

	altura := unaAltura! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeSuelo class' category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo class
	instanceVariableNames: ''!

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'JFOE 5/8/2023 19:51:11'!
arenoso

	^Arenoso new initializeArenoso! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'JFOE 5/8/2023 18:00:54'!
concretoConResistencia: resistencia 

	^Concreto new initializeConcretoConResistencia: resistencia ! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'JFOE 5/8/2023 18:17:49'!
tierra

	^Tierra new initializeTierra! !


!classDefinition: #Arenoso category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #Arenoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Arenoso methodsFor: 'as yet unclassified' stamp: 'JFOE 5/8/2023 18:37:25'!
esArenoso

	^true! !

!Arenoso methodsFor: 'as yet unclassified' stamp: 'JFOE 5/8/2023 18:37:35'!
esConcreto

	^false! !

!Arenoso methodsFor: 'as yet unclassified' stamp: 'JFOE 5/8/2023 18:37:44'!
esTierra

	^false! !

!Arenoso methodsFor: 'as yet unclassified' stamp: 'JFOE 5/8/2023 18:28:39'!
recibirGolpeDeTaladro: unTaladro conMecha: unaMecha

	unaMecha golpearSueloArenosoCon: unTaladro.
	^unTaladro! !

!Arenoso methodsFor: 'as yet unclassified' stamp: 'JFOE 5/8/2023 18:40:10'!
scan

	^ 7! !

!Arenoso methodsFor: 'as yet unclassified' stamp: 'JFOE 5/8/2023 20:34:36'!
tipo

	^#Arenoso! !


!classDefinition: #Concreto category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #Concreto
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Concreto methodsFor: 'as yet unclassified' stamp: 'JFOE 5/8/2023 18:37:58'!
esArenoso

	^false! !

!Concreto methodsFor: 'as yet unclassified' stamp: 'JFOE 5/8/2023 18:38:08'!
esConcreto

	^true! !

!Concreto methodsFor: 'as yet unclassified' stamp: 'JFOE 5/8/2023 18:37:53'!
esTierra

	^false! !

!Concreto methodsFor: 'as yet unclassified' stamp: 'JFOE 5/8/2023 18:34:15'!
recibirGolpeDeTaladro: unTaladro conMecha: unaMecha

	unaMecha golpearSueloDeConcretoCon: unTaladro.! !

!Concreto methodsFor: 'as yet unclassified' stamp: 'JFOE 5/8/2023 18:40:25'!
scan

	^ 50! !

!Concreto methodsFor: 'as yet unclassified' stamp: 'JFOE 5/8/2023 21:05:55'!
tipo

	^#Concreto! !


!classDefinition: #Tierra category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #Tierra
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Tierra methodsFor: 'as yet unclassified' stamp: 'JFOE 5/8/2023 18:38:29'!
esArenoso

	^false! !

!Tierra methodsFor: 'as yet unclassified' stamp: 'JFOE 5/8/2023 18:38:25'!
esConcreto

	^false! !

!Tierra methodsFor: 'as yet unclassified' stamp: 'JFOE 5/8/2023 18:38:19'!
esTierra

	^true! !

!Tierra methodsFor: 'as yet unclassified' stamp: 'JFOE 5/8/2023 19:42:07'!
recibirGolpeDeTaladro: unTaladro conMecha: unaMecha

	^unaMecha golpearSueloDeTierraCon: unTaladro.! !

!Tierra methodsFor: 'as yet unclassified' stamp: 'JFOE 5/8/2023 18:40:40'!
scan

	^ 10! !

!Tierra methodsFor: 'as yet unclassified' stamp: 'JFOE 5/8/2023 21:05:50'!
tipo

	^#Tierra! !


!classDefinition: #Mecha category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Mecha
	instanceVariableNames: 'tipo altura'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!


!classDefinition: #Diamante category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #Diamante
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Diamante methodsFor: 'accion' stamp: 'JFOE 5/8/2023 18:28:31'!
golpearSueloArenosoCon: unTaladro

	unTaladro romperMecha! !

!Diamante methodsFor: 'accion' stamp: 'JFOE 5/8/2023 21:09:20'!
golpearSueloDeConcretoCon: unTaladro

	unTaladro vecesQueGolpeoCapaActual even ifTrue: [ unTaladro capaDeSueloInmediata bajaUnDecimoDeResistencia].
	unTaladro capaDeSueloInmediata sinResistencia ifTrue: [ ^unTaladro transformarCapaEnArenoso].
	^unTaladro vecesQueGolpeoCapaActual! !

!Diamante methodsFor: 'accion' stamp: 'JFOE 5/8/2023 18:35:27'!
golpearSueloDeTierraCon: unTaladro

	^unTaladro pasarAProximaCapa! !


!classDefinition: #Soft category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #Soft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Soft methodsFor: 'accion' stamp: 'JFOE 5/8/2023 18:27:59'!
golpearSueloArenosoCon: unTaladro

	^unTaladro pasarAProximaCapa! !

!Soft methodsFor: 'accion' stamp: 'JFOE 5/8/2023 18:33:00'!
golpearSueloDeConcretoCon: unTaladro

	unTaladro romperMecha! !

!Soft methodsFor: 'accion' stamp: 'JFOE 5/8/2023 18:34:55'!
golpearSueloDeTierraCon: unTaladro

	^unTaladro! !


!classDefinition: #Widia category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #Widia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Widia methodsFor: 'accion' stamp: 'JFOE 5/8/2023 18:28:14'!
golpearSueloArenosoCon: unTaladro

	^unTaladro pasarAProximaCapa! !

!Widia methodsFor: 'accion' stamp: 'JFOE 5/8/2023 18:33:32'!
golpearSueloDeConcretoCon: unTaladro

	unTaladro  vecesQueGolpeoCapaActual = 3 ifTrue: [ unTaladro romperMecha].
	^unTaladro! !

!Widia methodsFor: 'accion' stamp: 'JFOE 5/8/2023 18:35:13'!
golpearSueloDeTierraCon: unTaladro

	
	unTaladro vecesQueGolpeoCapaActual = 2 ifTrue: [ ^unTaladro transformarCapaEnArenoso ].
	^unTaladro! !


!classDefinition: #Perforadora category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Perforadora
	instanceVariableNames: 'mechaPuesta container vecesQueGolpeoCapaActual suelo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Perforadora methodsFor: 'cambiar capa' stamp: 'JFOE 5/8/2023 21:31:59'!
pasarAProximaCapa
	
	suelo pasarAProximaCapa.
	suelo obtenerCapas ifEmpty: [^self].
	(suelo capaDeSueloInmediata isKindOf: CapaDeSuelo) ifFalse:[
			container addAll: suelo obtenerCapas.]! !

!Perforadora methodsFor: 'cambiar capa' stamp: 'JFOE 5/8/2023 20:49:41'!
transformarCapaEnArenoso
	
	suelo transformarCapaEnArenoso.! !


!Perforadora methodsFor: 'excavation' stamp: 'JFOE 5/8/2023 20:43:06'!
darGolpeDeTaladro
		
	self sinMecha ifTrue: [self error: 'No puede perforar'].

	suelo darGolpeALaCapaSuperior.

	^((suelo capaDeSueloInmediata) recibirGolpeDeTaladro: self conMecha: mechaPuesta).
! !


!Perforadora methodsFor: 'initialization' stamp: 'JFOE 5/8/2023 20:40:27'!
initializeSobreSuelo: capasDeSueloAExcavarInicialmente

	suelo := Suelo new initialize: capasDeSueloAExcavarInicialmente asOrderedCollection.
	vecesQueGolpeoCapaActual := 0.
	container := OrderedCollection new.
	mechaPuesta := #SinMecha! !


!Perforadora methodsFor: 'accessing' stamp: 'JFOE 5/8/2023 20:51:40'!
capaDeSueloInmediata

	^suelo capaDeSueloInmediata! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 21:20:54'!
conMechaRota

	^mechaPuesta = #Rota! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 21:12:20'!
elementsInContainer
	^container asArray! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 21:54:43'!
sinMecha

	^mechaPuesta = #SinMecha! !

!Perforadora methodsFor: 'accessing' stamp: 'JFOE 5/8/2023 20:43:55'!
vecesQueGolpeoCapaActual

	^ suelo cantidadDeGolpesALaCapaSuperior! !


!Perforadora methodsFor: 'sobre qué suelo' stamp: 'JFOE 5/8/2023 20:48:38'!
sobreSueloArenoso
	^suelo capaDeSueloInmediata esArenoso! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'JFOE 5/8/2023 20:48:49'!
sobreSueloConcreto
	^suelo capaDeSueloInmediata esConcreto! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'JFOE 5/8/2023 20:48:58'!
sobreSueloTierra
	^suelo capaDeSueloInmediata esTierra! !


!Perforadora methodsFor: 'cambiar mecha' stamp: 'JFOE 5/8/2023 18:29:20'!
ponerMechaDiamante
	mechaPuesta := Diamante new! !

!Perforadora methodsFor: 'cambiar mecha' stamp: 'JFOE 5/8/2023 18:29:25'!
ponerMechaSoft
	mechaPuesta := Soft new! !

!Perforadora methodsFor: 'cambiar mecha' stamp: 'JFOE 5/8/2023 18:29:31'!
ponerMechaWidia
	mechaPuesta := Widia new! !

!Perforadora methodsFor: 'cambiar mecha' stamp: 'JFOE 5/8/2023 18:24:06'!
romperMecha

	mechaPuesta := #Rota.
	self error: 'Se rompió' ! !


!Perforadora methodsFor: 'scan' stamp: 'JFOE 5/8/2023 20:37:33'!
calcularProfundidadDelSuelo
	
	|alturaTotal|
	
	alturaTotal := 0.
	suelo obtenerCapas do: [ :capa| alturaTotal := alturaTotal + capa altura ].

	^alturaTotal.
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'JFOE 5/8/2023 20:37:43'!
calcularProfundidadDelSueloHasta: tipoDeCapa
	
	| numeroDeCapa alturaTotal |
	
	numeroDeCapa := self obtenerNumeroDeCapa: tipoDeCapa.
	
	alturaTotal := 0.

	suelo obtenerCapas do: [:capa| 
		numeroDeCapa = capa scan ifTrue: [^ alturaTotal].
		alturaTotal := alturaTotal + capa altura.
		].
		
	^ alturaTotal.
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'JFOE 5/8/2023 20:37:57'!
contarCapas: tipoDeCapa
	
	"Cuenta las capas de tipo tipoDeCapa. Recordar que para identificar cada capa se utiliza el valor de scan que retorna. Por ej. un capa tipo Arenoso retorna 7 al scan"
	
	| numeroDeCapa |
	
	numeroDeCapa := self obtenerNumeroDeCapa: tipoDeCapa.
	
	^ (suelo obtenerCapas select: [:capa|numeroDeCapa = capa scan]) size.! !

!Perforadora methodsFor: 'scan' stamp: 'JFOE 5/8/2023 19:51:11'!
obtenerNumeroDeCapa: tipoDeCapa
	
	tipoDeCapa = #Arenoso ifTrue: [ ^ 7 ].
	tipoDeCapa = #Tierra ifTrue: [ ^ 10 ].
	tipoDeCapa = #Concreto ifTrue: [ ^ 50].	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Perforadora class' category: 'ISW1-2023-1C-Parcial-1'!
Perforadora class
	instanceVariableNames: ''!

!Perforadora class methodsFor: 'instance creation' stamp: 'ARM 4/27/2023 20:07:05'!
sobreSuelo: capasDeSueloAExcavar 

	^self new initializeSobreSuelo: capasDeSueloAExcavar ! !


!classDefinition: #Suelo category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Suelo
	instanceVariableNames: 'capas numeroDeGolpesALaCapaSuperior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Suelo methodsFor: 'initialize' stamp: 'JFOE 5/8/2023 20:41:57'!
initialize: capasDelSuelo

	self validateCapas: capasDelSuelo.
	capas := capasDelSuelo.
	numeroDeGolpesALaCapaSuperior := 0! !

!Suelo methodsFor: 'initialize' stamp: 'JFOE 5/8/2023 21:34:41'!
validateCapas: capasDelSuelo

	|index tamanio soloCapasDelSuelo|
	
	soloCapasDelSuelo := capasDelSuelo select: [:capa| capa className ~= 'String'].
	
	index := 1.
	tamanio := (soloCapasDelSuelo size).
	
	index to: (tamanio - 1) do: [:indice|
		((soloCapasDelSuelo at: indice) esDeTipo: (soloCapasDelSuelo at: indice + 1) tipo) ifTrue: [self error: 'todomal' .].].
	
	^capasDelSuelo.
! !


!Suelo methodsFor: 'accessing' stamp: 'JFOE 5/8/2023 20:44:09'!
cantidadDeGolpesALaCapaSuperior

	^numeroDeGolpesALaCapaSuperior ! !

!Suelo methodsFor: 'accessing' stamp: 'JFOE 5/8/2023 20:56:45'!
capaDeSueloInmediata

	^capas first! !

!Suelo methodsFor: 'accessing' stamp: 'JFOE 5/8/2023 20:36:57'!
obtenerCapas

	^capas! !


!Suelo methodsFor: 'actions' stamp: 'JFOE 5/8/2023 20:42:50'!
darGolpeALaCapaSuperior

	numeroDeGolpesALaCapaSuperior := numeroDeGolpesALaCapaSuperior + 1! !

!Suelo methodsFor: 'actions' stamp: 'JFOE 5/8/2023 20:46:18'!
pasarAProximaCapa
	numeroDeGolpesALaCapaSuperior := 0.
	capas := capas allButFirst.
	capas ifEmpty: [^self].! !

!Suelo methodsFor: 'actions' stamp: 'JFOE 5/8/2023 21:06:24'!
transformarCapaEnArenoso

	capas :=
		capas allButFirst asOrderedCollection
		addFirst: CapaDeSuelo arenoso;
		yourself! !
