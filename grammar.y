%{
    void yyerror (char* s);
    #include <stdio.h>
%}

%start statement
%token NAME
%token PROCESSOR
%token ISA
%token ARM
%token AMD
%token CDC
%token MIPS
%token CLOCK_SPEED
%token L1_MEMORY
%token L2_MEMORY
%token IS_RUNNING
%token SUBMIT_JOBS
%token GET_CLOCK_SPEED
%token RUN
%token DISCARD_JOB
%token MEMORY
%token MEMORY_TYPE
%token PRIMARY
%token SECONDARY
%token CACHE
%token MEM_SIZE
%token GET_AVAILABLE_MEMORY
%token GET_MEMORY
%token LINK
%token START_POINT
%token END_POINT
%token BANDWIDTH
%token CHANNEL_CAPACITY
%token JOB
%token JOB_ID
%token FLOPS_REQUIRED
%token DEADLINE
%token MEM_REQUIRED
%token AFFINITY
%token CLUSTER
%token PROCESSORS
%token TOPOLOGY
%token STAR
%token TREE
%token BUS
%token RING
%token MESH
%token LINK_BANDWIDTH
%token LINK_CAPACITY
%token CASE
%token DEFAULT
%token INT
%token FLOAT
%token STRING_LITERAL
%token ID
%token COLON
%token OPEN_CURLY
%token CLOSED_CURLY
%token EQUAL_TO
%token OPEN_SQUARE
%token CLOSED_SQUARE
%token INT_TYPE
%token FLOAT_TYPE
%token STRING_TYPE
%token SEMI
%token IF
%token SWITCH
%token WHILE
%token DO
%token FOR
%token OPEN_BRACKET
%token CONTINUE
%token BREAK
%token RETURN
%token DOT
%token PLUS_PLUS
%token MINUS_MINUS
%token NOT
%token MULTIPLY
%token ADD
%token SUB
%token DIV
%token MOD
%token LESS_THAN
%token GREATER_THAN
%token LESS_THAN_EQUAL
%token GREATER_THAN_EQUAL
%token NOT_EQUAL
%token EQUAL_EQUAL
%token AND
%token OR
%token QUE_MARK
%token QUOTE
%token GLOBAL_SCHEDULER
%token JOBS
%token POLICY
%token LOCAL_SCHEDULER
%token PID
%token FIFO
%token RR
%token LIFO
%token SJF
%token PRIORITY
%token GET_ASSIGNED_JOBS
%token GET_PROCESSOR
%token GET_EXEC_ORDER
%token GET_UNSCHEDULED_JOBS
%nonassoc CLOSED_BRACKET
%nonassoc ELSE
%nonassoc comma_prec
%nonassoc COMMA

%%

epsilon:
    %empty
;

statement:
    labeled-statement {printf("labeled-statement\n");}
    |compound-statement {printf("compound-statement\n");}
    |expression-statement {printf("expression-statement\n");}
    |selection-statement {printf("selection-statement\n");}
    |iteration-statement {printf("iteration-statement\n");}
    |jump-statement {printf("jump-statement\n");}
;

labeled-statement: 
    CASE constant-expression COLON statement {printf("CASE constant-expression COLON statement\n");}
    |DEFAULT COLON statement {printf("DEFAULT COLON statement\n");}
;

constant-expression:
    ID  {printf("ID \n");}
    |INT  {printf("INT \n");}
    |FLOAT {printf("FLOAT\n");}
;

compound-statement:
    OPEN_CURLY CLOSED_CURLY {printf("OPEN_CURLY CLOSED_CURLY\n");}
    |OPEN_CURLY declaration-list CLOSED_CURLY {printf("OPEN_CURLY declaration-list CLOSED_CURLY\n");}
    |OPEN_CURLY statement-list CLOSED_CURLY {printf("OPEN_CURLY statement-list CLOSED_CURLY\n");}
    |OPEN_CURLY declaration-list statement-list CLOSED_CURLY {printf("OPEN_CURLY declaration-list statement-list CLOSED_CURLY\n");}
;

declaration-list: 
    declaration {printf("declaration\n");}
    |declaration-list declaration {printf("declaration-list declaration\n");}
;

assignment-operator: 
    EQUAL_TO {printf("EQUAL_TO\n");}
;

declaration: 
    PROCESSOR ID assignment-operator Construct_Processor {printf("PROCESSOR ID assignment-operator Construct_Processor\n");}
    |MEMORY ID assignment-operator Construct_Memory {printf("MEMORY ID assignment-operator Construct_Memory\n");}
    |LINK ID assignment-operator Construct_Link {printf("LINK ID assignment-operator Construct_Link\n");}
    |JOB ID assignment-operator Construct_Job {printf("JOB ID assignment-operator Construct_Job\n");}
    |CLUSTER ID assignment-operator Construct_Cluster {printf("CLUSTER ID assignment-operator Construct_Cluster\n");}
    |GLOBAL_SCHEDULER ID assignment-operator Construct_Global_Scheduler {printf("GLOBAL_SCHEDULER ID assignment-operator Construct_Global_Scheduler\n");}
    |LOCAL_SCHEDULER ID assignment-operator Construct_Local_Scheduler  {printf("LOCAL_SCHEDULER ID assignment-operator Construct_Local_Scheduler \n");}
    |INT_TYPE ID assignment-operator assignment-expression {printf("INT_TYPE ID assignment-operator assignment-expression\n");}
    |FLOAT_TYPE ID assignment-operator assignment-expression  {printf("FLOAT_TYPE ID assignment-operator assignment-expression \n");}
    |STRING_TYPE ID assignment-operator primary-expression {printf("STRING_TYPE ID assignment-operator primary-expression\n");}
    |INT_TYPE ID OPEN_SQUARE  CLOSED_SQUARE  assignment-operator OPEN_CURLY argument-expression-list CLOSED_CURLY {printf("INT_TYPE ID OPEN_SQUARE  CLOSED_SQUARE  assignment-operator OPEN_CURLY argument-expression-list CLOSED_CURLY\n");}
    |FLOAT_TYPE ID OPEN_SQUARE  CLOSED_SQUARE  assignment-operator OPEN_CURLY argument-expression-list CLOSED_CURLY {printf("FLOAT_TYPE ID OPEN_SQUARE  CLOSED_SQUARE  assignment-operator OPEN_CURLY argument-expression-list CLOSED_CURLY\n");}
    |PROCESSOR ID OPEN_SQUARE  CLOSED_SQUARE  assignment-operator OPEN_CURLY CONSTRUCTOR_LIST CLOSED_CURLY {printf("PROCESSOR ID OPEN_SQUARE  CLOSED_SQUARE  assignment-operator OPEN_CURLY CONSTRUCTOR_LIST CLOSED_CURLY\n");}
    |LOCAL_SCHEDULER ID OPEN_SQUARE  CLOSED_SQUARE  assignment-operator OPEN_CURLY CONSTRUCTOR_LIST CLOSED_CURLY {printf("LOCAL_SCHEDULER ID OPEN_SQUARE  CLOSED_SQUARE  assignment-operator OPEN_CURLY CONSTRUCTOR_LIST CLOSED_CURLY\n");}
    |CLUSTER ID OPEN_SQUARE  CLOSED_SQUARE  assignment-operator OPEN_CURLY CONSTRUCTOR_LIST CLOSED_CURLY {printf("CLUSTER ID OPEN_SQUARE  CLOSED_SQUARE  assignment-operator OPEN_CURLY CONSTRUCTOR_LIST CLOSED_CURLY\n");}
    |JOB ID OPEN_SQUARE  CLOSED_SQUARE  assignment-operator OPEN_CURLY CONSTRUCTOR_LIST CLOSED_CURLY {printf("JOB ID OPEN_SQUARE  CLOSED_SQUARE  assignment-operator OPEN_CURLY CONSTRUCTOR_LIST CLOSED_CURLY\n");}
    |MEMORY ID OPEN_SQUARE  CLOSED_SQUARE  assignment-operator OPEN_CURLY CONSTRUCTOR_LIST CLOSED_CURLY {printf("MEMORY ID OPEN_SQUARE  CLOSED_SQUARE  assignment-operator OPEN_CURLY CONSTRUCTOR_LIST CLOSED_CURLY\n");}
    |LINK ID OPEN_SQUARE  CLOSED_SQUARE  assignment-operator OPEN_CURLY CONSTRUCTOR_LIST CLOSED_CURLY {printf("LINK ID OPEN_SQUARE  CLOSED_SQUARE  assignment-operator OPEN_CURLY CONSTRUCTOR_LIST CLOSED_CURLY\n");}
    |INT_TYPE ID OPEN_SQUARE INT CLOSED_SQUARE  {printf("INT_TYPE ID OPEN_SQUARE INT CLOSED_SQUARE \n");}
    |FLOAT_TYPE ID OPEN_SQUARE INT CLOSED_SQUARE  {printf("FLOAT_TYPE ID OPEN_SQUARE INT CLOSED_SQUARE \n");}
    |PROCESSOR ID OPEN_SQUARE INT CLOSED_SQUARE  {printf("PROCESSOR ID OPEN_SQUARE INT CLOSED_SQUARE \n");}
    |CLUSTER ID OPEN_SQUARE INT CLOSED_SQUARE  {printf("CLUSTER ID OPEN_SQUARE INT CLOSED_SQUARE \n");}
    |JOB ID OPEN_SQUARE INT CLOSED_SQUARE  {printf("JOB ID OPEN_SQUARE INT CLOSED_SQUARE \n");}
    |MEMORY ID OPEN_SQUARE INT CLOSED_SQUARE  {printf("MEMORY ID OPEN_SQUARE INT CLOSED_SQUARE \n");}
    |LINK ID OPEN_SQUARE INT CLOSED_SQUARE  {printf("LINK ID OPEN_SQUARE INT CLOSED_SQUARE \n");}
    |LOCAL_SCHEDULER ID OPEN_SQUARE INT CLOSED_SQUARE  {printf("LOCAL_SCHEDULER ID OPEN_SQUARE INT CLOSED_SQUARE \n");}
;

statement-list: 
    statement {printf("statement\n");}
    |statement-list statement {printf("statement-list statement\n");}
;

expression-statement: 
    SEMI {printf("SEMI\n");}
    |expression SEMI {printf("expression SEMI\n");}
;

expression:
    assignment-expression {printf("assignment-expression\n");}
    |expression COMMA assignment-expression   {printf("expression COMMA assignment-expression  \n");}
;  

selection-statement: 
    IF OPEN_BRACKET expression CLOSED_BRACKET statement {printf("IF OPEN_BRACKET expression CLOSED_BRACKET statement\n");}
    |IF OPEN_BRACKET expression CLOSED_BRACKET statement ELSE statement {printf("IF OPEN_BRACKET expression CLOSED_BRACKET statement ELSE statement\n");}
    |SWITCH OPEN_BRACKET expression CLOSED_BRACKET statement {printf("SWITCH OPEN_BRACKET expression CLOSED_BRACKET statement\n");}
;

iteration-statement: 
    WHILE OPEN_BRACKET expression CLOSED_BRACKET statement {printf("WHILE OPEN_BRACKET expression CLOSED_BRACKET statement\n");}
    |DO statement WHILE OPEN_BRACKET expression CLOSED_BRACKET SEMI {printf("DO statement WHILE OPEN_BRACKET expression CLOSED_BRACKET SEMI\n");}
    |FOR OPEN_BRACKET            SEMI            SEMI            CLOSED_BRACKET statement {printf("FOR OPEN_BRACKET            SEMI            SEMI            CLOSED_BRACKET statement\n");}
    |FOR OPEN_BRACKET            SEMI            SEMI expression CLOSED_BRACKET statement {printf("FOR OPEN_BRACKET            SEMI            SEMI expression CLOSED_BRACKET statement\n");}
    |FOR OPEN_BRACKET            SEMI expression SEMI            CLOSED_BRACKET statement {printf("FOR OPEN_BRACKET            SEMI expression SEMI            CLOSED_BRACKET statement\n");}
    |FOR OPEN_BRACKET            SEMI expression SEMI expression CLOSED_BRACKET statement {printf("FOR OPEN_BRACKET            SEMI expression SEMI expression CLOSED_BRACKET statement\n");}
    |FOR OPEN_BRACKET expression SEMI            SEMI            CLOSED_BRACKET statement {printf("FOR OPEN_BRACKET expression SEMI            SEMI            CLOSED_BRACKET statement\n");}
    |FOR OPEN_BRACKET expression SEMI            SEMI expression CLOSED_BRACKET statement {printf("FOR OPEN_BRACKET expression SEMI            SEMI expression CLOSED_BRACKET statement\n");}
    |FOR OPEN_BRACKET expression SEMI expression SEMI            CLOSED_BRACKET statement {printf("FOR OPEN_BRACKET expression SEMI expression SEMI            CLOSED_BRACKET statement\n");}
    |FOR OPEN_BRACKET expression SEMI expression SEMI expression CLOSED_BRACKET statement {printf("FOR OPEN_BRACKET expression SEMI expression SEMI expression CLOSED_BRACKET statement\n");}
;

jump-statement: 
    CONTINUE SEMI {printf("CONTINUE SEMI\n");}
    |BREAK SEMI {printf("BREAK SEMI\n");}
    |RETURN SEMI {printf("RETURN SEMI\n");}
    |RETURN expression SEMI {printf("RETURN expression SEMI\n");}
;

primary-expression: 
    ID {printf("ID\n");}
    |INT {printf("INT\n");}
    |FLOAT {printf("FLOAT\n");}
    |OPEN_BRACKET expression CLOSED_BRACKET {printf("OPEN_BRACKET expression CLOSED_BRACKET\n");}
;


postfix-expression:
    primary-expression {printf("primary-expression\n");}
    |postfix-expression  OPEN_SQUARE  expression  CLOSED_SQUARE  {printf("postfix-expression  OPEN_SQUARE  expression  CLOSED_SQUARE \n");}
    |GLOBAL_SCHEDULER_MEMBER_FUNCTION_FREE {printf("GLOBAL_SCHEDULER_MEMBER_FUNCTION_FREE\n");}
    |PROCESSOR_MEMBER_FUNCTION_FREE  {printf("PROCESSOR_MEMBER_FUNCTION_FREE \n");}
    |constructor {printf("constructor\n");}
    |postfix-expression DOT LOCAL_SCHEDULER_MEMBER_FUNCTION_DOT {printf("postfix-expression DOT LOCAL_SCHEDULER_MEMBER_FUNCTION_DOT\n");}
    |postfix-expression DOT PROCESSOR_MEMBER_FUNCTION_DOT  {printf("postfix-expression DOT PROCESSOR_MEMBER_FUNCTION_DOT \n");}
    |postfix-expression DOT MEMORY_MEMBER_FUNCTION_DOT  {printf("postfix-expression DOT MEMORY_MEMBER_FUNCTION_DOT \n");}
    |postfix-expression DOT JOB_MEMBER_FUNCTION_DOT  {printf("postfix-expression DOT JOB_MEMBER_FUNCTION_DOT \n");}
    |postfix-expression OPEN_BRACKET CLOSED_BRACKET  {printf("postfix-expression OPEN_BRACKET CLOSED_BRACKET \n");}
    |postfix-expression OPEN_BRACKET argument-expression-list CLOSED_BRACKET {printf("postfix-expression OPEN_BRACKET argument-expression-list CLOSED_BRACKET\n");}
    |postfix-expression PLUS_PLUS {printf("postfix-expression PLUS_PLUS\n");}
    |postfix-expression MINUS_MINUS {printf("postfix-expression MINUS_MINUS\n");}
;

argument-expression-list:
    assignment-expression {printf("assignment-expression\n");}
    | argument-expression-list COMMA assignment-expression {printf("argument-expression-list COMMA assignment-expression\n");}
;

unary-expression:
    postfix-expression {printf("postfix-expression\n");}
    |PLUS_PLUS unary-expression {printf("PLUS_PLUS unary-expression\n");}
    |MINUS_MINUS unary-expression {printf("MINUS_MINUS unary-expression\n");}
    |NOT unary-expression {printf("NOT unary-expression\n");}
;

multiplicative-expression: 
    unary-expression {printf("unary-expression\n");}
    |multiplicative-expression MULTIPLY unary-expression {printf("multiplicative-expression MULTIPLY unary-expression\n");}
    |multiplicative-expression DIV unary-expression {printf("multiplicative-expression DIV unary-expression\n");}
    |multiplicative-expression MOD unary-expression {printf("multiplicative-expression MOD unary-expression\n");}
;

additive-expression: 
    multiplicative-expression {printf("multiplicative-expression\n");}
    |additive-expression ADD multiplicative-expression {printf("additive-expression ADD multiplicative-expression\n");}
    |additive-expression SUB multiplicative-expression {printf("additive-expression SUB multiplicative-expression\n");}
;

relational-expression:
    additive-expression {printf("additive-expression\n");}
    |relational-expression LESS_THAN additive-expression {printf("relational-expression LESS_THAN additive-expression\n");}
    |relational-expression GREATER_THAN additive-expression {printf("relational-expression GREATER_THAN additive-expression\n");}
    |relational-expression LESS_THAN_EQUAL additive-expression {printf("relational-expression LESS_THAN_EQUAL additive-expression\n");}
    |relational-expression GREATER_THAN_EQUAL additive-expression {printf("relational-expression GREATER_THAN_EQUAL additive-expression\n");}
;

equality-expression: 
    relational-expression {printf("relational-expression\n");}
    |equality-expression assignment-operator relational-expression {printf("equality-expression assignment-operator relational-expression\n");}
    |equality-expression NOT_EQUAL relational-expression {printf("equality-expression NOT_EQUAL relational-expression\n");}
;

logical-AND-expression: 
    equality-expression {printf("equality-expression\n");}
    |logical-AND-expression AND equality-expression {printf("logical-AND-expression AND equality-expression\n");}
;

logical-OR-expression:
    logical-AND-expression {printf("logical-AND-expression\n");}
    |logical-OR-expression OR logical-AND-expression {printf("logical-OR-expression OR logical-AND-expression\n");}
;

conditional-expression: 
    logical-OR-expression {printf("logical-OR-expression\n");}
    |logical-OR-expression QUE_MARK expression COLON conditional-expression {printf("logical-OR-expression QUE_MARK expression COLON conditional-expression\n");}
;

assignment-expression:
    conditional-expression {printf("conditional-expression\n");}
    |unary-expression assignment-operator assignment-expression {printf("unary-expression assignment-operator assignment-expression\n");}
;

constructor: 
    Construct_Processor   {printf("Construct_Processor  \n");}
    |Construct_Memory   {printf("Construct_Memory  \n");}
    |Construct_Link   {printf("Construct_Link  \n");}
    |Construct_Job   {printf("Construct_Job  \n");}
    |Construct_Cluster {printf("Construct_Cluster\n");}
    |Construct_Global_Scheduler {printf("Construct_Global_Scheduler\n");}
    |Construct_Local_Scheduler {printf("Construct_Local_Scheduler\n");}
;

CONSTRUCTOR_LIST:
    CONSTRUCTOR_LIST_PRIME COMMA CONSTRUCTOR_LIST {printf("CONSTRUCTOR_LIST_PRIME COMMA CONSTRUCTOR_LIST \n");}
    |CONSTRUCTOR_LIST_PRIME %prec comma_prec {printf("CONSTRUCTOR_LIST_PRIME\n");}
;

CONSTRUCTOR_LIST_PRIME:
    ID {printf("ID\n");}
    |constructor {printf("constructor\n");}
;

name: 
    epsilon {printf("EPSILON\n");}
   |COMMA primary-expression   {printf("COMMA primary-expression\n");}
   |COMMA NAME assignment-operator primary-expression  {printf("COMMA NAME assignment-operator primary-expression \n");}
;

Construct_Global_Scheduler: 
    GLOBAL_SCHEDULER OPEN_BRACKET GLOBAL_SCHEDULER_PARAM_LIST CLOSED_BRACKET {printf("GLOBAL_SCHEDULER OPEN_BRACKET GLOBAL_SCHEDULER_PARAM_LIST CLOSED_BRACKET\n");}
;

GLOBAL_SCHEDULER_PARAM_LIST: 
    jobs policy     {printf("jobs policy    \n");}
;

jobs: 
    JOBS assignment-operator  OPEN_SQUARE CONSTRUCTOR_LIST CLOSED_SQUARE    {printf("JOBS assignment-operator  OPEN_SQUARE CONSTRUCTOR_LIST CLOSED_SQUARE   \n");}
    |OPEN_SQUARE CONSTRUCTOR_LIST CLOSED_SQUARE    {printf("OPEN_SQUARE CONSTRUCTOR_LIST CLOSED_SQUARE   \n");}
    |JOBS assignment-operator CONSTRUCTOR_LIST   {printf("JOBS assignment-operator CONSTRUCTOR_LIST  \n");}
    |CONSTRUCTOR_LIST {printf("CONSTRUCTOR_LIST\n");}
;

policy:
    epsilon {printf("EPSILON\n");}
    |COMMA POLICY assignment-operator primary-expression {printf("COMMA POLICY assignment-operator primary-expression\n");}
    |COMMA primary-expression {printf("COMMA primary-expression\n");}
;

Construct_Local_Scheduler:
    LOCAL_SCHEDULER OPEN_BRACKET LOCAL_SCHEDULER_PARAM_LIST CLOSED_BRACKET {printf("LOCAL_SCHEDULER OPEN_BRACKET LOCAL_SCHEDULER_PARAM_LIST CLOSED_BRACKET\n");}
;

LOCAL_SCHEDULER_PARAM_LIST:
    jobs COMMA PROCESSOR_ID SCHEDULE_POLICY {printf("jobs COMMA PROCESSOR_ID SCHEDULE_POLICY\n");}
;

PROCESSOR_ID:
    PID assignment-operator primary-expression {printf("PID assignment-operator primary-expression\n");}
    |primary-expression {printf("primary-expression\n");}
;

SCHEDULE_POLICY: 
    epsilon {printf("EPSILON\n");}
    |COMMA priority {printf("COMMA priority\n");}
    |COMMA POLICY assignment-operator POLICY_VALUES SCHEDULE_POLICY {printf("COMMA POLICY assignment-operator POLICY_VALUES SCHEDULE_POLICY\n");}
    |COMMA POLICY_VALUES SCHEDULE_POLICY {printf("COMMA POLICY_VALUES SCHEDULE_POLICY\n");}
;

POLICY_VALUES: 
    FIFO {printf("FIFO\n");}
    |RR {printf("RR\n");}
    |LIFO {printf("LIFO\n");}
    |SJF {printf("SJF\n");}
    |ID {printf("ID\n");}
;

priority: 
    PRIORITY assignment-operator OPEN_SQUARE argument-expression-list CLOSED_SQUARE  {printf("PRIORITY assignment-operator OPEN_SQUARE argument-expression-list CLOSED_SQUARE \n");}
    |OPEN_SQUARE argument-expression-list CLOSED_SQUARE  {printf("OPEN_SQUARE argument-expression-list CLOSED_SQUARE \n");}
;

Construct_Processor: 
    PROCESSOR OPEN_BRACKET PROC_PARAM_LIST CLOSED_BRACKET  {printf("PROCESSOR OPEN_BRACKET PROC_PARAM_LIST CLOSED_BRACKET \n");}
;

PROC_PARAM_LIST: 
    isa COMMA clock_speed COMMA l1_memory l2_memory {printf("isa COMMA clock_speed COMMA l1_memory l2_memory\n");}
;

isa: 
    ISA assignment-operator ISA_VALUES   {printf("ISA assignment-operator ISA_VALUES  \n");}
    |ISA_VALUES {printf("ISA_VALUES\n");}
;

ISA_VALUES:
    ARM   {printf("ARM  \n");}
    |AMD   {printf("AMD  \n");}
    |CDC   {printf("CDC  \n");}
    |MIPS   {printf("MIPS  \n");}
    |ID {printf("ID\n");}
;

clock_speed: 
    CLOCK_SPEED assignment-operator assignment-expression   {printf("CLOCK_SPEED assignment-operator assignment-expression  \n");}
    |assignment-expression {printf("assignment-expression\n");}
;

l1_memory: 
    L1_MEMORY assignment-operator CONSTRUCTOR_LIST {printf("L1_MEMORY assignment-operator CONSTRUCTOR_LIST  \n");}
    |CONSTRUCTOR_LIST {printf("CONSTRUCTOR_LIST\n");}
;

l2_memory:  
    epsilon {printf("EPSILON\n");}
    |COMMA name_prime {printf("COMMA name_prime\n");}
    |COMMA L2_MEMORY assignment-operator CONSTRUCTOR_LIST l2_memory {printf("COMMA L2_MEMORY assignment-operator CONSTRUCTOR_LIST l2_memory \n");}
    |COMMA CONSTRUCTOR_LIST l2_memory {printf("COMMA CONSTRUCTOR_LIST l2_memory \n");}
;

name_prime:
    primary-expression   {printf("primary-expression\n");}
   |NAME assignment-operator primary-expression  {printf("NAME assignment-operator primary-expression \n");}   
;

Construct_Memory: 
    MEMORY OPEN_BRACKET MEM_PARAM_LIST CLOSED_BRACKET {printf("MEMORY OPEN_BRACKET MEM_PARAM_LIST CLOSED_BRACKET\n");}
;

MEM_PARAM_LIST:  
    memory_type COMMA mem_size name {printf("memory_type COMMA mem_size name\n");}
;

memory_type:   
    MEMORY_TYPE assignment-operator MEM_TYPE_VALUES   {printf("MEMORY_TYPE assignment-operator MEM_TYPE_VALUES  \n");}
    |MEM_TYPE_VALUES {printf("MEM_TYPE_VALUES\n");}
;

MEM_TYPE_VALUES:
    PRIMARY   {printf("PRIMARY  \n");}
    |SECONDARY   {printf("SECONDARY  \n");}
    |CACHE {printf("CACHE\n");}
    |ID {printf("ID\n");}
;

mem_size:   
    MEM_SIZE assignment-operator assignment-expression   {printf("MEM_SIZE assignment-operator assignment-expression  \n");}
    |assignment-expression {printf("assignment-expression\n");}
;

Construct_Link: 
    LINK OPEN_BRACKET LINK_PARAM_LIST CLOSED_BRACKET {printf("LINK OPEN_BRACKET LINK_PARAM_LIST CLOSED_BRACKET\n");}
;

LINK_PARAM_LIST:
    start_point COMMA end_point COMMA bandwidth COMMA channel_capacity name {printf("start_point COMMA end_point COMMA bandwidth COMMA channel_capacity name\n");}
;

start_point:  
    START_POINT assignment-operator primary-expression  {printf("START_POINT assignment-operator primary-expression \n");}
    |primary-expression {printf("primary-expression\n");}
;

end_point: 
    END_POINT assignment-operator primary-expression  {printf("END_POINT assignment-operator primary-expression \n");}
    |primary-expression {printf("primary-expression\n");}
;

bandwidth: 
    BANDWIDTH assignment-operator assignment-expression   {printf("BANDWIDTH assignment-operator assignment-expression  \n");}
    |assignment-expression {printf("assignment-expression\n");}
;  

channel_capacity: 
    CHANNEL_CAPACITY assignment-operator assignment-expression   {printf("CHANNEL_CAPACITY assignment-operator assignment-expression  \n");}
    |assignment-expression {printf("assignment-expression\n");}
;

Construct_Job:  
    JOB OPEN_BRACKET JOB_PARAM_LIST CLOSED_BRACKET {printf("JOB OPEN_BRACKET JOB_PARAM_LIST CLOSED_BRACKET\n");}
;

JOB_PARAM_LIST:  
    job_id COMMA flops_required COMMA deadline COMMA mem_required COMMA affinity {printf("job_id COMMA flops_required COMMA deadline COMMA mem_required COMMA affinity\n");}
;

job_id:  
    JOB_ID assignment-operator assignment-expression   {printf("JOB_ID assignment-operator assignment-expression  \n");}
    |assignment-expression {printf("assignment-expression\n");}
;

flops_required:   
    FLOPS_REQUIRED assignment-operator assignment-expression   {printf("FLOPS_REQUIRED assignment-operator assignment-expression  \n");}
    |assignment-expression {printf("assignment-expression\n");}
;

deadline:   
    DEADLINE assignment-operator assignment-expression   {printf("DEADLINE assignment-operator assignment-expression  \n");}
    |assignment-expression {printf("assignment-expression\n");}
;

mem_required: 
    MEM_REQUIRED assignment-operator assignment-expression   {printf("MEM_REQUIRED assignment-operator assignment-expression  \n");}
    |assignment-expression {printf("assignment-expression\n");}
;

affinity:  
    AFFINITY assignment-operator OPEN_SQUARE assignment-expression COMMA assignment-expression COMMA assignment-expression COMMA assignment-expression CLOSED_SQUARE   {printf("AFFINITY assignment-operator OPEN_SQUARE assignment-expression COMMA assignment-expression COMMA assignment-expression COMMA assignment-expression CLOSED_SQUARE  \n");}
    |OPEN_SQUARE assignment-expression COMMA assignment-expression COMMA assignment-expression COMMA assignment-expression CLOSED_SQUARE     {printf("OPEN_SQUARE assignment-expression COMMA assignment-expression COMMA assignment-expression COMMA assignment-expression CLOSED_SQUARE    \n");}
    |ID {printf("ID\n");}
    |AFFINITY assignment-operator ID {printf("AFFINITY assignment-operator ID\n");}
;

Construct_Cluster: 
    CLUSTER OPEN_BRACKET CLUSTER_PARAM_LIST CLOSED_BRACKET {printf("CLUSTER OPEN_BRACKET CLUSTER_PARAM_LIST CLOSED_BRACKET\n");}
;

CLUSTER_PARAM_LIST:  
    processors COMMA topology COMMA link_bandwidth COMMA link_capacity name {printf("processors COMMA topology COMMA link_bandwidth COMMA link_capacity name\n");}
;

processors: 
    PROCESSORS assignment-operator  OPEN_SQUARE CONSTRUCTOR_LIST CLOSED_SQUARE    {printf("PROCESSORS assignment-operator  OPEN_SQUARE CONSTRUCTOR_LIST CLOSED_SQUARE   \n");}
    |OPEN_SQUARE CONSTRUCTOR_LIST CLOSED_SQUARE    {printf("OPEN_SQUARE CONSTRUCTOR_LIST CLOSED_SQUARE   \n");}
;

topology:
    TOPOLOGY assignment-operator TOPOLOGY_VALUES   {printf("TOPOLOGY assignment-operator TOPOLOGY_VALUES  \n");}
    |TOPOLOGY_VALUES {printf("TOPOLOGY_VALUES\n");}
;

TOPOLOGY_VALUES:
    TREE   {printf("TREE  \n");}
    |BUS   {printf("BUS  \n");}
    |RING   {printf("RING  \n");}
    |STAR   {printf("STAR  \n");}
    |MESH {printf("MESH\n");}
    |ID {printf("ID\n");}
;

link_bandwidth:  
    LINK_BANDWIDTH assignment-operator assignment-expression   {printf("LINK_BANDWIDTH assignment-operator assignment-expression  \n");}
    |assignment-expression {printf("assignment-expression\n");}
;

link_capacity: 
    LINK_CAPACITY assignment-operator assignment-expression   {printf("LINK_CAPACITY assignment-operator assignment-expression  \n");}
    |assignment-expression {printf("assignment-expression\n");}
;

PROCESSOR_MEMBER_FUNCTION_DOT:  
    is_running   {printf("is_running  \n");}
    |submit_jobs   {printf("submit_jobs  \n");}
    |get_clock_speed {printf("get_clock_speed\n");}
;

PROCESSOR_MEMBER_FUNCTION_FREE:  
    run   {printf("run  \n");}
    |discard_job {printf("discard_job\n");}
;

is_running:   
    IS_RUNNING OPEN_BRACKET CLOSED_BRACKET {printf("IS_RUNNING OPEN_BRACKET CLOSED_BRACKET\n");}
;

submit_jobs: 
    SUBMIT_JOBS OPEN_BRACKET SUBMIT_JOB_PARAM CLOSED_BRACKET {printf("SUBMIT_JOBS OPEN_BRACKET SUBMIT_JOB_PARAM CLOSED_BRACKET\n");}
;

SUBMIT_JOB_PARAM:  
    assignment-expression   {printf("assignment-expression  \n");}
    | OPEN_SQUARE argument-expression-list CLOSED_SQUARE  {printf(" OPEN_SQUARE argument-expression-list CLOSED_SQUARE \n");}
;

get_clock_speed:  
    GET_CLOCK_SPEED OPEN_BRACKET CLOSED_BRACKET {printf("GET_CLOCK_SPEED OPEN_BRACKET CLOSED_BRACKET\n");}
;

run:  
    RUN OPEN_BRACKET RUN_PARAM_LIST CLOSED_BRACKET {printf("RUN OPEN_BRACKET RUN_PARAM_LIST CLOSED_BRACKET\n");}
;

RUN_PARAM_LIST:  
    CONSTRUCTOR_LIST  {printf("CONSTRUCTOR_LIST \n");}
    |OPEN_SQUARE CONSTRUCTOR_LIST CLOSED_SQUARE  {printf("OPEN_SQUARE CONSTRUCTOR_LIST CLOSED_SQUARE \n");}
;

discard_job: 
    DISCARD_JOB OPEN_BRACKET ID CLOSED_BRACKET {printf("DISCARD_JOB OPEN_BRACKET ID CLOSED_BRACKET\n");}
;

MEMORY_MEMBER_FUNCTION_DOT:  
    get_available_memory {printf("get_available_memory\n");}
;

get_available_memory: 
    GET_AVAILABLE_MEMORY OPEN_BRACKET CLOSED_BRACKET {printf("GET_AVAILABLE_MEMORY OPEN_BRACKET CLOSED_BRACKET\n");}
;

JOB_MEMBER_FUNCTION_DOT:
    get_memory {printf("get_memory\n");}
;

get_memory: 
    GET_MEMORY OPEN_BRACKET CLOSED_BRACKET {printf("GET_MEMORY OPEN_BRACKET CLOSED_BRACKET\n");}
;

GLOBAL_SCHEDULER_MEMBER_FUNCTION_FREE:
    get_assigned_jobs {printf("get_assigned_jobs\n");}
    |get_processor {printf("get_processor\n");}
;

get_assigned_jobs:
    GET_ASSIGNED_JOBS OPEN_BRACKET GET_ASSIGNED_JOBS_PARAM CLOSED_BRACKET {printf("GET_ASSIGNED_JOBS OPEN_BRACKET GET_ASSIGNED_JOBS_PARAM CLOSED_BRACKET\n");}
;

GET_ASSIGNED_JOBS_PARAM: 
    PID assignment-operator primary-expression   {printf("PID assignment-operator primary-expression  \n");}
    |primary-expression {printf("primary-expression\n");}
;

get_processor:
    GET_PROCESSOR OPEN_BRACKET GET_PROCESSOR_PARAM CLOSED_BRACKET {printf("GET_PROCESSOR OPEN_BRACKET GET_PROCESSOR_PARAM CLOSED_BRACKET\n");}
;

GET_PROCESSOR_PARAM: 
    JOB_ID assignment-operator assignment-expression {printf("JOB_ID assignment-operator assignment-expression\n");}
    |assignment-expression {printf("assignment-expression\n");}
;

LOCAL_SCHEDULER_MEMBER_FUNCTION_DOT: 
    get_exec_order {printf("get_exec_order\n");}
    |get_unscheduled_jobs  {printf("get_unscheduled_jobs \n");}
;

get_exec_order:  
    GET_EXEC_ORDER OPEN_BRACKET CLOSED_BRACKET {printf("GET_EXEC_ORDER OPEN_BRACKET CLOSED_BRACKET\n");}
;

get_unscheduled_jobs: 
    GET_UNSCHEDULED_JOBS OPEN_BRACKET CLOSED_BRACKET {printf("GET_UNSCHEDULED_JOBS OPEN_BRACKET CLOSED_BRACKET\n");}
;

%%

void yyerror (char *s) {fprintf (stderr, "%s\n",s);}

int main(){
    yyparse();
    printf("statement\n");
}
