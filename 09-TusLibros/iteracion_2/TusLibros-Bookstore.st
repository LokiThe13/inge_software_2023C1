!classDefinition: #Cart category: 'TusLibros-Bookstore'!
Bag subclass: #Cart
	instanceVariableNames: 'catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Bookstore'!

!Cart methodsFor: 'contents' stamp: 'TK 6/12/2023 06:34:18'!
add: aProduct withOccurrences: anInteger 
	
	| inCatalogue PositiveQuantity |
	
	inCatalogue := catalogue includesKey: aProduct.
	PositiveQuantity := anInteger > 0.
	
	inCatalogue
		ifFalse: [ self error: self class errorItemNotInCatalogue. ].
	PositiveQuantity
		ifFalse: [ self error: self class errorNonPositiveQuantity. ].
		
	super add: aProduct withOccurrences: anInteger.! !

!Cart methodsFor: 'contents' stamp: 'TK 6/12/2023 06:04:20'!
list
	| list |
	
	list := OrderedCollection new.
	
	contents associationsDo: [ :anAssociation | list add: anAssociation ].
	
	^ list.! !

!Cart methodsFor: 'contents' stamp: 'TK 6/12/2023 06:42:51'!
total
	
	| total |
	
	total := 0.
	self withOccurrencesDo: [ :aProduct :aQuantity | total := (catalogue at: aProduct) * aQuantity + total ].
	^ total. ! !


!Cart methodsFor: 'initialization' stamp: 'TK 6/12/2023 06:00:09'!
initialize
	
	contents := OrderedDictionary new.! !

!Cart methodsFor: 'initialization' stamp: 'TK 6/12/2023 05:59:54'!
initializeFor: aCatalogue
	
	self initialize.
	catalogue := aCatalogue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Bookstore'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error' stamp: 'TK 6/12/2023 03:27:50'!
errorItemNotInCatalogue

	^ 'This product is not in our catalogue.'.! !

!Cart class methodsFor: 'error' stamp: 'TK 6/12/2023 06:07:59'!
errorNonPositiveQuantity

	^ 'Cannot add a non positive quantity of books.'.! !


!Cart class methodsFor: 'instance creation' stamp: 'TK 6/8/2023 03:43:37'!
for: aStore 

	^self new initializeFor: aStore ! !


!classDefinition: #CartTest category: 'TusLibros-Bookstore'!
TestCase subclass: #CartTest
	instanceVariableNames: 'toolbox'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Bookstore'!

!CartTest methodsFor: 'setup' stamp: 'TK 6/12/2023 03:54:24'!
setup

	toolbox := TestToolbox new.! !


!CartTest methodsFor: 'testing' stamp: 'TK 6/12/2023 04:15:31'!
test01NewCartIsEmpty

	self assert: Cart new isEmpty equals: true.! !

!CartTest methodsFor: 'testing' stamp: 'TK 6/12/2023 03:56:24'!
test02ObjectCarriedByStoreCanBeAddedToCart

	| cart |
	
	self setup.
	cart := Cart for: toolbox universalCatalogue.
	
	cart add: toolbox theLordOfTheRings.
	
	self assert: cart isEmpty equals: false.! !

!CartTest methodsFor: 'testing' stamp: 'TK 6/12/2023 03:57:05'!
test03ObjectNotCarriedByStoreCanNotBeAddedToCart

	| cart |
	
	self setup.
	cart := Cart for: toolbox emptyCatalogue.
	
	self
		should: [ cart add: toolbox theLordOfTheRings. ]
		raise: Error 
		withExceptionDo: 
		[ :anError | 
			self assert: anError messageText equals: Cart errorItemNotInCatalogue.
			self assert: cart isEmpty equals: true.
		]! !

!CartTest methodsFor: 'testing' stamp: 'TK 6/12/2023 07:54:18'!
test04EmptyCartProducesEmptyList

	| cart |
	
	self setup.
	cart := Cart for: toolbox universalCatalogue.
	
	self assert: cart list equals: OrderedCollection new.! !

!CartTest methodsFor: 'testing' stamp: 'TK 6/12/2023 03:58:29'!
test05CartWithOneProductProducesListWithOneItem

	| cart |
	
	self setup.
	cart := Cart for: toolbox universalCatalogue.
	
	cart add: toolbox theLordOfTheRings.
	
	self assert: cart list equals: (OrderedCollection with: toolbox theLordOfTheRings -> 1).! !

!CartTest methodsFor: 'testing' stamp: 'TK 6/12/2023 04:00:20'!
test06CartWithMultipleProductsProducesListWithMultipleItems

	| cart |
	
	self setup.
	cart := Cart for: toolbox universalCatalogue.
	
	cart add: toolbox theLordOfTheRings.
	cart add: toolbox theCallOfTheWild.
	
	self assert: 
		cart list 
	equals: 
		(OrderedCollection with: toolbox theLordOfTheRings -> 1 with: toolbox theCallOfTheWild -> 1).! !

!CartTest methodsFor: 'testing' stamp: 'TK 6/12/2023 04:00:55'!
test07CartCanContainMultipleOfTheSameProduct

	| cart |
	
	self setup.
	cart := Cart for: toolbox universalCatalogue.
	
	cart add: toolbox theLordOfTheRings withOccurrences: 5.
	
	self assert: cart list equals: (OrderedCollection with: toolbox theLordOfTheRings -> 5).! !

!CartTest methodsFor: 'testing' stamp: 'TK 6/12/2023 06:12:25'!
test08CannotAddNonPositiveQuantityOfBooksToCart

	| cart |
	
	self setup.
	cart := Cart for: toolbox universalCatalogue.
	
	self
		should: [ cart add: toolbox theLordOfTheRings withOccurrences: -1. ]
		raise: Error 
		withExceptionDo: 
		[ :anError | 
			self assert: anError messageText equals: Cart errorNonPositiveQuantity.
			self assert: cart isEmpty equals: true.
		]! !


!classDefinition: #CashierTest category: 'TusLibros-Bookstore'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'toolbox salesbook february2023Cashier february2023 aMerchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Bookstore'!

!CashierTest methodsFor: 'testing' stamp: 'TK 6/12/2023 08:03:31'!
test01AnEmptyCartCannotCheckout

	| creditCard |
	
	self setup.
	creditCard := toolbox validCreditCardFor: february2023.
	
	self 
		should: [ february2023Cashier checkout: Cart new with: creditCard registeringIn: salesbook forMonthOfYear: february2023. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: Cashier errorCannotCheckoutEmptyCart.
			self assert: salesbook isEmpty.
		].! !

!CashierTest methodsFor: 'testing' stamp: 'TK 6/12/2023 08:03:31'!
test02SingleProductCheckoutRegistersOnSalesbook

	| catalogue cart creditCard |
	
	self setup.
	catalogue := (Dictionary with: toolbox theLordOfTheRings -> 100).
	cart := Cart for: catalogue.
	creditCard := toolbox validCreditCardFor: february2023.
	
	cart add: toolbox theLordOfTheRings.
	february2023Cashier checkout: cart with: creditCard registeringIn: salesbook forMonthOfYear: february2023.
	
	self assert: salesbook equals: (OrderedCollection with: creditCard moniker -> 100).! !

!CashierTest methodsFor: 'testing' stamp: 'TK 6/12/2023 08:03:31'!
test03MultipleProductCheckoutRegistersOnSalesbook

	| catalogue cart creditCard |
	
	self setup.
	catalogue := (Dictionary with: toolbox theLordOfTheRings -> 100 with: toolbox  theCallOfTheWild -> 50).
	cart := Cart for: catalogue.
	creditCard := toolbox validCreditCardFor: february2023.
	
	cart add: toolbox theLordOfTheRings withOccurrences: 5.
	cart add: toolbox theCallOfTheWild withOccurrences: 5.
	february2023Cashier checkout: cart with: creditCard registeringIn: salesbook forMonthOfYear: february2023.
	
	self assert: salesbook equals: (OrderedCollection with: creditCard moniker -> 750).! !

!CashierTest methodsFor: 'testing' stamp: 'TK 6/12/2023 08:03:31'!
test04AnExpiredCreditCardCannotCheckout

	| cart creditCard |
	
	self setup.
	cart := Cart for: toolbox universalCatalogue.
	creditCard := toolbox expiredCreditCardFor: february2023.
	
	cart add: toolbox theLordOfTheRings withOccurrences: 1024.
	
	self 
		should: [ february2023Cashier checkout: cart with: creditCard registeringIn: salesbook forMonthOfYear: february2023. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: Cashier errorCannotCheckoutExpiredCreditCard.
			self assert: salesbook isEmpty.
		].! !

!CashierTest methodsFor: 'testing' stamp: 'TK 6/12/2023 08:03:31'!
test05ACreditCardWithoutFundsCannotCheckout

	| cart creditCard |
	
	self setup.
	cart := Cart for: toolbox universalCatalogue.
	creditCard := toolbox creditCardWithoutFundsFor: february2023 whenAsking: aMerchantProcessor.
	
	cart add: toolbox theLordOfTheRings withOccurrences: 1024.
	
	self 
		should: [ february2023Cashier checkout: cart with: creditCard registeringIn: salesbook forMonthOfYear: february2023. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: MerchantSimulator errorCannotCheckoutCreditCardWithoutFunds.
			self assert: salesbook isEmpty.
		].! !

!CashierTest methodsFor: 'testing' stamp: 'TK 6/12/2023 08:03:31'!
test06AStolenCreditCardCannotCheckout

	| cart creditCard |
	
	self setup.
	cart := Cart for: toolbox universalCatalogue.
	creditCard := toolbox stolenCreditCardFor: february2023 whenAsking: aMerchantProcessor.
	
	cart add: toolbox theLordOfTheRings withOccurrences: 1024.
	
	self 
		should: [ february2023Cashier checkout: cart with: creditCard registeringIn: salesbook forMonthOfYear: february2023. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: MerchantSimulator errorCannotCheckoutStolenCreditCard.
			self assert: salesbook isEmpty.
		].! !


!CashierTest methodsFor: 'setup' stamp: 'TK 6/12/2023 08:03:31'!
setup

	toolbox := TestToolbox new.
	february2023 := GregorianMonthOfYear februaryOf: (GregorianYear number: 2023).
	
	salesbook := OrderedCollection new.
	aMerchantProcessor := MerchantSimulator new.
	february2023Cashier := Cashier 
		withMerchantProcessor: aMerchantProcessor 
		forMonthOfYear: february2023.! !


!classDefinition: #Cashier category: 'TusLibros-Bookstore'!
Object subclass: #Cashier
	instanceVariableNames: 'merchantProcessor date'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Bookstore'!

!Cashier methodsFor: 'validation' stamp: 'TK 6/12/2023 08:07:31'!
validateSaleOf: aCart paidBy: aCreditCard forMonthOfYear: aMonthOfYear

	aCart isEmpty ifTrue:
		[ self error: self class errorCannotCheckoutEmptyCart. ].
	aCreditCard expiration < aMonthOfYear ifTrue: 
		[ self error: self class errorCannotCheckoutExpiredCreditCard. ].
	
	[ merchantProcessor validate: aCreditCard. ]
		on: Error - MessageNotUnderstood 
		do: [ :anError | self error: anError messageText. ]! !


!Cashier methodsFor: 'checkout' stamp: 'TK 6/12/2023 08:06:36'!
checkout: aCart with: aCreditCard registeringIn: aSalesbook forMonthOfYear: aMonthOfYear

	self validateSaleOf: aCart paidBy: aCreditCard forMonthOfYear: aMonthOfYear.
		
	aSalesbook add: aCreditCard moniker -> aCart total.! !


!Cashier methodsFor: 'initialization' stamp: 'TK 6/12/2023 07:16:47'!
initializeWithMerchantProcessor: aMerchantProcessor forMonthOfYear: aDate

	merchantProcessor := aMerchantProcessor.
	date := aDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros-Bookstore'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error' stamp: 'TK 6/12/2023 04:13:45'!
errorCannotCheckoutEmptyCart

	^ 'Cannot check out with an empty cart.'.! !

!Cashier class methodsFor: 'error' stamp: 'TK 6/12/2023 06:51:54'!
errorCannotCheckoutExpiredCreditCard

	^ 'This credit card has expired.'.! !


!Cashier class methodsFor: 'instance creation' stamp: 'TK 6/12/2023 07:17:49'!
withMerchantProcessor: aMerchantProcessor forMonthOfYear: aDate 

	^self new initializeWithMerchantProcessor: aMerchantProcessor forMonthOfYear: aDate.! !


!classDefinition: #CreditCard category: 'TusLibros-Bookstore'!
Object subclass: #CreditCard
	instanceVariableNames: 'number issued expiration owner ccv'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Bookstore'!

!CreditCard methodsFor: 'access' stamp: 'TK 6/12/2023 07:00:53'!
expiration

	^ expiration.! !

!CreditCard methodsFor: 'access' stamp: 'TK 6/12/2023 05:38:03'!
initializeNumbered: aCreditCardNumber issuedTo: aName on: aMonthOfYear expiringOn: anotherMonthOfYear withCCV: aCCV.

	number := aCreditCardNumber.
	owner := aName.
	issued := aMonthOfYear.
	expiration := anotherMonthOfYear.
	ccv := aCCV.! !

!CreditCard methodsFor: 'access' stamp: 'TK 6/12/2023 05:33:54'!
moniker

	^ (number copyFrom: 1 count: 6) , 'xxxxxx' , (number copyFrom: 12 count: 4).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros-Bookstore'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'TK 6/12/2023 05:54:20'!
numbered: aCreditCardNumber issuedTo: aName on: aMonthOfYear expiringOn: anotherMonthOfYear withCCV: aCCV.

	^ self new initializeNumbered: aCreditCardNumber issuedTo: aName on: aMonthOfYear expiringOn: anotherMonthOfYear withCCV: aCCV.! !


!classDefinition: #MerchantSimulator category: 'TusLibros-Bookstore'!
Object subclass: #MerchantSimulator
	instanceVariableNames: 'noFundsCreditCards stolenCreditCards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Bookstore'!

!MerchantSimulator methodsFor: 'validation' stamp: 'TK 6/12/2023 07:36:54'!
validate: aCreditCard

	(noFundsCreditCards includes: aCreditCard) ifTrue:
		[ self error: self class errorCannotCheckoutCreditCardWithoutFunds. ].
		
	(stolenCreditCards includes: aCreditCard) ifTrue:
		[ self error: self class errorCannotCheckoutStolenCreditCard. ].
	! !


!MerchantSimulator methodsFor: 'initialization' stamp: 'TK 6/12/2023 07:33:42'!
initialize

	noFundsCreditCards := Set new.
	stolenCreditCards := Set new.! !


!MerchantSimulator methodsFor: 'registering' stamp: 'TK 6/12/2023 07:32:53'!
addCardWithoutFunds: card 
	
	noFundsCreditCards add: card.! !

!MerchantSimulator methodsFor: 'registering' stamp: 'TK 6/12/2023 07:33:56'!
addStolenCard: card 
	
	stolenCreditCards add: card.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantSimulator class' category: 'TusLibros-Bookstore'!
MerchantSimulator class
	instanceVariableNames: ''!

!MerchantSimulator class methodsFor: 'error' stamp: 'TK 6/12/2023 07:22:45'!
errorCannotCheckoutCreditCardWithoutFunds

	^ 'This credit card does not have enough available funds.'.! !

!MerchantSimulator class methodsFor: 'error' stamp: 'TK 6/12/2023 07:36:14'!
errorCannotCheckoutStolenCreditCard

	^ 'This credit card is marked as stolen.'.! !


!classDefinition: #TestToolbox category: 'TusLibros-Bookstore'!
Object subclass: #TestToolbox
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Bookstore'!

!TestToolbox methodsFor: 'factory' stamp: 'TK 6/12/2023 07:32:07'!
creditCardWithoutFundsFor: aMonthOfYear whenAsking: aMerchantProcessor
	
	| card |
	
	card := CreditCard 
		numbered: '0123456789012345'
		issuedTo: 'Linda Amari'
		on: (aMonthOfYear previousMonth: aMonthOfYear month)
		expiringOn: (aMonthOfYear nextMonth: aMonthOfYear month)
		withCCV: '362'.
	
	aMerchantProcessor addCardWithoutFunds: card.
	
	^ card.! !

!TestToolbox methodsFor: 'factory' stamp: 'TK 6/12/2023 06:35:59'!
emptyCatalogue

	^ Dictionary new.! !

!TestToolbox methodsFor: 'factory' stamp: 'TK 6/12/2023 07:03:39'!
expiredCreditCardFor: aMonthOfYear
	
	^ CreditCard 
		numbered: '0123456789012345'
		issuedTo: 'Leah Graham'
		on: (aMonthOfYear previousMonth: aMonthOfYear month)
		expiringOn: (aMonthOfYear previousMonth: aMonthOfYear month)
		withCCV: '362'! !

!TestToolbox methodsFor: 'factory' stamp: 'TK 6/12/2023 07:34:33'!
stolenCreditCardFor: aMonthOfYear whenAsking: aMerchantProcessor
	
	| card |
	
	card := CreditCard 
		numbered: '0123456789012345'
		issuedTo: 'Bling McBling'
		on: (aMonthOfYear previousMonth: aMonthOfYear month)
		expiringOn: (aMonthOfYear nextMonth: aMonthOfYear month)
		withCCV: '362'.
	
	aMerchantProcessor addStolenCard: card.
	
	^ card.! !

!TestToolbox methodsFor: 'factory' stamp: 'TK 6/12/2023 03:41:20'!
theCallOfTheWild

	^ 'The Call of the Wild'.! !

!TestToolbox methodsFor: 'factory' stamp: 'TK 6/12/2023 03:41:05'!
theLordOfTheRings

	^ 'The Lord of the Rings'.! !

!TestToolbox methodsFor: 'factory' stamp: 'TK 6/12/2023 06:45:41'!
universalCatalogue
	
	^ ProtoObject new; 
		compile: 'includesKey: key ^ true.';
		yourself.! !

!TestToolbox methodsFor: 'factory' stamp: 'TK 6/12/2023 05:54:49'!
validCreditCardFor: aMonthOfYear
	
	^ CreditCard 
		numbered: '0123456789012345'
		issuedTo: 'Martin Brando'
		on: (aMonthOfYear previousMonth: aMonthOfYear month)
		expiringOn: (aMonthOfYear nextMonth: aMonthOfYear month)
		withCCV: '362'! !
