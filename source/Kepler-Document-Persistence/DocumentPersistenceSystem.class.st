Class {
	#name : #DocumentPersistenceSystem,
	#superclass : #System,
	#category : #'Kepler-Document-Persistence'
}

{ #category : #adding }
DocumentPersistenceSystem >> add: aDocument onCollectionNamed: aName [

	self subclassResponsibility 
]

{ #category : #querying }
DocumentPersistenceSystem >> collectionNamed: aName [

	self subclassResponsibility 
]

{ #category : #querying }
DocumentPersistenceSystem >> oneDocumentFilteredBy: aBlock onCollectionNamed: aCollectionName ifFound: aFoundBlock ifNone: aNoneBlock [

	self subclassResponsibility 
]

{ #category : #updating }
DocumentPersistenceSystem >> update: aDocumentToBeUpdated with: aDocument onCollectionNamed: aName [

	self subclassResponsibility 
]
