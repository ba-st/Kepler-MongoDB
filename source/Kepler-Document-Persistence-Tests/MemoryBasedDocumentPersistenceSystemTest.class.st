Class {
	#name : #MemoryBasedDocumentPersistenceSystemTest,
	#superclass : #TestCase,
	#category : #'Kepler-Document-Persistence-Tests'
}

{ #category : #tests }
MemoryBasedDocumentPersistenceSystemTest >> testAdding [

	| system document |

	system := MemoryBasedDocumentPersistenceSystem new.

	self assert: (system collectionNamed: 'tests') isEmpty.

	document := {('date' -> Date today).
		('rate' -> 80)} asDictionary.

	system add: document onCollectionNamed: 'tests'.
	self assert: (system collectionNamed: 'tests') size equals: 1	
]

{ #category : #tests }
MemoryBasedDocumentPersistenceSystemTest >> testQueryingCollectionByName [

	| system |
	system := MemoryBasedDocumentPersistenceSystem new.
	
	self assert:	(system collectionNamed: 'tests') isEmpty
]

{ #category : #tests }
MemoryBasedDocumentPersistenceSystemTest >> testUpdating [

	| system document updatedDocument |

	system := MemoryBasedDocumentPersistenceSystem new.

	self assert: (system collectionNamed: 'tests') isEmpty.

	document := {('date' -> Date today).
	('rate' -> 80)} asDictionary.


	updatedDocument := {('date' -> Date today).
	('rate' -> 90)} asDictionary.

	system add: document onCollectionNamed: 'tests'.
	self assert: (system collectionNamed: 'tests') size equals: 1.
	
	system update: document with: updatedDocument onCollectionNamed: 'tests'.
	self assert: (system collectionNamed: 'tests') size equals: 1
]
