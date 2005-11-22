/*-------------------------------------------------------------------------
 * slonik.h
 *
 *	Definitions for slonik
 *
 *	Copyright (c) 2003-2004, PostgreSQL Global Development Group
 *	Author: Jan Wieck, Afilias USA INC.
 *
 *	$Id: slonik.h,v 1.25 2005-11-22 05:11:59 wieck Exp $
 *-------------------------------------------------------------------------
 */


typedef struct SlonikScript_s SlonikScript;
typedef struct SlonikAdmInfo_s SlonikAdmInfo;
typedef struct SlonikStmt_s SlonikStmt;
typedef struct SlonikStmt_try_s SlonikStmt_try;
typedef struct SlonikStmt_echo_s SlonikStmt_echo;
typedef struct SlonikStmt_exit_s SlonikStmt_exit;
typedef struct SlonikStmt_repair_config_s SlonikStmt_repair_config;
typedef struct SlonikStmt_restart_node_s SlonikStmt_restart_node;
typedef struct SlonikStmt_init_cluster_s SlonikStmt_init_cluster;
typedef struct SlonikStmt_store_node_s SlonikStmt_store_node;
typedef struct SlonikStmt_drop_node_s SlonikStmt_drop_node;
typedef struct SlonikStmt_failed_node_s SlonikStmt_failed_node;
typedef struct SlonikStmt_uninstall_node_s SlonikStmt_uninstall_node;
typedef struct SlonikStmt_store_path_s SlonikStmt_store_path;
typedef struct SlonikStmt_drop_path_s SlonikStmt_drop_path;
typedef struct SlonikStmt_store_listen_s SlonikStmt_store_listen;
typedef struct SlonikStmt_drop_listen_s SlonikStmt_drop_listen;
typedef struct SlonikStmt_create_set_s SlonikStmt_create_set;
typedef struct SlonikStmt_drop_set_s SlonikStmt_drop_set;
typedef struct SlonikStmt_merge_set_s SlonikStmt_merge_set;
typedef struct SlonikStmt_set_add_table_s SlonikStmt_set_add_table;
typedef struct SlonikStmt_set_add_sequence_s SlonikStmt_set_add_sequence;
typedef struct SlonikStmt_set_drop_table_s SlonikStmt_set_drop_table;
typedef struct SlonikStmt_set_drop_sequence_s SlonikStmt_set_drop_sequence;
typedef struct SlonikStmt_set_move_table_s SlonikStmt_set_move_table;
typedef struct SlonikStmt_set_move_sequence_s SlonikStmt_set_move_sequence;
typedef struct SlonikStmt_table_add_key_s SlonikStmt_table_add_key;
typedef struct SlonikStmt_store_trigger_s SlonikStmt_store_trigger;
typedef struct SlonikStmt_drop_trigger_s SlonikStmt_drop_trigger;
typedef struct SlonikStmt_subscribe_set_s SlonikStmt_subscribe_set;
typedef struct SlonikStmt_unsubscribe_set_s SlonikStmt_unsubscribe_set;
typedef struct SlonikStmt_lock_set_s SlonikStmt_lock_set;
typedef struct SlonikStmt_unlock_set_s SlonikStmt_unlock_set;
typedef struct SlonikStmt_move_set_s SlonikStmt_move_set;
typedef struct SlonikStmt_ddl_script_s SlonikStmt_ddl_script;
typedef struct SlonikStmt_update_functions_s SlonikStmt_update_functions;
typedef struct SlonikStmt_wait_event_s SlonikStmt_wait_event;

typedef enum
{
	STMT_TRY = 1,
	STMT_CREATE_SET,
	STMT_DDL_SCRIPT,
	STMT_DROP_LISTEN,
	STMT_DROP_NODE,
	STMT_DROP_PATH,
	STMT_DROP_SET,
	STMT_DROP_TRIGGER,
	STMT_ECHO,
	STMT_EXIT,
	STMT_FAILED_NODE,
	STMT_INIT_CLUSTER,
	STMT_LOCK_SET,
	STMT_MERGE_SET,
	STMT_MOVE_SET,
	STMT_RESTART_NODE,
	STMT_REPAIR_CONFIG,
	STMT_SET_ADD_SEQUENCE,
	STMT_SET_ADD_TABLE,
	STMT_SET_DROP_SEQUENCE,
	STMT_SET_DROP_TABLE,
	STMT_SET_MOVE_SEQUENCE,
	STMT_SET_MOVE_TABLE,
	STMT_STORE_LISTEN,
	STMT_STORE_NODE,
	STMT_STORE_PATH,
	STMT_STORE_TRIGGER,
	STMT_SUBSCRIBE_SET,
	STMT_TABLE_ADD_KEY,
	STMT_UNINSTALL_NODE,
	STMT_UNLOCK_SET,
	STMT_UNSUBSCRIBE_SET,
	STMT_UPDATE_FUNCTIONS,
	STMT_WAIT_EVENT,
	STMT_ERROR
}	Slonik_stmttype;

struct SlonikScript_s
{
	char	   *clustername;
	char	   *filename;

	SlonikAdmInfo *adminfo_list;

	SlonikStmt *script_stmts;
};


struct SlonikAdmInfo_s
{
	int			no_id;
	char	   *stmt_filename;
	int			stmt_lno;
	char	   *conninfo;
	PGconn	   *dbconn;
	int64		last_event;
	int			version_major;
	int			version_minor;
	int			nodeid_checked;
	int			have_xact;
	SlonikScript *script;
	SlonikAdmInfo *next;
};


struct SlonikStmt_s
{
	Slonik_stmttype stmt_type;
	char	   *stmt_filename;
	int			stmt_lno;
	SlonikScript *script;
	SlonikStmt *next;
};


struct SlonikStmt_try_s
{
	SlonikStmt	hdr;
	SlonikStmt *try_block;
	SlonikStmt *error_block;
	SlonikStmt *success_block;
};


struct SlonikStmt_echo_s
{
	SlonikStmt	hdr;
	char	   *str;
};


struct SlonikStmt_exit_s
{
	SlonikStmt	hdr;
	int			exitcode;
};


struct SlonikStmt_restart_node_s
{
	SlonikStmt	hdr;
	int			no_id;
};

struct SlonikStmt_repair_config_s
{
	SlonikStmt	hdr;
	int			set_id;
	int			ev_origin;
	int			only_on_node;
};


struct SlonikStmt_init_cluster_s
{
	SlonikStmt	hdr;
	int			no_id;
	char	   *no_comment;
};


struct SlonikStmt_store_node_s
{
	SlonikStmt	hdr;
	int			no_id;
	char	   *no_comment;
	int			no_spool;
	int			ev_origin;
};


struct SlonikStmt_drop_node_s
{
	SlonikStmt	hdr;
	int			no_id;
	int			ev_origin;
};


struct SlonikStmt_failed_node_s
{
	SlonikStmt	hdr;
	int			no_id;
	int			backup_node;
};


struct SlonikStmt_uninstall_node_s
{
	SlonikStmt	hdr;
	int			no_id;
};


struct SlonikStmt_store_path_s
{
	SlonikStmt	hdr;
	int			pa_server;
	int			pa_client;
	char	   *pa_conninfo;
	int			pa_connretry;
};


struct SlonikStmt_drop_path_s
{
	SlonikStmt	hdr;
	int			pa_server;
	int			pa_client;
	int			ev_origin;
};


struct SlonikStmt_store_listen_s
{
	SlonikStmt	hdr;
	int			li_origin;
	int			li_receiver;
	int			li_provider;
};


struct SlonikStmt_drop_listen_s
{
	SlonikStmt	hdr;
	int			li_origin;
	int			li_receiver;
	int			li_provider;
};


struct SlonikStmt_create_set_s
{
	SlonikStmt	hdr;
	int			set_id;
	int			set_origin;
	char	   *set_comment;
};


struct SlonikStmt_drop_set_s
{
	SlonikStmt	hdr;
	int			set_id;
	int			set_origin;
};


struct SlonikStmt_merge_set_s
{
	SlonikStmt	hdr;
	int			set_id;
	int			add_id;
	int			set_origin;
};


struct SlonikStmt_set_add_table_s
{
	SlonikStmt	hdr;
	int			set_id;
	int			set_origin;
	int			tab_id;
	int			use_serial;
	char	   *use_key;
	char	   *tab_fqname;
	char	   *tab_comment;
};


struct SlonikStmt_set_add_sequence_s
{
	SlonikStmt	hdr;
	int			set_id;
	int			set_origin;
	int			seq_id;
	char	   *seq_fqname;
	char	   *seq_comment;
};


struct SlonikStmt_set_drop_table_s
{
	SlonikStmt	hdr;
	int			set_origin;
	int			tab_id;
};


struct SlonikStmt_set_drop_sequence_s
{
	SlonikStmt	hdr;
	int			set_origin;
	int			seq_id;
};


struct SlonikStmt_set_move_table_s
{
	SlonikStmt	hdr;
	int			set_origin;
	int			tab_id;
	int			new_set_id;
};


struct SlonikStmt_set_move_sequence_s
{
	SlonikStmt	hdr;
	int			set_origin;
	int			seq_id;
	int			new_set_id;
};


struct SlonikStmt_table_add_key_s
{
	SlonikStmt	hdr;
	int			no_id;
	char	   *tab_fqname;
};


struct SlonikStmt_store_trigger_s
{
	SlonikStmt	hdr;
	int			trig_tabid;
	char	   *trig_tgname;
	int			ev_origin;
};


struct SlonikStmt_drop_trigger_s
{
	SlonikStmt	hdr;
	int			trig_tabid;
	char	   *trig_tgname;
	int			ev_origin;
};


struct SlonikStmt_subscribe_set_s
{
	SlonikStmt	hdr;
	int			sub_setid;
	int			sub_provider;
	int			sub_receiver;
	int			sub_forward;
};


struct SlonikStmt_unsubscribe_set_s
{
	SlonikStmt	hdr;
	int			sub_setid;
	int			sub_receiver;
};


struct SlonikStmt_lock_set_s
{
	SlonikStmt	hdr;
	int			set_id;
	int			set_origin;
};


struct SlonikStmt_unlock_set_s
{
	SlonikStmt	hdr;
	int			set_id;
	int			set_origin;
};


struct SlonikStmt_move_set_s
{
	SlonikStmt	hdr;
	int			set_id;
	int			old_origin;
	int			new_origin;
};


struct SlonikStmt_ddl_script_s
{
	SlonikStmt	hdr;
	int			ddl_setid;
	char	   *ddl_fname;
	int			ev_origin;
	int			only_on_node;
	FILE	   *ddl_fd;
};


struct SlonikStmt_update_functions_s
{
	SlonikStmt	hdr;
	int			no_id;
};


struct SlonikStmt_wait_event_s
{
	SlonikStmt	hdr;
	int			wait_origin;
	int			wait_confirmed;
	int			wait_on;
	int			wait_timeout;
};




extern SlonikScript *parser_script;
extern int	parser_errors;




/* ----------
 * SlonDString
 * ----------
 */
#define		SLON_DSTRING_SIZE_INIT	256
#define		SLON_DSTRING_SIZE_INC	2

typedef struct
{
	size_t		n_alloc;
	size_t		n_used;
	char	   *data;
}	SlonDString;

#define		dstring_init(__ds) \
do { \
	(__ds)->n_alloc = SLON_DSTRING_SIZE_INIT; \
	(__ds)->n_used = 0; \
	(__ds)->data = malloc(SLON_DSTRING_SIZE_INIT); \
	if ((__ds)->data == NULL) { \
		perror("dstring_init: malloc()"); \
		exit(-1); \
	} \
} while (0)
#define		dstring_reset(__ds) \
do { \
	(__ds)->n_used = 0; \
	(__ds)->data[0] = '\0'; \
} while (0)
#define		dstring_free(__ds) \
do { \
	free((__ds)->data); \
	(__ds)->n_used = 0; \
	(__ds)->data = NULL; \
} while (0)
#define		dstring_nappend(__ds,__s,__n) \
do { \
	if ((__ds)->n_used + (__n) >= (__ds)->n_alloc)	\
	{ \
		while ((__ds)->n_used + (__n) >= (__ds)->n_alloc) \
			(__ds)->n_alloc *= SLON_DSTRING_SIZE_INC; \
		(__ds)->data = realloc((__ds)->data, (__ds)->n_alloc); \
		if ((__ds)->data == NULL) \
		{ \
			perror("dstring_nappend: realloc()"); \
			exit(-1); \
		} \
	} \
	memcpy(&((__ds)->data[(__ds)->n_used]), (__s), (__n)); \
	(__ds)->n_used += (__n); \
} while (0)
#define		dstring_append(___ds,___s) \
do { \
	register int ___n = strlen((___s)); \
	dstring_nappend((___ds),(___s),___n); \
} while (0)
#define		dstring_addchar(__ds,__c) \
do { \
	if ((__ds)->n_used + 1 >= (__ds)->n_alloc)	\
	{ \
		(__ds)->n_alloc *= SLON_DSTRING_SIZE_INC; \
		(__ds)->data = realloc((__ds)->data, (__ds)->n_alloc); \
		if ((__ds)->data == NULL) \
		{ \
			perror("dstring_append: realloc()"); \
			exit(-1); \
		} \
	} \
	(__ds)->data[(__ds)->n_used++] = (__c); \
} while (0)
#define		dstring_terminate(__ds) \
do { \
	(__ds)->data[(__ds)->n_used] = '\0'; \
} while (0)
#define		dstring_data(__ds)	((__ds)->data)


/*
 * Globals in slonik.c
 */
extern int	parser_errors;
extern char *current_file;

extern int	slonik_restart_node(SlonikStmt_restart_node * stmt);
extern int	slonik_init_cluster(SlonikStmt_init_cluster * stmt);
extern int	slonik_store_node(SlonikStmt_store_node * stmt);
extern int	slonik_drop_node(SlonikStmt_drop_node * stmt);
extern int	slonik_failed_node(SlonikStmt_failed_node * stmt);
extern int	slonik_uninstall_node(SlonikStmt_uninstall_node * stmt);
extern int	slonik_store_path(SlonikStmt_store_path * stmt);
extern int	slonik_drop_path(SlonikStmt_drop_path * stmt);
extern int	slonik_store_listen(SlonikStmt_store_listen * stmt);
extern int	slonik_drop_listen(SlonikStmt_drop_listen * stmt);
extern int	slonik_create_set(SlonikStmt_create_set * stmt);
extern int	slonik_drop_set(SlonikStmt_drop_set * stmt);
extern int	slonik_merge_set(SlonikStmt_merge_set * stmt);
extern int	slonik_set_add_table(SlonikStmt_set_add_table * stmt);
extern int	slonik_set_add_sequence(SlonikStmt_set_add_sequence * stmt);
extern int	slonik_set_drop_table(SlonikStmt_set_drop_table * stmt);
extern int	slonik_set_drop_sequence(SlonikStmt_set_drop_sequence * stmt);
extern int	slonik_set_move_table(SlonikStmt_set_move_table * stmt);
extern int	slonik_set_move_sequence(SlonikStmt_set_move_sequence * stmt);
extern int	slonik_table_add_key(SlonikStmt_table_add_key * stmt);
extern int	slonik_store_trigger(SlonikStmt_store_trigger * stmt);
extern int	slonik_drop_trigger(SlonikStmt_drop_trigger * stmt);
extern int	slonik_subscribe_set(SlonikStmt_subscribe_set * stmt);
extern int	slonik_unsubscribe_set(SlonikStmt_unsubscribe_set * stmt);
extern int	slonik_lock_set(SlonikStmt_lock_set * stmt);
extern int	slonik_unlock_set(SlonikStmt_unlock_set * stmt);
extern int	slonik_move_set(SlonikStmt_move_set * stmt);
extern int	slonik_ddl_script(SlonikStmt_ddl_script * stmt);
extern int	slonik_update_functions(SlonikStmt_update_functions * stmt);
extern int	slonik_wait_event(SlonikStmt_wait_event * stmt);

extern int	slon_scanint64(char *str, int64 * result);


/*
 * Globals in dbutil.c
 */
extern int	db_notice_silent;
extern int	db_notice_lno;

#ifdef HAVE_PQSETNOTICERECEIVER
void		db_notice_recv(void *arg, const PGresult *res);
#else
void		db_notice_recv(void *arg, const char *msg);
#endif
int			db_connect(SlonikStmt * stmt, SlonikAdmInfo * adminfo);
int			db_disconnect(SlonikStmt * stmt, SlonikAdmInfo * adminfo);

int db_exec_command(SlonikStmt * stmt, SlonikAdmInfo * adminfo,
				SlonDString * query);
int db_exec_evcommand(SlonikStmt * stmt, SlonikAdmInfo * adminfo,
				  SlonDString * query);
PGresult *db_exec_select(SlonikStmt * stmt, SlonikAdmInfo * adminfo,
			   SlonDString * query);
int db_get_version(SlonikStmt * stmt, SlonikAdmInfo * adminfo,
			   int *major, int *minor);
int db_check_namespace(SlonikStmt * stmt, SlonikAdmInfo * adminfo,
				   char *clustername);
int db_check_requirements(SlonikStmt * stmt, SlonikAdmInfo * adminfo,
					  char *clustername);
int			db_get_nodeid(SlonikStmt * stmt, SlonikAdmInfo * adminfo);
int			db_begin_xact(SlonikStmt * stmt, SlonikAdmInfo * adminfo);
int			db_commit_xact(SlonikStmt * stmt, SlonikAdmInfo * adminfo);
int			db_rollback_xact(SlonikStmt * stmt, SlonikAdmInfo * adminfo);

int			slon_mkquery(SlonDString * dsp, char *fmt,...);
int			slon_appendquery(SlonDString * dsp, char *fmt,...);


/*
 * Parser related globals
 */
extern int	yylineno;
extern char *yytext;
extern FILE *yyin;

extern void scan_new_input_file(FILE *in);

extern void yyerror(const char *str);
extern int	yyparse(void);
extern int	yylex(void);


/*
 * Local Variables:
 *	tab-width: 4
 *	c-indent-level: 4
 *	c-basic-offset: 4
 * End:
 */
