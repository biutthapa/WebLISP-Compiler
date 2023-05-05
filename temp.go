package main

import (
    "fmt"
    "github.com/antlr/antlr4/runtime/Go/antlr"
)

type TreeShapeListener struct {
    *parser.BaseLispListener
}

func (t *TreeShapeListener) EnterEveryRule(ctx antlr.ParserRuleContext) {
    ruleName := parser.LispParserRULE_names[ctx.GetRuleIndex()]
    fmt.Println("Entering rule " + ruleName)
}

func main() {
    input := antlr.NewInputStream("(+ 2 2)")
    lexer := parser.NewLispLexer(input)
    stream := antlr.NewCommonTokenStream(lexer, antlr.TokenDefaultChannel)
    p := parser.NewLispParser(stream)

    // Create a listener to traverse the parse tree
    listener := &TreeShapeListener{}

    // Attach the listener to the parse tree
    antlr.ParseTreeWalkerDefault.Walk(listener, p.Start())
}
