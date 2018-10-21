#!/bin/bash

Kblayout() {
	layout=$(xkblayout-state print "%s")
	echo $layout
}

