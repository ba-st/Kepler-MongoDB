# Installation

## Basic Installation

You can load **Kepler document persistence** evaluating:
```smalltalk
Metacello new
	baseline: 'KeplerDocumentPersistence';
	repository: 'github://fortizpenaloza/Kepler-Document-Persistence:master/source';
	load.
```
>  Change `master` to some released version if you want a pinned version

## Using as dependency

In order to include **Kepler document persistence** as part of your project, you should reference the package in your product baseline:

```smalltalk
setUpDependencies: spec

	spec
		baseline: 'KeplerDocumentPersistence'
			with: [ spec
				repository: 'github://fortizpenaloza/Kepler-Document-Persistence:v{XX}/source';
				loads: #('Deployment') ];
		import: 'KeplerDocumentPersistence'.
```
> Replace `{XX}` with the version you want to depend on

```smalltalk
baseline: spec

	<baseline>
	spec
		for: #common
		do: [ self setUpDependencies: spec.
			spec package: 'My-Package' with: [ spec requires: #('KeplerDocumentPersistence') ] ]
```
