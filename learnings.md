#Things I've learned by doing this project

## Vim
###Spell checking

[Vimcasts - Spell Checking](http://vimcasts.org/episodes/spell-checking/)

- Turn on the spell checker `set spell` which will add an underline (or highlight,
	depending on your editor configuration) to any words that are misspelled.
- Change the spell checker language to your region `set spelllang=en_ca`
- To move between misspelled words, press `[s` or `]s` to go to the previous or
  next misspelled word.
- To see the list of suggested words, press `z=`, and a list of suggestions will appear, allowing you to choose which is the spelling you want to use (by typing the number of the suggestion, or using your mouse. Savage.)
- Every language has a wordlist associated with it, allowing you to add words that should be accepted as spelled correctly (such as "spelled"), as well as add words that should be recognized as spelled incorrectly. Do this by having the cursor on the word, and pressing `zg` to add to the wordlist. To add an incorrect spelling to the wordlist, press `zw`.

## Bash

- recovering from errors in a for/while loop, use the `continue` keyword
  - for thing in array; do action || continue; done
