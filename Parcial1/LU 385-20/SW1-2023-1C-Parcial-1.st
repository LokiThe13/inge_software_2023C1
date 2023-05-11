!classDefinition: #TestDePerforación category: 'ISW1-2023-1C-Parcial-1'!
TestCase subclass: #TestDePerforación
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 20:22:30'!
test01CuandoExcavaSueloArenosoConMechaSoftRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaArena new.
			CapaTierra new.
			CapaConcreto conResistencia: 5. } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMecha: MechaSoft new.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaTierra new equals: (excavadora capaDeSueloSuperior).
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 19:45:29'!
test02CuandoExcavaSueloTierraConMechaSoftNoModificaElSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaTierra new.
			CapaConcreto conResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMecha: MechaSoft new.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaTierra new equals: excavadora capaDeSueloSuperior
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 20:55:56'!
test03CuandoExcavaConcretoConMechaSoftSeRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaConcreto conResistencia: 5.
			CapaTierra new.} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMecha: MechaSoft new.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: Perforadora errorMechaRota equals: unError messageText.
			self assert: excavadora conMechaRota.].
	! !

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 20:22:20'!
test04CuandoExcavaSueloArenosoConMechaWidiaRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaArena new.
			CapaTierra new.
			CapaConcreto conResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMecha: MechaWidia new.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaTierra new equals: excavadora capaDeSueloSuperior
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 20:23:15'!
test05CuandoExcavaSueloTierraConMechaWidiaEnDosImpactosTransformaLaCapaEnArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaTierra new.
			CapaConcreto conResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMecha: MechaWidia new.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: CapaArena new equals: excavadora capaDeSueloSuperior.
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 20:40:59'!
test06CuandoExcavaSueloConcretoConMechaWidiaEnTresImpactosRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaConcreto conResistencia: 5.	
			CapaTierra new.
		} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMecha: MechaWidia new.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: Perforadora errorMechaRota equals: unError messageText.
			self assert: excavadora conMechaRota.].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 20:57:49'!
test07CuandoExcavaSueloArenosoConMechaDiamanteRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaArena new.
			CapaTierra new.
			CapaConcreto conResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMecha: MechaDiamante new.

	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: Perforadora errorMechaRota equals: unError messageText.
			self assert: excavadora conMechaRota ].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 20:58:25'!
test08CuandoExcavaSueloTierraConMechaDiamanteRemueveCapa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaTierra new.
			CapaConcreto conResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMecha: MechaDiamante new.
	
	excavadora darGolpeDeTaladro.
	
	self assert: (CapaConcreto conResistencia: 5) equals: excavadora capaDeSueloSuperior

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 20:59:49'!
test09CuandoExcavaSueloConcretoConMechaDiamanteBajaUnDecimoDeResistencia

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaConcreto conResistencia: 5.
			CapaTierra new.
			}.
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMecha: MechaDiamante new.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: (CapaConcreto conResistencia: 4) equals: excavadora capaDeSueloSuperior

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 21:54:18'!
test10CuandoRemueveLaCapaYHayPiedrasLasRecolectaEnSuContainer

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaArena new.
			Gema llamada: 'Mica'.
			Gema llamada: 'Marmol'.
			}.
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMecha: MechaSoft new.
	
	excavadora darGolpeDeTaladro.
	
	self assert: {	Gema llamada: 'Mica'.			Gema llamada: 'Marmol'.			} equals: excavadora container.
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 21:11:24'!
test11CuandoRemueveLaCapaYNoHayNadaNoRecogeNada

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaArena new.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMecha: MechaSoft new.
	
	excavadora darGolpeDeTaladro.
	
	self assert: excavadora container isEmpty
	! !

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 21:04:16'!
test12NoPuedePerforarSinMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaArena new.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
		
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: Mecha errorMechaFaltante equals: unError messageText.
			self assert: (CapaArena new) equals: excavadora capaDeSueloSuperior ].	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 21:05:27'!
test13PuedeCalcularProfundidadDelSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaArena conAltura: 2. CapaTierra conAltura: 40. CapaArena new} .
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 42 equals: excavadora calcularProfundidadDelSuelo.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 21:31:28'!
test14PuedeContarLasCapasDeTipoArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaArena conAltura: 2. CapaTierra conAltura: 40. CapaArena new. CapaConcreto  conResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 2 equals: (excavadora contarCapasDeTipo: CapaArena).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 21:32:30'!
test15PuedeContarLasCapasDeTipoTierra

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaArena conAltura: 2. CapaTierra conAltura: 40. CapaArena new. CapaConcreto conResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 1 equals: (excavadora contarCapasDeTipo: CapaTierra).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 21:40:57'!
test16PuedeContarLasCapasDeTipoConcreto

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaArena conAltura: 2. CapaTierra conAltura: 40. CapaArena new. CapaConcreto conResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 1 equals: (excavadora contarCapasDeTipo: CapaConcreto).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 21:44:54'!
test17PuedeCalcularProfundidadHastaPrimerCapaDeTipoArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaArena conAltura: 2. CapaTierra conAltura: 40. CapaArena new. CapaConcreto conResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 0 equals: (excavadora calcularProfundidadDelSueloHasta: CapaArena).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 21:56:36'!
test18PuedeCalcularProfundidadHastaPrimerCapaDeTipoTierra

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaArena conAltura: 2. CapaTierra conAltura: 40. CapaArena new. CapaConcreto conResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 2 equals: (excavadora calcularProfundidadDelSueloHasta: CapaTierra).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'TK 5/8/2023 21:50:46'!
test19PuedeCalcularProfundidadHastaPrimerCapaDeTipoConcreto

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaArena conAltura: 2. CapaTierra conAltura: 40. CapaArena new. CapaConcreto conResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 42 equals: (excavadora calcularProfundidadDelSueloHasta: CapaConcreto).

	! !


!classDefinition: #ElementoSuelo category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #ElementoSuelo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!ElementoSuelo methodsFor: 'acceder' stamp: 'TK 5/8/2023 21:18:39'!
altura

	self subclassResponsibility.! !


!ElementoSuelo methodsFor: 'testeo' stamp: 'TK 5/8/2023 21:16:45'!
esGema

	^self subclassResponsibility.! !


!classDefinition: #CapaSuelo category: 'ISW1-2023-1C-Parcial-1'!
ElementoSuelo subclass: #CapaSuelo
	instanceVariableNames: 'altura'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaSuelo methodsFor: 'initialization' stamp: 'FRT 5/5/2023 16:08:54'!
initializeArenoso
	
	tipo := #Arenoso.
	altura := nil.! !

!CapaSuelo methodsFor: 'initialization' stamp: 'TK 5/8/2023 20:29:47'!
initializeConAltura: UnaAltura

	altura := UnaAltura.! !

!CapaSuelo methodsFor: 'initialization' stamp: 'ARM 5/8/2023 13:10:22'!
initializeConcretoConResistencia: resistenciaInicial 

	resistencia := resistenciaInicial.
	tipo := #Concreto.
	altura := nil.! !

!CapaSuelo methodsFor: 'initialization' stamp: 'FRT 5/5/2023 16:08:42'!
initializeTierra
	
	tipo := #Tierra.
	altura := nil.! !


!CapaSuelo methodsFor: 'testeo' stamp: 'TK 5/8/2023 18:28:40'!
esArenoso

	self subclassResponsibility.! !

!CapaSuelo methodsFor: 'testeo' stamp: 'TK 5/8/2023 18:28:46'!
esConcreto
	
	self subclassResponsibility.! !

!CapaSuelo methodsFor: 'testeo' stamp: 'TK 5/8/2023 21:17:01'!
esGema
	
	^false.! !

!CapaSuelo methodsFor: 'testeo' stamp: 'TK 5/8/2023 18:28:49'!
esTierra
	
	self subclassResponsibility.! !


!CapaSuelo methodsFor: 'comparación' stamp: 'TK 5/8/2023 19:24:14'!
= otraCapaDeSuelo

	self subclassResponsibility.! !

!CapaSuelo methodsFor: 'comparación' stamp: 'TK 5/8/2023 19:24:40'!
hash

	self subclassResponsibility.! !


!CapaSuelo methodsFor: 'bajar resistencia' stamp: 'TK 5/8/2023 20:46:58'!
arenifica

	self subclassResponsibility.! !

!CapaSuelo methodsFor: 'bajar resistencia' stamp: 'ARM 5/8/2023 13:10:22'!
bajaUnDecimoDeResistencia
	resistencia := resistencia - 1! !

!CapaSuelo methodsFor: 'bajar resistencia' stamp: 'TK 5/8/2023 19:11:45'!
colapsa

	self subclassResponsibility.! !

!CapaSuelo methodsFor: 'bajar resistencia' stamp: 'ARM 5/8/2023 13:10:22'!
sinResistencia
	^resistencia = 0! !


!CapaSuelo methodsFor: 'acceder' stamp: 'TK 5/8/2023 18:52:04'!
altura

	^altura.! !

!CapaSuelo methodsFor: 'acceder' stamp: 'TK 5/8/2023 18:52:13'!
debajo

	^debajo.! !

!CapaSuelo methodsFor: 'acceder' stamp: 'ARM 5/8/2023 13:10:35'!
resistencia

	^ resistencia.! !

!CapaSuelo methodsFor: 'acceder' stamp: 'ARM 4/27/2023 20:18:41'!
tipo

	^tipo! !


!CapaSuelo methodsFor: 'scan' stamp: 'TK 5/8/2023 18:56:24'!
scan

	self subclassResponsibility.! !


!CapaSuelo methodsFor: 'setters' stamp: 'TK 5/8/2023 18:57:21'!
asignarAltura: unaAltura

	altura := unaAltura! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaSuelo class' category: 'ISW1-2023-1C-Parcial-1'!
CapaSuelo class
	instanceVariableNames: ''!

!CapaSuelo class methodsFor: 'instance creation' stamp: 'ARM 4/27/2023 20:02:32'!
arenoso

	^self new initializeArenoso! !

!CapaSuelo class methodsFor: 'instance creation' stamp: 'TK 5/8/2023 20:29:23'!
conAltura: unaAltura 

	^self new initializeConAltura: unaAltura ! !

!CapaSuelo class methodsFor: 'instance creation' stamp: 'ARM 5/5/2023 18:01:35'!
concretoConResistencia: resistencia 

	^self new initializeConcretoConResistencia: resistencia ! !

!CapaSuelo class methodsFor: 'instance creation' stamp: 'ARM 4/27/2023 20:03:15'!
tierra

	^self new initializeTierra! !


!classDefinition: #CapaArena category: 'ISW1-2023-1C-Parcial-1'!
CapaSuelo subclass: #CapaArena
	instanceVariableNames: 'integridad'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaArena methodsFor: 'testeo' stamp: 'TK 5/8/2023 20:47:11'!
arenifica

	^false.! !

!CapaArena methodsFor: 'testeo' stamp: 'TK 5/8/2023 19:17:58'!
colapsa

	^integridad = 0.! !

!CapaArena methodsFor: 'testeo' stamp: 'TK 5/8/2023 19:54:41'!
esArena
	
	^true.! !

!CapaArena methodsFor: 'testeo' stamp: 'TK 5/8/2023 19:54:43'!
esConcreto
	
	^false.! !

!CapaArena methodsFor: 'testeo' stamp: 'TK 5/8/2023 19:54:47'!
esTierra
	
	^false.! !


!CapaArena methodsFor: 'accionar' stamp: 'TK 5/8/2023 20:42:31'!
taladrarConMechaDiamante: unaMechaDiamante

	unaMechaDiamante gastarMecha.! !

!CapaArena methodsFor: 'accionar' stamp: 'TK 5/8/2023 19:08:35'!
taladrarConMechaSoft: unaMechaSoft

	integridad := 0.! !

!CapaArena methodsFor: 'accionar' stamp: 'TK 5/8/2023 20:19:10'!
taladrarConMechaWidia: unaMechaWidia

	integridad := 0.! !


!CapaArena methodsFor: 'acceder' stamp: 'TK 5/8/2023 19:22:16'!
integridad

	^integridad.! !


!CapaArena methodsFor: 'comparación' stamp: 'TK 5/8/2023 19:52:00'!
= otraCapaSuelo

	^((otraCapaSuelo esArena) and: [otraCapaSuelo integridad = integridad]).! !

!CapaArena methodsFor: 'comparación' stamp: 'TK 5/8/2023 19:31:33'!
hash

	^integridad hash.! !


!CapaArena methodsFor: 'inicialización' stamp: 'TK 5/8/2023 21:09:43'!
initialize

	altura := 0.
	integridad := 1.! !


!classDefinition: #CapaConcreto category: 'ISW1-2023-1C-Parcial-1'!
CapaSuelo subclass: #CapaConcreto
	instanceVariableNames: 'resistencia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaConcreto methodsFor: 'inicialización' stamp: 'TK 5/8/2023 21:09:18'!
inicializarConResistencia: unaResistencia

	altura := 0.
	resistencia := unaResistencia.! !


!CapaConcreto methodsFor: 'testeo' stamp: 'TK 5/8/2023 20:55:42'!
arenifica

	^resistencia = 0.! !

!CapaConcreto methodsFor: 'testeo' stamp: 'TK 5/8/2023 20:44:54'!
colapsa

	^false.! !

!CapaConcreto methodsFor: 'testeo' stamp: 'TK 5/8/2023 19:54:37'!
esArena

	^false.! !

!CapaConcreto methodsFor: 'testeo' stamp: 'TK 5/8/2023 19:54:32'!
esConcreto

	^true.! !

!CapaConcreto methodsFor: 'testeo' stamp: 'TK 5/8/2023 19:54:34'!
esTierra

	^false.! !


!CapaConcreto methodsFor: 'comparación' stamp: 'TK 5/8/2023 19:29:21'!
= otraCapaSuelo

	^otraCapaSuelo esConcreto and: [otraCapaSuelo resistencia = resistencia].! !

!CapaConcreto methodsFor: 'comparación' stamp: 'TK 5/8/2023 19:31:43'!
hash

	^resistencia hash.! !


!CapaConcreto methodsFor: 'accionar' stamp: 'TK 5/8/2023 21:02:17'!
taladrarConMechaDiamante: unaMechaDiamante

	
	resistencia := resistencia - (1/2).! !

!CapaConcreto methodsFor: 'accionar' stamp: 'TK 5/8/2023 20:03:47'!
taladrarConMechaSoft: unaMechaSoft

	unaMechaSoft gastarMecha.! !

!CapaConcreto methodsFor: 'accionar' stamp: 'TK 5/8/2023 20:20:11'!
taladrarConMechaWidia: unaMechaWidia

	unaMechaWidia gastarMecha.! !


!CapaConcreto methodsFor: 'acceder' stamp: 'TK 5/8/2023 19:23:35'!
resistencia

	^resistencia.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaConcreto class' category: 'ISW1-2023-1C-Parcial-1'!
CapaConcreto class
	instanceVariableNames: ''!

!CapaConcreto class methodsFor: 'creación' stamp: 'TK 5/8/2023 20:16:42'!
conResistencia: unaResistencia

	^self new inicializarConResistencia: unaResistencia.! !


!classDefinition: #CapaTierra category: 'ISW1-2023-1C-Parcial-1'!
CapaSuelo subclass: #CapaTierra
	instanceVariableNames: 'integridad resistencia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaTierra methodsFor: 'acceso' stamp: 'TK 5/8/2023 18:26:49'!
scan

	^10 * second.! !


!CapaTierra methodsFor: 'testeo' stamp: 'TK 5/8/2023 20:45:41'!
arenifica

	^resistencia = 0.! !

!CapaTierra methodsFor: 'testeo' stamp: 'TK 5/8/2023 19:45:02'!
colapsa

	^integridad = 0.! !

!CapaTierra methodsFor: 'testeo' stamp: 'TK 5/8/2023 19:54:28'!
esArena

	^false.! !

!CapaTierra methodsFor: 'testeo' stamp: 'TK 5/8/2023 19:54:25'!
esConcreto

	^false.! !

!CapaTierra methodsFor: 'testeo' stamp: 'TK 5/8/2023 19:54:20'!
esTierra

	^true.! !


!CapaTierra methodsFor: 'acceder' stamp: 'TK 5/8/2023 19:27:25'!
integridad

	^integridad.! !


!CapaTierra methodsFor: 'comparación' stamp: 'TK 5/8/2023 19:53:47'!
= otraCapaSuelo
	^true.
	"^((otraCapaSuelo esTierra) and: [integridad = otraCapaSuelo integridad])."! !

!CapaTierra methodsFor: 'comparación' stamp: 'TK 5/8/2023 19:31:55'!
hash

	^integridad hash.! !


!CapaTierra methodsFor: 'accionar' stamp: 'TK 5/8/2023 20:46:13'!
taladrarConMechaDiamante: unaMechaDiamante

	integridad := 0.! !

!CapaTierra methodsFor: 'accionar' stamp: 'TK 5/8/2023 19:43:41'!
taladrarConMechaSoft: unaMechaSoft! !

!CapaTierra methodsFor: 'accionar' stamp: 'TK 5/8/2023 20:46:09'!
taladrarConMechaWidia: unaMechaWidia

	resistencia := resistencia - 1.! !


!CapaTierra methodsFor: 'inicialización' stamp: 'TK 5/8/2023 21:09:07'!
initialize
	
	altura := 0.
	integridad := 1.
	resistencia  := 2.! !


!classDefinition: #Gema category: 'ISW1-2023-1C-Parcial-1'!
ElementoSuelo subclass: #Gema
	instanceVariableNames: 'nombre'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Gema methodsFor: 'acceder' stamp: 'TK 5/8/2023 21:18:54'!
altura

	^0.! !

!Gema methodsFor: 'acceder' stamp: 'TK 5/8/2023 21:24:37'!
nombre

	^nombre.! !


!Gema methodsFor: 'testeo' stamp: 'TK 5/8/2023 21:17:11'!
esGema

	^true.! !


!Gema methodsFor: 'inicialización' stamp: 'TK 5/8/2023 21:22:16'!
initializeLLamada: unNombre

	nombre := unNombre.! !


!Gema methodsFor: 'comparación' stamp: 'TK 5/8/2023 21:54:25'!
= otraGema

	^nombre = otraGema nombre.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Gema class' category: 'ISW1-2023-1C-Parcial-1'!
Gema class
	instanceVariableNames: ''!

!Gema class methodsFor: 'creación' stamp: 'TK 5/8/2023 21:21:53'!
llamada: unNombre

	^self new initializeLLamada: unNombre.! !


!classDefinition: #Mecha category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Mecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Mecha methodsFor: 'testeo' stamp: 'TK 5/8/2023 20:09:31'!
rota

	self subclassResponsibility.! !


!Mecha methodsFor: 'accionar' stamp: 'TK 5/8/2023 18:12:06'!
taladrar: unSuelo

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Mecha class' category: 'ISW1-2023-1C-Parcial-1'!
Mecha class
	instanceVariableNames: ''!

!Mecha class methodsFor: 'errores' stamp: 'TK 5/8/2023 18:16:33'!
errorMechaFaltante

	^'No hay mecha.'! !

!Mecha class methodsFor: 'errores' stamp: 'TK 5/8/2023 18:13:25'!
errorMechaRota

	^'La mecha se rompió.'! !


!classDefinition: #MechaFaltante category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #MechaFaltante
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!MechaFaltante methodsFor: 'accionar' stamp: 'TK 5/8/2023 18:14:52'!
taladrar: unSuelo

	self error: Mecha errorMechaFaltante.! !


!MechaFaltante methodsFor: 'testeo' stamp: 'TK 5/8/2023 20:10:01'!
rota

	self error: Mecha errorMechaFaltante.! !


!classDefinition: #MechaFuncional category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #MechaFuncional
	instanceVariableNames: 'durabilidad'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!MechaFuncional methodsFor: 'accionar' stamp: 'TK 5/8/2023 20:01:10'!
gastarMecha

	durabilidad := durabilidad - 1.! !

!MechaFuncional methodsFor: 'accionar' stamp: 'TK 5/8/2023 20:00:22'!
taladrar: unSuelo

	self subclassResponsibility.! !


!MechaFuncional methodsFor: 'testeo' stamp: 'TK 5/8/2023 20:11:51'!
rota

	^durabilidad = 0.! !


!classDefinition: #MechaDiamante category: 'ISW1-2023-1C-Parcial-1'!
MechaFuncional subclass: #MechaDiamante
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!MechaDiamante methodsFor: 'accionar' stamp: 'TK 5/8/2023 20:57:38'!
taladrar: unSuelo

	unSuelo taladrarConMechaDiamante: self.! !


!MechaDiamante methodsFor: 'inicialización' stamp: 'TK 5/8/2023 20:01:59'!
initialize

	durabilidad := 1.! !


!classDefinition: #MechaSoft category: 'ISW1-2023-1C-Parcial-1'!
MechaFuncional subclass: #MechaSoft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!MechaSoft methodsFor: 'inicialización' stamp: 'TK 5/8/2023 20:01:38'!
initialize

	durabilidad := 1.! !


!MechaSoft methodsFor: 'accionar' stamp: 'TK 5/8/2023 19:17:35'!
taladrar: unSuelo

	unSuelo taladrarConMechaSoft: self.! !


!classDefinition: #MechaWidia category: 'ISW1-2023-1C-Parcial-1'!
MechaFuncional subclass: #MechaWidia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!MechaWidia methodsFor: 'accionar' stamp: 'TK 5/8/2023 20:18:55'!
taladrar: unSuelo

	unSuelo taladrarConMechaWidia: self.! !


!MechaWidia methodsFor: 'inicialización' stamp: 'TK 5/8/2023 20:02:15'!
initialize

	durabilidad := 3.! !


!classDefinition: #MechaRota category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #MechaRota
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!MechaRota methodsFor: 'accionar' stamp: 'TK 5/8/2023 18:12:54'!
taladrar: unSuelo

	self error: Mecha class errorMechaRota.! !


!MechaRota methodsFor: 'testeo' stamp: 'TK 5/8/2023 20:11:07'!
rota

	^true.! !


!classDefinition: #Perforadora category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Perforadora
	instanceVariableNames: 'tipoDeSuelo mecha vecesQueGolpeoCapaActual capasDeSueloDebajo container suelo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Perforadora methodsFor: 'excavación' stamp: 'TK 5/8/2023 21:23:17'!
darGolpeDeTaladro

	mecha taladrar: suelo.
	mecha rota ifTrue: [self error: self class errorMechaRota. mecha := MechaRota new.].
	(suelo isEmpty not and: [suelo top esGema]) ifTrue: [container := suelo obtenerGemas]. ! !


!Perforadora methodsFor: 'inicialización' stamp: 'TK 5/8/2023 18:33:22'!
initializeSobreSuelo: sueloAExcavar

	suelo := Suelo conCapas: (sueloAExcavar asOrderedCollection).
	container := OrderedCollection new.
	mecha := MechaFaltante new.! !


!Perforadora methodsFor: 'acceder' stamp: 'TK 5/8/2023 18:36:33'!
capaDeSueloSuperior

	^suelo top.! !

!Perforadora methodsFor: 'acceder' stamp: 'TK 5/8/2023 21:06:03'!
conMechaRota

	^mecha rota.! !

!Perforadora methodsFor: 'acceder' stamp: 'TK 5/8/2023 21:03:01'!
container

	^container asArray.! !

!Perforadora methodsFor: 'acceder' stamp: 'TK 5/8/2023 21:06:14'!
sinMecha

	^mecha = MechaFaltante.! !


!Perforadora methodsFor: 'sobre qué suelo' stamp: 'TK 5/8/2023 21:06:50'!
sobreSueloArenoso

	^suelo top esArena.! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'TK 5/8/2023 21:07:01'!
sobreSueloConcreto
	
	^suelo top esConcreto.! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'TK 5/8/2023 21:07:08'!
sobreSueloTierra
	
	^suelo top esTierra.! !


!Perforadora methodsFor: 'modificar' stamp: 'TK 5/8/2023 18:22:28'!
ponerMecha: unaMechaAColocar

	mecha := unaMechaAColocar.! !


!Perforadora methodsFor: 'scan' stamp: 'TK 5/8/2023 21:08:18'!
calcularProfundidadDelSuelo
	
	^suelo altura.
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'TK 5/8/2023 21:53:13'!
calcularProfundidadDelSueloHasta: tipoDeCapa
	
	^suelo profundidadHastaCapaDeTipo: tipoDeCapa.! !

!Perforadora methodsFor: 'scan' stamp: 'TK 5/8/2023 21:29:08'!
contarCapasDeTipo: tipoDeCapa
	
	^suelo contarCapasDeTipo: tipoDeCapa.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Perforadora class' category: 'ISW1-2023-1C-Parcial-1'!
Perforadora class
	instanceVariableNames: ''!

!Perforadora class methodsFor: 'instance creation' stamp: 'TK 5/8/2023 18:20:16'!
sobreSuelo: sueloAExcavar 

	^self new initializeSobreSuelo: sueloAExcavar ! !


!Perforadora class methodsFor: 'errores' stamp: 'TK 5/8/2023 20:06:04'!
errorMechaRota

	^'La mecha se rompió.'! !


!classDefinition: #Suelo category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Suelo
	instanceVariableNames: 'capas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Suelo methodsFor: 'inicialización' stamp: 'TK 5/8/2023 21:55:56'!
inicializarConCapas: unaPilaDeCapas

	capas := unaPilaDeCapas.
	(self sueloVálido) ifFalse: [self error: 'Suelo no válido ya que tiene capas de tipos iguales consecutivas.'].
	

	! !


!Suelo methodsFor: 'accionar' stamp: 'TK 5/8/2023 21:13:06'!
asentarSuelo

	| top |
	
	top := self top.
	top colapsa ifTrue: [self pop.].
	top arenifica ifTrue: [self pop. capas addFirst: (CapaArena conAltura: top altura).].! !

!Suelo methodsFor: 'accionar' stamp: 'TK 5/8/2023 21:20:11'!
obtenerGemas

	| gemas |
	
	gemas := capas asArray.
	capas := OrderedCollection new.
	^gemas.! !

!Suelo methodsFor: 'accionar' stamp: 'TK 5/8/2023 19:20:03'!
pop

	| top |
	
	top := self top.
	capas := capas copyFrom: 2 to: capas size.
	^top. ! !

!Suelo methodsFor: 'accionar' stamp: 'TK 5/8/2023 20:31:16'!
taladrarConMechaDiamante: unaMechaDiamante

	self top taladrarConMechaDiamante: unaMechaDiamante.
	self asentarSuelo.! !

!Suelo methodsFor: 'accionar' stamp: 'TK 5/8/2023 20:31:06'!
taladrarConMechaSoft: unaMechaSoft

	self top taladrarConMechaSoft: unaMechaSoft.
	self asentarSuelo.! !

!Suelo methodsFor: 'accionar' stamp: 'TK 5/8/2023 20:31:11'!
taladrarConMechaWidia: unaMechaDiamante

	self top taladrarConMechaWidia: unaMechaDiamante.
	self asentarSuelo.! !


!Suelo methodsFor: 'inspección' stamp: 'TK 5/8/2023 21:10:20'!
altura
	
	| sueloSinCapaSuperior |
	
	(capas isEmpty) ifTrue: [^0].
	sueloSinCapaSuperior := self class conCapas: (capas copyFrom: 2 to: capas size).
	^(capas at: 1) altura + sueloSinCapaSuperior altura.! !

!Suelo methodsFor: 'inspección' stamp: 'TK 5/8/2023 21:31:45'!
contarCapasDeTipo: unTipoDeCapa

	| sueloSinCapaSuperior |

	(capas isEmpty) ifTrue: [^0].
	sueloSinCapaSuperior := self class conCapas: (capas copyFrom: 2 to: capas size).
	^(((capas at: 1) class = unTipoDeCapa) ifTrue: 1 ifFalse: 0) + (sueloSinCapaSuperior contarCapasDeTipo: unTipoDeCapa).! !

!Suelo methodsFor: 'inspección' stamp: 'TK 5/8/2023 21:14:15'!
isEmpty

	^capas isEmpty.! !

!Suelo methodsFor: 'inspección' stamp: 'TK 5/8/2023 21:53:00'!
profundidadHastaCapaDeTipo: unTipoDeCapa

	| sueloSinCapaSuperior |

	(capas isEmpty) ifTrue: [^0].
	sueloSinCapaSuperior := self class conCapas: (capas copyFrom: 2 to: capas size).
	((capas at: 1) class = unTipoDeCapa) ifTrue: [^0].
	^((capas at: 1) altura) + (sueloSinCapaSuperior profundidadHastaCapaDeTipo: unTipoDeCapa).! !

!Suelo methodsFor: 'inspección' stamp: 'TK 5/8/2023 21:55:34'!
sueloVálido

	| sueloSinCapaSuperior tipoPrimero tipoSegundo|
	
	(capas size < 2) ifTrue: [^true].
	
	sueloSinCapaSuperior := self class conCapas: (capas copyFrom: 2 to: capas size).
	tipoPrimero := (capas at: 1) class.
	tipoSegundo := (capas at: 2) class.
	^(tipoPrimero ~= tipoSegundo or: [tipoPrimero = Gema]) and: [sueloSinCapaSuperior sueloVálido].! !

!Suelo methodsFor: 'inspección' stamp: 'TK 5/8/2023 19:13:46'!
top
	
	capas isEmpty ifTrue: [^self error: self class errorSueloAgotado].
	^capas at: 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Suelo class' category: 'ISW1-2023-1C-Parcial-1'!
Suelo class
	instanceVariableNames: 'capas'!

!Suelo class methodsFor: 'creación' stamp: 'TK 5/8/2023 18:19:54'!
conCapas: unaSecuenciaDeCapas

	^self new inicializarConCapas: unaSecuenciaDeCapas.! !


!Suelo class methodsFor: 'errores' stamp: 'TK 5/8/2023 18:07:41'!
errorSueloAgotado

	^'No hay nada que taladrar.'.! !
