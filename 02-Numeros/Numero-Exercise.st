!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'TK 4/17/2023 22:44:39'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'TK 4/17/2023 22:44:31'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'TK 4/17/2023 22:45:54'!
test27EnteroSubtractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'TK 4/17/2023 22:45:49'!
test28FraccionSubtractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'TK 4/17/2023 22:45:44'!
test29EnteroSubtractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'TK 4/17/2023 22:45:31'!
test31SubtractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'TK 4/17/2023 22:45:26'!
test32SubtractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'TK 4/17/2023 22:45:22'!
test33SubtractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'TK 4/17/2023 22:45:17'!
test34SubtractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 01:17:04'!
addToEntero: anEntero
	
	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 01:18:13'!
addToFraccion: aFraccion
	
	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 01:18:05'!
divideAFraccion: aFraccion
	
	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 01:17:17'!
divideAnEntero: anEntero
	
	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 01:17:52'!
multiplyAFraccion: aFraccion
	
	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 01:17:25'!
multiplyAnEntero: anEntero
	
	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 01:17:45'!
subtractFromAFraccion: aFraccion
	
	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 01:17:32'!
subtractFromAnEntero: anEntero
	
	self subclassResponsibility ! !


!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 00:15:43'!
addToEntero: anEntero

	^self class with: value + anEntero integerValue.! !

!Entero methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 01:04:02'!
addToFraccion: aFraccion

	| newNumerator |
	newNumerator := self * aFraccion denominator + aFraccion numerator. 
	^Fraccion with: newNumerator over: aFraccion denominator.! !

!Entero methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 01:02:53'!
divideAFraccion: aFraccion

	^Fraccion with: aFraccion numerator over: self * aFraccion denominator.! !

!Entero methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 00:15:36'!
divideAnEntero: anEntero

	^Fraccion with: anEntero over: self.! !

!Entero methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 00:56:42'!
multiplyAFraccion: aFraccion

	| newNumerator |
	newNumerator := self * aFraccion numerator.
	
	^Fraccion with: newNumerator over: aFraccion denominator.! !

!Entero methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 00:56:22'!
multiplyAnEntero: anEntero

	^self class with: value * anEntero integerValue.! !

!Entero methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 00:20:24'!
subtractFromAFraccion: aFraccion

	| newNumerator |
	newNumerator := aFraccion numerator - (self * aFraccion denominator).

	^Fraccion with: newNumerator over: aFraccion denominator.! !

!Entero methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 00:20:10'!
subtractFromAnEntero: anEntero

	^self class with: anEntero integerValue - value.! !


!Entero methodsFor: 'arithmetic operations' stamp: 'TK 4/18/2023 00:36:38'!
* aMultiplier
	
	^aMultiplier multiplyAnEntero: self.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TK 4/17/2023 23:23:05'!
+ anAdder 
	
	^anAdder addToEntero: self
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TK 4/18/2023 00:36:47'!
- aSubtrahend 

	^aSubtrahend subtractFromAnEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TK 4/18/2023 00:01:26'!
/ aDivisor 
	
	^aDivisor divideAnEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TK 4/18/2023 23:17:03'!
fibonacci

	self subclassResponsibility 
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'TK 4/18/2023 23:51:36'!
initializeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'TK 4/18/2023 23:18:26'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'TK 4/18/2023 23:18:18'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'TK 4/18/2023 23:18:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'object creation' stamp: 'TK 4/19/2023 01:33:05'!
dividing: aNumerator withGCD: aGreatestCommonDenominator

	self subclassResponsibility.! !

!Entero methodsFor: 'object creation' stamp: 'TK 4/19/2023 02:29:57'!
dividingCoprime: aDividend

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'TK 4/18/2023 23:54:12'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [ self error: 'aValue debe ser anInteger' ].
	
	^(Entero subclasses detect: [ :aSubclass | aSubclass canHandle: aValue ]) new initializeWith: aValue.! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'arithmetic operations' stamp: 'TK 4/18/2023 23:55:55'!
fibonacci
	
	^Entero with: 1! !


!Cero methodsFor: 'object creation' stamp: 'TK 4/20/2023 01:15:25'!
dividing: aDividend

	self error: Fraccion canNotDivideByZeroErrorDescription.! !

!Cero methodsFor: 'object creation' stamp: 'TK 4/19/2023 02:30:17'!
dividingCoprime: aDividend

	self error: Fraccion canNotDivideByZeroErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: 'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'handling' stamp: 'TK 4/18/2023 23:38:56'!
canHandle: aValue

	^aValue = 0.! !


!classDefinition: #Negativo category: 'Numero-Exercise'!
Entero subclass: #Negativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativo methodsFor: 'arithmetic operations' stamp: 'TK 4/19/2023 00:04:25'!
fibonacci

	self error: Entero negativeFibonacciErrorDescription.! !


!Negativo methodsFor: 'object creation' stamp: 'TK 4/20/2023 01:15:50'!
dividing: aDividend

	^self negated dividing: aDividend negated.! !

!Negativo methodsFor: 'object creation' stamp: 'TK 4/19/2023 02:36:11'!
dividingCoprime: aDividend

	^self negated dividingCoprime: aDividend negated.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Negativo class' category: 'Numero-Exercise'!
Negativo class
	instanceVariableNames: ''!

!Negativo class methodsFor: 'handling' stamp: 'TK 4/18/2023 23:39:20'!
canHandle: aValue

	^aValue < 0.! !


!classDefinition: #PositivoMayorAUno category: 'Numero-Exercise'!
Entero subclass: #PositivoMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!PositivoMayorAUno methodsFor: 'arithmetic operations' stamp: 'TK 4/19/2023 00:02:53'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci! !


!PositivoMayorAUno methodsFor: 'object creation' stamp: 'TK 4/20/2023 01:16:14'!
dividing: aDividend

	| numerator denominator greatestCommonDivisor |
	
	greatestCommonDivisor  := aDividend greatestCommonDivisorWith: self.

	numerator := aDividend // greatestCommonDivisor.
	denominator := self // greatestCommonDivisor.
	
	^denominator dividingCoprime: numerator.! !

!PositivoMayorAUno methodsFor: 'object creation' stamp: 'TK 4/19/2023 02:30:46'!
dividingCoprime: aDividend

	^Fraccion with: aDividend overCoprime: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositivoMayorAUno class' category: 'Numero-Exercise'!
PositivoMayorAUno class
	instanceVariableNames: ''!

!PositivoMayorAUno class methodsFor: 'handling' stamp: 'TK 4/18/2023 23:39:59'!
canHandle: aValue

	^aValue > 1.! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'arithmetic operations' stamp: 'TK 4/19/2023 02:34:08'!
fibonacci

	^self. ! !


!Uno methodsFor: 'object creation' stamp: 'TK 4/20/2023 01:16:26'!
dividing: aNumerator

	^aNumerator.! !

!Uno methodsFor: 'object creation' stamp: 'TK 4/19/2023 02:31:03'!
dividingCoprime: aDividend

	^aDividend.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: 'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'handling' stamp: 'TK 4/18/2023 23:40:21'!
canHandle: aValue

	^aValue = 1.! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 00:17:06'!
addToEntero: anEntero

	| newNumerator |
	newNumerator := anEntero * denominator + numerator.

	^self class with: newNumerator over: denominator.! !

!Fraccion methodsFor: 'arithmetic typed operations' stamp: 'TK 4/17/2023 23:18:57'!
addToFraccion: aFraccion

	| newNumerator newDenominator |
	
	newNumerator := numerator * aFraccion denominator + (aFraccion numerator * denominator).
	newDenominator := denominator * aFraccion denominator.
	
	^self class with: newNumerator over: newDenominator.! !

!Fraccion methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 00:44:11'!
divideAFraccion: aFraccion

	| newNumerator newDenominator |
	
	newNumerator := denominator * aFraccion numerator.
	newDenominator := numerator * aFraccion denominator.
	
	^self class with: newNumerator over: newDenominator.! !

!Fraccion methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 01:11:05'!
divideAnEntero: anEntero

	| newNumerator |
	newNumerator := anEntero * denominator.

	^self class with: newNumerator over: numerator.! !

!Fraccion methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 00:43:45'!
multiplyAFraccion: aFraccion

	| newNumerator newDenominator |
	
	newNumerator := numerator * aFraccion numerator.
	newDenominator := denominator * aFraccion denominator.
	
	^self class with: newNumerator over: newDenominator.! !

!Fraccion methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 01:10:28'!
multiplyAnEntero: anEntero

	| newNumerator |
	newNumerator := anEntero * numerator.

	^self class with: newNumerator over: denominator.! !

!Fraccion methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 00:48:27'!
subtractFromAFraccion: aFraccion

	| newNumerator newDenominator |
	
	newNumerator := aFraccion numerator * denominator - (aFraccion denominator * numerator).
	newDenominator := aFraccion denominator * denominator.
	
	^self class with: newNumerator over: newDenominator.! !

!Fraccion methodsFor: 'arithmetic typed operations' stamp: 'TK 4/18/2023 01:12:06'!
subtractFromAnEntero: anEntero

	| newNumerator |
	newNumerator := anEntero * denominator - numerator.

	^self class with: newNumerator over: denominator.! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'TK 4/18/2023 00:37:21'!
* aMultiplier 
	
	^aMultiplier multiplyAFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TK 4/17/2023 23:23:46'!
+ anAdder 
	
	^anAdder addToFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TK 4/18/2023 00:37:44'!
- aSubtrahend 
	
	^aSubtrahend subtractFromAFraccion: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TK 4/18/2023 00:37:59'!
/ aDivisor 
	
	^aDivisor divideAFraccion: self.! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'TK 4/19/2023 01:44:22'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator.! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'instance creation' stamp: 'TK 4/20/2023 01:15:14'!
with: aDividend over: aDivisor

	^aDivisor dividing: aDividend.! !

!Fraccion class methodsFor: 'instance creation' stamp: 'TK 4/19/2023 02:28:52'!
with: aDividend overCoprime: aDivisor

	^self new initializeWith: aDividend over: aDivisor.! !
