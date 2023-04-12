!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'TK 4/11/2023 00:57:04'!
assertThat: aCustomerBook containsANumberOfActiveCustomersEqualTo: anExpectedNumberOfActiveCustomers containsANumberOfSuspendedCustomersEqualTo: anExpectedNumberOfSuspendedCustomers containsANumberOfCustomersEqualTo: anExpectedNumberOfCustomers
	
	self assert: anExpectedNumberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: anExpectedNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: anExpectedNumberOfCustomers equals: aCustomerBook numberOfCustomers.
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TK 4/11/2023 00:28:10'!
assertThat: anActionToValue failsWith: anExpectedError fulfilling: aCondition fulfilling: anotherCondition

    [ anActionToValue value.
    self fail ]
        on: anExpectedError 
        do: [ :anError | 
            self assert: (aCondition valueWithPossibleArgument: anError).
            self assert: (anotherCondition valueWithPossibleArgument: anError).]
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TK 4/11/2023 02:07:39'!
assertThat: anActionToValue takesLessTimeThan: aMaximumDuration

    | millisecondsBeforeRunning millisecondsAfterRunning |

    millisecondsBeforeRunning :=  Time millisecondClockValue * millisecond.
    anActionToValue value.
    millisecondsAfterRunning := Time millisecondClockValue * millisecond.

    self assert: millisecondsAfterRunning - millisecondsBeforeRunning < aMaximumDuration
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TK 4/11/2023 01:54:55'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertThat: [customerBook addCustomerNamed: 'John Lennon'.] takesLessTimeThan: 50 * millisecond
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TK 4/11/2023 01:54:50'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self assertThat: [customerBook removeCustomerNamed: paulMcCartney.] takesLessTimeThan: 100 * millisecond
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TK 4/11/2023 00:02:26'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self assertThat: [customerBook addCustomerNamed: ''.] failsWith: Error 
	fulfilling: [:anError | anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.] 
	fulfilling: [customerBook isEmpty.]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TK 4/11/2023 00:32:47'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertThat: [customerBook removeCustomerNamed: 'Paul McCartney'.] failsWith: NotFound 
	fulfilling: [customerBook numberOfCustomers = 1.] 
	fulfilling: [customerBook includesCustomerNamed: johnLennon.]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TK 4/11/2023 00:59:01'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertThat: customerBook 
		containsANumberOfActiveCustomersEqualTo: 0 
		containsANumberOfSuspendedCustomersEqualTo: 1 
		containsANumberOfCustomersEqualTo: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TK 4/11/2023 00:58:26'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThat: customerBook 
		containsANumberOfActiveCustomersEqualTo: 0 
		containsANumberOfSuspendedCustomersEqualTo: 0 
		containsANumberOfCustomersEqualTo: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TK 4/11/2023 00:32:34'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertThat: [customerBook suspendCustomerNamed: 'George Harrison'.] failsWith: CantSuspend
	fulfilling: [customerBook numberOfCustomers = 1.]
	fulfilling: [customerBook includesCustomerNamed: johnLennon.]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TK 4/11/2023 00:32:38'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self assertThat: [customerBook suspendCustomerNamed: johnLennon.] failsWith: CantSuspend
	fulfilling: [customerBook numberOfCustomers = 1.]
	fulfilling: [customerBook includesCustomerNamed: johnLennon.]
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'TK 4/11/2023 01:04:58'!
initialize

	active := OrderedCollection new.
	suspended := OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'TK 4/11/2023 01:03:58'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'TK 4/11/2023 01:06:15'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'TK 4/11/2023 02:01:42'!
removeCustomerNamed: aName 

	^active remove: aName ifAbsent: [ 
		^suspended remove: aName ifAbsent: [^NotFound signal.].
	].
	
	! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'TK 4/11/2023 03:15:12'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
