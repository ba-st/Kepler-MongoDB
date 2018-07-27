Class {
	#name : #MemoryBasedDocumentPersistenceSystemTest,
	#superclass : #SystemBasedUserStoryTest,
	#category : #'Kepler-Document-Persistence-Tests'
}

{ #category : #initialization }
MemoryBasedDocumentPersistenceSystemTest >> setUpRequirements [

	self requireMemoryBasedDocumentPersistenceSystem 
]

{ #category : #tests }
MemoryBasedDocumentPersistenceSystemTest >> testAdding [

	| document |

	self assert: (self persistenceSystem collectionNamed: 'tests') isEmpty.

	document := {('date' -> Date today).
	('rate' -> 80)} asDictionary.

	self persistenceSystem add: document onCollectionNamed: 'tests'.
	
	self
		withTheOnlyOneIn: (self persistenceSystem collectionNamed: 'tests')
		do: [ :element | self assert: element equals: document ]
]

{ #category : #tests }
MemoryBasedDocumentPersistenceSystemTest >> testQueryingCollectionByName [

	self
		assert: (self persistenceSystem collectionNamed: 'tests') isEmpty
]

{ #category : #tests }
MemoryBasedDocumentPersistenceSystemTest >> testQueryingOne [

	| document |

	self persistenceSystem
		oneDocumentFilteredBy: [ :existingDocument | (existingDocument at: #date) = Date today ]
		onCollectionNamed: 'tests'
		ifFound: [ :foundDocument | self fail ]
		ifNone: [  ].

	self assert: (self persistenceSystem collectionNamed: 'tests') isEmpty.

	document := {('date' -> Date today).
	('rate' -> 80)} asDictionary.

	self persistenceSystem add: document onCollectionNamed: 'tests'.

	self persistenceSystem
		oneDocumentFilteredBy: [ :existingDocument | (existingDocument at: #date) = Date today ]
		onCollectionNamed: 'tests'
		ifFound: [ :foundDocument | self assert: document equals: foundDocument ]
		ifNone: [ self fail ]
]

{ #category : #tests }
MemoryBasedDocumentPersistenceSystemTest >> testUpdating [

	| document updatedDocument |

	self assert: (self persistenceSystem collectionNamed: 'tests') isEmpty.

	document := {('date' -> Date today).
	('rate' -> 80)} asDictionary.

	self persistenceSystem add: document onCollectionNamed: 'tests'.
	self
		withTheOnlyOneIn: (self persistenceSystem collectionNamed: 'tests')
		do: [ :element | self assert: element equals: document ].

	updatedDocument := {('date' -> Date today).
	('rate' -> 90)} asDictionary.

	self deny: document = updatedDocument.
	
	self persistenceSystem
		update: document
		with: updatedDocument
		onCollectionNamed: 'tests'.
		
	self
		withTheOnlyOneIn: (self persistenceSystem collectionNamed: 'tests')
		do: [ :element | self assert: element equals: updatedDocument ]
]

{ #category : #'tests support' }
MemoryBasedDocumentPersistenceSystemTest >> withTheOnlyOneIn: aCollection do: aBlock [

	self assert: aCollection size equals: 1.
	aBlock value: aCollection anyOne
]
