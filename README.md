# Haskell Basics

> Talk: Intro to Haskell, for Jax.Ex

An introductory Haskell project. This is a command line application that formats its
inputs into multiple columns, as a table. It is a clone of the unix utility `column`
in table mode.

## Getting Started

This project requires:

  * [GHC](https://www.haskell.org/ghc/) >= 9
  * [Cabal](https://www.haskell.org/cabal/) >= 3

The recommended way to install GHC and Cabal is via [GHCup](https://www.haskell.org/ghcup/)

## Installation

This utility can be installed using cabal

    cabal build
    cabal install

Run columnate

    columnate < LICENSE

Or you can run it without installing

    cabal run < LICENSE

## Running

To run it, pipe input into stdin:

   columnate < LICENSE

More examples

   # get only files from /etc ... but leave them in a column format
   find /etc -maxdepth 1 -mindepth 1 -type f | tr '\n' '\t' | fold -s | columnate

   # compare to `column -t` - which sometimes gives a column: line too long error.
   find /etc -maxdepth 1 -mindepth 1 -type f | tr '\n' '\t' | fold -s | column -t


## Slides

More useful links and information can be found in the presentation here: [slides](/doc/slides.md)
