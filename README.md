# Kanpur Language Lexical Analyzer
Overview
This project implements a lexical analyzer (scanner) for the Kanpur programming language using Flex. The lexical analyzer identifies and classifies lexemes into various token types such as keywords, operators, identifiers, strings, delimiters, integers, floating-point numbers, and hexadecimal literals.

Features
Recognizes keywords, operators, identifiers, strings, delimiters, integers, floating-point numbers, and hexadecimal literals.
Handles multiline strings, comments, and whitespace.
Case-insensitive for keywords and operators; case-sensitive for identifiers.
Reports errors for illegal characters and ill-formed strings.
Usage
To use the lexical analyzer:

Clone the repository:

bash
Copy code
git clone https://github.com/gprashant22github/lexical-analyzer.git
Compile the lexical analyzer:

go
Copy code
make
Run the lexical analyzer on a Kanpur program file:

bash
Copy code
./lexer public1.knp
Replace public1.knp with your Kanpur program file.

View the output which lists and classifies all lexemes.

Example Output
vbnet
Copy code
LEXEME      TOKEN             COUNT
-----------------------------------
BEGIN       KEYWORD           1
ELSE        KEYWORD           1
END         KEYWORD           1
GT          OPERATOR          1
IF          KEYWORD           1
INTEGER     KEYWORD           1
PRINT       IDENTIFIER        1
STRING      "x is greater than y" 1
STRING      " y is greater than x" 1
...         ...               ...
Requirements
Flex (Lexical Analyzer Generator)
License
This project is licensed under the MIT License - see the LICENSE file for details.
