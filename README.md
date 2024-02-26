# dform : From XSD to Form

![dform](img/dform.svg)

## Introduction

**dform** is a tool to generate forms from XML Schema Definition (XSD) files. It is written in XSLT and can be used as a standalone tool or as a library in other XSLT stylesheets.

## Features

## Usage

## Installation

## Examples

## License

## Author

## References

| min   | max       | type         | description                |
| ----- | --------- | ------------ | -------------------------- |
| -     | 0         | Ignorer      |                            |
| x     | 0         | Ignorer      |                            |
| 0     | -         | Optionnel    | Seulement le template      |
| 0     | 1         | Optionnel    | Seulement le template      |
| 0     | y(>1)     | Optionnels   | Seulement le template      |
| 0     | unbounded | Optionnels   | Seulement le template      |
| -     | -         | Un seul      | Seulement le div           |
| -     | 1         | Un seul      | Seulement le div           |
| -     | y(>1)     | Un et plus   | Le div et le template      |
| -     | unbounded | Un et plus   | Le div et le template      |
| 1     | 1         | Un seul      | Seulement le div           |
| 1     | -         | Un seul      | Seulement le div           |
| 1     | y(>1)     | Un et plus   | Le div et le template      |
| 1     | unbounded | Un et plus   | Le div et le template      |
| x(>1) | -         | x occurences | Boucle de x div            |
| x(>1) | y(<=x)    | x occurences | Boucle de x div            |
| x(>1) | y(>x)     | x à y        | Boucle de x et le template |
| x(>1) | unbounded | x à y        | Boucle de x et le template |
