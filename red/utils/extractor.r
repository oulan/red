REBOL [
	Title:   "Information extractor from Red runtime source code"
	Author:  "Nenad Rakocevic"
	File: 	 %extractor.r
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2012 Nenad Rakocevic. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt"
	Notes: {
		These utility functions extract types ID and function definitions from Red
		runtime source code and make it available to the compiler, before the Red runtime
		is actually compiled.
		
		This procedure is required during bootstrapping, as the REBOL compiler can't
		examine loaded Red data in memory at runtime.
	}
]

context [
	definitions: make block! 100
	data: load %runtime/macros.reds
	
	extract-defs: func [type [word!] /local list index][
		list: select data type
		
		index: 0
		forall list [
			if set-word? list/1 [
				list/1: to word! list/1
				index: list/2
			]
			if word? list/1 [
				repend definitions [list/1 index]
				index: index + 1
			]
		]
	]
	
	extract-defs 'datatypes!
	extract-defs 'actions!
	extract-defs 'natives!
	
	data: none
]