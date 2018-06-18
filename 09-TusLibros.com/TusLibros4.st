!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'KFG 6/17/2018 21:55:03'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart class invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'KFG 6/17/2018 22:00:44'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart class invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'KFG 6/17/2018 21:55:08'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart class invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'KFG 6/18/2018 00:33:44'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			ownedBy: 'anOwner'
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory currentMonthOfYear
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'KFG 6/18/2018 00:33:55'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		ownedBy: 'anOwner'
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory currentMonthOfYear 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'KFG 6/18/2018 00:34:11'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				ownedBy: 'anOwner'
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory currentMonthOfYear
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'KFG 6/18/2018 00:35:14'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		ownedBy: 'anOwner'
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory currentMonthOfYear
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'KFG 6/18/2018 00:35:17'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		ownedBy: 'anOwner'
		charging: creditCard
		throught: self
		on: testObjectsFactory currentMonthOfYear
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'KFG 6/18/2018 00:35:22'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		ownedBy: 'anOwner'
		charging: creditCard
		throught: self
		on: testObjectsFactory currentMonthOfYear
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #ExternalInterfaceTest category: #TusLibros!
TestCase subclass: #ExternalInterfaceTest
	instanceVariableNames: 'testObjectsFactory debitBehavior clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ExternalInterfaceTest methodsFor: 'private' stamp: 'KFG 6/18/2018 02:05:12'!
createDefaultInterface
	| catalog |
	catalog _ testObjectsFactory defaultCatalog.
	catalog
		at: self validBook
		put: 3.
	catalog
		at: self validBook2
		put: 4.
	clock _ TestClock now: testObjectsFactory today.
	^ ExternalInterface
		withUsersAndPasswordsFrom: self validUsersAndPasswords
		withItemCatalog: catalog
		registeringOn: OrderedCollection new
		debitingThrough: self
		onTimeFrom: clock.! !

!ExternalInterfaceTest methodsFor: 'private' stamp: 'KFG 6/18/2018 00:41:15'!
debit: anAmount from: aCreditCard 
! !

!ExternalInterfaceTest methodsFor: 'private' stamp: 'KFG 6/18/2018 01:51:07'!
forwardClock: aDuration

	clock forwardTime: aDuration! !

!ExternalInterfaceTest methodsFor: 'private' stamp: 'KFG 6/17/2018 19:32:20'!
invalidBook

	^'invalid book'! !

!ExternalInterfaceTest methodsFor: 'private' stamp: 'KFG 6/17/2018 18:48:45'!
invalidCartId

	^nil! !

!ExternalInterfaceTest methodsFor: 'private' stamp: 'KFG 6/17/2018 18:34:36'!
invalidPassword

	^'invalid password'! !

!ExternalInterfaceTest methodsFor: 'private' stamp: 'KFG 6/17/2018 18:04:43'!
invalidUser

	^'invalid user'! !

!ExternalInterfaceTest methodsFor: 'private' stamp: 'KFG 6/18/2018 01:54:10'!
rewindClock: aDuration

	clock rewindTime: aDuration! !

!ExternalInterfaceTest methodsFor: 'private' stamp: 'KFG 6/17/2018 18:38:20'!
validBook

	^'valid book'! !

!ExternalInterfaceTest methodsFor: 'private' stamp: 'KFG 6/17/2018 22:26:42'!
validBook2

	^'valid book2'! !

!ExternalInterfaceTest methodsFor: 'private' stamp: 'KFG 6/17/2018 18:00:01'!
validUser

	^'valid user'! !

!ExternalInterfaceTest methodsFor: 'private' stamp: 'KFG 6/17/2018 18:00:38'!
validUserPassword
	^ 'valid password'.! !

!ExternalInterfaceTest methodsFor: 'private' stamp: 'KFG 6/17/2018 18:30:56'!
validUsersAndPasswords

	| combinations |
	combinations := Dictionary new.
	combinations at: self validUser put: self validUserPassword.
	^combinations! !


!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/17/2018 18:23:38'!
test01CanCreateCartWithValidUserAndPassword
	| interface |
	interface _ self createDefaultInterface.
	self
		shouldnt: [
			interface
				createCartForUser: self validUser
				withPassword: self validUserPassword ]
		raise: Error - MessageNotUnderstood.! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/17/2018 18:31:36'!
test02CanNotCreateCartWithInvalidUser
	| interface |
	interface _ self createDefaultInterface.
	self
		should: [
			interface
				createCartForUser: self invalidUser
				withPassword: self validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = interface class invalidUserPasswordErrorDescription ].! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/17/2018 18:34:21'!
test03CanNotCreateCartWithInvalidPassword

	| interface |

	interface := self createDefaultInterface.

	self
		should: [ interface createCartForUser: self validUser withPassword: self invalidPassword ]
		raise: (Error - MessageNotUnderstood)
		withExceptionDo: [ :anError | 
			self assert: anError messageText = interface  class invalidUserPasswordErrorDescription ]! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/18/2018 02:16:59'!
test04CanAddItemsToACreatedCart

    | interface cartId |

    interface := self createDefaultInterface.

    cartId := interface createCartForUser: self validUser withPassword: self validUserPassword.
    self
        shouldnt: [interface add: self validBook quantity: 1 toCartWithId: cartId]
        raise: (Error - MessageNotUnderstood)! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/17/2018 22:05:27'!
test05CanNotAddItemToNotCreatedCart
	| interface |
	interface _ self createDefaultInterface.
	self
		should: [
			interface
				add: self validBook
				quantity: 1
				toCartWithId: self invalidCartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = interface class invalidCartIdErrorDescription ].! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/17/2018 22:05:27'!
test06CanNotAddItemNotSellByTheStore
	| interface cartId |
	interface _ self createDefaultInterface.
	cartId _ interface
		createCartForUser: self validUser
		withPassword: self validUserPassword.
	self
		should: [
			interface
				add: self invalidBook
				quantity: 1
				toCartWithId: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = interface class invalidItemErrorMessage ].! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/17/2018 22:05:27'!
test07CanNotAddLessThanOneItem
	| interface cartId |
	interface _ self createDefaultInterface.
	cartId _ interface
		createCartForUser: self validUser
		withPassword: self validUserPassword.
	self
		should: [
			interface
				add: self validBook
				quantity: -1
				toCartWithId: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = interface class invalidQuantityErrorMessage ].! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/17/2018 22:03:47'!
test08ListCartOfAnEmptyCartRetunsEmptyCollection

	| interface cartId |

	interface := self createDefaultInterface.

	cartId := interface createCartForUser: self validUser withPassword: self validUserPassword.
	self assert: (interface listCartWithId: cartId) isEmpty 
	! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/17/2018 22:12:58'!
test09CanNotListCartOfInvalidCartId

	| interface |

	interface := self createDefaultInterface.

	self 
		should: [interface listCartWithId: self invalidCartId] 
		raise: (Error - MessageNotUnderstood)
		withExceptionDo: [ :anError | 
			self assert: anError messageText = interface class invalidCartIdErrorDescription ]! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/17/2018 22:29:41'!
test10ListCartListsTheCorrectItems

	| interface cartId cartContent |

	interface := self createDefaultInterface.

	cartId := interface createCartForUser: self validUser withPassword: self validUserPassword.
	interface add: self validBook quantity: 1 toCartWithId: cartId.
	interface add: self validBook2 quantity: 2 toCartWithId: cartId.
	cartContent := interface listCartWithId: cartId.
	
	self assert: (cartContent occurrencesOf: self validBook) equals: 1. 
	self assert: (cartContent occurrencesOf: self validBook2) equals: 2.
	self assert: (cartContent size) equals: 3.
! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/17/2018 22:55:34'!
test11CanCheckoutACart

	| interface cartId  |

	interface := self createDefaultInterface.

	cartId := interface createCartForUser: self validUser withPassword: self validUserPassword.
	interface add: self validBook quantity: 1 toCartWithId: cartId.
	self
		shouldnt: [interface 
			checkOutCartWithId: cartId 
			withCreditCardNumbered: '4546101090908453' 
			ownedBy: 'Homer Jay Simpson' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: (Error - MessageNotUnderstood)! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/17/2018 22:58:37'!
test12CanNotCheckoutANotCreatedCart

	| interface |

	interface := self createDefaultInterface.

	self
		should: [interface 
			checkOutCartWithId: self invalidCartId 
			withCreditCardNumbered: '4546101090908453' 
			ownedBy: 'Homer Jay Simpson' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: (Error - MessageNotUnderstood)
		withExceptionDo: [ :anError |
			self assert: anError messageText = interface class invalidCartIdErrorDescription ]! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/17/2018 23:00:44'!
test13CanNotCheckoutAnEmptyCart

	| interface cartId |

	interface := self createDefaultInterface.

	cartId := interface createCartForUser: self validUser withPassword: self validUserPassword.
	self
		should: [interface 
			checkOutCartWithId: cartId 
			withCreditCardNumbered: '4546101090908453' 
			ownedBy: 'Homer Jay Simpson' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: (Error - MessageNotUnderstood)
		withExceptionDo: [ :anError |
			self assert: anError messageText = interface class cartCanNotBeEmptyErrorMessage ]! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/17/2018 23:07:24'!
test14CanNotCheckoutWithAnExpiredCreditCard

	| interface cartId |

	interface := self createDefaultInterface.

	cartId := interface createCartForUser: self validUser withPassword: self validUserPassword.
	interface add: self validBook quantity: 1 toCartWithId: cartId.
	self
		should: [interface 
			checkOutCartWithId: cartId 
			withCreditCardNumbered: '4546101090908453' 
			ownedBy: 'Homer Jay Simpson' 
			expiringOn: testObjectsFactory expiredMonthOfYear ]
		raise: (Error - MessageNotUnderstood)
		withExceptionDo: [ :anError |
			self assert: anError messageText = interface class canNotChargeAnExpiredCreditCardErrorMessage ]! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/18/2018 01:35:51'!
test15CanNotListPurchasesOfInvalidCombinationOfUserAndPassword

	| interface cartId |

	interface := self createDefaultInterface.

	cartId := interface createCartForUser: self validUser withPassword: self validUserPassword.
	interface add: self validBook quantity: 2 toCartWithId: cartId.
	interface add: self validBook2 quantity: 1 toCartWithId: cartId.
	interface 
		checkOutCartWithId: cartId 
		withCreditCardNumbered: '4546101090908453' 
		ownedBy: 'Homer Jay Simpson' 
		expiringOn: testObjectsFactory notExpiredMonthOfYear.
		
	self
		should: [ interface listPurchasesOfUser: self invalidUser withPassword: self validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: error messageText = interface class invalidUserPasswordErrorDescription	
		 ].
		
	self
		should: [ interface listPurchasesOfUser: self validUser withPassword: self invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: error messageText = interface class invalidUserPasswordErrorDescription	
		 ].! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/18/2018 00:12:55'!
test16PurchasesListIsEmptyWhenThereAreNoSales
	| interface cartId purchases |
	interface _ self createDefaultInterface.
	cartId _ interface
		createCartForUser: self validUser
		withPassword: self validUserPassword.
	interface
		add: self validBook
		quantity: 2
		toCartWithId: cartId.
	interface
		add: self validBook2
		quantity: 1
		toCartWithId: cartId.
	purchases _ interface
		listPurchasesOfUser: self validUser
		withPassword: self validUserPassword.
	self assert: purchases isEmpty.! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/18/2018 01:32:03'!
test17ListPurchasesIncludesOnlyBoughtItems
	| interface cartId purchases |
	interface _ self createDefaultInterface.
	cartId _ interface
		createCartForUser: self validUser
		withPassword: self validUserPassword.
	interface
		add: self validBook
		quantity: 2
		toCartWithId: cartId.
	interface
		add: self validBook2
		quantity: 1
		toCartWithId: cartId.
	interface
		checkOutCartWithId: cartId
		withCreditCardNumbered: '4546101090908453'
		ownedBy: 'Homer Jay Simpson'
		expiringOn: testObjectsFactory notExpiredMonthOfYear.
	purchases _ interface
		listPurchasesOfUser: self validUser
		withPassword: self validUserPassword.
	self
		assert: (purchases occurrencesOf: self validBook)
		equals: 2.
	self
		assert: (purchases occurrencesOf: self validBook2)
		equals: 1.
	self
		assert: purchases size
		equals: 3.! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/18/2018 02:26:30'!
test18CanNotAddToCartWhenSessionIsExpired

	| interface cartId |

	interface := self createDefaultInterface.
	cartId := interface createCartForUser: self validUser withPassword: self validUserPassword.
	self forwardClock: 31 minutes. "Por problemas de precision, tuvimos que dejar 31 minutos. La diferencia es de 0.00002 segundos"
	self 
		should: [interface add: self validBook quantity: 2 toCartWithId: cartId]
		raise: (Error - MessageNotUnderstood)
		withExceptionDo: [ :anError |
			self assert: anError messageText = interface class expiredSessionErrorDescription ].

	self rewindClock: 29 minutes.
	self assert: (interface listCartWithId: cartId) isEmpty! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/18/2018 02:28:54'!
test19CanNotListCartWhenSessionHasExpired

	| interface cartId |

	interface := self createDefaultInterface.
	cartId := interface createCartForUser: self validUser withPassword: self validUserPassword.
	self forwardClock: 31 minutes. 
	self 
		should: [interface listCartWithId: cartId]
		raise: (Error - MessageNotUnderstood)
		withExceptionDo: [ :anError |
			self assert: anError messageText = interface class expiredSessionErrorDescription ].
! !

!ExternalInterfaceTest methodsFor: 'tests' stamp: 'KFG 6/18/2018 02:31:03'!
test20CanNotCheckOutCartWhenSessionIsExpired

	| interface cartId |

	interface := self createDefaultInterface.
	cartId := interface createCartForUser: self validUser withPassword: self validUserPassword.
	interface add: self validBook quantity: 2 toCartWithId: cartId.
	self forwardClock: 31 minutes. 
	self 
		should: [interface checkOutCartWithId: cartId withCreditCardNumbered: '11' ownedBy: 'jp' expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: (Error - MessageNotUnderstood)
		withExceptionDo: [ :anError |
			self assert: anError messageText = interface class expiredSessionErrorDescription ].! !


!ExternalInterfaceTest methodsFor: 'set up' stamp: 'KFG 6/17/2018 17:52:28'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!Cart methodsFor: 'assertions' stamp: 'KFG 6/17/2018 21:54:57'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'KFG 6/17/2018 22:00:39'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'KFG 6/17/2018 22:33:32'!
contents
	
	^items copy! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !

!Cart class methodsFor: 'instance creation' stamp: 'KFG 6/17/2018 21:54:32'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'instance creation' stamp: 'KFG 6/17/2018 22:00:24'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #CartSession category: #TusLibros!
Object subclass: #CartSession
	instanceVariableNames: 'owner cart lastUsedTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'initialization' stamp: 'KFG 6/18/2018 01:59:17'!
initializeOwnedBy: aUser forCart: aCart

	owner := aUser.
	cart := aCart.
	lastUsedTime := DateAndTime now.! !


!CartSession methodsFor: 'accessing' stamp: 'KFG 6/18/2018 01:13:03'!
cart

	^cart! !

!CartSession methodsFor: 'accessing' stamp: 'KFG 6/18/2018 01:10:08'!
owner

	^owner copy! !


!CartSession methodsFor: 'evaluating' stamp: 'KFG 6/18/2018 02:05:21'!
isExpiredAt: aDateAndTime

	^(aDateAndTime - lastUsedTime) >= (30 minutes)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #TusLibros!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'as yet unclassified' stamp: 'KFG 6/18/2018 01:09:31'!
ownedBy: aUser forCart: aCart 

	^self new initializeOwnedBy: aUser forCart: aCart ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'KFG 6/18/2018 01:27:26'!
createSale
	^ Sale of: total to: owner withItems: cart contents
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

!Cashier methodsFor: 'initialization' stamp: 'KFG 6/18/2018 00:23:20'!
initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	owner := anOwner.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'KFG 6/18/2018 00:24:06'!
toCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration owner number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'KFG 6/17/2018 23:24:37'!
isExpiredOn: aDate 
	
	^expiration < aDate ! !


!CreditCard methodsFor: 'initialization' stamp: 'KFG 6/18/2018 01:08:10'!
initializeExpiringOn: aMonthOfYear ofOwner: anOwner numbered: aCreditCartNumber
	
	expiration := aMonthOfYear.
	owner := anOwner.
	number := aCreditCartNumber .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'KFG 6/18/2018 01:06:49'!
expiringOn: aMonthOfYear ofOwner: anOwner numbered: aCreditCartNumber
	
	^self new initializeExpiringOn: aMonthOfYear ofOwner: anOwner numbered: aCreditCartNumber! !


!classDefinition: #ExternalInterface category: #TusLibros!
Object subclass: #ExternalInterface
	instanceVariableNames: 'validUsersAndPasswords carts lastCartID catalog merchantProcessor salesBook clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ExternalInterface methodsFor: 'adding' stamp: 'KFG 6/18/2018 01:12:44'!
add: aBook quantity: aQuantity toCartWithId: aCartId
	| cartSession |
	cartSession _ self cartSessionWithId: aCartId.
	cartSession cart
		add: aQuantity
		of: aBook.! !


!ExternalInterface methodsFor: 'private' stamp: 'KFG 6/18/2018 02:21:21'!
cartSessionWithId: aCartId
	| cartSession |
	cartSession := carts
		at: aCartId
		ifAbsent: [ self error: self class invalidCartIdErrorDescription ].
		
	(cartSession isExpiredAt: clock now) ifTrue: [ self error: self class expiredSessionErrorDescription ].
	
	^cartSession! !

!ExternalInterface methodsFor: 'private' stamp: 'KFG 6/17/2018 19:35:18'!
nextCartID

	lastCartID := lastCartID = 1.
	^lastCartID! !


!ExternalInterface methodsFor: 'checkout' stamp: 'KFG 6/18/2018 01:15:21'!
checkOutCartWithId: aCartId withCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear
	| cartSession cashier |
	cartSession _ self cartSessionWithId: aCartId.
	cartSession cart isEmpty ifTrue: [ self error: self class cartCanNotBeEmptyErrorMessage ].
	cashier _ Cashier
		toCheckout: cartSession cart
		ownedBy: cartSession owner
		charging:
			(CreditCard
				expiringOn: anExpirationMonthOfYear
				ofOwner: anOwner
				numbered: aCreditCartNumber)
		throught: merchantProcessor
		on: (GregorianMonthOfYear current)
		registeringOn: salesBook.
	^ cashier checkOut.! !


!ExternalInterface methodsFor: 'cart-creation' stamp: 'KFG 6/18/2018 01:11:07'!
createCartForUser: aUser withPassword: aPassword
	| savedPassword cartID |
	savedPassword _ validUsersAndPasswords
		at: aUser
		ifAbsent: [ self error: self class invalidUserPasswordErrorDescription ].
	savedPassword = aPassword 
		ifTrue: [ 
			cartID := self nextCartID.
			carts at: cartID put: (CartSession ownedBy: aUser forCart: (Cart acceptingItemsOf: catalog )).
			^cartID.
		]
		ifFalse: [ self error: self class invalidUserPasswordErrorDescription ].! !


!ExternalInterface methodsFor: 'initialization' stamp: 'KFG 6/18/2018 02:17:43'!
initializeWithUsersAndPasswordsFrom: usersAndPasswords withItemCatalog: aCatalog registeringOn: aSalesBook debitingThrough: aMerchantProcessor onTimeFrom: aClock

	validUsersAndPasswords := usersAndPasswords.
	catalog := aCatalog.
	carts := Dictionary new.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	clock := aClock..
	lastCartID := 0.! !


!ExternalInterface methodsFor: 'listing' stamp: 'KFG 6/18/2018 01:14:01'!
listCartWithId: aCartID

	| cartSession |
	cartSession := self cartSessionWithId: aCartID .

	^cartSession cart contents! !

!ExternalInterface methodsFor: 'listing' stamp: 'KFG 6/18/2018 01:29:08'!
listPurchasesOfUser: aUser withPassword: aPassword
	| savedPassword sales listedPurchases |
	savedPassword _ validUsersAndPasswords
		at: aUser
		ifAbsent: [ self error: self class invalidUserPasswordErrorDescription ].
	savedPassword = aPassword 
		ifTrue: [
			sales := salesBook select: [ :aSale | aSale doneTo: aUser ].
			listedPurchases := Bag new.
			sales do: [ :sale | listedPurchases addAll: sale items].
			^listedPurchases 
		]
		ifFalse: [ self error: self class invalidUserPasswordErrorDescription ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExternalInterface class' category: #TusLibros!
ExternalInterface class
	instanceVariableNames: ''!

!ExternalInterface class methodsFor: 'as yet unclassified' stamp: 'KFG 6/17/2018 23:33:48'!
canNotChargeAnExpiredCreditCardErrorMessage

	^Cashier canNotChargeAnExpiredCreditCardErrorMessage ! !

!ExternalInterface class methodsFor: 'as yet unclassified' stamp: 'KFG 6/17/2018 23:01:52'!
cartCanNotBeEmptyErrorMessage

	^Cashier cartCanNotBeEmptyErrorMessage! !

!ExternalInterface class methodsFor: 'as yet unclassified' stamp: 'KFG 6/18/2018 01:58:14'!
expiredSessionErrorDescription

	^'Session has expired'! !

!ExternalInterface class methodsFor: 'as yet unclassified' stamp: 'KFG 6/17/2018 18:49:13'!
invalidCartIdErrorDescription

	^'Cart ID is invalid'! !

!ExternalInterface class methodsFor: 'as yet unclassified' stamp: 'KFG 6/17/2018 21:54:36'!
invalidItemErrorMessage

	^Cart invalidItemErrorMessage ! !

!ExternalInterface class methodsFor: 'as yet unclassified' stamp: 'KFG 6/17/2018 22:01:39'!
invalidQuantityErrorMessage
	
	^Cart invalidQuantityErrorMessage ! !

!ExternalInterface class methodsFor: 'as yet unclassified' stamp: 'KFG 6/17/2018 18:03:59'!
invalidUserPasswordErrorDescription

	^'User-Password combination is invalid'! !

!ExternalInterface class methodsFor: 'as yet unclassified' stamp: 'KFG 6/18/2018 02:05:50'!
withUsersAndPasswordsFrom: usersAndPasswords withItemCatalog: aCatalog registeringOn: aSalesBook debitingThrough: aMerchantProcessor onTimeFrom: aClock

	^self new initializeWithUsersAndPasswordsFrom: usersAndPasswords withItemCatalog: aCatalog registeringOn: aSalesBook debitingThrough: aMerchantProcessor onTimeFrom: aClock! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total user items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'KFG 6/18/2018 00:26:42'!
doneTo: aUser
	
	^ user = aUser! !

!Sale methodsFor: 'total' stamp: 'KFG 6/18/2018 01:29:32'!
items
	
	^ items copy! !

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'KFG 6/18/2018 01:28:24'!
initializeWithTotal: aTotal toUser: aUser withItems: soldItems

	total := aTotal. 
	user := aUser.
	items := soldItems! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'KFG 6/18/2018 01:27:56'!
of: aTotal to: aUser withItems: soldItems

	"should assert total is not negative or 0!!"
	^self new initializeWithTotal: aTotal toUser: aUser withItems: soldItems! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'KFG 6/18/2018 01:07:21'!
expiredCreditCard
	
	^CreditCard expiringOn: GregorianMonthOfYear current previous ofOwner: 'sb' numbered: '1234123412341234'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'KFG 6/18/2018 01:07:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: GregorianMonthOfYear current next ofOwner: 'sb' numbered: '1234123412341234'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'KFG 6/17/2018 23:28:55'!
currentMonthOfYear

	^GregorianMonthOfYear current! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'KFG 6/17/2018 23:24:24'!
expiredMonthOfYear

	^ GregorianMonthOfYear current previous! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'KFG 6/17/2018 22:53:00'!
notExpiredMonthOfYear

	^ GregorianMonthOfYear current next.! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #TestClock category: #TusLibros!
Object subclass: #TestClock
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestClock methodsFor: 'clock actions' stamp: 'KFG 6/18/2018 01:53:17'!
forwardTime: aDuration

	now := now + aDuration ! !

!TestClock methodsFor: 'clock actions' stamp: 'KFG 6/18/2018 02:07:34'!
now

	^now! !

!TestClock methodsFor: 'clock actions' stamp: 'KFG 6/18/2018 01:53:25'!
rewindTime: aDuration

	now := now - aDuration ! !


!TestClock methodsFor: 'initialization' stamp: 'KFG 6/18/2018 01:48:02'!
initializeNow: aTime 

	now := aTime! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestClock class' category: #TusLibros!
TestClock class
	instanceVariableNames: ''!

!TestClock class methodsFor: 'as yet unclassified' stamp: 'KFG 6/18/2018 01:47:45'!
now: aTime 
	
	^self new initializeNow: aTime ! !
