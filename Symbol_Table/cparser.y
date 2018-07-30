%{
#include"definition.h"

struct global my,check;
int open;
int jumpcount,returntype,returnpointer;
char returnchar[100];
int Totalerrors,funcount;
struct allFunc **ALL;
struct structure
{
	char in[100];
	int s;
}maxi[100];
%}
%token IDENTIFIER CONSTANT STRING_LITERAL
%token INC_OP DEC_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP
%token IF ELSE WHILE FOR RETURN
%token CHAR INT FLOAT VOID

%start root
%union{
        struct AST *node;	//non-terminals

        struct terminal{	//terminals
                        char *text;
                        int type;
                        int line;
        } Sval;

}

%type <Sval> IDENTIFIER CONSTANT STRING_LITERAL
%type <Sval> INC_OP DEC_OP LE_OP GE_OP EQ_OP NE_OP
%type <Sval> AND_OP OR_OP
%type <Sval> IF ELSE WHILE FOR RETURN
%type <Sval> CHAR INT FLOAT VOID

%type <node> var 
%type <node> arg_var
%type <node> variables
%type <node> type
%type <node> declaration 
%type <node> argument_list
%type <node> statement
%type <node> iteration_statement
%type <node> selection_statement
%type <node> jump_statement
%type <node> ass_operator
%type <node> expression_statement
%type <node> arg_list
%type <node> primary_exp
%type <node> main_exp
%type <node> unary_op
%type <node> unary_exp
%type <node> mul_div_mod
%type <node> plus_minus
%type <node> lt_gt_lte_gte
%type <node> eq_neq
%type <node> andand
%type <node> oror
%type <node> conditional_exp
%type <node> expression
%type <node> statement_list
%type <node> body
%type <node> func_definition
%type <node> root
%type <node> result_id
%type <node> openB
%type <node> closeB
%type <node> istart
%type <node> iend

%%

primary_exp
        : IDENTIFIER 				{$$ = MakeNode(0); $$->type = $1.type; strcpy($$->lexeme,$1.text);

        								check.array = 0; check.struct_member = 0; 
        								//printf("parser :: %s %d\n",$1.text,$1.type);
        								struct symbolTable *temp = FindSymbol($1.text,check,currentT);
        								if(temp==NULL) printf("not found %s\n",$1.text);
        								else{
        										$$->type = temp->type;
        										$$->pointer = temp->pointer;
        									}
        								$$->array = 300;	
        								$$->where = temp;
        								$$->lval = 1;


        							}
        | STRING_LITERAL 			{$$ = MakeNode(0); $$->type = $1.type; strcpy($$->lexeme,$1.text);

        								// not sure
        								$$->lval = 0;
        								$$->pointer = 0;
        							}
        | '(' expression ')'        {$$ = $2;

        								//$$->type = $2->type;
        							}
        | CONSTANT 					{$$ = MakeNode(0); $$->type = $1.type; strcpy($$->lexeme,$1.text);

        								$$->type = $1.type;
        								$$->pointer = 0;
        								$$->lval = 0;
        								$$->array  = 200;
        							}
        ;

variables
	: var 						{
									$$ = $1; $$->pointer = 0;
								}
	| variables ',' var        {
									$$ = MakeNode(2); $$->type = 100; strcpy($$->lexeme,",");
									$$->child[0] = $1; $1->parent = $$; 
									$$->child[1] = $3; $3->parent = $$;  $3->pointer = 0; 
							   }
	;

type
        : CHAR     		{$$ = MakeNode(0); $$->type = $1.type; strcpy($$->lexeme,$1.text);}
        | INT 			{$$ = MakeNode(0); $$->type = $1.type; strcpy($$->lexeme,$1.text);}
        | VOID			{$$ = MakeNode(0); $$->type = $1.type; strcpy($$->lexeme,$1.text);}
      	| FLOAT			{$$ = MakeNode(0); $$->type = $1.type; strcpy($$->lexeme,$1.text);}
        ;


var 
	: IDENTIFIER				{$$ = MakeNode(0); $$->type = $1.type; strcpy($$->lexeme,$1.text);
								$$->array = 0;
								}
	| IDENTIFIER '[' CONSTANT ']' '[' CONSTANT ']'
								{$$ = MakeNode(0); $$->type = $1.type; strcpy($$->lexeme,$1.text);
								$$->array = 2; $$->dim1 = atoi($3.text); $$->dim2 = atoi($6.text);
							}	
	| IDENTIFIER '[' CONSTANT ']'	
								{$$ = MakeNode(0); $$->type = $1.type; strcpy($$->lexeme,$1.text);
								$$->array = 1; $$->dim1 = atoi($3.text);
								}
	;

arg_var
	: IDENTIFIER 		{
							$$ = MakeNode(0); $$->type = $1.type; strcpy($$->lexeme,$1.text);
							$$->array = 0; $$->pointer = 0;
						}
        ;

declaration 
	: type variables ';' 	{
								my.type = $1->type; my.struct_member = 0; addVar(my,$2,currentT);
							}
	;

argument_list					// to be modified
	: type arg_var			{ 
								currentT->parent->t->array  = 4;
								$$ = $1;

								my.type = $1->type; my.struct_member = 0;
								addVar(my,$2,currentT);

							}
	| argument_list ',' type arg_var  
							{
								currentT->parent->t->array  = 4;	
								$$ = MakeNode(2); $$->type = 100; strcpy($$->lexeme,",");
								$$->child[0] = $1; $1->parent = $$;
								$$->child[1] = $3; $3->parent = $$;

								// add arg_var to symboltable
								my.type = $3->type; my.struct_member = 0;
								addVar(my,$4,currentT);

							}
	;

statement
        : body  			{$$ = $1;}
		| expression_statement   {$$ = $1;}
        | jump_statement   	{$$ = $1;}
		| iteration_statement   {$$ = $1;}
		| declaration     		{$$=MakeNode(0); $$->type = -1;strcpy($$->lexeme,"dec");}
		| selection_statement    {$$ = $1;}
        ;
istart
		:	'{'		{
						jumpcount++;
						currentT = EnterScope(currentT);
					}
		;
iend
		:	'}'		{
						currentT = ExitScope(currentT);
					//	$$ = MakeNode(0); $$->type = 100; strcpy($$->lexeme,"}");
						jumpcount--;
						
					}
		;

iteration_statement
        : FOR '(' expression_statement expression_statement expression ')' istart statement_list iend
        				{
      						$$ = MakeNode(4); $$->type = $1.type; strcpy($$->lexeme,$1.text);
      						$$->child[0] = $3; $3->parent = $$; 
      						$$->child[1] = $4; $4->parent = $$;
      						$$->child[2] = $5; $5->parent = $$;
      						$$->child[3] = $8; $8->parent = $$;
      				//		$$->child[4] = $9; $9->parent = $$;
      						$$->array = 12;				

      						$$->scope = $8->scope;
      						$$->scopenode = $8->scopenode;
      						
      						propagate($3,$8->scope,$8->scopenode);
      						propagate($4,$8->scope,$8->scopenode);
      						propagate($5,$8->scope,$8->scopenode);
      					}
        | WHILE '(' expression ')' istart statement_list iend
      					{
      						$$ = MakeNode(2); $$->type = $1.type; strcpy($$->lexeme,$1.text);
      						$$->child[0] = $3; $3->parent = $$; 
      						$$->child[1] = $6; $6->parent = $$;
      					//	$$->child[2] = $7; $7->parent = $$;
      						$$->array = 10;			

      						$$->scope = $6->scope;
      						$$->scopenode = $6->scopenode;
      						propagate($3,$6->scope,$6->scopenode);	
      					}
        ;
jump_statement
        :
        RETURN ';' 				{ $$ = MakeNode(0); $$->type = $1.type; strcpy($$->lexeme,$1.text);

        								if(returntype != VOID ){
        									printf("Invalid Return type\n");
        									Totalerrors++;
        								}	
        							}
        | RETURN expression ';'      { $$ = MakeNode(1); $$->type = $1.type; strcpy($$->lexeme,$1.text);
        								$$->child[0] = $2; $2->parent = $$;

        								if(returntype != $2->type){
        									printf("Invalid Return type\n");
        									Totalerrors++;
        								}
        							}
        ;

selection_statement
        : IF '(' expression ')' body
        				{
      						$$ = MakeNode(2); $$->type = $1.type; strcpy($$->lexeme,$1.text);
      						$$->child[1] = $5; $5->parent = $$;
      						$$->child[0] = $3; $3->parent = $$; 
      						$$->array = 15;				
      					}
        | IF '(' expression ')' body ELSE statement

        				{
      						$$ = MakeNode(3); $$->type = $1.type; strcpy($$->lexeme,$1.text);
      						$$->child[2] = $7; $7->parent = $$;
      						$$->child[0] = $3; $3->parent = $$; 
      						$$->child[1] = $5; $5->parent = $$;
      						$$->array = 16;				
      					}
	;



ass_operator
        : '='         	{ $$ = MakeNode(2); $$->type = 100; strcpy($$->lexeme,"=");}
        ;


expression_statement
        : ';'					{$$ = MakeNode(0); $$->type = 100; strcpy($$->lexeme,";");}
        | expression ';'		{$$ = $1;}
        ;
arg_list
	: expression				{$$=$1;}
	| arg_list ',' expression 		{$$ = MakeNode(2); $$->type = 100; strcpy($$->lexeme,",");
									 $$->child[0] = $1; $1->parent = $$;
									 $$->child[1] = $3; $3->parent = $$;}
	;

main_exp
	: primary_exp 							{$$=$1;}
	| IDENTIFIER '['expression']' 		{$$=MakeNode(1); $$->type = $1.type; strcpy($$->lexeme,$1.text);
										  $$->child[0] = $3; $3->parent = $$; $$->array=1;

										  check.array = 1; check.struct_member = 0;
										  struct symbolTable *temp = FindSymbol($1.text,check,currentT);
        								  if(temp==NULL) printf("not found %s\n",$1.text);
        								  else{
	        								  if($3->type != INT){
	        								  	printf("Array index must be integer\n");
	        								  	Totalerrors++;
	        								  }
	        								  else
	        								  	$$->type = temp->type;
	        								  	$$->pointer = temp->pointer;
        									}
        									$$->array = 301;
        									$$->where = temp;
        									$$->lval = 1;	
										}
	| IDENTIFIER '['expression']' '['expression']'  {$$=MakeNode(2); $$->type = $1.type; strcpy($$->lexeme,$1.text);
										  			$$->child[0] = $3; $3->parent = $$; 
										  			$$->child[1] = $6; $6->parent = $$; $$->array=2;
										  			
										  			check.array = 2; check.struct_member = 0;
										  			struct symbolTable *temp = FindSymbol($1.text,check,currentT);
        											if(temp==NULL) printf("not found %s\n",$1.text);
        											else{
        											if($3->type != INT || $6->type != INT){
			        								  	printf("Array index must be integer\n");
			        								  	Totalerrors++;
			        								  }
			        								  else
			        								  	$$->type = temp->type;
			        								  $$->pointer = temp->pointer;
			        								}
			        								$$->array = 302;
			        								$$->where = temp;
			        								$$->lval = 1;
										  		}
	| IDENTIFIER '(' ')' 				{$$=MakeNode(0); $$->type = $1.type; strcpy($$->lexeme,$1.text);
										 $$->array = 3;

										 	check.array = 3; check.struct_member = 0;
										 	struct symbolTable *temp = FindSymbol($1.text,check,currentT);
        									if(temp==NULL) printf("not found %s\n",$1.text);
        									else{
        										$$->type = temp->type;
        										$$->pointer = temp->pointer;
        									}
        									$$->where = temp;
        									$$->lval = 0;
										}
	| IDENTIFIER '(' arg_list ')'  		{$$=MakeNode(1); $$->type = $1.type; strcpy($$->lexeme,$1.text);
										 $$->array = 4; $$->child[0]= $3; $3->parent = $$;

										 check.array = 4; check.struct_member = 0;
										 struct symbolTable *temp = FindSymbol($1.text,check,currentT);
        								 if(temp==NULL) printf("not found %s\n",$1.text);

        								 else{
        										$$->type = temp->type;
        										$$->pointer = temp->pointer;
        									}
        									// check definition of function 
        									$$->where = temp;
        									$$->lval = 0;
							if(check_arg($1.text,$3)){
								printf("Argument type does not match\n");
							}	///calling parameter
										}
	;
unary_op
	: '-' 					{$$=MakeNode(0); $$->type=100; strcpy($$->lexeme,"-"); }
	| '!' 					{$$=MakeNode(0); $$->type=100; strcpy($$->lexeme,"!"); }
	;
unary_exp
	: main_exp  			{$$=$1;}
	| unary_op unary_exp 	{$$=MakeNode(1); $$->type = $1->type;	strcpy($$->lexeme,$1->lexeme);
							 $$->child[0]=$2; $2->parent = $$; 
							 
							 	$$->lval = 0;
							 	if(strcmp($1->lexeme,"+")==0 ||strcmp($1->lexeme,"-")==0||strcmp($1->lexeme,"!")==0)
							 		$$->type = $2->type;
							 	else if(strcmp($1->lexeme,"~")==0 && $2->type == INT)
							 		$$->type = INT;
							 	else if(strcmp($1->lexeme,"*")==0 && $2->pointer == 1){
							 		$$->type = $2->type;
							 		if($2->lval == 1)
							 			$$->lval = 1;
							 	}
							 	else if(strcmp($1->lexeme,"&")==0 && $2->lval==1){ // to be modified
							 		$$->type = $2->type;
							 		$$->pointer = 1;
							 	}	
							 	else{
							 		printf("Invalid operands for %s\n",$1->lexeme);	
							 		Totalerrors++;
							 	}

							 	}
	;

mul_div_mod
	: unary_exp					{$$=$1;}
	| mul_div_mod '*' unary_exp  {$$=MakeNode(2); $$->type = 100;	strcpy($$->lexeme,"*");
							 $$->child[0]=$1; $1->parent = $$;
							 $$->child[1]=$3; $3->parent = $$;

							 if (($1->type == INT && $3->type == CHAR) || ($3->type == INT && $1->type == CHAR)){
							 		$$->type = INT;
							 }
							 else if($1->type != $3->type){
							 			printf("Invalid operands for * \n");
							 			Totalerrors++;
							 }	
							 else	
								$$->type = $1->type;

							 	}
	| mul_div_mod '/' unary_exp	{$$=MakeNode(2); $$->type = 100;	strcpy($$->lexeme,"/");
							 $$->child[0]=$1; $1->parent = $$;
							 $$->child[1]=$3; $3->parent = $$;

							if (($1->type == INT && $3->type == CHAR) || ($3->type == INT && $1->type == CHAR)){
							 		$$->type = INT;
							 }
							 else if($1->type != $3->type){
							 			printf("Invalid operands for / \n");
							 			Totalerrors++;
							 }	
							 else	
								$$->type = $1->type;					 


							 	}
	;
plus_minus
	: mul_div_mod  				{$$=$1;}
	| plus_minus '+' mul_div_mod  {$$=MakeNode(2); $$->type = 100;	strcpy($$->lexeme,"+");
							 $$->child[0]=$1; $1->parent = $$;
							 $$->child[1]=$3; $3->parent = $$;	

							 if (($1->type == INT && $3->type == CHAR) || ($3->type == INT && $1->type == CHAR)){
							 		$$->type = INT;
							 }
							 else if($1->type != $3->type)	{
							 			printf("Invalid operands for +\n");
							 			Totalerrors++;
							 		}	
							 else	
								$$->type = $1->type;

							}
	| plus_minus '-' mul_div_mod  {$$=MakeNode(2); $$->type = 100;	strcpy($$->lexeme,"-");
							 $$->child[0]=$1; $1->parent = $$;
							 $$->child[1]=$3; $3->parent = $$;	

							 if (($1->type == INT && $3->type == CHAR) || ($3->type == INT && $1->type == CHAR)){
							 		$$->type = INT;
							 }
							 else if($1->type != $3->type)	{
							 			printf("Invalid operands for +\n");
							 			Totalerrors++;
							 		}	
							 else	
								$$->type = $1->type;

							}
	;
	
lt_gt_lte_gte
	: plus_minus     				{$$=$1;}
	| lt_gt_lte_gte '<' plus_minus   {$$=MakeNode(2); $$->type = 100;	strcpy($$->lexeme,"<");
							 $$->child[0]=$1; $1->parent = $$;
							 $$->child[1]=$3; $3->parent = $$;


							 if($1->type != $3->type){
							 			printf("Invalid operands for <\n");
							 			Totalerrors++;
							 		}
							 		else	
									$$->type = INT;

							 	}
	| lt_gt_lte_gte '>' plus_minus   {$$=MakeNode(2); $$->type = 100;	strcpy($$->lexeme,">");
							 $$->child[0]=$1; $1->parent = $$;
							 $$->child[1]=$3; $3->parent = $$;

							 if($1->type != $3->type){
							 			printf("Invalid operands for >\n");
							 		Totalerrors++;
							 		}
							 		else	
									$$->type = INT;

							 }

							 	
	| lt_gt_lte_gte LE_OP plus_minus  {$$=MakeNode(2); $$->type = $2.type;	strcpy($$->lexeme,$2.text);
							 $$->child[0]=$1; $1->parent = $$;
							 $$->child[1]=$3; $3->parent = $$;

							 if($1->type != $3->type){
							 			printf("Invalid operands for %s\n",$2.text);
							 		Totalerrors++;
							 	}
							 		else	
									$$->type = INT;

							 	}
	| lt_gt_lte_gte GE_OP plus_minus  {$$=MakeNode(2); $$->type = $2.type;	strcpy($$->lexeme,$2.text);
							 $$->child[0]=$1; $1->parent = $$;
							 $$->child[1]=$3; $3->parent = $$;	

							 if($1->type != $3->type){
							 			printf("Invalid operands for %s\n",$2.text);
							 			Totalerrors++;
							 		}
							 		else	
									$$->type = INT;

							}
	;
	
eq_neq
	: lt_gt_lte_gte 				{$$ = $1;}
	| eq_neq EQ_OP lt_gt_lte_gte 	
							{$$=MakeNode(2); $$->type = $2.type;	strcpy($$->lexeme,$2.text);
							 $$->child[0]=$1; $1->parent = $$;
							 $$->child[1]=$3; $3->parent = $$;

							 	if($1->type != $3->type){
							 			printf("Invalid operands for %s\n",$2.text);
							 			Totalerrors++;
							 		}
							 	else	
									$$->type = INT;

							 	}
	| eq_neq NE_OP	lt_gt_lte_gte 
								 {$$=MakeNode(2); $$->type = $2.type;	strcpy($$->lexeme,$2.text);
							 		$$->child[0]=$1; $1->parent = $$;
							 		$$->child[1]=$3; $3->parent = $$;	

							 		if($1->type != $3->type){
							 			printf("Invalid operands for %s\n",$2.text);
							 			Totalerrors++;
							 		}
							 		else	
									$$->type = INT;
									 
							 	}
	;

andand
	: eq_neq 					{$$ = $1;}
	| andand AND_OP eq_neq 		{$$=MakeNode(2); $$->type = $2.type;	strcpy($$->lexeme,$2.text);
							 $$->child[0]=$1; $1->parent = $$;
							 $$->child[1]=$3; $3->parent = $$;

							 if($1->type != INT || $3->type != INT){
							 	printf("Invalid operands for %s\n",$2.text);
							 	Totalerrors++;
							 }else{
							 	$$->type = INT;
							 }

							 }
	;
oror
	: andand				{$$ = $1;}
	| oror OR_OP andand		{$$=MakeNode(2); $$->type = $2.type;	strcpy($$->lexeme,$2.text);
							 $$->child[0]=$1; $1->parent = $$;
							 $$->child[1]=$3; $3->parent = $$;	

							 if($1->type != INT || $3->type != INT){
							 	printf("Invalid operands for %s\n",$2.text);
							 	Totalerrors++;
							 }else{
							 	$$->type = INT;
							 }

							}
	;

conditional_exp
        : oror 		{$$ = $1;}
        ;
expression
	: conditional_exp						{$$=$1;}
	| unary_exp ass_operator expression 	{ $$ = $2; $$->child[0] = $1; $1->parent = $$;
											 $$->child[1] = $3; $3->parent = $$;

											 if($1->lval != 1){
											 	printf("Not an Lvalue Expression\n");
											 	Totalerrors++;
											 }else{

												if($2->type==100){
													if ($1->type == INT && $3->type == CHAR){
							 							$$->type = $1->type;
							 						}
													else if($1->type != $3->type){
														printf("Invalid Operand for %s\n",$2->lexeme);
														Totalerrors++;
														//printf("= %d %d",$1->type,$3->type);
													}
													else
														$$->type = $1->type;
												}else{
													
													if($1->type!=INT || $3->type!=INT){
														printf("Invalid Operand for %s\n",$2->lexeme);
														Totalerrors++;
													}
													else
														$$->type = $1->type;
												} 

											}
											$$->lval = 0;
											}
	;
statement_list
	: statement   					{$$=$1;}
	| statement_list statement      
							{ $$ = MakeNode(2); $$->type =101; strcpy($$->lexeme,";");
							  $$->child[0] = $1; if($1 != NULL) $1->parent = $$;
							  $$->child[1] = $2;  if($2 != NULL) $2->parent = $$;
							}
	;

openB
		: '{'
		{
			if(open == 0)
				currentT = EnterScope(currentT);
			else{
				open = 0;
			}
		}
		;
closeB
		:	'}'
		{
			currentT = ExitScope(currentT);
		}
		;

body
        : openB statement_list closeB		{$$=$2;}
        ;

result_id 		
		: type IDENTIFIER 
							{
								open = 1;
								my.array = 3; my.pointer = 0; my.struct_member = 0; my.type = $1->type;
								AddSymbol($2.text,my,currentT);

								currentT = EnterScope(currentT);

								$$ = MakeNode(2); $$->type = $2.type; strcpy($$->lexeme,$2.text);
								$$->child[0] = $1; $1->parent = $$;
								$$->array = 50;

								returntype = $1->type;
								returnpointer = 0;

							}
		;

func_definition
	: result_id '(' argument_list ')' body		
								{

									$$ = $1;
								//	$$->child[1] = $3; $3->parent = $$;
									$$->child[1] = $5; $5->parent = $$;

									ALL[funcount] = (struct allFunc *)malloc(sizeof(struct allFunc));
									strcpy(ALL[funcount]->name,$1->lexeme);
									ALL[funcount]->t = $$;
									ALL[funcount]->arg = $3;
									ALL[funcount]->st = currentT->child[currentT->current - 1];
									funcount++;				
								}
	| result_id '(' ')' body {
									$$ = $1;
									$$->child[1] = $4; $4->parent = $$;
									//$$->NumChild -= 1;
									$$->array += 3;	


									ALL[funcount] = (struct allFunc *)malloc(sizeof(struct allFunc));
									strcpy(ALL[funcount]->name,$1->lexeme);
									ALL[funcount]->t = $$;
									ALL[funcount]->arg = NULL;
									ALL[funcount]->st = currentT->child[currentT->current - 1];		
									funcount++;						
								}
	
	;
root
	: declaration 	{$$=MakeNode(0); $$->type = -1;strcpy($$->lexeme,"dec");}
	| func_definition		{$$ = $1; tree = $$; }
	| root declaration {$$ = $1; tree = $$;}
	| root func_definition 	  
					{$$ = MakeNode(2); $$->type=1000; strcpy($$->lexeme,"@");
					 $$->child[0] = $1; $1->parent = $$;
					 $$->child[1] = $2; $2->parent = $$;
					tree = $$;	}
	;


%%
yyerror(s)
char *s;
{
        fflush(stdout);
		printf("Parse Error\n");
		return 0;
}
int main()
{
	open = 0;
	jumpcount=0;
	returntype=0;
	returnpointer=0;
	Totalerrors=0;
	funcount = 0;
	init();
	yyparse();
	depthSymbolTree(sym,1);
	printSymbolTree(sym);
	if(Totalerrors>0)
		printf("Total symantic errors: %d\n",Totalerrors);
	else{
		printf("Generating MIPS code...\n");
		GenerateMIPS();
	}
	
	return 0;
}
