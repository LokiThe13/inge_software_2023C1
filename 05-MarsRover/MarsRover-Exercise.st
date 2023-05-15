!classDefinition: #MarsRoverTest category: 'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRover aStartingPosition aStartingCardinalDirection emptyCommandSequence zero north east south west'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTest methodsFor: 'setup' stamp: 'Tk 5/15/2023 00:47:11'!
setup

	zero := 0 @ 0.
	north := 0 @ 1.
	east := 1 @ 0.
	south := 0 @ -1.
	west := -1 @ 0.
	marsRover := MarsRover at: zero facing: north.! !


!MarsRoverTest methodsFor: 'testing' stamp: 'Tk 5/15/2023 00:13:52'!
test01RoverStaysPutWithEmptyCommandSequence

	self setup.
	
	marsRover executeCommandSequence: ''.
	
	self assert: marsRover position equals: zero.
	self assert: marsRover direction equals: north.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Tk 5/15/2023 00:14:22'!
test02RoverMovesForwardOnceWithCommandForward

	self setup.
	
	marsRover executeCommandSequence: 'F'.
	
	self assert: marsRover position equals: 0 @ 1.
	self assert: marsRover direction equals: north.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Tk 5/15/2023 00:14:41'!
test03RoverMovesForwardTwiceWithCommandForwardForward

	self setup.
	
	marsRover executeCommandSequence: 'FF'.
	
	self assert: marsRover position equals: 0 @ 2.
	self assert: marsRover direction equals: north.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Tk 5/15/2023 00:14:51'!
test04RoverMovesForwardAsManyTimesAsForwardIsRepeated

	self setup.
	
	marsRover executeCommandSequence: 'FFFFF'.
	
	self assert: marsRover position equals: 0 @ 5.
	self assert: marsRover direction equals: north.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Tk 5/15/2023 00:14:59'!
test05RoverMovesBackOnceWithCommandBack

	self setup.
	
	marsRover executeCommandSequence: 'B'.
	
	self assert: marsRover position equals: 0 @ -1.
	self assert: marsRover direction equals: north.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Tk 5/15/2023 00:15:06'!
test06RoverMovesBackTwiceWithCommandBackBack

	self setup.
	
	marsRover executeCommandSequence: 'BB'.
	
	self assert: marsRover position equals: 0 @ -2.
	self assert: marsRover direction equals: north.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Tk 5/15/2023 00:16:52'!
test07RoverMovesBackAsManyTimesAsBackIsRepeated

	self setup.
	
	marsRover executeCommandSequence: 'BBBBB'.
	
	self assert: marsRover position equals: 0 @ -5.
	self assert: marsRover direction equals: north.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Tk 5/15/2023 00:16:06'!
test08RoverRotatesLeftOnceWithCommandLeft

	self setup.
	
	marsRover executeCommandSequence: 'L'.
	
	self assert: marsRover position equals: zero.
	self assert: marsRover direction equals: west.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Tk 5/15/2023 00:16:01'!
test09RoverRotatesLeftTwiceWithCommandLeftLeft

	self setup.
	
	marsRover executeCommandSequence: 'LL'.
	
	self assert: marsRover position equals: zero.
	self assert: marsRover direction equals: south.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Tk 5/15/2023 00:15:57'!
test10RoverRotatesLeftAsManyTimesAsLeftIsRepeated

	self setup.
	
	marsRover executeCommandSequence: 'LLLLL'.
	
	self assert: marsRover position equals: zero.
	self assert: marsRover direction equals: west.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Tk 5/15/2023 00:15:47'!
test11RoverRotatesRightOnceWithCommandRight

	self setup.
	
	marsRover executeCommandSequence: 'R'.
	
	self assert: marsRover position equals: zero.
	self assert: marsRover direction equals: east.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Tk 5/15/2023 00:17:11'!
test12RoverRotatesRightTwiceWithCommandRightRight

	self setup.
	
	marsRover executeCommandSequence: 'RR'.
	
	self assert: marsRover position equals: zero.
	self assert: marsRover direction equals: south.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Tk 5/15/2023 00:16:22'!
test13RoverRotatesRightAsManyTimesAsRightIsRepeated

	self setup.
	
	marsRover executeCommandSequence: 'RRRRR'.
	
	self assert: marsRover position equals: zero.
	self assert: marsRover direction equals: east.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Tk 5/15/2023 00:45:06'!
test14RoverCanMixInstructions

	self setup.
	
	marsRover executeCommandSequence: 'FL'.
	
	self assert: marsRover position equals: 0 @ 1.
	self assert: marsRover direction equals: west.
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Tk 5/15/2023 00:30:51'!
test15RoverCanHandleComplexCommands

	self setup.
	
	marsRover executeCommandSequence: 'FFLFFRFRFLBLBBBRRRBBBRFRFFF'.
	
	self assert: marsRover position equals: 1 @ 8.
	self assert: marsRover direction equals: north.
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Tk 5/15/2023 00:47:11'!
test16RoverCantHandleUnvalidCommands

	self setup.
	
	self
		should: [ marsRover executeCommandSequence: 'ERFF'. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover errorNoCommandHandler.
		]
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'Tk 5/15/2023 00:47:11'!
test17RoverPartiallyAppliesCommandWhenEncounteringError

	self setup.
	
	self
		should: [ marsRover executeCommandSequence: 'FFRFFLFFEBBLBRRFF'. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover errorNoCommandHandler.
			self assert: marsRover position equals: 2 @ 4.
			self assert: marsRover direction equals: north.
		]
	
	! !


!classDefinition: #MarsRover category: 'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction commandHandler'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'commands' stamp: 'Tk 5/15/2023 00:42:05'!
executeCommandSequence: aCommandSequence
	
	| command |
	
	aCommandSequence isEmpty ifTrue: [^self.].
	command := aCommandSequence at: 1.
	(commandHandler keys includes: command)
		ifFalse: [self error: self class errorNoCommandHandler.]
		ifTrue: [(commandHandler at: command) value].
	self executeCommandSequence: (aCommandSequence copyFrom: 2 to: aCommandSequence size).! !


!MarsRover methodsFor: 'actioning' stamp: 'Tk 5/14/2023 22:31:07'!
moveBackwards

	position := position - direction.! !

!MarsRover methodsFor: 'actioning' stamp: 'Tk 5/14/2023 22:30:58'!
moveForwards

	position := position + direction.! !

!MarsRover methodsFor: 'actioning' stamp: 'Tk 5/14/2023 22:30:18'!
rotateLeft

	direction := direction y negated @ direction x.! !

!MarsRover methodsFor: 'actioning' stamp: 'Tk 5/14/2023 22:29:29'!
rotateRight

	direction := direction y @ direction x negated.

! !


!MarsRover methodsFor: 'accessing' stamp: 'Tk 5/14/2023 22:31:28'!
direction

	^direction.! !

!MarsRover methodsFor: 'accessing' stamp: 'Tk 5/14/2023 20:30:53'!
position

	^position.! !


!MarsRover methodsFor: 'initialization' stamp: 'Tk 5/15/2023 00:24:27'!
initializeAt: aPosition facing: aDirection 

	commandHandler := Dictionary 
		with: $F -> [self moveForwards]
		with: $B -> [self moveBackwards]
		with: $L -> [self rotateLeft]
		with: $R -> [self rotateRight].
	position := aPosition.
	direction := aDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: 'position facing'!

!MarsRover class methodsFor: 'creation' stamp: 'Tk 5/15/2023 00:23:54'!
at: aPosition facing: aDirection
	
	^self basicNew initializeAt: aPosition facing: aDirection.! !

!MarsRover class methodsFor: 'creation' stamp: 'Tk 5/15/2023 00:10:46'!
new
	
	^self basicNew initializeAt: 0 @ 0 facing: 0 @ 1.! !


!MarsRover class methodsFor: 'error' stamp: 'Tk 5/15/2023 00:23:40'!
errorNoCommandHandler
	
	^'There is no known handler for this command. Aborting execution.'! !
