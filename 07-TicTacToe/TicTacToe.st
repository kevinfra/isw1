!classDefinition: #TicTacToeTest category: #TicTacToStep21!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/28/2018 17:49:33'!
assertPlayerPlays: aCollectionOfPlays expectsToOnlyHave: anExpectedCollectionOfPlays

	self assert: aCollectionOfPlays size equals: anExpectedCollectionOfPlays size.
	anExpectedCollectionOfPlays do: [ :aPlay |
		self assert: (aCollectionOfPlays includes: aPlay)
	].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:40:17'!
playedInTurns: orderedCollectionOfPlays
	| game |
	game _ TicTacToe start.
	orderedCollectionOfPlays withIndexDo: [ :play :index |
		index even
			ifTrue: [ game playOAt: play ]
			ifFalse: [ game playXAt: play ]].
	^ game.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 20:50:42'!
test01NoPlayMustBeMadeWhenTheGameStarts
	| game |
	game _ TicTacToe start.
	self assert: game isEmpty.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 21:34:56'!
test02XPlayMustBeTheOnlyPlayInGameWhenXMakeTheFirstPlay
	| game |
	game _ TicTacToe start.
	game playXAt: 1 @ 1.
	self
		assertPlayerPlays: game Xs
		expectsToOnlyHave: (OrderedCollection with: 1 @ 1).
	self assert: game Os isEmpty.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 21:24:59'!
test02_01OCannotStart
	| game |
	game _ TicTacToe start.
	self
		should: [ game playOAt: 2 @ 2 ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe notOTurnErrorMessage
				equals: anError messageText.
			self assert: game isEmpty. ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:16:35'!
test03XAndOPlaysMustBeRegisteredAndNoOtherPlays
	| game |
	game _ TicTacToe start.
	game playXAt: 1 @ 1.
	game playOAt: 2 @ 2.
	self
		assertPlayerPlays: game Xs
		expectsToOnlyHave: (OrderedCollection with: 1 @ 1).
	self
		assertPlayerPlays: game Os
		expectsToOnlyHave: (OrderedCollection with: 2 @ 2).! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:25:54'!
test04ShouldRaiseErrorWhenXTriesToPlayTwiceInARow
	| game |
	game _ TicTacToe start.
	game playXAt: 1 @ 1.
	self
		should: [ game playXAt: 2 @ 2 ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe notXTurnErrorMessage
				equals: anError messageText.
			self
				assertPlayerPlays: game Xs
				expectsToOnlyHave: (OrderedCollection with: 1 @ 1).
			self assert: game Os isEmpty ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:33:00'!
test05ShouldRaiseErrorWhenOTriesToPlayTwiceInARow
	| game |
	game _ TicTacToe start.
	game playXAt: 1 @ 1.
	game playOAt: 2 @ 2.
	self
		should: [ game playOAt: 3 @ 3 ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe notOTurnErrorMessage
				equals: anError messageText.
			self
				assertPlayerPlays: game Xs
				expectsToOnlyHave: (OrderedCollection with: 1 @ 1).
			self
				assertPlayerPlays: game Os
				expectsToOnlyHave: (OrderedCollection with: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:33:17'!
test06ShouldRaiseErrorWhenXTriesToPutInAPositionTakenByHim
	| game |
	game _ TicTacToe start.
	game playXAt: 1 @ 1.
	game playOAt: 2 @ 2.
	self
		should: [ game playXAt: 1 @ 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe positionTakenErrorMessage
				equals: anError messageText.
			self
				assertPlayerPlays: game Xs
				expectsToOnlyHave: (OrderedCollection with: 1 @ 1).
			self
				assertPlayerPlays: game Os
				expectsToOnlyHave: (OrderedCollection with: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:34:06'!
test07ShouldRaiseErrorWhenXTriesToPutInAPositionTakenByO
	| game |
	game _ TicTacToe start.
	game playXAt: 1 @ 1.
	game playOAt: 2 @ 2.
	self
		should: [ game playXAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe positionTakenErrorMessage
				equals: anError messageText.
			self
				assertPlayerPlays: game Xs
				expectsToOnlyHave: (OrderedCollection with: 1 @ 1).
			self
				assertPlayerPlays: game Os
				expectsToOnlyHave: (OrderedCollection with: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:34:20'!
test08ShouldRaiseErrorWhenOTriesToPutInAPositionTakenByX
	| game |
	game _ TicTacToe start.
	game playXAt: 1 @ 1.
	self
		should: [ game playOAt: 1 @ 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe positionTakenErrorMessage
				equals: anError messageText.
			self
				assertPlayerPlays: game Xs
				expectsToOnlyHave: (OrderedCollection with: 1 @ 1).
			self assert: game Os isEmpty ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:39:55'!
test09ShouldRaiseErrorWhenOTriesToPutInAPositionTakenByHim
	| game |
	game _ TicTacToe start.
	game playXAt: 1 @ 1.
	game playOAt: 2 @ 2.
	game playXAt: 3 @ 3.
	self
		should: [ game playOAt: 2 @ 2 ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe positionTakenErrorMessage
				equals: anError messageText.
			self
				assertPlayerPlays: game Xs
				expectsToOnlyHave:
					(OrderedCollection
						with: 1 @ 1
						with: 3 @ 3).
			self
				assertPlayerPlays: game Os
				expectsToOnlyHave: (OrderedCollection with: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:54:11'!
test10NoPlayerHasWonIfThereIsNotThreeOfTheSameInLine
	| game |
	game _ self playedInTurns:
		(Array
			with: 1 @ 1
			with: 2 @ 1
			with: 2 @ 2
			with: 3 @ 3).
	self deny: game oHasWon.
	self deny: game xHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:54:11'!
test11XHasWonWhenHePutThreeInTheUpperRow
	| game |
	game _ self playedInTurns:
		(Array
			with: 1 @ 1
			with: 2 @ 1
			with: 1 @ 2
			with: 3 @ 3
			with: 1 @ 3).
	self assert: game xHasWon.
	self deny: game oHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:54:11'!
test12XHasWonWhenHePutThreeInTheMiddleColumn
	| game |
	game _ self playedInTurns:
		(Array
			with: 2 @ 1
			with: 1 @ 1
			with: 2 @ 2
			with: 3 @ 1
			with: 2 @ 3).
	self assert: game xHasWon.
	self deny: game oHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:54:11'!
test13XHasWonWhenHePutThreeInTheLowerRow
	| game |
	game _ self playedInTurns:
		(Array
			with: 3 @ 1
			with: 1 @ 1
			with: 3 @ 2
			with: 2 @ 1
			with: 3 @ 3).
	self assert: game xHasWon.
	self deny: game oHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:54:11'!
test14XHasWonWhenHePutThreeInTheLeftColumn
	| game |
	game _ self playedInTurns:
		(Array
			with: 1 @ 1
			with: 2 @ 2
			with: 2 @ 1
			with: 3 @ 3
			with: 3 @ 1).
	self assert: game xHasWon.
	self deny: game oHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:54:11'!
test15XHasWonWhenHePutThreeInTheDownDiagonal
	| game |
	game _ self playedInTurns:
		(Array
			with: 1 @ 1
			with: 2 @ 1
			with: 2 @ 2
			with: 2 @ 3
			with: 3 @ 3).
	self assert: game xHasWon.
	self deny: game oHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:54:11'!
test16XHasWonWhenHePutThreeInTheUpDiagonal
	| game |
	game _ self playedInTurns:
		(Array
			with: 3 @ 1
			with: 2 @ 1
			with: 2 @ 2
			with: 1 @ 2
			with: 1 @ 3).
	self assert: game xHasWon.
	self deny: game oHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:54:11'!
test17OHasWonWhenHePutThreeInTheUpperRow
	| game |
	game _ self playedInTurns:
		(Array
			with: 3 @ 1
			with: 1 @ 1
			with: 2 @ 2
			with: 1 @ 2
			with: 3 @ 3
			with: 1 @ 3).
	self assert: game oHasWon.
	self deny: game xHasWon.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:01:11'!
test18ShouldRaiseErrorWhenOTriesToPlayAndTheGameWasAlreadyOver
	| game |
	game _ self playedInTurns: (Array with: 1 @ 1 with: 2 @ 1 with: 1 @ 2 with: 3 @ 1 with: 1 @ 3).
	self
		should: [ game playOAt: 3 @ 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage
				equals: anError messageText.
			self 
				assertPlayerPlays: game Os
				expectsToOnlyHave: (OrderedCollection with: 2 @ 1 with: 3 @ 1). ].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:16:19'!
test19ShouldRaiseErrorWhenXTriesToPlayAndTheGameWasAlreadyOver
	| game |
	game _ self playedInTurns: (Array with: 2 @ 2 with: 1 @ 1 with: 2 @ 1 with: 1 @ 2 with: 3 @ 1 with: 1 @ 3).
	self
		should: [ game playXAt: 3 @ 2 ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage
				equals: anError messageText.
			self
				assertPlayerPlays: game Xs
				expectsToOnlyHave: (OrderedCollection with: 2@2 with: 2@1 with: 3@1).].! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:20:36'!
test20GameMustBeTiedWhenGameIsOverAndNoOneHasWon
	| game |
	game _ TicTacToe start.
	game playXAt: 2 @ 2.
	game playOAt: 1 @ 1.
	game playXAt: 1 @ 3.
	game playOAt: 3 @ 1.
	game playXAt: 2 @ 1.
	game playOAt: 2 @ 3.
	game playXAt: 1 @ 2.
	game playOAt: 3 @ 2.
	game playXAt: 3 @ 3.
	self assert: game isOver.
	self deny: game xHasWon.
	self deny: game oHasWon.
	self assert: game isTied.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:20:46'!
test21GameIsOverAndNotTiedWhenXHasWon
	| game |
	game _ TicTacToe start.
	game playXAt: 2 @ 2.
	game playOAt: 1 @ 2.
	game playXAt: 1 @ 1.
	game playOAt: 2 @ 1.
	game playXAt: 1 @ 3.
	game playOAt: 2 @ 3.
	game playXAt: 3 @ 2.
	game playOAt: 3 @ 1.
	game playXAt: 3 @ 3.
	self assert: game isOver.
	self assert: game xHasWon.
	self deny: game oHasWon.
	self deny: game isTied.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:25:12'!
test22GameIsOverAndNotTiedWhenOHasWon
	| game |
	game _ self playedInTurns: (Array with: 2 @ 2 with: 3 @ 3 with: 1 @ 2 with: 3 @ 2 with: 1 @ 1 with: 3 @ 1).
	self assert: game isOver.
	self deny: game xHasWon.
	self assert: game oHasWon.
	self deny: game isTied.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:25:25'!
test23XIsPlayingWhenGameStarts
	| game |
	game _ TicTacToe start.
	self assert: game isPlayingX.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:27:40'!
test24OIsPlayingWhenAfterXPlays
	| game |
	game _ TicTacToe start.
	game playXAt: 2 @ 2.
	self deny: game isPlayingX.
	self assert: game isPlayingO.! !


!classDefinition: #TicTacToe category: #TicTacToStep21!
Object subclass: #TicTacToe
	instanceVariableNames: 'state xs os'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:51:41'!
checkIfTied
	^ xs size = 5 and: [ os size = 4 and: [ self xHasWon not ]	].! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 12:51:23'!
hasCompletedColumn: positions
	
	^ (1 to: 3) anySatisfy: [ :y | (positions count: [ :position | position y = y ]) = 3 ]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 12:36:01'!
hasCompletedRow: positions

	^ (1 to: 3) anySatisfy: [ :x | (positions count: [ :posicion | posicion x = x ]) = 3 ]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 12:56:21'!
hasDownDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@n ]
! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 13:02:13'!
hasUpDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:43:04'!
hasWon: positions
	^ (self hasCompletedRow: positions) or: [
		(self hasCompletedColumn: positions) or: [
			(self hasDownDiagonal: positions) or: [ self hasUpDiagonal: positions ]]].! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 19:37:44'!
isEmpty
	^os isEmpty and: xs isEmpty.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:38:07'!
isOver
	^ state isOver.! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:29:57'!
isPlayingO
	^ state isPlayingO! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:29:55'!
isPlayingX
	^ state isPlayingX! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:52:04'!
isTied
	^ state isTied! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:59:01'!
oHasWon
	^ state oHasWon .! !

!TicTacToe methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:54:11'!
xHasWon
	^ state xHasWon.! !


!TicTacToe methodsFor: 'testing' stamp: 'jg 5/22/2018 10:01:34'!
Os

	^os copy.! !

!TicTacToe methodsFor: 'testing' stamp: 'jg 5/22/2018 10:01:25'!
Xs

	^xs copy.! !


!TicTacToe methodsFor: 'playing' stamp: 'KFG 5/31/2018 00:53:27'!
playOAt: aPosition
	state
		playOAt: aPosition
		inGame: self.
	(self hasWon: os)
		ifTrue: [ state _ TTTOWon new ]
		ifFalse: [ 
			self checkIfTied
				ifTrue: [ state _ TTTTied new ]
				ifFalse: [ state _ TTTXTurn new ].
		]! !

!TicTacToe methodsFor: 'playing' stamp: 'KFG 5/31/2018 00:53:34'!
playXAt: aPosition
	state
		playXAt: aPosition
		inGame: self.
	(self hasWon: xs)
		ifTrue: [ state _ TTTXWon new ]
		ifFalse:  [ 
			self checkIfTied 
				ifTrue: [ state _ TTTTied new ]
				ifFalse: [ state _ TTTOTurn new ].
		]! !


!TicTacToe methodsFor: 'initialization' stamp: 'KFG 5/30/2018 21:20:06'!
start
	
	xs:= Set new.
	os:= Set new.
	state := TTTXTurn new.! !


!TicTacToe methodsFor: 'modifying' stamp: 'KFG 5/30/2018 23:24:28'!
insertOAt: aPosition
	
	^os add: aPosition! !

!TicTacToe methodsFor: 'modifying' stamp: 'KFG 5/30/2018 21:22:17'!
insertXAt: aPosition
	
	^xs add: aPosition! !


!TicTacToe methodsFor: 'validation' stamp: 'KFG 5/31/2018 00:07:27'!
validateForPosition: aPosition

	(xs includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
	(os includes: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToStep21!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 13:15:31'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'MM 5/30/2018 02:23:14'!
notOTurnErrorMessage

	^'Not O turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 10:26:38'!
notXTurnErrorMessage

	^'Not X turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 11:20:12'!
positionTakenErrorMessage
	
	^'Position taken'! !


!TicTacToe class methodsFor: 'class initialization' stamp: 'KFG 5/30/2018 20:51:22'!
start
	
	^self new start! !


!classDefinition: #TicTacToeState category: #TicTacToStep21!
Object subclass: #TicTacToeState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TicTacToeState methodsFor: 'playing' stamp: 'KFG 5/30/2018 21:26:33'!
playOAt: aPosition inGame: aTicTacToeGame

	^ self subclassResponsibility ! !

!TicTacToeState methodsFor: 'playing' stamp: 'KFG 5/30/2018 21:19:03'!
playXAt: aPosition inGame: aTicTacToeGame
	^ self subclassResponsibility.! !


!TicTacToeState methodsFor: 'evaluating' stamp: 'KFG 5/30/2018 20:54:32'!
isOver

	^ self subclassResponsibility ! !

!TicTacToeState methodsFor: 'evaluating' stamp: 'KFG 5/31/2018 00:35:23'!
isPlayingO

	^ self subclassResponsibility ! !

!TicTacToeState methodsFor: 'evaluating' stamp: 'KFG 5/31/2018 00:34:41'!
isPlayingX

	^ self subclassResponsibility ! !

!TicTacToeState methodsFor: 'evaluating' stamp: 'KFG 5/30/2018 20:55:31'!
isTied

	^ self subclassResponsibility ! !

!TicTacToeState methodsFor: 'evaluating' stamp: 'KFG 5/30/2018 23:53:49'!
oHasWon
	^ self subclassResponsibility.! !

!TicTacToeState methodsFor: 'evaluating' stamp: 'KFG 5/30/2018 23:54:11'!
xHasWon
	^ self subclassResponsibility.! !


!classDefinition: #TTTOTurn category: #TicTacToStep21!
TicTacToeState subclass: #TTTOTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TTTOTurn methodsFor: 'playing' stamp: 'KFG 5/31/2018 00:08:59'!
playOAt: aPosition inGame: aTicTacToeGame

	aTicTacToeGame validateForPosition: aPosition.
	aTicTacToeGame insertOAt: aPosition! !

!TTTOTurn methodsFor: 'playing' stamp: 'KFG 5/30/2018 23:25:40'!
playXAt: aPosition inGame: aTicTacToeGame

	^ self error: aTicTacToeGame class notXTurnErrorMessage! !


!TTTOTurn methodsFor: 'evaluating' stamp: 'KFG 5/30/2018 20:58:58'!
isOver

	^ false! !

!TTTOTurn methodsFor: 'evaluating' stamp: 'KFG 5/31/2018 00:36:06'!
isPlayingO
	^ true.! !

!TTTOTurn methodsFor: 'evaluating' stamp: 'KFG 5/31/2018 00:36:02'!
isPlayingX
	^ false.! !

!TTTOTurn methodsFor: 'evaluating' stamp: 'KFG 5/30/2018 20:59:01'!
isTied

	^ false! !

!TTTOTurn methodsFor: 'evaluating' stamp: 'KFG 5/30/2018 23:53:49'!
oHasWon
	^ false.! !

!TTTOTurn methodsFor: 'evaluating' stamp: 'KFG 5/30/2018 23:54:11'!
xHasWon
	^ false.! !


!classDefinition: #TTTOver category: #TicTacToStep21!
TicTacToeState subclass: #TTTOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TTTOver methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:55:02'!
isOver

	^ true! !

!TTTOver methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:35:46'!
isPlayingO

	^ false! !

!TTTOver methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:35:44'!
isPlayingX

	^ false! !

!TTTOver methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:13:42'!
playOAt: aPosition inGame: aTicTacToeGame

	^ self error: aTicTacToeGame class canNotPlayWhenGameIsOverErrorMessage! !

!TTTOver methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:13:46'!
playXAt: aPosition inGame: aTicTacToeGame

	^ self error: aTicTacToeGame class canNotPlayWhenGameIsOverErrorMessage! !


!classDefinition: #TTTOWon category: #TicTacToStep21!
TTTOver subclass: #TTTOWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TTTOWon methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:59:44'!
isTied

	^ false! !

!TTTOWon methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:59:56'!
oHasWon

	^ true! !

!TTTOWon methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:59:50'!
xHasWon

	^ false! !


!classDefinition: #TTTTied category: #TicTacToStep21!
TTTOver subclass: #TTTTied
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TTTTied methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:47:42'!
isTied
	
	^ true! !

!TTTTied methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:47:29'!
oHasWon
	
	^ false! !

!TTTTied methodsFor: 'as yet unclassified' stamp: 'KFG 5/31/2018 00:47:27'!
xHasWon
	
	^ false! !


!classDefinition: #TTTXWon category: #TicTacToStep21!
TTTOver subclass: #TTTXWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TTTXWon methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:55:15'!
isTied

	^ false! !

!TTTXWon methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:55:50'!
oHasWon

	^ false! !

!TTTXWon methodsFor: 'as yet unclassified' stamp: 'KFG 5/30/2018 23:55:55'!
xHasWon

	^ true! !


!classDefinition: #TTTXTurn category: #TicTacToStep21!
TicTacToeState subclass: #TTTXTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToStep21'!

!TTTXTurn methodsFor: 'playing' stamp: 'KFG 5/30/2018 23:16:04'!
playOAt: aPosition inGame: aTicTacToeGame
	
	^ self error: aTicTacToeGame class notOTurnErrorMessage ! !

!TTTXTurn methodsFor: 'playing' stamp: 'KFG 5/31/2018 00:07:08'!
playXAt: aPosition inGame: aTicTacToeGame

	aTicTacToeGame validateForPosition: aPosition.
	aTicTacToeGame insertXAt: aPosition.! !


!TTTXTurn methodsFor: 'evaluating' stamp: 'KFG 5/30/2018 20:56:14'!
isOver

	^ false! !

!TTTXTurn methodsFor: 'evaluating' stamp: 'KFG 5/31/2018 00:36:19'!
isPlayingO
	^ false.! !

!TTTXTurn methodsFor: 'evaluating' stamp: 'KFG 5/31/2018 00:36:23'!
isPlayingX
	^ true.! !

!TTTXTurn methodsFor: 'evaluating' stamp: 'KFG 5/30/2018 20:56:19'!
isTied

	^ false! !

!TTTXTurn methodsFor: 'evaluating' stamp: 'KFG 5/30/2018 23:53:49'!
oHasWon
	^ false.! !

!TTTXTurn methodsFor: 'evaluating' stamp: 'KFG 5/30/2018 23:54:11'!
xHasWon
	^ false.! !
