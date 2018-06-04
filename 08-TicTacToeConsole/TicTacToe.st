!classDefinition: #TicTacToeTest category: #TicTacToe!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 10/27/2017 17:25:54'!
functionalException

	^Error - MessageNotUnderstood! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 10/26/2017 15:10:54'!
test01GameStartsWithAnEmptyBoarAndPlayingX

	"I initialize it on each test and not in the setUp to facilitate the restar of the test - Hernan"
	
	game _ TicTacToe new.

	self assertXIsMarkedOn: {} andOOn: {}.
	self assertIsPlayingX.
	
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:35'!
test02AfterMarkingWithXGameKeepsMarkAndNextPlayerIsO

	game _ TicTacToe new.
	
	game markAll: {1@1}.

	self assertXIsMarkedOn: {1@1} andOOn: {}.
	self assertIsPlayingO

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:31'!
test03AfterMarkingWithOGameKeepsMarkAndNextPlayerIsY

	game _ TicTacToe new.

	game markAll: { 1 @ 1. 2 @ 2 }.

	self assertXIsMarkedOn: {1@1} andOOn: {2@2}.
	self assertIsPlayingX.

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:28'!
test04CanNotMarkWithXWhenLastMarkWasX

	game _ TicTacToe new.
	
	game markAll: { 1@1 }.

	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:23'!
test05CanNotMarkWithOWhenLastMarkWasO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithOAt: 3 @ 3 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:19'!
test06CanNotMarkWithXAnAlreadyMarkedPositionWithX

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithXAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:16'!
test07CanNotMarkWithXAnAlreadyMarkedPositionWithO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:12'!
test08CanNotMarkWithOAnAlreadyMarkedPositionWithX

	game _ TicTacToe new.
	
	game markAll: { 1@1 }.
	
	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:08'!
test09CanNotMarkWithOAnAlreadyMarkedPositionWithO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2. 3@3 }.

	self
		should: [ game markWithOAt: 2 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1. 3@3} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:04'!
test10XWinsWhenCompletesRowNumber1

	game _ TicTacToe new.

	game markAll: {1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self assertXWon.
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:59'!
test11XWinsWhenCompletesRowNumber2

	game _ TicTacToe new.

	game markAll: {2@1. 1@1. 2@2. 3@1. 2@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:54'!
test12XWinsWhenCompletesRowNumber3

	game _ TicTacToe new.

	game markAll: {3@1. 1@1. 3@2. 2@1. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:50'!
test13XWinsWhenCompletesAColumn

	game _ TicTacToe new.

	game markAll: { 1@1. 2@2. 1@2. 3@3. 1@3}.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:45'!
test14XWinsWhenCompletesDiagonalGoingDown

	game _ TicTacToe new.

	game markAll: { 1@1. 1@2. 2@2. 1@3. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:41'!
test15XWinsWhenCompletesDiagonalGoingUp

	game _ TicTacToe new.

	game markAll: { 1@3. 1@2. 2@2. 2@1. 3@ 1 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:35'!
test16OWinsWhenCompletesARow

	game _ TicTacToe new.

	game markAll: {2@1. 1@1. 2@2. 1@2. 3@1. 1@3 }.

	self assertOWon! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:31'!
test17OWinsWhenCompletesAColumn

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 3@3. 1@2. 2@3. 1@3 }.

	self assertOWon! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:25'!
test18OWinsWhenCompletesDiagonalGoingDown

	game _ TicTacToe new.

	game markAll: { 3@2. 1@3. 1@2. 2@2. 1@1. 3@1 }.

	self assertOWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:20'!
test19OWinsWhenCompletesDiagonalGoingUp

	game _ TicTacToe new.

	game markAll: {1@2. 1@1. 1@3. 2@2. 2@1. 3@3 }.

	self assertOWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:15'!
test20OCanNotPlayWhenXWon

	game _ TicTacToe new.

	game markAll: { 1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self
		should: [ game markWithOAt: 3 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertOIsMarkedOn: {2@1. 3@1} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:12'!
test21XCanNotPlayWhenOWon

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 2@1. 1@2. 3@1. 1@3 }.

	self
		should: [ game markWithXAt: 3 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: { 2@2. 2@1. 3@1 } ]
		! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:08'!
test22GameCanEndUpTied

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	self assertGameIsTied! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:01'!
test23XCanWinOnLastEmptyPosition

	game _ TicTacToe new.

	game markAll: { 2@2. 1@2. 1@1. 2@1. 1@3. 2@3. 3@2. 3@1. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:41:58'!
test24CanNotPlayWhenGameIsTied

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'JG 5/12/2018 13:23:11'!
test25CanNotMarkOutsideBoard

	game _ TicTacToe new.

	#(0 4) do: [ :aPositionComponent |
		self assertCanNotMarkAt: aPositionComponent @ 1.
		self assertCanNotMarkAt: 1 @ aPositionComponent ].
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:49:43'!
test26OCanNotMarkWhenGameIsOver

	game _ TicTacToe new.

	game markAll: { 1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self
		should: [ game markAt: 3 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertOIsMarkedOn: {2@1. 3@1} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MM 6/2/2018 17:58:13'!
test27TicTacToeAcceptsAObserver

	| testObserver |
	game _ TicTacToe new.
	testObserver := TestObserver new.
	game addObserver: testObserver.
	
	self assert: testObserver notifications isEmpty! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MM 6/4/2018 15:44:58'!
test28WhenXPlaysAnObserverIsNotified
	| testObserver |
	game _ TicTacToe new.
	testObserver _ TestObserver new.
	game addObserver: testObserver.
	game markAll:
		{2 @ 2}.
	self
		assertNotificationsEquals:
			{'X marcó en 2@2'. 'Estado: Jugando O'}
		onObserver: testObserver.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MM 6/4/2018 15:44:58'!
test29WhenOPlaysAnObserverIsNotified
	| testObserver |
	game _ TicTacToe new.
	testObserver _ TestObserver new.
	game addObserver: testObserver.
	game markAll:
		{2 @ 2. 1 @ 1}.
	self
		assertNotificationsEquals:
			{'X marcó en 2@2'. 'Estado: Jugando O'. 'O marcó en 1@1'. 'Estado: Jugando X'}
		onObserver: testObserver.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MM 6/4/2018 15:44:58'!
test30ObserverIsNotNotifiedWhenAnErrorIsRaised
	| testObserver |
	game _ TicTacToe new.
	testObserver _ TestObserver new.
	game addObserver: testObserver.
	game markAll:
		{1 @ 1}.
	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe notXTurnErrorMessage
				equals: anError messageText.
			self
				assertXIsMarkedOn:
					{1 @ 1}
				andOOn:
					{}.
			self
				assertNotificationsEquals:
					{'X marcó en 1@1'. 'Estado: Jugando O'}
				onObserver: testObserver ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MM 6/4/2018 15:44:58'!
test31ObserverShowsXWonAfterXWins
	| testObserver |
	game _ TicTacToe new.
	testObserver _ TestObserver new.
	game addObserver: testObserver.
	game markAll:
		{1 @ 1. 2 @ 1. 1 @ 2. 3 @ 1. 1 @ 3}.
	self assertXWon.
	self
		assertNotificationsEquals:
			{'X marcó en 1@1'. 'Estado: Jugando O'. 'O marcó en 2@1'. 'Estado: Jugando X'. 'X marcó en 1@2'. 'Estado: Jugando O'. 'O marcó en 3@1'. 'Estado: Jugando X'. 'X marcó en 1@3'. 'Estado: Juego terminado - Ganó X!!'}
		onObserver: testObserver.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MM 6/4/2018 15:44:58'!
test32ObserverShowsOWonAfterOWins
	| testObserver |
	game _ TicTacToe new.
	testObserver _ TestObserver new.
	game addObserver: testObserver.
	game markAll:
		{2 @ 1. 1 @ 1. 2 @ 2. 1 @ 2. 3 @ 1. 1 @ 3}.
	self assertOWon.
	self
		assertNotificationsEquals:
			{'X marcó en 2@1'. 'Estado: Jugando O'. 'O marcó en 1@1'. 'Estado: Jugando X'. 'X marcó en 2@2'. 'Estado: Jugando O'. 'O marcó en 1@2'. 'Estado: Jugando X'. 'X marcó en 3@1'. 'Estado: Jugando O'. 'O marcó en 1@3'. 'Estado: Juego terminado - Ganó O!!'}
		onObserver: testObserver.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MM 6/4/2018 15:44:58'!
test33ObserverShowsGameIsTiedAfterPlayersTie
	| testObserver |
	game _ TicTacToe new.
	testObserver _ TestObserver new.
	game addObserver: testObserver.
	game markAll:
		{2 @ 2. 1 @ 1. 1 @ 3. 3 @ 1. 2 @ 1. 2 @ 3. 1 @ 2. 3 @ 2. 3 @ 3}.
	self assertGameIsTied.
	self
		assertNotificationsEquals:
			{'X marcó en 2@2'. 'Estado: Jugando O'. 'O marcó en 1@1'. 'Estado: Jugando X'. 'X marcó en 1@3'. 'Estado: Jugando O'. 'O marcó en 3@1'. 'Estado: Jugando X'. 'X marcó en 2@1'. 'Estado: Jugando O'. 'O marcó en 2@3'. 'Estado: Jugando X'. 'X marcó en 1@2'. 'Estado: Jugando O'. 'O marcó en 3@2'. 'Estado: Jugando X'. 'X marcó en 3@3'. 'Estado: Juego terminado - Empate'}
		onObserver: testObserver.! !

!TicTacToeTest methodsFor: 'testing' stamp: 'KFG 6/4/2018 02:14:21'!
test34TicTacToeConsolePrintsStatusAfterXPlays
	| console aStream |
	game _ TicTacToe new.
	aStream := ReadWriteStream with: String new.
	console := TicTacToeConsole printingOn: aStream.
	game addObserver: console.
	
	game markAll: { 2@2. }.
	self assert: '''X marcó en 2@2''''Estado: Jugando O''' equals: aStream contents.
! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MM 6/4/2018 13:31:43'!
test35TicTacToeConsolePrintsStatusAfterOPlays
	| console aStream |
	game _ TicTacToe new.
	aStream := ReadWriteStream with: String new.
	console := TicTacToeConsole printingOn: aStream.
	game addObserver: console.
	
	game markAll: { 2@2. 1@1. }.
	self assert: '''X marcó en 2@2''''Estado: Jugando O''''O marcó en 1@1''''Estado: Jugando X''' equals: aStream contents.
! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MM 6/4/2018 14:26:29'!
test36TicTacToeConsolePrintsStatusAfterXWins
	| console aStream |
	game _ TicTacToe new.
	aStream := ReadWriteStream with: String new.
	console := TicTacToeConsole printingOn: aStream.
	game addObserver: console.
	
	game markAll: {1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self assert: '''X marcó en 1@1''''Estado: Jugando O''''O marcó en 2@1''''Estado: Jugando X''''X marcó en 1@2''''Estado: Jugando O''''O marcó en 3@1''''Estado: Jugando X''''X marcó en 1@3''''Estado: Juego terminado - Ganó X!!''' equals: aStream contents.
! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MM 6/4/2018 14:28:58'!
test37TicTacToeConsolePrintsStatusAfterOWins
	| console aStream |
	game _ TicTacToe new.
	aStream := ReadWriteStream with: String new.
	console := TicTacToeConsole printingOn: aStream.
	game addObserver: console.
	
	game markAll: {2@1. 1@1. 2@2. 1@2. 3@1. 1@3 }.
	
	self assert: '''X marcó en 2@1''''Estado: Jugando O''''O marcó en 1@1''''Estado: Jugando X''''X marcó en 2@2''''Estado: Jugando O''''O marcó en 1@2''''Estado: Jugando X''''X marcó en 3@1''''Estado: Jugando O''''O marcó en 1@3''''Estado: Juego terminado - Ganó O!!''' equals: aStream contents.
! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MM 6/4/2018 14:32:05'!
test38TicTacToeConsolePrintsStatusAfterGameIsTied
	| console aStream |
	game _ TicTacToe new.
	aStream := ReadWriteStream with: String new.
	console := TicTacToeConsole printingOn: aStream.
	game addObserver: console.
	
	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.
	
	self assert: '''X marcó en 2@2''''Estado: Jugando O''''O marcó en 1@1''''Estado: Jugando X''''X marcó en 1@3''''Estado: Jugando O''''O marcó en 3@1''''Estado: Jugando X''''X marcó en 2@1''''Estado: Jugando O''''O marcó en 2@3''''Estado: Jugando X''''X marcó en 1@2''''Estado: Jugando O''''O marcó en 3@2''''Estado: Jugando X''''X marcó en 3@3''''Estado: Juego terminado - Empate''' equals: aStream contents.
! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MM 6/4/2018 15:59:13'!
test39TicTacToeViewPrintsStatusAfterXPlays
	| view aStream |
	game _ TicTacToe new.
	aStream := ReadWriteStream with: String new.
	view := TicTacToeView printingOn: aStream.
	game addObserver: view.
	
	game markAll: {2@2}.
	
	self assert: 'X' equals: (view board x: 2 y: 2 ).! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MM 6/4/2018 15:57:54'!
test40TicTacToeViewPrintsStatusAfterOPlays
	| view aStream |
	game _ TicTacToe new.
	aStream := ReadWriteStream with: String new.
	view := TicTacToeView printingOn: aStream.
	game addObserver: view.
	
	game markAll: {2@2. 1@1}.
	
	self assert: 'X' equals: (view board x: 2 y: 2 ).
	self assert: 'O' equals: (view board x: 1 y: 1 ).! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MM 6/4/2018 15:58:30'!
test41TicTacToeViewPrintsStatusAfterXWins
	| view aStream |
	game _ TicTacToe new.
	aStream := ReadWriteStream with: String new.
	view := TicTacToeView printingOn: aStream.
	game addObserver: view.
	
	game markAll: {1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self assert: 'X' equals: (view board x: 1 y: 1 ).
	self assert: 'O' equals: (view board x: 2 y: 1 ).
	self assert: 'X' equals: (view board x: 1 y: 2 ).
	self assert: 'O' equals: (view board x: 3 y: 1 ).
	self assert: 'X' equals: (view board x: 1 y: 3 ).

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MM 6/4/2018 15:59:55'!
test42TicTacToeViewPrintsStatusAfterOWins
	| view aStream |
	game _ TicTacToe new.
	aStream := ReadWriteStream with: String new.
	view := TicTacToeView printingOn: aStream.
	game addObserver: view.
	
	game markAll: {2@1. 1@1. 2@2. 1@2. 3@1. 1@3 }.
	
	self assert: 'X' equals: (view board x: 2 y: 1 ).
	self assert: 'O' equals: (view board x: 1 y: 1 ).
	self assert: 'X' equals: (view board x: 2 y: 2 ).
	self assert: 'O' equals: (view board x: 1 y: 2 ).
	self assert: 'X' equals: (view board x: 3 y: 1 ).
	self assert: 'O' equals: (view board x: 1 y: 3 ).
! !

!TicTacToeTest methodsFor: 'testing' stamp: 'MM 6/4/2018 16:01:25'!
test43TicTacToeViewPrintsStatusGameIsTied
	| view aStream |
	game _ TicTacToe new.
	aStream := ReadWriteStream with: String new.
	view := TicTacToeView printingOn: aStream.
	game addObserver: view.
	
	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.
	
	self assert: 'X' equals: (view board x: 2 y: 2 ).
	self assert: 'O' equals: (view board x: 1 y: 1 ).
	self assert: 'X' equals: (view board x: 1 y: 3 ).
	self assert: 'O' equals: (view board x: 3 y: 1 ).
	self assert: 'X' equals: (view board x: 2 y: 1 ).
	self assert: 'O' equals: (view board x: 2 y: 3 ).
	self assert: 'X' equals: (view board x: 1 y: 2 ).
	self assert: 'O' equals: (view board x: 3 y: 2 ).
	self assert: 'X' equals: (view board x: 3 y: 3 ).	! !


!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/27/2017 10:29:06'!
assertCanNotMarkAt: aPosition

	self assertCanNotMarkUsing: [ game markWithXAt: aPosition ].
	self assertCanNotMarkUsing: [ game markWithOAt: aPosition ].
	
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/27/2017 10:29:29'!
assertCanNotMarkUsing: aMarkingClosure

	self
		should: aMarkingClosure 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionOutsideBoardErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:11:14'!
assertGameIsNotOver

	self deny: game isOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:23:48'!
assertGameIsOver
	
	self assert: game isOver.

	self deny: game isPlayingX.
	self deny: game isPlayingO.
		
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:40:41'!
assertGameIsTied

	self assertGameIsOver.
	
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self assert: game isTied.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:13:05'!
assertIsPlayingO
	
	self deny: game isPlayingX.
	self assert: game isPlayingO.
	self assertGameIsNotOver ! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:11:05'!
assertIsPlayingX
		
	self assert: game isPlayingX.
	self deny: game isPlayingO.
	self assertGameIsNotOver.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'MM 6/4/2018 15:44:58'!
assertNotificationsEquals: notifications onObserver: anObserver
	self
		assert: notifications size
		equals: anObserver notifications size.
	notifications withIndexDo: [ :notification :index |
		self
			assert: notification
			equals: (anObserver notifications at: index) ].! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:38:07'!
assertOIsMarkedOn: oPositions
		
	self assert: oPositions size equals: game playerOPositions size.
	self assert: (game playerOPositions difference: oPositions) isEmpty.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:32:18'!
assertOWon

	self assertGameIsOver.
	
	self deny: game hasPlayerXWon.
	self assert: game hasPlayerOWon.
	self deny: game isTied.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:37:56'!
assertXIsMarkedOn: xPositions

	self assert: xPositions size equals: game playerXPositions size.
	self assert: (game playerXPositions difference: xPositions) isEmpty.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:37:44'!
assertXIsMarkedOn: xPositions andOOn: oPositions
 
	self assertXIsMarkedOn: xPositions.
	self assertOIsMarkedOn: oPositions.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:23:30'!
assertXWon
	
	self assertGameIsOver.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.
! !


!classDefinition: #TestObserver category: #TicTacToe!
Object subclass: #TestObserver
	instanceVariableNames: 'notifications'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TestObserver methodsFor: 'accessing' stamp: 'MM 6/2/2018 18:09:38'!
initialize
	notifications := OrderedCollection new.! !

!TestObserver methodsFor: 'accessing' stamp: 'MM 6/2/2018 18:08:53'!
notifications
	^notifications! !


!TestObserver methodsFor: 'events-registering' stamp: 'MM 6/2/2018 21:04:00'!
oIsPlaying
	notifications add: 'Estado: Jugando O'.! !

!TestObserver methodsFor: 'events-registering' stamp: 'KFG 6/4/2018 00:56:08'!
oPlayedAt: aPosition 
	notifications add: ('O marcó en ' append: aPosition asString )! !

!TestObserver methodsFor: 'events-registering' stamp: 'KFG 6/4/2018 00:49:05'!
stateUpdatedTo: aTicTacToeState
	notifications add: (aTicTacToeState printOn: 'Estado: ').! !

!TestObserver methodsFor: 'events-registering' stamp: 'MM 6/3/2018 19:09:14'!
xIsPlaying
	notifications add: 'Estado: Jugando X'.! !

!TestObserver methodsFor: 'events-registering' stamp: 'MM 6/2/2018 20:05:39'!
xPlayedAt: aPosition 
	notifications add: ('X marcó en ' append: aPosition asString )! !


!classDefinition: #TicTacToe category: #TicTacToe!
Object subclass: #TicTacToe
	instanceVariableNames: 'state playerOPositions playerXPositions observer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToe methodsFor: 'initialization' stamp: 'MM 6/2/2018 18:02:04'!
initialize
	playerXPositions _ OrderedCollection new.
	playerOPositions _ OrderedCollection new.
	state _ PlayingX for: self.
	observer := TicTacToeObserver new.! !


!TicTacToe methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:39'!
markAll: positions

	positions do: [ :aPosition | self markAt: aPosition ]! !

!TicTacToe methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:23'!
markAt: aPosition

	^state markAt: aPosition ! !

!TicTacToe methodsFor: 'marking board' stamp: 'HAW 10/27/2017 10:30:17'!
markWithOAt: aPosition

	self assertIsInBoardBounds: aPosition.
	
	state markWithOAt: aPosition.! !

!TicTacToe methodsFor: 'marking board' stamp: 'HAW 10/27/2017 10:24:49'!
markWithXAt: aPosition

	self assertIsInBoardBounds: aPosition.
	
	state markWithXAt: aPosition.! !


!TicTacToe methodsFor: 'marking board - private' stamp: 'KFG 6/4/2018 00:29:32'!
add: aPosition to: positions nextPlayerState: nextPlayingState winnerState: winnerState

	positions add: aPosition.
	state := (self stateAfterAddingTo: positions with: nextPlayingState and: winnerState) for: self.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/25/2017 15:35:08'!
assertIsFree: aPosition

	(self isTaken: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/27/2017 10:26:10'!
assertIsInBoardBounds: aPosition

	(aPosition between: 1@1 and: 3@3) ifFalse: [ self error: self class positionOutsideBoardErrorMessage ]! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'KFG 6/4/2018 00:55:31'!
markWithOWhenPlayingOAt: aPosition
	self assertIsFree: aPosition.
	self
		add: aPosition
		to: playerOPositions
		nextPlayerState: PlayingX
		winnerState: PlayerOWon.
	observer notifyOPlayedAt: aPosition.
	observer notifyStateUpdate: state! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:01'!
markWithOWhenPlayingXAt: aPosition
	self error: self class notOTurnErrorMessage.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:32'!
markWithXWhenPlayingOAt: aPoint
	self error: self class notXTurnErrorMessage.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'KFG 6/4/2018 00:50:09'!
markWithXWhenPlayingXAt: aPosition
	self assertIsFree: aPosition.
	self
		add: aPosition
		to: playerXPositions
		nextPlayerState: PlayingO
		winnerState: PlayerXWon.
	observer notifyXPlayedAt: aPosition.
	observer notifyStateUpdate: state
! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:44:57'!
stateAfterAddingTo: positions with: nextPlayingState and: winnerState

	(self hasWin: positions) ifTrue: [ ^ winnerState ].
	self shouldBeTiedWhenNoOneWon ifTrue: [ ^ GameTied ].

	^ nextPlayingState.! !


!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ state hasPlayerOWon.! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ state hasPlayerXWon.! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 13:32:14'!
isOver
	
	^state isOver! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:24:01'!
isTied
	
	^ state isTied! !


!TicTacToe methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:38'!
isPlayingO
	
	^state isPlayingO! !

!TicTacToe methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:14'!
isPlayingX
	
	^state isPlayingX ! !


!TicTacToe methodsFor: 'testing board positions' stamp: 'HAW 10/25/2017 15:50:52'!
isTaken: aPosition
	^ (playerXPositions includes: aPosition) or: [ playerOPositions includes: aPosition ].! !


!TicTacToe methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:16'!
playerOPositions
	^ playerOPositions copy.! !

!TicTacToe methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:32'!
playerXPositions
	^ playerXPositions copy.! !


!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:22:42'!
has: positions threeOf: aPositionComponent

	^(positions collect: aPositionComponent) asBag contents values includes: 3 
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:09:34'!
hasCompletedColumn: positions
	
	^self has: positions threeOf: [ :aPosition | aPosition x ]
	
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:25:55'!
hasCompletedDiagonal: positions 
	
	^(self hasUpDiagonal: positions) or: [self hasDownDiagonal: positions]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:10:47'!
hasCompletedLine: positions
	
	^self has: positions threeOf: [ :aPosition | aPosition y ]
! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:25:48'!
hasCompletedStraightLine: positions
	
	^(self hasCompletedColumn: positions) or: [self hasCompletedLine: positions ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/24/2017 17:12:48'!
hasDownDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/24/2017 17:12:48'!
hasUpDiagonal: positions
	
	^(1 to: 3) allSatisfy: [ :n | positions includes: n@n ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:26:17'!
hasWin: positions

	^positions size >= 3 and: [ (self hasCompletedStraightLine: positions) or: [ self hasCompletedDiagonal: positions ]].
		
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:44:42'!
shouldBeTiedWhenNoOneWon

	^ playerXPositions size = 5 and: [ playerOPositions size = 4 ].! !


!TicTacToe methodsFor: 'events-registering' stamp: 'MM 6/2/2018 18:01:03'!
addObserver: aConcreteObserver 
	observer addConcreteObserver: aConcreteObserver! !


!TicTacToe methodsFor: 'events-triggering' stamp: 'MM 6/2/2018 20:58:15'!
notifyOIsPlaying
	observer notifyOIsPlaying.! !

!TicTacToe methodsFor: 'events-triggering' stamp: 'MM 6/3/2018 18:54:08'!
notifyXIsPlaying
	observer notifyXIsPlaying.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToe!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
notOTurnErrorMessage
	
	^'Not O''s turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
notXTurnErrorMessage
	
	^'Not X''s turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/27/2017 10:26:31'!
positionOutsideBoardErrorMessage
	
	^'Position is outside board'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
positionTakenErrorMessage
	
	^'Position taken'! !


!classDefinition: #TicTacToeConsole category: #TicTacToe!
Object subclass: #TicTacToeConsole
	instanceVariableNames: 'output'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeConsole methodsFor: 'initialization' stamp: 'KFG 6/4/2018 01:56:47'!
initializePrintingOn: aStream

	output := aStream! !


!TicTacToeConsole methodsFor: 'printing' stamp: 'MM 6/4/2018 13:28:15'!
oPlayedAt: aPosition
	('O marcó en ' append: aPosition asString) printOn: output! !

!TicTacToeConsole methodsFor: 'printing' stamp: 'KFG 6/4/2018 02:05:38'!
stateUpdatedTo: aTicTacToeState
	(aTicTacToeState printOn: 'Estado: ') printOn: output.! !

!TicTacToeConsole methodsFor: 'printing' stamp: 'KFG 6/4/2018 01:57:48'!
xPlayedAt: aPosition 
	('X marcó en ' append: aPosition asString) printOn: output! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeConsole class' category: #TicTacToe!
TicTacToeConsole class
	instanceVariableNames: ''!

!TicTacToeConsole class methodsFor: 'as yet unclassified' stamp: 'KFG 6/4/2018 01:56:12'!
printingOn: aStream

	^self new initializePrintingOn: aStream! !


!classDefinition: #TicTacToeObserver category: #TicTacToe!
Object subclass: #TicTacToeObserver
	instanceVariableNames: 'concreteObservers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeObserver methodsFor: 'subscribing' stamp: 'MM 6/2/2018 18:05:40'!
addConcreteObserver: aConcreteObserver 
	concreteObservers add: aConcreteObserver.! !

!TicTacToeObserver methodsFor: 'subscribing' stamp: 'MM 6/2/2018 18:07:38'!
initialize
	concreteObservers := OrderedCollection new.! !


!TicTacToeObserver methodsFor: 'events-triggering' stamp: 'MM 6/2/2018 21:00:58'!
notifyOIsPlaying
	concreteObservers do: [ :aConcreteObserver | aConcreteObserver oIsPlaying]! !

!TicTacToeObserver methodsFor: 'events-triggering' stamp: 'KFG 6/4/2018 00:55:55'!
notifyOPlayedAt: aPosition
	concreteObservers do: [ :aConcreteObserver | aConcreteObserver oPlayedAt: aPosition ]! !

!TicTacToeObserver methodsFor: 'events-triggering' stamp: 'KFG 6/4/2018 00:48:47'!
notifyStateUpdate: aTicTacToeState
	concreteObservers do: [ :aConcreteObserver | aConcreteObserver stateUpdatedTo: aTicTacToeState ]! !

!TicTacToeObserver methodsFor: 'events-triggering' stamp: 'MM 6/3/2018 19:08:08'!
notifyXIsPlaying
	concreteObservers do: [ :aConcreteObserver | aConcreteObserver xIsPlaying]! !

!TicTacToeObserver methodsFor: 'events-triggering' stamp: 'MM 6/2/2018 19:57:21'!
notifyXPlayedAt: aPosition
	concreteObservers do: [ :aConcreteObserver | aConcreteObserver xPlayedAt: aPosition ]! !


!classDefinition: #TicTacToeState category: #TicTacToe!
Object subclass: #TicTacToeState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
hasPlayerOWon
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
hasPlayerXWon
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
isOver
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
isTied
	
	self subclassResponsibility! !


!TicTacToeState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:28:07'!
isPlayingO
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:28:07'!
isPlayingX
	
	self subclassResponsibility! !


!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:31'!
markAt: aPosition

	self subclassResponsibility ! !

!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:25'!
markWithOAt: aPosition
	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:16'!
markWithXAt: aPosition
	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'marking board' stamp: 'KFG 6/4/2018 00:41:35'!
printOn: aStream

	self subclassResponsibility ! !


!TicTacToeState methodsFor: 'initialization' stamp: 'MM 6/2/2018 20:52:51'!
initializeFor: aGame

	game := aGame! !


!TicTacToeState methodsFor: 'events-triggering' stamp: 'MM 6/2/2018 20:54:10'!
notify

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeState class' category: #TicTacToe!
TicTacToeState class
	instanceVariableNames: ''!

!TicTacToeState class methodsFor: 'as yet unclassified' stamp: 'HAW 10/25/2017 13:05:29'!
for: aTicTacToe 
	
	^self new initializeFor: aTicTacToe ! !


!classDefinition: #GameOverState category: #TicTacToe!
TicTacToeState subclass: #GameOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!GameOverState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 11:53:57'!
isOver
	
	^true! !


!GameOverState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:05:23'!
isPlayingO
	
	^false! !

!GameOverState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:05:27'!
isPlayingX
	
	^false! !


!GameOverState methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:09'!
markAt: aPosition

	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:25'!
markWithOAt: aPosition
	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:16'!
markWithXAt: aPosition
	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'KFG 6/4/2018 01:07:41'!
printOn: aStream
	
	^aStream append: 'Juego terminado'! !


!classDefinition: #GameTied category: #TicTacToe!
GameOverState subclass: #GameTied
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ false.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ false.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:24:49'!
isTied
	
	^true! !

!GameTied methodsFor: 'testing game result' stamp: 'KFG 6/4/2018 01:16:53'!
printOn: aStream
	
	^(super printOn: aStream) append: ' - Empate'! !


!classDefinition: #PlayerOWon category: #TicTacToe!
GameOverState subclass: #PlayerOWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ true.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ false.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:06:24'!
isTied
	
	^false! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'KFG 6/4/2018 01:12:02'!
printOn: aStream
	
	^(super printOn: aStream) append: ' - Ganó O!!'! !


!classDefinition: #PlayerXWon category: #TicTacToe!
GameOverState subclass: #PlayerXWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ false.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ true.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:25:44'!
isTied
	
	^false! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'KFG 6/4/2018 01:06:44'!
printOn: aStream
	
	^(super printOn: aStream) append: ' - Ganó X!!'! !


!classDefinition: #PlayingState category: #TicTacToe!
TicTacToeState subclass: #PlayingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:10'!
hasPlayerOWon
	^ false.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:17'!
hasPlayerXWon
	^ false.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:26'!
isOver
	
	^false! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:52'!
isTied
	
	^false! !


!classDefinition: #PlayingO category: #TicTacToe!
PlayingState subclass: #PlayingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:36'!
isPlayingO
	
	^true! !

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:27'!
isPlayingX
	
	^false! !


!PlayingO methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:13'!
markAt: aPosition

	^game markWithOAt: aPosition ! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:45'!
markWithOAt: aPosition
	game markWithOWhenPlayingOAt: aPosition.! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:32'!
markWithXAt: aPosition
	game markWithXWhenPlayingOAt: aPosition.! !


!PlayingO methodsFor: 'events-triggering' stamp: 'MM 6/2/2018 20:58:15'!
notify
	game notifyOIsPlaying.! !


!PlayingO methodsFor: 'printing' stamp: 'KFG 6/4/2018 00:46:30'!
printOn: aStream

	^aStream append: 'Jugando O'! !


!classDefinition: #PlayingX category: #TicTacToe!
PlayingState subclass: #PlayingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:50'!
isPlayingO
	
	^false! !

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:23'!
isPlayingX
	
	^true! !


!PlayingX methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:17'!
markAt: aPosition

	^game markWithXAt: aPosition ! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:01'!
markWithOAt: aPosition
	game markWithOWhenPlayingXAt: aPosition.! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:46'!
markWithXAt: aPosition
	game markWithXWhenPlayingXAt: aPosition.! !


!PlayingX methodsFor: 'events-triggering' stamp: 'MM 6/3/2018 18:53:05'!
notify
	game notifyXIsPlaying ! !


!PlayingX methodsFor: 'printing' stamp: 'KFG 6/4/2018 00:45:14'!
printOn: aStream

	^aStream append: 'Jugando X'! !


!classDefinition: #TicTacToeView category: #TicTacToe!
Object subclass: #TicTacToeView
	instanceVariableNames: 'output board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeView methodsFor: 'initialization' stamp: 'MM 6/4/2018 16:17:53'!
initializeBoard

	board := Array2D height: 3 width: 3.
	(1 to: (board height)) do: [ :row | 
		(1 to: (board width)) do: [ :col |
			board i: row j: col put: ' '
		]
	].! !

!TicTacToeView methodsFor: 'initialization' stamp: 'MM 6/4/2018 16:19:03'!
initializePrintingOn: aStream

	output := aStream.
	self initializeBoard ! !


!TicTacToeView methodsFor: 'printing' stamp: 'MM 6/4/2018 15:43:40'!
oPlayedAt: aPosition 
	board at: aPosition put: 'O'! !

!TicTacToeView methodsFor: 'printing' stamp: 'MM 6/4/2018 15:19:07'!
stateUpdatedTo: aTicTacToeState
	(aTicTacToeState printOn: 'Estado: ') printOn: output.! !

!TicTacToeView methodsFor: 'printing' stamp: 'MM 6/4/2018 15:40:41'!
xPlayedAt: aPosition 
	board at: aPosition put: 'X'! !


!TicTacToeView methodsFor: 'accessing' stamp: 'MM 6/4/2018 15:34:17'!
board
	^board! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeView class' category: #TicTacToe!
TicTacToeView class
	instanceVariableNames: ''!

!TicTacToeView class methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2018 15:19:07'!
printingOn: aStream

	^self new initializePrintingOn: aStream! !
