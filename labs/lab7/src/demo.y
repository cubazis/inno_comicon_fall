%{
    #define DEBUG
    #include <cstdio>
    #include <string>
    #include <iostream>
    #include <stack>
    
    using namespace std;
    #define YYSTYPE string
    #define YYERROR_VERBOSE 1
    
    typedef pair <string, int> meta_data;
    typedef stack <meta_data> meta_stack;

    static meta_stack class_st;
    static meta_stack func_st;
    static string func_name = "";
    static string call_params = "";
    static string file_name = "";

    static void clean_stack( meta_stack& stack, int indent );

    int  wrapRet = 1;
    
    int yylex(void);
    extern "C" {
        int yywrap( void ) {
            return wrapRet;
        }
    }
    void yyerror(const char *str) {
    }    
    extern FILE* yyin;   

    static const string type = "undefined";
    static bool isInteractive;
    int main();
    static string get_call_function_name_from_call_chain(string call_chain);
%}

%token CLASS DEFINED COLON DOT LBRACE RBRACE ID OTHER DEF COMMA STAR MESSAGE
%start input

%left RBRACE
%left LBRACE

%%
input: /* empty */
     | input class_def
     | input func_def
     | input calls_chain
     | input error
;

/* CLASS */
class_def: CLASS classname inheritance COLON suite
    {
        int indent = @1.last_column;
        meta_data new_class($2, indent);

        clean_stack( class_st, indent );
        class_st.push( new_class );

        #ifdef DEBUG
            cout //<< "[" << indent << "] "
                 << @$.first_line
                 << " ☭ CLASS: "
                 << $2            << "("
                 << $3            << ")"
                 << endl;
        #endif
    }
;
classname: ID
            {
                $$ = $1;
            }
;
inheritance: /* empty */
            {
                $$ = "";
            }
           | LBRACE class_args_list RBRACE
            {
                $$ = $2;
            }
;
class_args_list: /* empty */
                {
                    $$ = "";
                }
               | class_arg
                {
                    $$ = $1;
                }
;
class_arg:  dotted_name
          | class_arg COMMA dotted_name
            {
                $$ += $2 + $3;
            }
;
/* end of CLASS */

/* FUNCTION */
func_def: DEF funcname LBRACE func_args_list RBRACE COLON suite
        {
            string fnc_name = $2;
            int indent = @1.last_column;
              
            clean_stack( class_st, indent );
            meta_stack tmp_class_st(class_st);

            while (!tmp_class_st.empty())
            {
                tmp_class_st.pop();
            }

            meta_data new_func(fnc_name, indent);
            clean_stack( func_st, indent );
            func_st.push( new_func );

            #ifdef DEBUG
                cout //<< "[" << indent << "] "
                     << @$.first_line << " ☭ FUNC:  "
                     << fnc_name      << "("
                     << $4            << ")"
                     << endl;
            #endif
        }
;
funcname: ID
        {
            $$ = $1;
        }
;
func_args_list: /* empty */
                {
                    $$ = "";
                }
              | func_arg
                {
                    $$ = $1;
                }
;
func_arg: dotted_name
        | star_arg
        | calls_chain
        | func_arg OTHER
            {
                $$ += $2;
            }
        | func_arg COMMA
            {
                $$ += $2;
            }
        | func_arg dotted_name
            {
                $$ += $2;
            }
        | func_arg star_arg
            {
                $$ += $2;
            }
        | func_arg MESSAGE
            {
                $$ += $2;
            }
        | func_arg calls_chain
            {
                $$ += $2;
            }
;
star_arg: STAR ID
            {
                $$ = $1 + $2;
            }
        | STAR STAR ID
            {
                $$ = $1 + $2 + $3;
            }
;
/* end of FUNCTION */

suite:
;

/* FUNCTION CALL */
calls_chain: func_call
            {
                string cd = get_call_function_name_from_call_chain($$);
                #ifdef DEBUG
                     cout //<< "[" << @$.last_column << "] "
                          << @$.first_line
                          << " Function1: " << func_name 
                          << " ☭ CALL: "  << cd
                          << " ☭ PARAM: " << call_params
                          << endl;
                #endif

            }
           | calls_chain DOT func_call
            {
                $$ += $2 + $3;
                string cd = get_call_function_name_from_call_chain($$);

                #ifdef DEBUG
                     cout //<< "[" << @$.last_column << "] "
                          << @$.first_line 
                          << " Function2: " << func_name 
                          << " ☭ CALL: "  << cd
                          << " ☭ PARAM: " << call_params << endl;
                #endif
            }
;
func_call: dotted_name func_call_params
            {
                bool isFirst = true;

                func_name = "";
                int indent = @1.last_column;

                clean_stack(func_st, indent);
                meta_stack tmp_func_st(func_st);

                while (!tmp_func_st.empty())
                {
                    if(true == isFirst)
                    {
                        func_name = tmp_func_st.top().first;
                        tmp_func_st.pop();
                        isFirst = false;
                        continue;
                    }

                    tmp_func_st.pop();
                }

                if (func_name == "") {
                    func_name = "__main__";
                }

                $$ = $1 + $2;
            }
;
dotted_name: ID
           | dotted_name DOT ID
            {
                $$ += $2 + $3;
            }
;
func_call_params: LBRACE RBRACE
                    {
                        call_params = "";
                        $$ = $1 + $2;
                    }
                | LBRACE call_params RBRACE
                    {
                        call_params = $2;
                        $$ = $1 + $2 + $3;
                    }
;
call_params: OTHER
           | DEFINED
           | MESSAGE
           | dotted_name
           | STAR
           | calls_chain
           | func_call_params
           | call_params DEFINED
            {
                $$ += $2;
            }
           | call_params MESSAGE
            {
                $$ += $2;
            }
           | call_params dotted_name
            {
                $$ += $2;
            }
           | call_params OTHER
            {
                $$ += $2;
            }
           | call_params calls_chain
            {
                $$ += $2;
            }
           | call_params COMMA
            {
                $$ += $2;
            }
           | call_params COLON
            {
                $$ += $2;
            }
           | call_params STAR
            {
                $$ += $2;
            }
           | call_params func_call_params
            {
                $$ += $2;
            }
;
/* end of FUNCTION CALL */

%%

static void clean_stack(meta_stack& stack, int indent)
{
    while(!stack.empty())
    {
        if(indent > stack.top().second)
            break;
        stack.pop();
    }
}

static string get_call_function_name_from_call_chain(string call_chain)
{
    int braces = 0;
    string name = "";
    for (int i = call_chain.length()-1; i > 0; i--)
    {
        switch (call_chain[i])
        {
            case ')':   braces ++;
                        continue;
            case '(':   braces --;
                        if (braces == 0) {
                            for (int j = i-1; j >= 0; j--)
                            {
                                if (call_chain[j] != '.') {
                                    name = call_chain[j] + name;
                                }
                                else {
                                    return name;
                                }
                            }
                            return name;
                        }
            default: ;
        }
    }
    return name;
}

int main()
{
    return yyparse();
}