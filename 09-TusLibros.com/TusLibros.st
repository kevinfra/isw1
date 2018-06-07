!classDefinition: #TusLibrosTests category: #TusLibros!
TestCase subclass: #TusLibrosTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTests methodsFor: 'Testing' stamp: 'MM 6/7/2018 01:14:41'!
test01NewCartIsEmpty
	| newCart catalog |
	catalog := Dictionary new.
	newCart := Cart withItemsFrom: catalog.
	
	self assert: newCart isEmpty.! !

!TusLibrosTests methodsFor: 'Testing' stamp: 'MM 6/7/2018 01:23:47'!
test02CartIsNotEmptyAfterAddingABook
	| newCart isbn catalog |
	isbn := 'isbn'.
	catalog := Dictionary new.
	catalog at: isbn put: 1.
	newCart := Cart withItemsFrom: catalog.
	
	newCart add: isbn.
	
	self deny: newCart isEmpty.! !

!TusLibrosTests methodsFor: 'Testing' stamp: 'MM 6/7/2018 01:00:22'!
test03CannotAddItemThatDoesntBelongToStore
	| newCart isbn catalog|
	catalog := Dictionary new.
	newCart := Cart withItemsFrom: catalog.
	isbn := 'isbn'.
	
	self should: [newCart add: isbn.]
		  raise: (Error - MessageNotUnderstood)
		  withExceptionDo: [ :anError | 
			self assert: (anError messageText) equals: Cart invalidItemErrorMessage.
			self assert: newCart isEmpty.
		  ]! !

!TusLibrosTests methodsFor: 'Testing' stamp: 'MM 6/7/2018 01:37:53'!
test04CannotAddItemWithQuantityLessThanOne
	| newCart isbn catalog|
	isbn := 'isbn'.
	catalog := Dictionary new.
	catalog at: isbn put: 1.
	newCart := Cart withItemsFrom: catalog.

	
	self should: [newCart add: isbn quantity: 0.]
		  raise: (Error - MessageNotUnderstood)
		  withExceptionDo: [ :anError | 
			self assert: (anError messageText) equals: Cart invalidQuantityErrorMessage.
			self assert: newCart isEmpty.
		  ]! !

!TusLibrosTests methodsFor: 'Testing' stamp: 'MM 6/7/2018 01:41:56'!
test05CartShouldContainTwiceAnItemWhenQuantityIsTwo
	| newCart isbn catalog|
	isbn := 'isbn'.
	catalog := Dictionary new.
	catalog at: isbn put: 1.
	newCart := Cart withItemsFrom: catalog.
	newCart add: isbn quantity: 2.
	
	self deny: newCart isEmpty.
	self assert: (newCart amountOfItem: isbn) equals: 2.! !

!TusLibrosTests methodsFor: 'Testing' stamp: 'MM 6/7/2018 01:46:04'!
test06CartShouldContainTwiceAnItemWhenItsAddedTwice
	| newCart isbn catalog|
	isbn := 'isbn'.
	catalog := Dictionary new.
	catalog at: isbn put: 1.
	newCart := Cart withItemsFrom: catalog.
	newCart add: isbn.
	newCart add: isbn.
		
	self deny: newCart isEmpty.
	self assert: (newCart amountOfItem: isbn) equals: 2.! !

!TusLibrosTests methodsFor: 'Testing' stamp: 'MM 6/7/2018 01:52:14'!
test07AddingAnItemToCartOnlyAddsThatItem
	| newCart isbn catalog|
	isbn := 'isbn'.
	catalog := Dictionary new.
	catalog at: isbn put: 1.
	newCart := Cart withItemsFrom: catalog.
	newCart add: isbn.
			
	self deny: newCart isEmpty.
	self assert: (newCart amountOfItem: isbn) equals: 1.
	self assert: (newCart totalItems) equals: 1.! !

!TusLibrosTests methodsFor: 'Testing' stamp: 'MM 6/7/2018 02:21:36'!
test08TotalItemsOfCartMustEqualTheSumOfAllQuantities
	| newCart isbn catalog isbn2 |
	isbn := 'isbn'.
	isbn2 := 'isbn2'.
	catalog := Dictionary new.
	catalog at: isbn put: 1.
	catalog at: isbn2 put: 1.
	newCart := Cart withItemsFrom: catalog.
	newCart add: isbn quantity: 2.
	newCart add: isbn2.
			
	self deny: newCart isEmpty.
	self assert: (newCart amountOfItem: isbn) equals: 2.
	self assert: (newCart amountOfItem: isbn2) equals: 1.
	self assert: (newCart totalItems) equals: 3.! !

!TusLibrosTests methodsFor: 'Testing' stamp: 'MM 6/7/2018 02:46:22'!
test09CartItemsOnlyIncludeAddedItems
	| newCart isbn catalog isbn2 addedItems newCartContents |
	isbn := 'isbn'.
	isbn2 := 'isbn2'.
	catalog := Dictionary new.
	catalog at: isbn put: 1.
	catalog at: isbn2 put: 1.
	newCart := Cart withItemsFrom: catalog.
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

!Cart methodsFor: 'adding' stamp: 'MM 6/7/2018 02:57:59'!
add: anItem quantity: aQuantity
	| previousQuantity |
	catalog
		at: anItem
		ifAbsent: [ ^ self error: self class invalidItemErrorMessage ].
	aQuantity < 1 ifTrue: [ ^ self error: self class invalidQuantityErrorMessage ].
	
	previousQuantity := self amountOfItem: anItem.
	contents
		at: anItem
		put: aQuantity + previousQuantity .! !


!Cart methodsFor: 'initialization' stamp: 'MM 6/7/2018 02:57:02'!
initializeWith: aCatalog
	contents := Bag new.
	catalog := aCatalog.! !


!Cart methodsFor: 'accessing' stamp: 'MM 6/7/2018 01:44:49'!
amountOfItem: anItem 
	^contents at: anItem ifAbsent: [0]. ! !

!Cart methodsFor: 'accessing' stamp: 'MM 6/7/2018 02:54:20'!
contents
	| itemCollection |
	itemCollection _ Bag new.
	^ contents keysAndValuesDo: [ :item :quantity |
		itemCollection add: item withOccurrences: quantity ].! !

!Cart methodsFor: 'accessing' stamp: 'MM 6/7/2018 00:28:41'!
isEmpty
	^contents isEmpty ! !

!Cart methodsFor: 'accessing' stamp: 'MM 6/7/2018 01:54:16'!
totalItems
	^contents values inject: 0 into: [ :totalItems :itemQuantity | totalItems + itemQuantity ].! !

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
