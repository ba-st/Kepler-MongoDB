Class {
	#name : #BaselineOfKeplerDocumentPersistence,
	#superclass : #BaselineOf,
	#category : #BaselineOfKeplerDocumentPersistence
}

{ #category : #baselines }
BaselineOfKeplerDocumentPersistence >> baseline: spec [

	<baseline>
	spec
		for: #common
		do: [ self setUpDependencies: spec.

			spec postLoadDoIt: #registerInterface.

			spec
				package: 'Kepler-Document-Persistence'
					with: [ spec requires: #('Kepler' 'MongoTalk') ];
				package: 'Kepler-Document-Persistence-Tests'
					with: [ spec requires: #('Kepler-Document-Persistence') ].

			spec
				group: 'Deployment' with: #('Kepler-Document-Persistence');
				group: 'Tests' with: #('Kepler-Document-Persistence-Tests');
				group: 'Development' with: #('Deployment' 'Tests' 'SystemBasedTests');
				group: 'default' with: #('Deployment') ]
]

{ #category : #'interface registering' }
BaselineOfKeplerDocumentPersistence >> registerInterface [

	self
		registerInterfaceAs: #DocumentPersistenceSystemInterface
		named: 'Document Persistence System Interface'
		declaring: #(#add:onCollectionNamed: #collectionNamed: #oneDocumentFilteredBy:onCollectionNamed:ifFound:ifNone: #update:with:onCollectionNamed:)
]

{ #category : #'interface registering' }
BaselineOfKeplerDocumentPersistence >> registerInterfaceAs: aKey named: aName declaring: aSelectorSet [

	SystemInterface bind: aKey to: (Interface named: aName declaring: aSelectorSet)
]

{ #category : #baselines }
BaselineOfKeplerDocumentPersistence >> setUpDependencies: spec [

	spec
		baseline: 'Kepler'
		with: [ spec
				repository: 'github://ba-st/Kepler:v2.0.3/source';
				loads: #('Deployment' 'SystemBasedTests') ].
	spec import: 'Kepler'.

	spec
		baseline: 'MongoTalk'
		with: [ spec
				repository: 'github://pharo-nosql/mongotalk:1.15/mc';
				loads: #('Core' 'Tools') ]
]
