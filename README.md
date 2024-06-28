# Kanpur Language Lexical Analyzer

## Overview
This project implements a lexical analyzer (scanner) for the Kanpur programming language using Flex. The lexical analyzer identifies and classifies lexemes into various token types such as keywords, operators, identifiers, strings, delimiters, integers, floating-point numbers, and hexadecimal literals.

## Features
- Recognizes keywords, operators, identifiers, strings, delimiters, integers, floating-point numbers, and hexadecimal literals.
- Handles multiline strings, comments, and whitespace.
- Case-insensitive for keywords and operators; case-sensitive for identifiers.
- Reports errors for illegal characters and ill-formed strings.

## Usage
To use the lexical analyzer:
1. Clone the repository :
git clone https://github.com/gprashant22github/lexical-analyzer.git
2. Compile the lexical analyzer :
make
3. Run the lexical analyzer on a Kanpur program file :
./lexer public1.knp.
Replace `public1.knp` with your Kanpur program file.

4. View the output which lists and classifies all lexemes.

## Example Output

LEXEME    TOKEN       COUNT \n
---------------------------\n
BEGIN     KEYWORD     1\n
ELSE      KEYWORD     1\n
END       KEYWORD     1\n
GT        OPERATOR    1\n
IF        KEYWORD     1\n
INTEGER   KEYWORD     1\n
PRINT     IDENTIFIER  1\n
STRING    "x is greater than y"  1\n
STRING    " y is greater than x"  1\n
...       ...         ...\n



## Requirements
- Flex (Lexical Analyzer Generator)

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
