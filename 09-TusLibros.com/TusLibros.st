!classDefinition: #TusLibrosTests category: #TusLibros!
TestCase subclass: #TusLibrosTests
	instanceVariableNames: 'catalog newCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:09:58'!
setUp

	catalog := Dictionary new.
	newCart := Cart withItemsFrom: catalog.! !

!TusLibrosTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:10:17'!
test01NewCartIsEmpty

	self assert: newCart isEmpty.! !

!TusLibrosTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:11:09'!
test02CartIsNotEmptyAfterAddingABook
	| isbn |
	isbn := 'isbn'.
	catalog at: isbn put: 1.	
	newCart add: isbn.
	
	self deny: newCart isEmpty.! !

!TusLibrosTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:11:59'!
test03CannotAddItemThatDoesntBelongToStore
	| isbn |
	isbn := 'isbn'.
	
	self should: [newCart add: isbn.]
		  raise: (Error - MessageNotUnderstood)
		  withExceptionDo: [ :anError | 
			self assert: (anError messageText) equals: Cart invalidItemErrorMessage.
			self assert: newCart isEmpty.
		  ]! !

!TusLibrosTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:12:19'!
test04CannotAddItemWithQuantityLessThanOne
	| isbn |
	isbn := 'isbn'.
	catalog at: isbn put: 1.
	
	self should: [newCart add: isbn quantity: 0.]
		  raise: (Error - MessageNotUnderstood)
		  withExceptionDo: [ :anError | 
			self assert: (anError messageText) equals: Cart invalidQuantityErrorMessage.
			self assert: newCart isEmpty.
		  ]! !

!TusLibrosTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:12:38'!
test05CartShouldContainTwiceAnItemWhenQuantityIsTwo
	| isbn |
	isbn := 'isbn'.
	catalog at: isbn put: 1.
	newCart add: isbn quantity: 2.
	
	self deny: newCart isEmpty.
	self assert: (newCart amountOfItem: isbn) equals: 2.! !

!TusLibrosTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:12:52'!
test06CartShouldContainTwiceAnItemWhenItsAddedTwice
	| isbn |
	isbn := 'isbn'.
	catalog at: isbn put: 1.
	newCart add: isbn.
	newCart add: isbn.
		
	self deny: newCart isEmpty.
	self assert: (newCart amountOfItem: isbn) equals: 2.! !

!TusLibrosTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:13:04'!
test07AddingAnItemToCartOnlyAddsThatItem
	| isbn |
	isbn := 'isbn'.
	catalog at: isbn put: 1.
	newCart add: isbn.
			
	self deny: newCart isEmpty.
	self assert: (newCart amountOfItem: isbn) equals: 1.
	self assert: (newCart totalItems) equals: 1.! !

!TusLibrosTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:13:15'!
test08TotalItemsOfCartMustEqualTheSumOfAllQuantities
	| isbn isbn2 |
	isbn := 'isbn'.
	isbn2 := 'isbn2'.
	catalog at: isbn put: 1.
	catalog at: isbn2 put: 1.
	newCart add: isbn quantity: 2.
	newCart add: isbn2.
			
	self deny: newCart isEmpty.
	self assert: (newCart amountOfItem: isbn) equals: 2.
	self assert: (newCart amountOfItem: isbn2) equals: 1.
	self assert: (newCart totalItems) equals: 3.! !

!TusLibrosTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:13:30'!
test09CartItemsOnlyIncludeAddedItems
	| isbn isbn2 addedItems newCartContents |
	isbn := 'isbn'.
	isbn2 := 'isbn2'.
	catalog at: isbn put: 1.
	catalog at: isbn2 put: 1.
	newCart add: isbn quantity: 2.
	newCart add: isbn2.
	
	addedItems := OrderedCollection with: isbn with: isbn with: isbn2. 
	newCartContents := newCart contents.
			
	self deny: newCart isEmpty.
	newCartContents do: [ :content | self assert: (addedItems includes: content) ].
	addedItems do: [ :item | self assert: (newCartContents includes: item) ].! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'contents catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'adding' stamp: 'MM 6/7/2018 01:33:41'!
add: anItem
	^self add: anItem quantity: 1! !

!Cart methodsFor: 'adding' stamp: 'KFG 6/7/2018 03:04:06'!
add: anItem quantity: aQuantity
	catalog
		at: anItem
		ifAbsent: [ ^ self error: self class invalidItemErrorMessage ].
	aQuantity < 1 ifTrue: [ ^ self error: self class invalidQuantityErrorMessage ].
	
	contents
		add: anItem
		withOccurrences: aQuantity! !


!Cart methodsFor: 'initialization' stamp: 'MM 6/7/2018 02:57:02'!
initializeWith: aCatalog
	contents := Bag new.
	catalog := aCatalog.! !


!Cart methodsFor: 'accessing' stamp: 'KFG 6/7/2018 03:05:14'!
amountOfItem: anItem 
	^contents occurrencesOf: anItem. ! !

!Cart methodsFor: 'accessing' stamp: 'KFG 6/7/2018 03:06:27'!
contents
	^ contents copy! !

!Cart methodsFor: 'accessing' stamp: 'MM 6/7/2018 00:28:41'!
isEmpty
	^contents isEmpty ! !

!Cart methodsFor: 'accessing' stamp: 'KFG 6/7/2018 03:08:47'!
totalItems
	^contents size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: 'catalog'!

!Cart class methodsFor: 'instanciation' stamp: 'MM 6/7/2018 01:09:58'!
withItemsFrom: aDictionary 
	^self new initializeWith: aDictionary ! !


!Cart class methodsFor: 'error messages' stamp: 'MM 6/7/2018 01:17:30'!
invalidItemErrorMessage
	^'Item is not valid'! !

!Cart class methodsFor: 'error messages' stamp: 'MM 6/7/2018 01:36:55'!
invalidQuantityErrorMessage
	^'Quantity must be grater than one'! !
