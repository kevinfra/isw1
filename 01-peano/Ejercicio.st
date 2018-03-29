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

!II class methodsFor: 'as yet unclassified' stamp: 'KFG 3/29/2018 17:21:45'!
* unPeano
	^self previous * (unPeano + unPeano)! !

!II class methodsFor: 'as yet unclassified' stamp: 'MM 3/27/2018 02:29:56'!
+ unPeano
	^self previous + unPeano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'KFG 3/29/2018 17:10:21'!
- unPeano
	^unPeano restaleA: self! !

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

II instVarNamed: 'next' put: III!
II instVarNamed: 'previous' put: I!

!classDefinition: #III category: #'Quinta actividad'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Quinta actividad'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'KFG 3/29/2018 17:21:54'!
* unPeano
	^self previous * (unPeano + unPeano)! !

!III class methodsFor: 'as yet unclassified' stamp: 'KFG 3/27/2018 15:48:32'!
+ unPeano
	^self previous + unPeano next! !

!III class methodsFor: 'as yet unclassified' stamp: 'KFG 3/29/2018 17:10:26'!
- unPeano
	^unPeano restaleA: self! !

!III class methodsFor: 'as yet unclassified' stamp: 'KFG 3/27/2018 15:48:32'!
next
	(next = nil)
	ifTrue: [
		next := self cloneNamed: (self name, 'I').
		next previous: self
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'KFG 3/27/2018 15:48:32'!
previous
	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'KFG 3/27/2018 15:48:32'!
previous: unPeano
	previous := unPeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'KFG 3/27/2018 15:48:32'!
removeAllNext
	(next = nil)
	ifFalse: [
		next removeAllNext.
		next removeFromSystem.
		next := nil
	]
! !

!III class methodsFor: 'as yet unclassified' stamp: 'KFG 3/29/2018 17:25:28'!
restaleA: unPeano
	^unPeano previous - previous! !

III instVarNamed: 'next' put: IIII!
III instVarNamed: 'previous' put: II!

!classDefinition: #IIII category: #'Quinta actividad'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Quinta actividad'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'KFG 3/29/2018 17:22:00'!
* unPeano
	^self previous * (unPeano + unPeano)! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'KFG 3/27/2018 15:48:41'!
+ unPeano
	^self previous + unPeano next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'KFG 3/29/2018 17:10:30'!
- unPeano
	^unPeano restaleA: self! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'KFG 3/27/2018 15:48:41'!
next
	(next = nil)
	ifTrue: [
		next := self cloneNamed: (self name, 'I').
		next previous: self
	].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'KFG 3/27/2018 15:48:41'!
previous
	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'KFG 3/27/2018 15:48:41'!
previous: unPeano
	previous := unPeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'KFG 3/27/2018 15:48:41'!
removeAllNext
	(next = nil)
	ifFalse: [
		next removeAllNext.
		next removeFromSystem.
		next := nil
	]
! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'KFG 3/29/2018 17:25:33'!
restaleA: unPeano
	^unPeano previous - previous! !

IIII instVarNamed: 'next' put: nil!
IIII instVarNamed: 'previous' put: III!