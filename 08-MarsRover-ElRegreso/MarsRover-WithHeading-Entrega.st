!classDefinition: #MarsRoverHeadingLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverHeadingLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingLoggerTest methodsFor: 'tests' stamp: 'TK 6/4/2023 22:53:01'!
test01NewMarsRoverProducesEmptyHeadingLog

	| marsRover logger |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogWriter for: marsRover 
								with: NASAHeadingObserver.
	
	self assert: logger log equals: OrderedCollection new.! !

!MarsRoverHeadingLoggerTest methodsFor: 'tests' stamp: 'TK 6/4/2023 22:53:05'!
test02HeadingCommandWritesToHeadingLog

	| marsRover logger |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogWriter for: marsRover 
								with: NASAHeadingObserver.
	
	marsRover process: 'r'.
	
	self assert: logger log equals: (OrderedCollection with: 'Pointing East.').! !

!MarsRoverHeadingLoggerTest methodsFor: 'tests' stamp: 'TK 6/4/2023 22:53:10'!
test03PositionCommandDoesNotWriteToHeadingLog

	| marsRover logger |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogWriter for: marsRover 
								with: NASAHeadingObserver.
	
	marsRover process: 'f'.
	
	self assert: logger log equals: OrderedCollection new.! !

!MarsRoverHeadingLoggerTest methodsFor: 'tests' stamp: 'TK 6/4/2023 22:53:14'!
test04HeadingCommandsAllWriteToHeadingLog

	| marsRover logger |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogWriter for: marsRover 
								with: NASAHeadingObserver.
	
	marsRover process: 'rrffll'.
	
	self assert: logger log equals: (OrderedCollection 
							with: 'Pointing East.'
							with: 'Pointing South.'
							with: 'Pointing East.'
							with: 'Pointing North.'
	).! !


!MarsRoverHeadingLoggerTest methodsFor: 'cardinals' stamp: 'TK 6/4/2023 17:46:57'!
east

	^ MarsRoverHeadingEast.! !

!MarsRoverHeadingLoggerTest methodsFor: 'cardinals' stamp: 'TK 6/4/2023 17:46:53'!
north

	^ MarsRoverHeadingNorth.! !

!MarsRoverHeadingLoggerTest methodsFor: 'cardinals' stamp: 'TK 6/4/2023 17:47:02'!
south

	^ MarsRoverHeadingSouth.! !

!MarsRoverHeadingLoggerTest methodsFor: 'cardinals' stamp: 'TK 6/4/2023 17:47:06'!
west

	^ MarsRoverHeadingWest.! !


!classDefinition: #MarsRoverHeadingWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverHeadingWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWindowTest methodsFor: 'tests' stamp: 'TK 6/5/2023 00:18:20'!
test01NewMarsRoverProducesEmptyHeadingWindow

	| marsRover window |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverWindow for: marsRover
								with: NASAHeadingObserver.
	
	self assert: window show equals: (OrderedCollection with: 'heading: ').! !

!MarsRoverHeadingWindowTest methodsFor: 'tests' stamp: 'TK 6/5/2023 00:19:18'!
test02HeadingCommandWritesToHeadingWindow

	| marsRover window |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverWindow for: marsRover
								with: NASAHeadingObserver.
	
	marsRover process: 'r'.
	
	self assert: window show equals: (OrderedCollection with: 'heading: Pointing East.').! !

!MarsRoverHeadingWindowTest methodsFor: 'tests' stamp: 'TK 6/5/2023 00:19:40'!
test03PositionCommandDoesNotWriteToHeadingWindow

	| marsRover window |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverWindow for: marsRover
								with: NASAHeadingObserver.
	
	marsRover process: 'f'.
	
	self assert: window show equals: (OrderedCollection with: 'heading: ').! !

!MarsRoverHeadingWindowTest methodsFor: 'tests' stamp: 'TK 6/5/2023 00:20:36'!
test04PositionCommandsAllOverwriteIntoHeadingWindow

	| marsRover window |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverWindow for: marsRover
								with: NASAHeadingObserver.
	
	marsRover process: 'rrflr'.
	
	self assert: window show equals: (OrderedCollection with: 'heading: Pointing South.').! !


!MarsRoverHeadingWindowTest methodsFor: 'cardinals' stamp: 'TK 6/5/2023 00:14:33'!
east

	^ MarsRoverHeadingEast.! !

!MarsRoverHeadingWindowTest methodsFor: 'cardinals' stamp: 'TK 6/5/2023 00:14:28'!
north

	^ MarsRoverHeadingNorth.! !

!MarsRoverHeadingWindowTest methodsFor: 'cardinals' stamp: 'TK 6/5/2023 00:14:38'!
south

	^ MarsRoverHeadingSouth.! !

!MarsRoverHeadingWindowTest methodsFor: 'cardinals' stamp: 'TK 6/5/2023 00:14:45'!
west

	^ MarsRoverHeadingWest.! !


!classDefinition: #MarsRoverPositionHeadingLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverPositionHeadingLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionHeadingLoggerTest methodsFor: 'tests' stamp: 'TK 6/4/2023 22:51:45'!
test01NewMarsRoverProducesEmptyPositionHeadingLog

	| marsRover logger |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogWriter for: marsRover 
								with: NASAPositionObserver 
								with: NASAHeadingObserver.
	
	self assert: logger log equals: OrderedCollection new.! !

!MarsRoverPositionHeadingLoggerTest methodsFor: 'tests' stamp: 'TK 6/4/2023 22:51:30'!
test02PositionCommandWritesToPositionHeadingLog

	| marsRover logger |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogWriter for: marsRover 
								with: NASAPositionObserver 
								with: NASAHeadingObserver.
	
	marsRover process: 'f'.
	
	self assert: logger log equals: (OrderedCollection with: 0@1).! !

!MarsRoverPositionHeadingLoggerTest methodsFor: 'tests' stamp: 'TK 6/4/2023 22:51:48'!
test03HeadingCommandWritesToPositionHeadingLog

	| marsRover logger |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogWriter for: marsRover 
								with: NASAPositionObserver 
								with: NASAHeadingObserver.
	
	marsRover process: 'r'.
	
	self assert: logger log equals: (OrderedCollection with: 'Pointing East.').! !

!MarsRoverPositionHeadingLoggerTest methodsFor: 'tests' stamp: 'TK 6/4/2023 22:51:53'!
test04PositionAndHeadingCommandsAllWriteToPositionHeadingLog

	| marsRover logger |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogWriter for: marsRover 
								with: NASAPositionObserver 
								with: NASAHeadingObserver.
	
	marsRover process: 'frrbbl'.
	
	self assert: logger log equals: (OrderedCollection
								with: 0@1
								with: 'Pointing East.'
								with: 'Pointing South.'
								with: 0@2
								with: 0@3
								with: 'Pointing East.').! !


!MarsRoverPositionHeadingLoggerTest methodsFor: 'cardinals' stamp: 'TK 6/4/2023 18:08:56'!
east

	^ MarsRoverHeadingEast.! !

!MarsRoverPositionHeadingLoggerTest methodsFor: 'cardinals' stamp: 'TK 6/4/2023 18:08:50'!
north

	^ MarsRoverHeadingNorth.! !

!MarsRoverPositionHeadingLoggerTest methodsFor: 'cardinals' stamp: 'TK 6/4/2023 18:09:01'!
south

	^ MarsRoverHeadingSouth.! !

!MarsRoverPositionHeadingLoggerTest methodsFor: 'cardinals' stamp: 'TK 6/4/2023 18:09:07'!
west

	^ MarsRoverHeadingWest.! !


!classDefinition: #MarsRoverPositionHeadingWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverPositionHeadingWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionHeadingWindowTest methodsFor: 'cardinals' stamp: 'TK 6/5/2023 00:15:21'!
east

	^ MarsRoverHeadingEast.! !

!MarsRoverPositionHeadingWindowTest methodsFor: 'cardinals' stamp: 'TK 6/5/2023 00:15:16'!
north

	^ MarsRoverHeadingNorth.! !

!MarsRoverPositionHeadingWindowTest methodsFor: 'cardinals' stamp: 'TK 6/5/2023 00:15:28'!
south

	^ MarsRoverHeadingSouth.! !

!MarsRoverPositionHeadingWindowTest methodsFor: 'cardinals' stamp: 'TK 6/5/2023 00:15:32'!
west

	^ MarsRoverHeadingWest.! !


!MarsRoverPositionHeadingWindowTest methodsFor: 'tests' stamp: 'TK 6/5/2023 00:21:19'!
test01NewMarsRoverProducesEmptyPositionHeadingWindow

	| marsRover window |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverWindow for: marsRover
								with: NASAHeadingObserver.
	
	self assert: window show equals: (OrderedCollection with: 'heading: ').! !

!MarsRoverPositionHeadingWindowTest methodsFor: 'tests' stamp: 'TK 6/5/2023 00:26:54'!
test02PositionCommandWritesToPositionHeadingWindow

	| marsRover window |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverWindow for: marsRover
								with: NASAPositionObserver
								with: NASAHeadingObserver.
	
	marsRover process: 'f'.
	
	self assert: window show equals: (OrderedCollection with: 'position: 0@1' with: 'heading: ').! !

!MarsRoverPositionHeadingWindowTest methodsFor: 'tests' stamp: 'TK 6/5/2023 00:24:55'!
test03HeadingCommandWritesToPositionHeadingWindow

	| marsRover window |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverWindow for: marsRover
								with: NASAPositionObserver
								with: NASAHeadingObserver.
	
	marsRover process: 'r'.
	
	self assert: window show equals: (OrderedCollection with: 'position: ' with: 'heading: Pointing East.').! !

!MarsRoverPositionHeadingWindowTest methodsFor: 'tests' stamp: 'TK 6/5/2023 00:33:47'!
test04PositioAndHeadingCommandsAllOverwriteIntoPositionHeadingWindow

	| marsRover window |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverWindow for: marsRover
								with: NASAPositionObserver
								with: NASAHeadingObserver.
	
	marsRover process: 'ffrfrbbl'.
	
	self assert: window show equals: (OrderedCollection with: 'position: 1@4' with: 'heading: Pointing East.').! !


!classDefinition: #MarsRoverPositionLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverPositionLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionLoggerTest methodsFor: 'tests' stamp: 'TK 6/4/2023 22:52:10'!
test01NewMarsRoverProducesEmptyPositionLog

	| marsRover logger |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogWriter for: marsRover 
								with: NASAPositionObserver.
	
	self assert: logger log equals: OrderedCollection new.! !

!MarsRoverPositionLoggerTest methodsFor: 'tests' stamp: 'TK 6/4/2023 22:52:19'!
test02PositionCommandWritesToPositionLog

	| marsRover logger |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogWriter for: marsRover 
								with: NASAPositionObserver.
	
	marsRover process: 'f'.
	
	self assert: logger log equals: (OrderedCollection with: 0@1).! !

!MarsRoverPositionLoggerTest methodsFor: 'tests' stamp: 'TK 6/4/2023 22:52:27'!
test03RotationCommandDoesNotWriteToPositionLog

	| marsRover logger |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogWriter for: marsRover 
								with: NASAPositionObserver.
	
	marsRover process: 'r'.
	
	self assert: logger log equals: OrderedCollection new.! !

!MarsRoverPositionLoggerTest methodsFor: 'tests' stamp: 'TK 6/4/2023 22:52:34'!
test04PositionCommandsAllWriteToPositionLog

	| marsRover logger |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogWriter for: marsRover 
								with: NASAPositionObserver.
	
	marsRover process: 'ffrff'.
	
	self assert: logger log equals: (OrderedCollection 
							with: 0@1
							with: 0@2
							with: 1@2
							with: 2@2
	).! !


!MarsRoverPositionLoggerTest methodsFor: 'cardinals' stamp: 'TK 6/4/2023 17:11:41'!
east

	^ MarsRoverHeadingEast.! !

!MarsRoverPositionLoggerTest methodsFor: 'cardinals' stamp: 'TK 6/4/2023 17:11:37'!
north

	^ MarsRoverHeadingNorth.! !

!MarsRoverPositionLoggerTest methodsFor: 'cardinals' stamp: 'TK 6/4/2023 17:11:46'!
south

	^ MarsRoverHeadingSouth.! !

!MarsRoverPositionLoggerTest methodsFor: 'cardinals' stamp: 'TK 6/4/2023 17:11:52'!
west

	^ MarsRoverHeadingWest.! !


!classDefinition: #MarsRoverPositionWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverPositionWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionWindowTest methodsFor: 'tests' stamp: 'TK 6/5/2023 00:06:54'!
test01NewMarsRoverProducesEmptyPositionWindow

	| marsRover window |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverWindow for: marsRover
								with: NASAPositionObserver.
	
	self assert: window show equals: (OrderedCollection with: 'position: ').! !

!MarsRoverPositionWindowTest methodsFor: 'tests' stamp: 'TK 6/5/2023 00:09:32'!
test02PositionCommandWritesToPositionWindow

	| marsRover window |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverWindow for: marsRover
								with: NASAPositionObserver.
	
	marsRover process: 'f'.
	
	self assert: window show equals: (OrderedCollection with: 'position: 0@1').! !

!MarsRoverPositionWindowTest methodsFor: 'tests' stamp: 'TK 6/5/2023 00:10:45'!
test03RotationCommandDoesNotWriteToPositionWindow

	| marsRover window |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverWindow for: marsRover
								with: NASAPositionObserver.
	
	marsRover process: 'r'.
	
	self assert: window show equals: (OrderedCollection with: 'position: ').! !

!MarsRoverPositionWindowTest methodsFor: 'tests' stamp: 'TK 6/5/2023 00:11:44'!
test04PositionCommandsAllOverwriteIntoPositionWindow

	| marsRover window |
	
	marsRover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverWindow for: marsRover
								with: NASAPositionObserver.
	
	marsRover process: 'ffrff'.
	
	self assert: window show equals: (OrderedCollection with: 'position: 2@2').! !


!MarsRoverPositionWindowTest methodsFor: 'cardinals' stamp: 'TK 6/4/2023 22:59:57'!
east

	^ MarsRoverHeadingEast.! !

!MarsRoverPositionWindowTest methodsFor: 'cardinals' stamp: 'TK 6/4/2023 22:59:52'!
north

	^ MarsRoverHeadingNorth.! !

!MarsRoverPositionWindowTest methodsFor: 'cardinals' stamp: 'TK 6/4/2023 23:00:02'!
south

	^ MarsRoverHeadingSouth.! !

!MarsRoverPositionWindowTest methodsFor: 'cardinals' stamp: 'TK 6/4/2023 23:00:07'!
west

	^ MarsRoverHeadingWest.! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'TK 6/4/2023 16:51:18'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: MarsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'cardinals' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'cardinals' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'cardinals' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'cardinals' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head headingSignal positionSignal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'TK 6/4/2023 16:51:32'!
signalInvalidCommand
	
	self error: self class invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'TK 6/5/2023 04:12:35'!
initializeAt: aPosition heading: aHeadingType

	position := PositionProperty for: aPosition.
	head := HeadingProperty for: self heading: aHeadingType.! !


!MarsRover methodsFor: 'heading' stamp: 'TK 6/5/2023 04:05:48'!
headEast
	
	head headEast.! !

!MarsRover methodsFor: 'heading' stamp: 'TK 6/5/2023 04:05:45'!
headNorth
	
	head headNorth.! !

!MarsRover methodsFor: 'heading' stamp: 'TK 6/5/2023 04:05:42'!
headSouth
	
	head headSouth.! !

!MarsRover methodsFor: 'heading' stamp: 'TK 6/5/2023 04:05:36'!
headWest
	
	head headWest.! !

!MarsRover methodsFor: 'heading' stamp: 'TK 6/4/2023 21:30:48'!
rotateLeft
	
	head rotateLeft.! !

!MarsRover methodsFor: 'heading' stamp: 'TK 6/4/2023 21:30:45'!
rotateRight
	
	head rotateRight.! !


!MarsRover methodsFor: 'testing' stamp: 'TK 6/5/2023 04:58:14'!
isAt: aPosition heading: aHeadingType

	|positionEqual headingEqual|
	
	positionEqual := position wrapee = aPosition.
	headingEqual := head isHeading: aHeadingType.
	^ positionEqual and: [ headingEqual ].! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'TK 6/5/2023 04:16:51'!
moveBackward
	
	head moveBackward.! !

!MarsRover methodsFor: 'moving' stamp: 'TK 6/5/2023 04:47:56'!
moveEast
	
	position moveEast.! !

!MarsRover methodsFor: 'moving' stamp: 'TK 6/5/2023 04:16:53'!
moveForward
	
	head moveForward.! !

!MarsRover methodsFor: 'moving' stamp: 'TK 6/5/2023 04:51:32'!
moveNorth
	
	position moveNorth.! !

!MarsRover methodsFor: 'moving' stamp: 'TK 6/5/2023 04:48:11'!
moveSouth
	
	position moveSouth.! !

!MarsRover methodsFor: 'moving' stamp: 'TK 6/5/2023 04:48:17'!
moveWest
	
	position moveWest.! !


!MarsRover methodsFor: 'command processing' stamp: 'TK 6/4/2023 18:14:13'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand. ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'observers' stamp: 'TK 6/5/2023 04:12:44'!
headingBeingObservedBy: anObserver

	head beingObservedBy: anObserver.! !

!MarsRover methodsFor: 'observers' stamp: 'TK 6/5/2023 04:12:49'!
positionBeingObservedBy: anObserver

	position beingObservedBy: anObserver.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!MarsRover class methodsFor: 'error' stamp: 'TK 6/4/2023 16:51:05'!
invalidCommandErrorDescription
	
	^'Invalid command'! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'TK 6/5/2023 04:40:26'!
isHeading: aHeadingType

	^ self isKindOf: aHeadingType.! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #MarsRoverLogWriter category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverLogWriter
	instanceVariableNames: 'log observers marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogWriter methodsFor: 'log' stamp: 'TK 6/4/2023 21:56:01'!
log

	^ log.! !

!MarsRoverLogWriter methodsFor: 'log' stamp: 'TK 6/4/2023 23:42:58'!
write: aString from: anObserver

	log add: aString.! !


!MarsRoverLogWriter methodsFor: 'observe' stamp: 'TK 6/4/2023 22:19:03'!
addObserver: anObserverClass

	observers add: (anObserverClass for: marsRover listenedBy: self).! !


!MarsRoverLogWriter methodsFor: 'initialization' stamp: 'TK 6/4/2023 22:19:21'!
initializeFor: aMarsRover
	
	marsRover := aMarsRover.
	observers := Set new.
	log := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLogWriter class' category: 'MarsRover-WithHeading'!
MarsRoverLogWriter class
	instanceVariableNames: 'marsRover'!

!MarsRoverLogWriter class methodsFor: 'instance creation' stamp: 'TK 6/4/2023 22:16:33'!
for: aMarsRover

	^ self new initializeFor: aMarsRover.! !

!MarsRoverLogWriter class methodsFor: 'instance creation' stamp: 'TK 6/4/2023 23:05:40'!
for: aMarsRover with: anObserverClass

	^ self new initializeFor: aMarsRover; 
			addObserver: anObserverClass; 
			yourself.! !

!MarsRoverLogWriter class methodsFor: 'instance creation' stamp: 'TK 6/4/2023 22:20:02'!
for: aMarsRover with: anObserverClass with: anotherObserverClass

	^ self new initializeFor: aMarsRover; 
			addObserver: anObserverClass;
			addObserver: anotherObserverClass;
			yourself.! !


!classDefinition: #MarsRoverObservableProperty category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObservableProperty
	instanceVariableNames: 'value observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObservableProperty methodsFor: 'observers' stamp: 'TK 6/4/2023 19:33:16'!
beingObservedBy: anObserver

	observers add: anObserver.! !

!MarsRoverObservableProperty methodsFor: 'observers' stamp: 'TK 6/5/2023 05:00:29'!
sendToObservers: aMessage

	observers do: [ :anObserver | aMessage sendTo: anObserver ]! !

!MarsRoverObservableProperty methodsFor: 'observers' stamp: 'TK 6/5/2023 05:03:32'!
sendToObservers: aMessage with: arg

	observers do: [ :anObserver | aMessage sendTo: anObserver with: arg ]! !

!MarsRoverObservableProperty methodsFor: 'observers' stamp: 'TK 6/5/2023 05:03:25'!
sendToObservers: aMessage withAll: args

	observers do: [ :anObserver | aMessage sendTo: anObserver withAll: args ]! !


!MarsRoverObservableProperty methodsFor: 'initialization' stamp: 'TK 6/4/2023 21:46:05'!
initialize

	observers := Set new.! !


!MarsRoverObservableProperty methodsFor: 'message passing' stamp: 'TK 6/5/2023 04:55:40'!
doesNotUnderstand: aMessage

	^ aMessage sendTo: value.! !


!MarsRoverObservableProperty methodsFor: 'update' stamp: 'TK 6/4/2023 20:06:33'!
update: aValue

	self subclassResponsibility.! !


!MarsRoverObservableProperty methodsFor: 'accessing' stamp: 'TK 6/5/2023 04:58:02'!
wrapee

	^ value.! !


!classDefinition: #HeadingProperty category: 'MarsRover-WithHeading'!
MarsRoverObservableProperty subclass: #HeadingProperty
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingProperty methodsFor: 'heading' stamp: 'TK 6/5/2023 05:00:54'!
headEast
	
	value := MarsRoverHeadingEast for: marsRover.
	self sendToObservers: #headEast.! !

!HeadingProperty methodsFor: 'heading' stamp: 'TK 6/5/2023 05:01:05'!
headNorth
	
	value := MarsRoverHeadingNorth for: marsRover.
	self sendToObservers: #headNorth.! !

!HeadingProperty methodsFor: 'heading' stamp: 'TK 6/5/2023 05:01:11'!
headSouth

	value := MarsRoverHeadingSouth for: marsRover.
	self sendToObservers: #headSouth.! !

!HeadingProperty methodsFor: 'heading' stamp: 'TK 6/5/2023 05:01:17'!
headWest

	value := MarsRoverHeadingWest for: marsRover.
	self sendToObservers: #headWest.! !


!HeadingProperty methodsFor: 'initialization' stamp: 'TK 6/5/2023 04:05:03'!
initializeFor: aMarsRover heading: aHeading.

	super initialize.
	marsRover := aMarsRover.
	value := aHeading.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HeadingProperty class' category: 'MarsRover-WithHeading'!
HeadingProperty class
	instanceVariableNames: 'marsRover'!

!HeadingProperty class methodsFor: 'instance creation' stamp: 'TK 6/5/2023 04:11:50'!
for: aMarsRover heading: aHeadingClass

	^ self new initializeFor: aMarsRover heading: (aHeadingClass for: aMarsRover).! !


!classDefinition: #PositionProperty category: 'MarsRover-WithHeading'!
MarsRoverObservableProperty subclass: #PositionProperty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionProperty methodsFor: 'position' stamp: 'TK 6/5/2023 05:08:10'!
moveEast

	value := 1@0 + value.
	self sendToObservers: #positionedAt: with: value.! !

!PositionProperty methodsFor: 'position' stamp: 'TK 6/5/2023 05:08:17'!
moveNorth

	value := 0@1 + value.
	self sendToObservers: #positionedAt: with: value.! !

!PositionProperty methodsFor: 'position' stamp: 'TK 6/5/2023 05:08:20'!
moveSouth

	value := 0@-1 + value.
	self sendToObservers: #positionedAt: with: value.! !

!PositionProperty methodsFor: 'position' stamp: 'TK 6/5/2023 05:10:38'!
moveWest

	value := -1@0 + value.
	self sendToObservers: #positionedAt: with: value.! !


!PositionProperty methodsFor: 'initialization' stamp: 'TK 6/5/2023 02:04:31'!
initializeFor: aPosition

	value := aPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositionProperty class' category: 'MarsRover-WithHeading'!
PositionProperty class
	instanceVariableNames: ''!

!PositionProperty class methodsFor: 'instance creation' stamp: 'TK 6/5/2023 02:04:10'!
for: aPosition

	^ self new initializeFor: aPosition.! !


!classDefinition: #MarsRoverPropertyObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverPropertyObserver
	instanceVariableNames: 'listener'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPropertyObserver methodsFor: 'initialization' stamp: 'TK 6/4/2023 22:25:41'!
initializeFor: aMarsRover listenedBy: aListener
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverPropertyObserver class' category: 'MarsRover-WithHeading'!
MarsRoverPropertyObserver class
	instanceVariableNames: ''!

!MarsRoverPropertyObserver class methodsFor: 'instance creation' stamp: 'TK 6/4/2023 22:06:08'!
for: aMarsRover listenedBy: aListener.

	^ self new initializeFor: aMarsRover listenedBy: aListener.! !


!classDefinition: #HeadingObserver category: 'MarsRover-WithHeading'!
MarsRoverPropertyObserver subclass: #HeadingObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingObserver methodsFor: 'initialization' stamp: 'TK 6/4/2023 23:12:31'!
initializeFor: aMarsRover listenedBy: aListener
	
	listener := aListener.
	aMarsRover headingBeingObservedBy: self.! !


!HeadingObserver methodsFor: 'name' stamp: 'TK 6/4/2023 23:48:43'!
name

	^ 'heading'.! !


!HeadingObserver methodsFor: 'observe' stamp: 'TK 6/4/2023 22:46:41'!
headEast

	self subclassResponsibility ! !

!HeadingObserver methodsFor: 'observe' stamp: 'TK 6/4/2023 22:47:38'!
headNorth

	self subclassResponsibility ! !

!HeadingObserver methodsFor: 'observe' stamp: 'TK 6/4/2023 22:47:41'!
headSouth

	self subclassResponsibility ! !

!HeadingObserver methodsFor: 'observe' stamp: 'TK 6/4/2023 22:47:44'!
headWest

	self subclassResponsibility ! !


!classDefinition: #NASAHeadingObserver category: 'MarsRover-WithHeading'!
HeadingObserver subclass: #NASAHeadingObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!NASAHeadingObserver methodsFor: 'observe' stamp: 'TK 6/4/2023 23:43:24'!
headEast

	listener write: 'Pointing East.' from: self..! !

!NASAHeadingObserver methodsFor: 'observe' stamp: 'TK 6/4/2023 23:43:22'!
headNorth

	listener write: 'Pointing North.' from: self..! !

!NASAHeadingObserver methodsFor: 'observe' stamp: 'TK 6/4/2023 23:43:20'!
headSouth

	listener write: 'Pointing South.' from: self..! !

!NASAHeadingObserver methodsFor: 'observe' stamp: 'TK 6/4/2023 23:43:17'!
headWest

	listener write: 'Pointing West.' from: self.! !


!classDefinition: #PositionObserver category: 'MarsRover-WithHeading'!
MarsRoverPropertyObserver subclass: #PositionObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionObserver methodsFor: 'observe' stamp: 'TK 6/5/2023 05:05:03'!
positionedAt: aPosition

	self subclassResponsibility ! !


!PositionObserver methodsFor: 'initialization' stamp: 'TK 6/4/2023 23:12:27'!
initializeFor: aMarsRover listenedBy: aListener
	
	listener := aListener.
	aMarsRover positionBeingObservedBy: self.! !


!PositionObserver methodsFor: 'name' stamp: 'TK 6/4/2023 23:48:57'!
name

	^ 'position'.! !


!classDefinition: #NASAPositionObserver category: 'MarsRover-WithHeading'!
PositionObserver subclass: #NASAPositionObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!NASAPositionObserver methodsFor: 'observe' stamp: 'TK 6/5/2023 05:04:55'!
positionedAt: aPosition

	listener write: aPosition from: self.! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverWindow
	instanceVariableNames: 'marsRover observers values properties'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'window' stamp: 'TK 6/5/2023 02:00:42'!
fieldFor: anObserver

	^ anObserver name , ': ' , (observers at: anObserver) asString! !

!MarsRoverWindow methodsFor: 'window' stamp: 'TK 6/5/2023 02:01:46'!
show

	^ observers keysSortedSafely 
				inject: OrderedCollection new 
				into: 	[ :windowOutput :anObserver | windowOutput add: (self fieldFor: anObserver); yourself ]! !

!MarsRoverWindow methodsFor: 'window' stamp: 'TK 6/4/2023 23:45:35'!
write: aString from: anObserver
	
	observers at: anObserver put: aString.! !


!MarsRoverWindow methodsFor: 'initialization' stamp: 'TK 6/5/2023 00:30:53'!
initializeFor: aMarsRover
	
	marsRover := aMarsRover.
	observers := OrderedDictionary new.
	! !


!MarsRoverWindow methodsFor: 'observe' stamp: 'TK 6/5/2023 00:30:58'!
addObserver: anObserverClass

	| observer |
	observer := anObserverClass for: marsRover listenedBy: self.
	observers add: observer -> ''.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindow class' category: 'MarsRover-WithHeading'!
MarsRoverWindow class
	instanceVariableNames: ''!

!MarsRoverWindow class methodsFor: 'instance creation' stamp: 'TK 6/4/2023 23:03:40'!
for: aMarsRover

	^ self new initializeFor: aMarsRover.! !

!MarsRoverWindow class methodsFor: 'instance creation' stamp: 'TK 6/4/2023 23:05:53'!
for: aMarsRover with: anObserverClass

	^ self new initializeFor: aMarsRover; 
			addObserver: anObserverClass;
			yourself.! !

!MarsRoverWindow class methodsFor: 'instance creation' stamp: 'TK 6/4/2023 23:05:50'!
for: aMarsRover with: anObserverClass with: anotherObserverClass

	^ self new initializeFor: aMarsRover; 
			addObserver: anObserverClass;
			addObserver: anotherObserverClass;
			yourself.! !
