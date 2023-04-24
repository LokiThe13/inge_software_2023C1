!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'TK 4/23/2023 22:42:20'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStackBase new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'TK 4/23/2023 22:42:20'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStackBase new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'TK 4/23/2023 22:42:20'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStackBase new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'TK 4/23/2023 22:42:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStackBase new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'TK 4/23/2023 22:42:20'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStackBase new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'TK 4/23/2023 22:42:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStackBase new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'TK 4/23/2023 22:42:20'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStackBase new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'TK 4/23/2023 22:42:20'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStackBase new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStackBase stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'TK 4/23/2023 22:42:20'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStackBase new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStackBase stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'TK 4/23/2023 22:42:20'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStackBase new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStackBase stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'stack expectedStack sentenceFinderByPrefix dog cat cataclysm cataclysmically rat liberty lions limit libel tiling aliment ill'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'TK 4/23/2023 17:32:26'!
initialize: aStack and: anotherStack with: aCollection

	self initialize: aStack with: aCollection.
	self initialize: anotherStack with: aCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'TK 4/23/2023 17:27:13'!
initialize: aStack with: anArray

	anArray do: [ :anElement | aStack push: anElement ].! !

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'TK 4/23/2023 22:42:20'!
setup
	
	stack := OOStackBase new.
	expectedStack  := OOStackBase new.
	sentenceFinderByPrefix := SentenceFinderByPrefix new.
	dog := 'dog'.
	cat := 'cat'.
	rat := 'rat'.
	cataclysm := 'cataclysm'.
	cataclysmically := 'cataclysmically'.
	
	liberty := 'liberté et fraternité.'.
	lions := 'lions stalk.'.
	limit := 'limit as n tends to infinity does not exist.'.
	libel := 'libel can be defined as a published false statement that is damaging.'.
	tiling := 'the tiling needs to be precise for it to perfectly fit.'.
	aliment := 'aliment is needed both for body and soul.'.
	ill := 'ill intent is difficult to prove in a court of law.'.! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TK 4/23/2023 19:57:28'!
test01NoMatchesInEmptyStack

	| result |

	self setup.	
	self initialize: stack and: expectedStack with: Bag new.
	
	result := sentenceFinderByPrefix selectSentencesBeginningWith: cat in: stack.
	
	self assertThat: stack equals: expectedStack.
	self assert: result = Bag new.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TK 4/23/2023 21:53:22'!
test02MatchesPrefix

	| result |

	self setup.	
	self initialize: stack and: expectedStack with: (Bag with: cat).
	
	result := sentenceFinderByPrefix selectSentencesBeginningWith: cat in: stack.
	
	self assertThat: stack equals: expectedStack.
	self assert: result = (Bag with: cat).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TK 4/23/2023 21:53:29'!
test03OnlyMatchesPrefix

	| result |

	self setup.	
	self initialize: stack and: expectedStack with: (Bag with: dog with: cat with: rat).
	
	result := sentenceFinderByPrefix selectSentencesBeginningWith: cat in: stack.
	
	self assertThat: stack equals: expectedStack.
	self assert: result = (Bag with: cat).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TK 4/23/2023 21:52:11'!
test04MatchesAllOccurrences

	| result |

	self setup.	
	self initialize: stack and: expectedStack with: (Bag with: liberty with: lions with: limit with: libel).
	
	result := sentenceFinderByPrefix selectSentencesBeginningWith: 'li' in: stack.
	
	self assertThat: stack equals: expectedStack.
	self assert: result = (Bag with: liberty with: lions with: limit with: libel).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TK 4/23/2023 21:52:04'!
test05OnlyMatchesAllOccurrences

	| result |

	self setup.	
	self initialize: stack and: expectedStack with: (Bag with: ill with: liberty with: aliment with: lions with: limit with: libel).
	
	result := sentenceFinderByPrefix selectSentencesBeginningWith: 'li' in: stack.
	
	self assertThat: stack equals: expectedStack.
	self assert: result = (Bag with: liberty with: lions with: limit with: libel).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TK 4/23/2023 21:51:57'!
test06CanMatchTheSameSentenceMultipleTimes

	| result |

	self setup.	
	self initialize: stack and: expectedStack with: (Bag with: ill with: lions with: aliment with: lions with: lions with: ill).
	
	result := sentenceFinderByPrefix selectSentencesBeginningWith: 'li' in: stack.
	
	self assertThat: stack equals: expectedStack.
	self assert: result = (Bag with: lions with: lions with: lions).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TK 4/23/2023 22:05:23'!
test07NoMatchesIfAllDifferent

	| result |

	self setup.	
	self initialize: stack and: expectedStack with: (Bag with: ill with: liberty with: aliment with: lions with: limit with: libel).
	
	result := sentenceFinderByPrefix selectSentencesBeginningWith: 'lia' in: stack.
	
	self assertThat: stack equals: expectedStack.
	self assert: result = (Bag new).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TK 4/23/2023 22:30:42'!
test08DoesntMatchPrefixOfPrefix

	| result |

	self setup.	
	self initialize: stack and: expectedStack with: (Bag with: cat with: cataclysm with: cataclysmically).
	
	result := sentenceFinderByPrefix selectSentencesBeginningWith: cataclysmically in: stack.
	
	self assertThat: stack equals: expectedStack.
	self assert: result = (Bag with: cataclysmically).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TK 4/23/2023 22:22:49'!
test09EmptyPrefixIsInvalid

	self setup.	
	self initialize: stack with: (Bag with: dog with: cat with: rat).
	
	self should: [ sentenceFinderByPrefix selectSentencesBeginningWith: '' in: stack ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix prefixEmptyErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TK 4/23/2023 22:22:55'!
test10WhitespaceInPrefixIsInvalid

	self setup.	
	self initialize: stack with: (Bag with: dog with: cat with: rat).
	
	self should: [ sentenceFinderByPrefix selectSentencesBeginningWith: 'a cat' in: stack ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix prefixContainsWhitespaceErrorDescription ]! !


!SentenceFinderByPrefixTest methodsFor: 'assertion' stamp: 'TK 4/23/2023 16:36:11'!
assertThat: aStack equals: anotherStack

	| aStackTop anotherStackTop|

	self assert: aStack size = anotherStack size.
	aStack isEmpty ifTrue: [^self].

	aStackTop := aStack pop.
	anotherStackTop := anotherStack pop.
	
	self assert: aStackTop = anotherStackTop.
	self assertThat: aStack equals: anotherStack.
	
	aStack push: aStackTop.
	anotherStack push: anotherStackTop.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'properties' stamp: 'TK 4/23/2023 22:44:29'!
height
	
	self subclassResponsibility.! !


!OOStack methodsFor: 'accessing' stamp: 'TK 4/23/2023 22:45:11'!
stackValue

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'instance creation' stamp: 'TK 4/23/2023 22:45:43'!
new

	^OOStackBase new.! !


!OOStack class methodsFor: 'error descriptions' stamp: 'TK 4/23/2023 22:48:31'!
stackEmptyErrorDescription
	
	^ 'stack is empty'.! !


!classDefinition: #OOStackBase category: 'Stack-Exercise'!
OOStack subclass: #OOStackBase
	instanceVariableNames: 'top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'accessing' stamp: 'TK 4/23/2023 22:49:57'!
stackValue

	self error: self class stackEmptyErrorDescription.! !


!OOStackBase methodsFor: 'properties' stamp: 'TK 4/23/2023 03:50:18'!
height

	^0.! !

!OOStackBase methodsFor: 'properties' stamp: 'TK 4/23/2023 03:50:23'!
isEmpty

	^self size = 0.! !

!OOStackBase methodsFor: 'properties' stamp: 'TK 4/23/2023 03:52:23'!
size

	^top height.! !


!OOStackBase methodsFor: 'actions' stamp: 'TK 4/23/2023 03:51:11'!
pop

	| poppedElement |

	poppedElement := self top.
	top := top below.
	
	^poppedElement.! !

!OOStackBase methodsFor: 'actions' stamp: 'TK 4/23/2023 22:38:34'!
push: aValue

	| newBlock |
	
	newBlock := OOStackBlock with: aValue above: top.
	
	top := newBlock.
	! !

!OOStackBase methodsFor: 'actions' stamp: 'TK 4/23/2023 22:49:33'!
top

	^top stackValue.! !


!OOStackBase methodsFor: 'initialization' stamp: 'TK 4/23/2023 03:52:30'!
initialize

	top := self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackBase class' category: 'Stack-Exercise'!
OOStackBase class
	instanceVariableNames: ''!

!OOStackBase class methodsFor: 'as yet unclassified' stamp: 'TK 4/23/2023 22:52:03'!
new

	^self basicNew initialize.! !


!classDefinition: #OOStackBlock category: 'Stack-Exercise'!
OOStack subclass: #OOStackBlock
	instanceVariableNames: 'value below'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBlock methodsFor: 'initialization' stamp: 'Jfo 4/21/2023 22:52:26'!
initializeWith: aValue above: aStackElement

	value := aValue.
	below := aStackElement.
! !


!OOStackBlock methodsFor: 'accessing' stamp: 'TK 4/23/2023 04:09:50'!
below

	^below.! !

!OOStackBlock methodsFor: 'accessing' stamp: 'TK 4/23/2023 22:49:23'!
stackValue

	^value.! !


!OOStackBlock methodsFor: 'properties' stamp: 'TK 4/23/2023 04:13:22'!
height

	^self below height + 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackBlock class' category: 'Stack-Exercise'!
OOStackBlock class
	instanceVariableNames: ''!

!OOStackBlock class methodsFor: 'instance creation' stamp: 'TK 4/23/2023 22:52:53'!
with: aValue above: aStackElement

	^self basicNew initializeWith: aValue above: aStackElement! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'validating' stamp: 'TK 4/23/2023 21:39:24'!
validate: aPrefix

	aPrefix isEmpty ifTrue: [self error: self class prefixEmptyErrorDescription].
	aPrefix containsSeparators ifTrue: [self error: self class prefixContainsWhitespaceErrorDescription].! !


!SentenceFinderByPrefix methodsFor: 'enumerating' stamp: 'TK 4/23/2023 21:39:47'!
selectSentencesBeginningWith: aPrefix in: aSentenceStack

	| top tail |
	
	self validate: aPrefix.
	
	aSentenceStack isEmpty ifTrue: [^Bag new].
	
	top := aSentenceStack pop.
	tail := self selectSentencesBeginningWith: aPrefix in: aSentenceStack.
	(top beginsWith: aPrefix) ifTrue: [tail add: top].
	
	aSentenceStack push: top.
	^tail.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'TK 4/23/2023 18:19:10'!
prefixContainsWhitespaceErrorDescription
	
	^'prefix contains whitespace.'.! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'TK 4/23/2023 16:40:29'!
prefixEmptyErrorDescription
	
	^'prefix cannot be empty.'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!CharacterSequence methodsFor: 'converting' stamp: 'TK 4/23/2023 18:33:12'!
containsSeparators
	
	^self ~= self withoutSeparators.! !

