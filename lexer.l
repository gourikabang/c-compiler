%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "grammar.tab.h"
%}

%%
,							 return COMMA;

"Global_Scheduler"	return GLOBAL_SCHEDULER;
"jobs"				return JOBS;
"policy"			return POLICY;
"Local_Scheduler"	return LOCAL_SCHEDULER;
"pid"				return PID;
"\"FIFO\""			return FIFO;
"\"RR\""			return RR;
"\"LIFO\""			return LIFO;
"\"SJF\""			return SJF;
"priority"			return PRIORITY;
"get_assigned_jobs"	return GET_ASSIGNED_JOBS;
"get_processor"		return GET_PROCESSOR;
"get_exec_order"	return GET_EXEC_ORDER;
"get_unscheduled_jobs"	return GET_UNSCHEDULED_JOBS;

"name"			 return NAME;
"Processor"		 return PROCESSOR;
"isa" 			 return ISA;
"\"ARM\""		 return ARM;
"\"AMD\""		 return AMD;
"\"CDC\""		 return CDC;
"\"MIPS\""		 return MIPS;
"clock_speed"	 return CLOCK_SPEED;
"l1_memory"		 return L1_MEMORY;
"l2_memory"		 return L2_MEMORY;

"is_running"	 return IS_RUNNING;
"submit_jobs"	 return SUBMIT_JOBS;
"get_clock_speed"	 return GET_CLOCK_SPEED;
"run"				 return RUN;
"discard_job"		 return DISCARD_JOB;

"Memory"			 return MEMORY;
"memory_type"		 return MEMORY_TYPE;
"\"primary\""		 return PRIMARY;
"\"secondary\""		 return SECONDARY;
"\"cache\""			 return CACHE;
"mem_size"			 return MEM_SIZE;

"get_available_memory"	 return GET_AVAILABLE_MEMORY;
"get_memory"			 return GET_MEMORY;

"Link"					 return LINK;
"start_point"			 return START_POINT;
"end_point"				 return END_POINT;
"bandwidth"				 return BANDWIDTH;
"channel_capacity"		 return CHANNEL_CAPACITY;

"Job"					 return JOB;
"job_id"				 return JOB_ID;
"flops_required"		 return FLOPS_REQUIRED;
"deadline"				 return DEADLINE;
"mem_required"			 return MEM_REQUIRED;
"affinity"				 return AFFINITY;

"Cluster"				 return CLUSTER;
"processors"			 return PROCESSORS;
"topology"				 return TOPOLOGY;
"\"star\""				 return STAR;
"\"bus\""				 return BUS;
"\"tree\""				 return TREE;
"\"mesh\""				 return MESH;
"\"ring\""				 return RING;
"link_bandwidth"		 return LINK_BANDWIDTH;
"link_capacity"			 return LINK_CAPACITY;

"case"					 return CASE;
"default"				 return DEFAULT;
"\"int\""				 return INT_TYPE;
"\"float\""				 return FLOAT_TYPE;
"\"string\""			 return STRING_TYPE;
"if"					 return IF;
"else"					 return ELSE;
"switch"				 return SWITCH;
"while"					 return WHILE;
"do" 					 return DO;
"for"					 return FOR;
"continue"				 return CONTINUE;
"break"					 return BREAK;
"return"				 return RETURN;

\.						 return DOT;


([-|+]?[1-9][0-9]*)|0		 return INT;
[-|+]?[1-9][0-9]*(\.[0-9]+)? 	 return FLOAT;
\"[^ \t\n\"]+\"					 return STRING_LITERAL;


[a-zA-Z][_0-9a-zA-Z]*		 return ID;
:							 return COLON;
\{							 return OPEN_CURLY;
\}							 return CLOSED_CURLY;
==							 return EQUAL_EQUAL;
=							 return EQUAL_TO;
\[							 return OPEN_SQUARE;
\]							 return CLOSED_SQUARE;
\;							 return SEMI;
\)							 return CLOSED_BRACKET;
\(							 return OPEN_BRACKET;
\+\+						 return PLUS_PLUS;
--							 return MINUS_MINUS;
!=							 return NOT_EQUAL;
!							 return NOT;
\*							 return MULTIPLY;
\+							 return ADD;
-							 return SUB;
\/							 return DIV;
\%							 return MOD;
\<=							 return LESS_THAN_EQUAL;
>= 							 return GREATER_THAN_EQUAL;
\<							 return LESS_THAN;
> 							 return GREATER_THAN;
&&							 return AND;
\|\|						 return OR;
\?							 return QUE_MARK;
\"							 return QUOTE;
[ \n\t]						;
.							printf("unexpected character\n"); 

%%

