%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Token types
#define KEYWORD 1
#define OPERATOR 2
#define IDENTIFIER 3
#define STRING 4
#define DELIMITER 5
#define INTEGER 6
#define FLOATING_POINT 7
#define HEXADECIMAL 8

int line_number = 1;

typedef struct Token {
    char *lexeme;
    int type;
    int count;
    struct Token *next;
} Token;

Token *token_list = NULL;

void yyerror(const char *msg);
void add_token(char *lexeme, int type);
void print_tokens();
void free_tokens();

%}

%option noyywrap

%%

[\t\f ]+                    { /* Ignore whitespace */ }
\n                          { line_number++; }
"ARRAY"|"BEGIN"|"BOOLEAN"|"COMMENT"|"CONTINUE"|"DO"|"DOUBLE"|"ELSE"|"END"|"FALSE"|"FOR"|"IF"|"INTEGER"|"LABEL"|"LIST"|"LONG"|"OWN"|"PROCEDURE"|"STEP"|"SWITCH"|"THEN"|"TRUE"|"UNTIL"|"VALUE"|"WHILE"  { add_token(yytext, KEYWORD); }
"AND"|"OR"|"LEQ"|"LT"|"GEQ"|"GT"|"NOT"|"EQL"|"NEQ"|"%"|"&"|"<="|"+"|"-"|"/"|">="|":="|"*"|"^"|"|"|"<<"|">>" { add_token(yytext, OPERATOR); }
"("|")"|"["|"]"|"{"|"}"|","|"'"|";"|"\""|":"|"'" { add_token(yytext, DELIMITER); }
[a-zA-Z][a-zA-Z0-9]*        { add_token(yytext, IDENTIFIER); }
\"([^\"\n]*)\"              { add_token(yytext, STRING); }
\'([^\'\n]*)\'              { add_token(yytext, STRING); }
0[xX][0-9a-fA-F]+           { add_token(yytext, HEXADECIMAL); }
[0-9]+\.[0-9]{1,6}          { add_token(yytext, FLOATING_POINT); }
[0-9]+                      { add_token(yytext, INTEGER); }
.                           { yyerror("Illegal character"); }

%%

void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s at line %d\n", msg, line_number);
    print_tokens();
    free_tokens();
    exit(1);
}

void add_token(char *lexeme, int type) {
    Token *current = token_list;
    while (current != NULL) {
        if (strcmp(current->lexeme, lexeme) == 0 && current->type == type) {
            current->count++;
            return;
        }
        current = current->next;
    }
    Token *new_token = (Token *)malloc(sizeof(Token));
    new_token->lexeme = strdup(lexeme);
    new_token->type = type;
    new_token->count = 1;
    new_token->next = token_list;
    token_list = new_token;
}

int compare_tokens(const void *a, const void *b) {
    Token *tokenA = *(Token **)a;
    Token *tokenB = *(Token **)b;
    return strcmp(tokenA->lexeme, tokenB->lexeme);
}

void print_tokens() {
    int token_count = 0;
    Token *current = token_list;
    while (current != NULL) {
        token_count++;
        current = current->next;
    }

    Token **tokens = (Token **)malloc(token_count * sizeof(Token *));
    current = token_list;
    for (int i = 0; i < token_count; i++) {
        tokens[i] = current;
        current = current->next;
    }

    qsort(tokens, token_count, sizeof(Token *), compare_tokens);

    printf("LEXEME\tTOKEN\tCOUNT\n");
    for (int i = 0; i < token_count; i++) {
        printf("%s\t", tokens[i]->lexeme);
        switch (tokens[i]->type) {
            case KEYWORD: printf("KEYWORD\t"); break;
            case OPERATOR: printf("OPERATOR\t"); break;
            case IDENTIFIER: printf("IDENTIFIER\t"); break;
            case STRING: printf("STRING\t"); break;
            case DELIMITER: printf("DELIMITER\t"); break;
            case INTEGER: printf("INTEGER\t"); break;
            case FLOATING_POINT: printf("FLOATING_POINT\t"); break;
            case HEXADECIMAL: printf("HEXADECIMAL\t"); break;
        }
        printf("%d\n", tokens[i]->count);
    }

    free(tokens);
}

void free_tokens() {
    Token *current = token_list;
    while (current != NULL) {
        Token *next = current->next;
        free(current->lexeme);
        free(current);
        current = next;
    }
    token_list = NULL;
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr, "Could not open file %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    }

    yylex();
    print_tokens();
    free_tokens();
    return 0;
}
