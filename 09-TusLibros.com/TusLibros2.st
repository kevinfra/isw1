!classDefinition: #CartTests category: #TusLibros!
TestCase subclass: #CartTests
	instanceVariableNames: 'catalog newCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:09:58'!
setUp

	catalog := Dictionary new.
	newCart := Cart withItemsFrom: catalog.! !

!CartTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:10:17'!
test01NewCartIsEmpty

	self assert: newCart isEmpty.! !

!CartTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:11:09'!
test02CartIsNotEmptyAfterAddingABook
	| isbn |
	isbn := 'isbn'.
	catalog at: isbn put: 1.	
	newCart add: isbn.
	
	self deny: newCart isEmpty.! !

!CartTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:11:59'!
test03CannotAddItemThatDoesntBelongToStore
	| isbn |
	isbn := 'isbn'.
	
	self should: [newCart add: isbn.]
		  raise: (Error - MessageNotUnderstood)
		  withExceptionDo: [ :anError | 
			self assert: (anError messageText) equals: Cart invalidItemErrorMessage.
			self assert: newCart isEmpty.
		  ]! !

!CartTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:12:19'!
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

!CartTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:12:38'!
test05CartShouldContainTwiceAnItemWhenQuantityIsTwo
	| isbn |
	isbn := 'isbn'.
	catalog at: isbn put: 1.
	newCart add: isbn quantity: 2.
	
	self deny: newCart isEmpty.
	self assert: (newCart amountOfItem: isbn) equals: 2.! !

!CartTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:12:52'!
test06CartShouldContainTwiceAnItemWhenItsAddedTwice
	| isbn |
	isbn := 'isbn'.
	catalog at: isbn put: 1.
	newCart add: isbn.
	newCart add: isbn.
		
	self deny: newCart isEmpty.
	self assert: (newCart amountOfItem: isbn) equals: 2.! !

!CartTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:13:04'!
test07AddingAnItemToCartOnlyAddsThatItem
	| isbn |
	isbn := 'isbn'.
	catalog at: isbn put: 1.
	newCart add: isbn.
			
	self deny: newCart isEmpty.
	self assert: (newCart amountOfItem: isbn) equals: 1.
	self assert: (newCart totalItems) equals: 1.! !

!CartTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:13:15'!
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

!CartTests methodsFor: 'Testing' stamp: 'KFG 6/7/2018 03:13:30'!
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


!classDefinition: #CashierTests category: #TusLibros!
TestCase subclass: #CashierTests
	instanceVariableNames: 'catalog cashier cart creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTests methodsFor: 'Testing' stamp: 'KFG 6/10/2018 18:59:56'!
setUp
	catalog _ Dictionary new.
	cart _ Cart withItemsFrom: catalog.
	creditCard _ CreditCard
		withNumber: '1234123412341234'
		ownedBy: 'Lord del sufrimiento'
		expiresOn: GregorianMonthOfYear current next.
	cashier _ Cashier
		withCatalog: catalog
		withCart: cart
		withCreditCard: creditCard.! !

!CashierTests methodsFor: 'Testing' stamp: 'MM 6/10/2018 17:02:46'!
test01CannotCheckoutWithEmptyCart
	self 
		should: [cashier checkout] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: Cashier cartCannotBeEmptyErrorMessage].
	! !

!CashierTests methodsFor: 'Testing' stamp: 'MM 6/10/2018 18:16:31'!
test02TotalValueToCheckoutIsSumOfAllItemValuesInCart
	catalog
		at: 'isbn'
		put: 10.
	cart
		add: 'isbn'
		quantity: 2.
	self
		assert: 20
		equals: cashier checkout.! !

!CashierTests methodsFor: 'Testing' stamp: 'MM 6/10/2018 18:16:52'!
test03CannotCheckoutItemThatIsNotInCatalog
	| anotherCatalog newCashier |
	catalog
		at: 'isbn'
		put: 10.
	cart add: 'isbn'.
	anotherCatalog _ Dictionary new.
	anotherCatalog
		at: 'another_isbn'
		put: 15.
	newCashier _ Cashier
		withCatalog: anotherCatalog
		withCart: cart
		withCreditCard: creditCard.
	self
		should: [ newCashier checkout ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: anError messageText
				equals: Cashier itemIsNotInCatalogErrorMessage ].! !

!CashierTests methodsFor: 'Testing' stamp: 'KFG 6/10/2018 18:59:40'!
test04CannotCheckoutWithInvalidNumberOfCreditCard
	| anotherCreditCard |
	catalog
		at: 'isbn'
		put: 10.
	cart add: 'isbn'.
	anotherCreditCard := CreditCard withNumber: '1234' ownedBy:'Me'  expiresOn:GregorianMonthOfYear current next.
	
	self
		should: [ Cashier withCatalog: catalog
		withCart: cart
		withCreditCard: anotherCreditCard . ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: anError messageText
				equals: Cashier invalidCreditCardNumberErrorMessage ].! !

!CashierTests methodsFor: 'Testing' stamp: 'KFG 6/10/2018 18:59:36'!
test05CannotCheckoutWithInvalidOwnerOfCreditCard
	| anotherCreditCard |
	catalog
		at: 'isbn'
		put: 10.
	cart add: 'isbn'.
	anotherCreditCard := CreditCard withNumber: '1234123412341234' ownedBy:''  expiresOn:GregorianMonthOfYear current next.
	
	self
		should: [ Cashier withCatalog: catalog
		withCart: cart
		withCreditCard: anotherCreditCard . ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: anError messageText
				equals: Cashier invalidCreditCardOwnerErrorMessage ].! !

!CashierTests methodsFor: 'Testing' stamp: 'KFG 6/10/2018 18:59:31'!
test06CannotCheckoutWithExpiredCreditCard
	| anotherCreditCard |
	catalog
		at: 'isbn'
		put: 10.
	cart add: 'isbn'.
	anotherCreditCard _ CreditCard
		withNumber: '1234123412341234'
		ownedBy: 'Homero Thomson del lago del terror'
		expiresOn: GregorianMonthOfYear current previous.
	self
		should: [
			Cashier
				withCatalog: catalog
				withCart: cart
				withCreditCard: anotherCreditCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: anError messageText
				equals: Cashier expiredCreditCardErrorMessage ].! !


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

!Cart methodsFor: 'accessing' stamp: 'MM 6/10/2018 17:29:55'!
itemsDo: aBlock
	
	^ contents do: [:anItem | aBlock value: anItem]! !

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


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'catalog cart creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'MM 6/10/2018 17:43:58'!
checkout
	|sum|
 	cart isEmpty ifTrue: [ ^self error: self class cartCannotBeEmptyErrorMessage ].
	sum := 0.
	cart itemsDo: [ :anItem |
		catalog at: anItem ifAbsent: [^self error: self class itemIsNotInCatalogErrorMessage ].
		sum := sum + (catalog at: anItem) ].
	^sum.! !


!Cashier methodsFor: 'initialization' stamp: 'MM 6/10/2018 17:54:52'!
initializeWithCatalog: aCatalog withCart: aCart withCreditCard: aCreditCard
	catalog := aCatalog .
	cart := aCart .
	creditCard := aCreditCard .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'MM 6/10/2018 16:40:14'!
cartCannotBeEmptyErrorMessage
	^'Cart cannot be empty'! !

!Cashier class methodsFor: 'error messages' stamp: 'KFG 6/10/2018 19:01:17'!
expiredCreditCardErrorMessage
	^'The credit card is expired'! !

!Cashier class methodsFor: 'error messages' stamp: 'MM 6/10/2018 18:20:44'!
invalidCreditCardNumberErrorMessage
	^'The credit card number doesnt have 16 digits'! !

!Cashier class methodsFor: 'error messages' stamp: 'MM 6/10/2018 18:38:00'!
invalidCreditCardOwnerErrorMessage
	^'The credit card owner is empty'! !

!Cashier class methodsFor: 'error messages' stamp: 'MM 6/10/2018 17:41:52'!
itemIsNotInCatalogErrorMessage
	^'Item is not in catalog'.! !


!Cashier class methodsFor: 'initialization' stamp: 'MM 6/10/2018 18:36:15'!
withCatalog: aCatalog withCart: aCart withCreditCard: aCreditCard
	self assertIfCreditCardIsValid: aCreditCard .
	^self new initializeWithCatalog: aCatalog withCart: aCart withCreditCard: aCreditCard .! !


!Cashier class methodsFor: 'testing' stamp: 'KFG 6/10/2018 19:01:02'!
assertIfCreditCardIsValid: aCreditCard
	(aCreditCard number size = 16) ifFalse: [^self error: self invalidCreditCardNumberErrorMessage ].
	(aCreditCard owner size > 0) ifFalse: [^self error: self invalidCreditCardOwnerErrorMessage ].
	(aCreditCard expirationDate > GregorianMonthOfYear current) ifFalse: [^self error: self expiredCreditCardErrorMessage ].! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'number owner expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'MM 6/10/2018 18:10:51'!
initializeWithNumber: aNumber ownedBy: anOwner expiresOn: aDate
	number := aNumber .
	owner := anOwner .
	expirationDate := aDate .! !


!CreditCard methodsFor: 'accessing' stamp: 'KFG 6/10/2018 18:55:26'!
expirationDate
	^expirationDate ! !

!CreditCard methodsFor: 'accessing' stamp: 'MM 6/10/2018 18:26:58'!
number
	^number! !

!CreditCard methodsFor: 'accessing' stamp: 'MM 6/10/2018 18:27:22'!
owner
	^owner ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'initialization' stamp: 'MM 6/10/2018 18:09:04'!
withNumber: aNumber ownedBy: anOwner expiresOn: aDate
	^self new initializeWithNumber: aNumber ownedBy: anOwner expiresOn: aDate! !
