!classDefinition: #I category: #'Quinta actividad'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Quinta actividad'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'KFG 3/29/2018 17:20:47'!
* unPeano
	^unPeano! !

!I class methodsFor: 'as yet unclassified' stamp: 'MM 3/26/2018 21:54:21'!
+ unPeano
	^unPeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'KFG 3/29/2018 17:17:42'!
- unPeano
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'as yet unclassified' stamp: 'KFG 3/29/2018 17:13:00'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'numeros negativos no soportados'! !

!I class methodsFor: 'as yet unclassified' stamp: 'MM 3/31/2018 19:37:48'!
dividileA: unPeano
	^unPeano! !

!I class methodsFor: 'as yet unclassified' stamp: 'MM 3/26/2018 21:50:50'!
next
	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'KFG 3/29/2018 17:17:56'!
previous
	self error: 'no hay previous de I'! !

!I class methodsFor: 'as yet unclassified' stamp: 'KFG 3/29/2018 17:09:03'!
restaleA: unPeano
	^unPeano previous! !


!classDefinition: #II category: #'Quinta actividad'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Quinta actividad'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'MM 3/31/2018 19:25:05'!
* unPeano
	^unPeano + (self previous * unPeano)! !

!II class methodsFor: 'as yet unclassified' stamp: 'MM 3/27/2018 02:29:56'!
+ unPeano
	^self previous + unPeano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'KFG 3/29/2018 17:10:21'!
- unPeano
	^unPeano restaleA: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'MM 3/31/2018 21:12:01'!
/ unPeano
	^ unPeano dividileA: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'MM 3/31/2018 19:38:07'!
dividileA: unPeano
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'MM 3/26/2018 21:50:33'!
next
	(next = nil)
	ifTrue: [
		next := self cloneNamed: (self name, 'I').
		next previous: self
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'MM 3/26/2018 21:48:29'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'MM 3/26/2018 21:48:41'!
previous: unPeano
	previous := unPeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'MM 3/27/2018 02:18:38'!
removeAllNext
	(next = nil)
	ifFalse: [
		next removeAllNext.
		next removeFromSystem.
		next := nil
	]
! !

!II class methodsFor: 'as yet unclassified' stamp: 'KFG 3/29/2018 17:25:13'!
restaleA: unPeano
	^unPeano previous - previous! !

II instVarNamed: 'next' put: nil!
II instVarNamed: 'previous' put: I!