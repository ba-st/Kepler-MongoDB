Extension { #name : #SystemBasedUserStoryTest }

{ #category : #'*Kepler-Document-Persistence-Tests' }
SystemBasedUserStoryTest >> persistenceSystem [

	^ rootSystem systemImplementing: #DocumentPersistenceSystemInterface
]

{ #category : #'*Kepler-Document-Persistence-Tests' }
SystemBasedUserStoryTest >> requireMemoryBasedDocumentPersistenceSystem [

	systemBuilder add: MemoryBasedDocumentPersistenceSystem new.
]
