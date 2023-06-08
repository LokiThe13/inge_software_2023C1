!classDefinition: #CartTest category: 'TusLibros-Bookstore'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Bookstore'!

!CartTest methodsFor: 'testing' stamp: 'TK 6/8/2023 03:32:23'!
test01NewCartIsEmpty

	| cart |
	
	cart := Cart new.
	
	self assert: cart isEmpty equals: true.! !

!CartTest methodsFor: 'testing' stamp: 'TK 6/8/2023 03:41:29'!
test02ObjectCarriedByStoreCanBeAddedToCart

	| book cart store |
	
	book := Book withISBN: '0123456789123'.
	store := Store with: book.
	cart := Cart for: store.
	
	cart add: book.
	
	self assert: cart isEmpty equals: false.! !

!CartTest methodsFor: 'testing' stamp: 'TK 6/8/2023 03:48:41'!
test03ObjectNotCarriedByStoreCanNotBeAddedToCart

	| book cart store |
	
	book := Book withISBN: '0123456789123'.
	store := Store new.
	cart := Cart for: store.
	
	self
		should: [ cart add: book. ]
		raise: Error 
		withExceptionDo: 
		[ :anError | 
			self assert: anError messageText equals: Store errorItemNotCarriedByStore.
			self assert: cart isEmpty equals: true.
		]! !

!CartTest methodsFor: 'testing' stamp: 'TK 6/8/2023 04:11:44'!
test04EmptyCartProducesEmptyList

	| cart store |
	
	store := Store new.
	cart := Cart for: store.
	
	self assert: cart list equals: OrderedCollection new.! !

!CartTest methodsFor: 'testing' stamp: 'TK 6/8/2023 04:07:11'!
test05CartWithOneProductProducesListWithOneItem

	| book store cart |
	
	book := Book withISBN: '0123456789012'.
	store := Store with: book.
	cart := Cart for: store.
	
	cart add: book.
	
	self assert: cart list equals: (OrderedCollection with: book -> 1).! !

!CartTest methodsFor: 'testing' stamp: 'TK 6/8/2023 04:12:37'!
test06CartWithMultipleProductsProducesListWithMultipleItems

	| book anotherBook store cart |
	
	book := Book withISBN: '0123456789012'.
	anotherBook := Book withISBN: '1234567890123'.
	store := Store with: book with: anotherBook.
	cart := Cart for: store.
	
	cart add: book.
	cart add: anotherBook.
	
	self assert: cart list equals: (OrderedCollection with: book -> 1 with: anotherBook -> 1).! !

!CartTest methodsFor: 'testing' stamp: 'TK 6/8/2023 04:17:35'!
test07CartCanContainMultipleOfTheSameProduct

	| book store cart |
	
	book := Book withISBN: '0123456789012'.
	store := Store with: book.
	cart := Cart for: store.
	
	5 timesRepeat: [ cart add: book. ].
	
	self assert: cart list equals: (OrderedCollection with: book -> 5).! !


!classDefinition: #Book category: 'TusLibros-Bookstore'!
Object subclass: #Book
	instanceVariableNames: 'iSBN isbn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Bookstore'!

!Book methodsFor: 'initialization' stamp: 'TK 6/8/2023 03:42:46'!
initializeWithISBN: anISBN 

	isbn := anISBN.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: 'TusLibros-Bookstore'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'instance creation' stamp: 'TK 6/8/2023 03:42:16'!
withISBN: anISBN

	^ self new initializeWithISBN: anISBN. ! !


!classDefinition: #Cart category: 'TusLibros-Bookstore'!
Object subclass: #Cart
	instanceVariableNames: 'store contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Bookstore'!

!Cart methodsFor: 'contents' stamp: 'TK 6/8/2023 04:36:30'!
add: aProduct 
	
	(store carries: aProduct) 
		ifTrue: [ 	contents add: aProduct. ]
		ifFalse: [ self error: Store errorItemNotCarriedByStore. ]! !

!Cart methodsFor: 'contents' stamp: 'TK 6/8/2023 03:59:00'!
isEmpty
	
	^ contents isEmpty.! !

!Cart methodsFor: 'contents' stamp: 'TK 6/8/2023 04:35:25'!
list
	| list |
	
	list := OrderedCollection new.
	contents withOccurrencesDo: [ :aProduct :aQuantity | list add: (Association key: aProduct value: aQuantity). ].
	
	^ list.! !


!Cart methodsFor: 'initialization' stamp: 'TK 6/8/2023 04:31:46'!
initialize

	| orderedBag |
	
	orderedBag := Bag new.
	orderedBag setContents: OrderedDictionary new.
	
	contents := orderedBag.! !

!Cart methodsFor: 'initialization' stamp: 'TK 6/8/2023 03:59:21'!
initializeFor: aStore 
	
	self initialize.
	store := aStore.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Bookstore'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'TK 6/8/2023 03:43:37'!
for: aStore 

	^self new initializeFor: aStore ! !


!classDefinition: #Store category: 'TusLibros-Bookstore'!
Object subclass: #Store
	instanceVariableNames: 'products'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Bookstore'!

!Store methodsFor: 'products' stamp: 'TK 6/8/2023 04:14:26'!
add: aBook 
	
	products add: aBook.! !

!Store methodsFor: 'products' stamp: 'TK 6/8/2023 04:15:56'!
carries: aProduct

	^ products includes: aProduct.! !


!Store methodsFor: 'initialization' stamp: 'TK 6/8/2023 04:14:43'!
initialize

	products := Set new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Store class' category: 'TusLibros-Bookstore'!
Store class
	instanceVariableNames: ''!

!Store class methodsFor: 'instance creation' stamp: 'TK 6/8/2023 04:14:02'!
with: aBook

	^ (self new) 
		add: aBook;
		yourself.! !

!Store class methodsFor: 'instance creation' stamp: 'TK 6/8/2023 04:13:55'!
with: aBook with: anotherBook

	^ (self new) 
		add: aBook; 
		add: anotherBook; 
		yourself.! !


!Store class methodsFor: 'error messages' stamp: 'TK 6/8/2023 03:49:42'!
errorItemNotCarriedByStore

	'This item is not carried by this store and as such cannot be retrieved.'! !
