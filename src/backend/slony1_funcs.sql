-- ----------------------------------------------------------------------
-- slony1_funcs.sql
--
--    Declaration of replication support functions.
--
--	Copyright (c) 2003-2009, PostgreSQL Global Development Group
--	Author: Jan Wieck, Afilias USA INC.
--
-- 
-- ----------------------------------------------------------------------

-- **********************************************************************
-- * C functions in src/backend/slony1_base.c
-- **********************************************************************


-- ----------------------------------------------------------------------
-- FUNCTION createEvent (cluster_name, ev_type [, ev_data [...]])
--
--	Create an sl_event entry
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.createEvent (name, text)
	returns bigint
	as '$libdir/slony1_funcs', '_Slony_I_createEvent'
	language C
	called on null input;

comment on function @NAMESPACE@.createEvent (name, text) is
'FUNCTION createEvent (cluster_name, ev_type [, ev_data [...]])

Create an sl_event entry';

create or replace function @NAMESPACE@.createEvent (name, text, text)
	returns bigint
	as '$libdir/slony1_funcs', '_Slony_I_createEvent'
	language C
	called on null input;

comment on function @NAMESPACE@.createEvent (name, text, text) is
'FUNCTION createEvent (cluster_name, ev_type [, ev_data [...]])

Create an sl_event entry';

create or replace function @NAMESPACE@.createEvent (name, text, text, text)
	returns bigint
	as '$libdir/slony1_funcs', '_Slony_I_createEvent'
	language C
	called on null input;

comment on function @NAMESPACE@.createEvent (name, text, text, text) is
'FUNCTION createEvent (cluster_name, ev_type [, ev_data [...]])

Create an sl_event entry';

create or replace function @NAMESPACE@.createEvent (name, text, text, text, text)
	returns bigint
	as '$libdir/slony1_funcs', '_Slony_I_createEvent'
	language C
	called on null input;

comment on function @NAMESPACE@.createEvent (name, text, text, text, text) is
'FUNCTION createEvent (cluster_name, ev_type [, ev_data [...]])

Create an sl_event entry';

create or replace function @NAMESPACE@.createEvent (name, text, text, text, text, text)
	returns bigint
	as '$libdir/slony1_funcs', '_Slony_I_createEvent'
	language C
	called on null input;

comment on function @NAMESPACE@.createEvent (name, text, text, text, text, text) is
'FUNCTION createEvent (cluster_name, ev_type [, ev_data [...]])

Create an sl_event entry';

create or replace function @NAMESPACE@.createEvent (name, text, text, text, text, text, text)
	returns bigint
	as '$libdir/slony1_funcs', '_Slony_I_createEvent'
	language C
	called on null input;

comment on function @NAMESPACE@.createEvent (name, text, text, text, text, text, text) is
'FUNCTION createEvent (cluster_name, ev_type [, ev_data [...]])

Create an sl_event entry';

create or replace function @NAMESPACE@.createEvent (name, text, text, text, text, text, text, text)
	returns bigint
	as '$libdir/slony1_funcs', '_Slony_I_createEvent'
	language C
	called on null input;

comment on function @NAMESPACE@.createEvent (name, text, text, text, text, text, text, text) is
'FUNCTION createEvent (cluster_name, ev_type [, ev_data [...]])

Create an sl_event entry';

create or replace function @NAMESPACE@.createEvent (name, text, text, text, text, text, text, text, text)
	returns bigint
	as '$libdir/slony1_funcs', '_Slony_I_createEvent'
	language C
	called on null input;

comment on function @NAMESPACE@.createEvent (name, text, text, text, text, text, text, text, text) is
'FUNCTION createEvent (cluster_name, ev_type [, ev_data [...]])

Create an sl_event entry';

create or replace function @NAMESPACE@.createEvent (name, text, text, text, text, text, text, text, text, text)
	returns bigint
	as '$libdir/slony1_funcs', '_Slony_I_createEvent'
	language C
	called on null input;

comment on function @NAMESPACE@.createEvent (name, text, text, text, text, text, text, text, text, text) is
'FUNCTION createEvent (cluster_name, ev_type [, ev_data [...]])

Create an sl_event entry';

-- ----------------------------------------------------------------------
-- FUNCTION denyAccess ()
--
--	Trigger function to prevent modifications to a table on
--	a subscriber.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.denyAccess ()
	returns trigger
	as '$libdir/slony1_funcs', '_Slony_I_denyAccess'
	language C
	security definer;

comment on function @NAMESPACE@.denyAccess () is 
  'Trigger function to prevent modifications to a table on a subscriber';

grant execute on function @NAMESPACE@.denyAccess () to public;


-- ----------------------------------------------------------------------
-- FUNCTION lockedSet (cluster_name)
--
--	Trigger function to prevent modifications to a table before
--	and after a moveSet().
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.lockedSet ()
	returns trigger
	as '$libdir/slony1_funcs', '_Slony_I_lockedSet'
	language C;

comment on function @NAMESPACE@.lockedSet () is 
  'Trigger function to prevent modifications to a table before and after a moveSet()';

-- ----------------------------------------------------------------------
-- FUNCTION getLocalNodeId (name)
--
--	
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.getLocalNodeId (name) returns int4
    as '$libdir/slony1_funcs', '_Slony_I_getLocalNodeId'
	language C
	security definer;
grant execute on function @NAMESPACE@.getLocalNodeId (name) to public;

comment on function @NAMESPACE@.getLocalNodeId (name) is 
  'Returns the node ID of the node being serviced on the local database';

-- ----------------------------------------------------------------------
-- FUNCTION getModuleVersion ()
--
--	Returns the compiled in version number of the Slony-I shared
--	object.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.getModuleVersion () returns text
    as '$libdir/slony1_funcs', '_Slony_I_getModuleVersion'
	language C
	security definer;
grant execute on function @NAMESPACE@.getModuleVersion () to public;

comment on function @NAMESPACE@.getModuleVersion () is
  'Returns the compiled-in version number of the Slony-I shared object';

create or replace function @NAMESPACE@.checkmoduleversion () returns text as $$
declare
  moduleversion	text;
begin
  select into moduleversion @NAMESPACE@.getModuleVersion();
  if moduleversion <> '@MODULEVERSION@' then
      raise exception 'Slonik version: @MODULEVERSION@ != Slony-I version in PG build %',
             moduleversion;
  end if;
  return null;
end;$$ language plpgsql;

comment on function @NAMESPACE@.checkmoduleversion () is 
'Inline test function that verifies that slonik request for STORE
NODE/INIT CLUSTER is being run against a conformant set of
schema/functions.';

select @NAMESPACE@.checkmoduleversion();

-----------------------------------------------------------------------
-- This function checks to see if the namespace name is valid.  
--
-- Apparently pgAdminIII does different validation than Slonik, and so
-- users that set up cluster names using pgAdminIII can get in trouble in
-- that they do not get around to needing Slonik until it is too
-- late...
-----------------------------------------------------------------------

create or replace function @NAMESPACE@.check_namespace_validity () returns boolean as $$
declare
	c_cluster text;
begin
	c_cluster := '@CLUSTERNAME@';
	if c_cluster !~ E'^[[:alpha:]_][[:alnum:]_\$]{0,62}$' then
		raise exception 'Cluster name % is not a valid SQL symbol!', c_cluster;
	else
		raise notice 'checked validity of cluster % namespace - OK!', c_cluster;
	end if;
	return 't';
end
$$ language plpgsql;

select @NAMESPACE@.check_namespace_validity();
drop function @NAMESPACE@.check_namespace_validity();

-- ----------------------------------------------------------------------
-- FUNCTION logTrigger ()
--
--	
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.logTrigger () returns trigger
    as '$libdir/slony1_funcs', '_Slony_I_logTrigger'
	language C
	security definer;

comment on function @NAMESPACE@.logTrigger () is 
  'This is the trigger that is executed on the origin node that causes
updates to be recorded in sl_log_1/sl_log_2.';

grant execute on function @NAMESPACE@.logTrigger () to public;

-- ----------------------------------------------------------------------
-- FUNCTION terminateNodeConnections (failed_node)
--
--	
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.terminateNodeConnections (int4) returns int4
as $$
declare
	p_failed_node	alias for $1;
	v_row			record;
begin
	for v_row in select nl_nodeid, nl_conncnt,
			nl_backendpid from @NAMESPACE@.sl_nodelock
			where nl_nodeid = p_failed_node for update
	loop
		perform @NAMESPACE@.killBackend(v_row.nl_backendpid, 'TERM');
		delete from @NAMESPACE@.sl_nodelock
			where nl_nodeid = v_row.nl_nodeid
			and nl_conncnt = v_row.nl_conncnt;
	end loop;

	return 0;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.terminateNodeConnections (int4) is 
  'terminates all backends that have registered to be from the given node';

-- ----------------------------------------------------------------------
-- FUNCTION killBackend (pid, signame)
--
--	
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.killBackend (int4, text) returns int4
    as '$libdir/slony1_funcs', '_Slony_I_killBackend'
	language C;

comment on function @NAMESPACE@.killBackend(int4, text) is
  'Send a signal to a postgres process. Requires superuser rights';

-- ----------------------------------------------------------------------
-- FUNCTION seqtrack (seqid, seqval)
--
--	
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.seqtrack (int4, int8) returns int8
    as '$libdir/slony1_funcs', '_Slony_I_seqtrack'
	strict language C;

comment on function @NAMESPACE@.seqtrack(int4, int8) is
  'Returns NULL if seqval has not changed since the last call for seqid';

-- ----------------------------------------------------------------------
-- FUNCTION slon_quote_brute(text)
--
--	Function that quotes a given string.
--	All existing quotes will be escaped.
--
--	This function will be used to quote output of internal functions.
-- ----------------------------------------------------------------------

create or replace function @NAMESPACE@.slon_quote_brute(text) returns text
as $$
declare	
    p_tab_fqname alias for $1;
    v_fqname text default '';
begin
    v_fqname := '"' || replace(p_tab_fqname,'"','""') || '"';
    return v_fqname;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.slon_quote_brute(text) is
  'Brutally quote the given text';

-- ----------------------------------------------------------------------
-- FUNCTION slon_quote_input(text)
--
--	Function that quotes a given fqn. This function quotes every
--	word that isn't quoted yet. Words or groups of words that are
--	already quoted will be untouched.
--
--	This function will be used to quote user input.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.slon_quote_input(text) returns text as $$
  declare
     p_tab_fqname alias for $1;
     v_nsp_name text;
     v_tab_name text;
	 v_i integer;
	 v_l integer;
     v_pq2 integer;
begin
	v_l := length(p_tab_fqname);

	-- Let us search for the dot
	if p_tab_fqname like '"%' then
		-- if the first part of the ident starts with a double quote, search
		-- for the closing double quote, skipping over double double quotes.
		v_i := 2;
		while v_i <= v_l loop
			if substr(p_tab_fqname, v_i, 1) != '"' then
				v_i := v_i + 1;
			else
				v_i := v_i + 1;
				if substr(p_tab_fqname, v_i, 1) != '"' then
					exit;
				end if;
				v_i := v_i + 1;
			end if;
		end loop;
	else
		-- first part of ident is not quoted, search for the dot directly
		v_i := 1;
		while v_i <= v_l loop
			if substr(p_tab_fqname, v_i, 1) = '.' then
				exit;
			end if;
			v_i := v_i + 1;
		end loop;
	end if;

	-- v_i now points at the dot or behind the string.

	if substr(p_tab_fqname, v_i, 1) = '.' then
		-- There is a dot now, so split the ident into its namespace
		-- and objname parts and make sure each is quoted
		v_nsp_name := substr(p_tab_fqname, 1, v_i - 1);
		v_tab_name := substr(p_tab_fqname, v_i + 1);
		if v_nsp_name not like '"%' then
			v_nsp_name := '"' || replace(v_nsp_name, '"', '""') ||
						  '"';
		end if;
		if v_tab_name not like '"%' then
			v_tab_name := '"' || replace(v_tab_name, '"', '""') ||
						  '"';
		end if;

		return v_nsp_name || '.' || v_tab_name;
	else
		-- No dot ... must be just an ident without schema
		if p_tab_fqname like '"%' then
			return p_tab_fqname;
		else
			return '"' || replace(p_tab_fqname, '"', '""') || '"';
		end if;
	end if;

end;$$ language plpgsql;

comment on function @NAMESPACE@.slon_quote_input(text) is
  'quote all words that aren''t quoted yet';

-- **********************************************************************
-- * PL/pgSQL functions for administrative tasks
-- **********************************************************************


-- ----------------------------------------------------------------------
-- FUNCTION slonyVersionMajor()
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.slonyVersionMajor()
returns int4
as $$
begin
	return 2;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.slonyVersionMajor () is 
  'Returns the major version number of the slony schema';

-- ----------------------------------------------------------------------
-- FUNCTION slonyVersionMinor()
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.slonyVersionMinor()
returns int4
as $$
begin
	return 0;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.slonyVersionMinor () is 
  'Returns the minor version number of the slony schema';


-- ----------------------------------------------------------------------
-- FUNCTION slonyVersionPatchlevel()
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.slonyVersionPatchlevel()
returns int4
as $$
begin
	return 5;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.slonyVersionPatchlevel () is 
  'Returns the version patch level of the slony schema';


-- ----------------------------------------------------------------------
-- FUNCTION slonyVersion()
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.slonyVersion()
returns text
as $$
begin
	return @NAMESPACE@.slonyVersionMajor()::text || '.' || 
	       @NAMESPACE@.slonyVersionMinor()::text || '.' || 
	       @NAMESPACE@.slonyVersionPatchlevel()::text;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.slonyVersion() is 
  'Returns the version number of the slony schema';


-- ----------------------------------------------------------------------
-- FUNCTION registry_set_int4(key, value);
-- FUNCTION registry_get_int4(key, default);
-- FUNCTION registry_set_text(key, value);
-- FUNCTION registry_get_text(key, default);
-- FUNCTION registry_set_timestamp(key, value);
-- FUNCTION registry_get_timestamp(key, default);
--
--	Functions for accessing sl_registry
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.registry_set_int4(text, int4)
returns int4 as $$
DECLARE
	p_key		alias for $1;
	p_value		alias for $2;
BEGIN
	if p_value is null then
		delete from @NAMESPACE@.sl_registry
				where reg_key = p_key;
	else
		lock table @NAMESPACE@.sl_registry;
		update @NAMESPACE@.sl_registry
				set reg_int4 = p_value
				where reg_key = p_key;
		if not found then
			insert into @NAMESPACE@.sl_registry (reg_key, reg_int4)
					values (p_key, p_value);
		end if;
	end if;
	return p_value;
END;
$$ language plpgsql;
comment on function @NAMESPACE@.registry_set_int4(text, int4) is
'registry_set_int4(key, value)

Set or delete a registry value';

create or replace function @NAMESPACE@.registry_get_int4(text, int4)
returns int4 as $$
DECLARE
	p_key		alias for $1;
	p_default	alias for $2;
	v_value		int4;
BEGIN
	select reg_int4 into v_value from @NAMESPACE@.sl_registry
			where reg_key = p_key;
	if not found then 
		v_value = p_default;
		if p_default notnull then
			perform @NAMESPACE@.registry_set_int4(p_key, p_default);
		end if;
	else
		if v_value is null then
			raise exception 'Slony-I: registry key % is not an int4 value',
					p_key;
		end if;
	end if;
	return v_value;
END;
$$ language plpgsql;
comment on function @NAMESPACE@.registry_get_int4(text, int4) is
'registry_get_int4(key, value)

Get a registry value. If not present, set and return the default.';

create or replace function @NAMESPACE@.registry_set_text(text, text)
returns text as $$
DECLARE
	p_key		alias for $1;
	p_value		alias for $2;
BEGIN
	if p_value is null then
		delete from @NAMESPACE@.sl_registry
				where reg_key = p_key;
	else
		lock table @NAMESPACE@.sl_registry;
		update @NAMESPACE@.sl_registry
				set reg_text = p_value
				where reg_key = p_key;
		if not found then
			insert into @NAMESPACE@.sl_registry (reg_key, reg_text)
					values (p_key, p_value);
		end if;
	end if;
	return p_value;
END;
$$ language plpgsql;
comment on function @NAMESPACE@.registry_set_text(text, text) is
'registry_set_text(key, value)

Set or delete a registry value';

create or replace function @NAMESPACE@.registry_get_text(text, text)
returns text as $$
DECLARE
	p_key		alias for $1;
	p_default	alias for $2;
	v_value		text;
BEGIN
	select reg_text into v_value from @NAMESPACE@.sl_registry
			where reg_key = p_key;
	if not found then 
		v_value = p_default;
		if p_default notnull then
			perform @NAMESPACE@.registry_set_text(p_key, p_default);
		end if;
	else
		if v_value is null then
			raise exception 'Slony-I: registry key % is not a text value',
					p_key;
		end if;
	end if;
	return v_value;
END;
$$ language plpgsql;
comment on function @NAMESPACE@.registry_get_text(text, text) is
'registry_get_text(key, value)

Get a registry value. If not present, set and return the default.';

create or replace function @NAMESPACE@.registry_set_timestamp(text, timestamp)
returns timestamp as $$
DECLARE
	p_key		alias for $1;
	p_value		alias for $2;
BEGIN
	if p_value is null then
		delete from @NAMESPACE@.sl_registry
				where reg_key = p_key;
	else
		lock table @NAMESPACE@.sl_registry;
		update @NAMESPACE@.sl_registry
				set reg_timestamp = p_value
				where reg_key = p_key;
		if not found then
			insert into @NAMESPACE@.sl_registry (reg_key, reg_timestamp)
					values (p_key, p_value);
		end if;
	end if;
	return p_value;
END;
$$ language plpgsql;
comment on function @NAMESPACE@.registry_set_timestamp(text, timestamp) is
'registry_set_timestamp(key, value)

Set or delete a registry value';

create or replace function @NAMESPACE@.registry_get_timestamp(text, timestamp)
returns timestamp as $$
DECLARE
	p_key		alias for $1;
	p_default	alias for $2;
	v_value		timestamp;
BEGIN
	select reg_timestamp into v_value from @NAMESPACE@.sl_registry
			where reg_key = p_key;
	if not found then 
		v_value = p_default;
		if p_default notnull then
			perform @NAMESPACE@.registry_set_timestamp(p_key, p_default);
		end if;
	else
		if v_value is null then
			raise exception 'Slony-I: registry key % is not an timestamp value',
					p_key;
		end if;
	end if;
	return v_value;
END;
$$ language plpgsql;
comment on function @NAMESPACE@.registry_get_timestamp(text, timestamp) is
'registry_get_timestamp(key, value)

Get a registry value. If not present, set and return the default.';


-- ----------------------------------------------------------------------
-- FUNCTION cleanupNodelock ()
--
--	Remove old entries from the nodelock table
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.cleanupNodelock ()
returns int4
as $$
declare
	v_row		record;
begin
	for v_row in select nl_nodeid, nl_conncnt, nl_backendpid
			from @NAMESPACE@.sl_nodelock
			for update
	loop
		if @NAMESPACE@.killBackend(v_row.nl_backendpid, 'NULL') < 0 then
			raise notice 'Slony-I: cleanup stale sl_nodelock entry for pid=%',
					v_row.nl_backendpid;
			delete from @NAMESPACE@.sl_nodelock where
					nl_nodeid = v_row.nl_nodeid and
					nl_conncnt = v_row.nl_conncnt;
		end if;
	end loop;

	return 0;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.cleanupNodelock() is
'Clean up stale entries when restarting slon';

-- ----------------------------------------------------------------------
-- FUNCTION registerNodeConnection (nodeid)
--
-- register a node connection for a slon so that only that slon services
-- the node
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.registerNodeConnection (int4)
returns int4
as $$
declare
	p_nodeid	alias for $1;
begin
	insert into @NAMESPACE@.sl_nodelock
		(nl_nodeid, nl_backendpid)
		values
		(p_nodeid, pg_backend_pid());

	return 0;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.registerNodeConnection (int4) is
'Register (uniquely) the node connection so that only one slon can service the node';


-- ----------------------------------------------------------------------
-- FUNCTION initializeLocalNode (no_id, no_comment)
--
--	Initializes a new node.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.initializeLocalNode (int4, text)
returns int4
as $$
declare
	p_local_node_id		alias for $1;
	p_comment			alias for $2;
	v_old_node_id		int4;
	v_first_log_no		int4;
	v_event_seq			int8;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Make sure this node is uninitialized or got reset
	-- ----
	select last_value::int4 into v_old_node_id from @NAMESPACE@.sl_local_node_id;
	if v_old_node_id != -1 then
		raise exception 'Slony-I: This node is already initialized';
	end if;

	-- ----
	-- Set sl_local_node_id to the requested value and add our
	-- own system to sl_node.
	-- ----
	perform setval('@NAMESPACE@.sl_local_node_id', p_local_node_id);
	perform @NAMESPACE@.storeNode_int (p_local_node_id, p_comment);

	if (pg_catalog.current_setting('max_identifier_length')::integer - pg_catalog.length('@NAMESPACE@')) < 5 then
		raise notice 'Slony-I: Cluster name length [%] versus system max_identifier_length [%] ', pg_catalog.length('@NAMESPACE@'), pg_catalog.current_setting('max_identifier_length');
		raise notice 'leaves narrow/no room for some Slony-I-generated objects (such as indexes).';
		raise notice 'You may run into problems later!';
	end if;
	
	return p_local_node_id;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.initializeLocalNode (int4, text) is 
  'no_id - Node ID #
no_comment - Human-oriented comment

Initializes the new node, no_id';

-- ----------------------------------------------------------------------
-- FUNCTION storeNode (no_id, no_comment)
--
--	Generate the STORE_NODE event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.storeNode (int4, text)
returns bigint
as $$
declare
	p_no_id			alias for $1;
	p_no_comment	alias for $2;
begin
	perform @NAMESPACE@.storeNode_int (p_no_id, p_no_comment);
	return  @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'STORE_NODE',
									p_no_id::text, p_no_comment::text);
end;
$$ language plpgsql
	called on null input;

comment on function @NAMESPACE@.storeNode(int4, text) is
'no_id - Node ID #
no_comment - Human-oriented comment

Generate the STORE_NODE event for node no_id';

-- ----------------------------------------------------------------------
-- FUNCTION storeNode_int (no_id, no_comment)
--
--	Process the STORE_NODE event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.storeNode_int (int4, text)
returns int4
as $$
declare
	p_no_id			alias for $1;
	p_no_comment	alias for $2;
	v_old_row		record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Check if the node exists
	-- ----
	select * into v_old_row
			from @NAMESPACE@.sl_node
			where no_id = p_no_id
			for update;
	if found then 
		-- ----
		-- Node exists, update the existing row.
		-- ----
		update @NAMESPACE@.sl_node
				set no_comment = p_no_comment
				where no_id = p_no_id;
	else
		-- ----
		-- New node, insert the sl_node row
		-- ----
		insert into @NAMESPACE@.sl_node
				(no_id, no_active, no_comment) values
				(p_no_id, 'f', p_no_comment);
	end if;

	return p_no_id;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.storeNode_int(int4, text) is
'no_id - Node ID #
no_comment - Human-oriented comment

Internal function to process the STORE_NODE event for node no_id';


-- ----------------------------------------------------------------------
-- FUNCTION enableNode (no_id)
--
--	Generate the ENABLE_NODE event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.enableNode (int4)
returns bigint
as $$
declare
	p_no_id			alias for $1;
	v_local_node_id	int4;
	v_node_row		record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Check that we are the node to activate and that we are
	-- currently disabled.
	-- ----
	v_local_node_id := @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');
	select * into v_node_row
			from @NAMESPACE@.sl_node
			where no_id = p_no_id
			for update;
	if not found then 
		raise exception 'Slony-I: node % not found', p_no_id;
	end if;
	if v_node_row.no_active then
		raise exception 'Slony-I: node % is already active', p_no_id;
	end if;

	-- ----
	-- Activate this node and generate the ENABLE_NODE event
	-- ----
	perform @NAMESPACE@.enableNode_int (p_no_id);
	return  @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'ENABLE_NODE',
									p_no_id::text);
end;
$$ language plpgsql;

comment on function @NAMESPACE@.enableNode(int4) is
'no_id - Node ID #

Generate the ENABLE_NODE event for node no_id';

-- ----------------------------------------------------------------------
-- FUNCTION enableNode_int (no_id)
--
--	Process the ENABLE_NODE event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.enableNode_int (int4)
returns int4
as $$
declare
	p_no_id			alias for $1;
	v_local_node_id	int4;
	v_node_row		record;
	v_sub_row		record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Check that the node is inactive
	-- ----
	select * into v_node_row
			from @NAMESPACE@.sl_node
			where no_id = p_no_id
			for update;
	if not found then 
		raise exception 'Slony-I: node % not found', p_no_id;
	end if;
	if v_node_row.no_active then
		return p_no_id;
	end if;

	-- ----
	-- Activate the node and generate sl_confirm status rows for it.
	-- ----
	update @NAMESPACE@.sl_node
			set no_active = 't'
			where no_id = p_no_id;
	insert into @NAMESPACE@.sl_confirm
			(con_origin, con_received, con_seqno)
			select no_id, p_no_id, 0 from @NAMESPACE@.sl_node
				where no_id != p_no_id
				and no_active;
	insert into @NAMESPACE@.sl_confirm
			(con_origin, con_received, con_seqno)
			select p_no_id, no_id, 0 from @NAMESPACE@.sl_node
				where no_id != p_no_id
				and no_active;

	-- ----
	-- Generate ENABLE_SUBSCRIPTION events for all sets that
	-- origin here and are subscribed by the just enabled node.
	-- ----
	v_local_node_id := @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');
	for v_sub_row in select SUB.sub_set, SUB.sub_provider from
			@NAMESPACE@.sl_set S,
			@NAMESPACE@.sl_subscribe SUB
			where S.set_origin = v_local_node_id
			and S.set_id = SUB.sub_set
			and SUB.sub_receiver = p_no_id
			for update of S
	loop
		perform @NAMESPACE@.enableSubscription (v_sub_row.sub_set,
				v_sub_row.sub_provider, p_no_id);
	end loop;

	return p_no_id;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.enableNode_int(int4) is
'no_id - Node ID #

Internal function to process the ENABLE_NODE event for node no_id';

-- ----------------------------------------------------------------------
-- FUNCTION disableNode (no_id)
--
--	Generate the DISABLE_NODE event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.disableNode (int4)
returns bigint
as $$
declare
	p_no_id			alias for $1;
begin
	-- **** TODO ****
	raise exception 'Slony-I: disableNode() not implemented';
end;
$$ language plpgsql;
comment on function @NAMESPACE@.disableNode(int4) is
'generate DISABLE_NODE event for node no_id';

-- ----------------------------------------------------------------------
-- FUNCTION disableNode_int (no_id)
--
--	Process the DISABLE_NODE event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.disableNode_int (int4)
returns int4
as $$
declare
	p_no_id			alias for $1;
begin
	-- **** TODO ****
	raise exception 'Slony-I: disableNode_int() not implemented';
end;
$$ language plpgsql;

comment on function @NAMESPACE@.disableNode(int4) is
'process DISABLE_NODE event for node no_id

NOTE: This is not yet implemented!';

-- ----------------------------------------------------------------------
-- FUNCTION dropNode (no_id)
--
--	Generate the DROP_NODE event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.dropNode (int4)
returns bigint
as $$
declare
	p_no_id			alias for $1;
	v_node_row		record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Check that this got called on a different node
	-- ----
	if p_no_id = @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
		raise exception 'Slony-I: DROP_NODE cannot initiate on the dropped node';
	end if;

	select * into v_node_row from @NAMESPACE@.sl_node
			where no_id = p_no_id
			for update;
	if not found then
		raise exception 'Slony-I: unknown node ID %', p_no_id;
	end if;

	-- ----
	-- Make sure we do not break other nodes subscriptions with this
	-- ----
	if exists (select true from @NAMESPACE@.sl_subscribe
			where sub_provider = p_no_id)
	then
		raise exception 'Slony-I: Node % is still configured as a data provider',
				p_no_id;
	end if;

	-- ----
	-- Make sure no set originates there any more
	-- ----
	if exists (select true from @NAMESPACE@.sl_set
			where set_origin = p_no_id)
	then
		raise exception 'Slony-I: Node % is still origin of one or more sets',
				p_no_id;
	end if;

	-- ----
	-- Call the internal drop functionality and generate the event
	-- ----
	perform @NAMESPACE@.dropNode_int(p_no_id);
	return  @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'DROP_NODE',
									p_no_id::text);
end;
$$ language plpgsql;
comment on function @NAMESPACE@.dropNode(int4) is
'generate DROP_NODE event to drop node node_id from replication';

-- ----------------------------------------------------------------------
-- FUNCTION dropNode_int (no_id)
--
--	Process the DROP_NODE event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.dropNode_int (int4)
returns int4
as $$
declare
	p_no_id			alias for $1;
	v_tab_row		record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- If the dropped node is a remote node, clean the configuration
	-- from all traces for it.
	-- ----
	if p_no_id <> @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
		delete from @NAMESPACE@.sl_subscribe
				where sub_receiver = p_no_id;
		delete from @NAMESPACE@.sl_listen
				where li_origin = p_no_id
					or li_provider = p_no_id
					or li_receiver = p_no_id;
		delete from @NAMESPACE@.sl_path
				where pa_server = p_no_id
					or pa_client = p_no_id;
		delete from @NAMESPACE@.sl_confirm
				where con_origin = p_no_id
					or con_received = p_no_id;
		delete from @NAMESPACE@.sl_event
				where ev_origin = p_no_id;
		delete from @NAMESPACE@.sl_node
				where no_id = p_no_id;

		return p_no_id;
	end if;

	-- ----
	-- This is us ... deactivate the node for now, the daemon
	-- will call uninstallNode() in a separate transaction.
	-- ----
	update @NAMESPACE@.sl_node
			set no_active = false
			where no_id = p_no_id;

	-- Rewrite sl_listen table
	perform @NAMESPACE@.RebuildListenEntries();

	return p_no_id;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.dropNode_int(int4) is
'internal function to process DROP_NODE event to drop node node_id from replication';


-- ----------------------------------------------------------------------
-- FUNCTION failedNode (failed_node, backup_node)
--
--	Initiate a failover. This function must be called on all nodes
--	and then waited for the restart of all node daemons.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.failedNode(int4, int4)
returns int4
as $$
declare
	p_failed_node		alias for $1;
	p_backup_node		alias for $2;
	v_row				record;
	v_row2				record;
	v_n					int4;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- All consistency checks first
	-- Check that every node that has a path to the failed node
	-- also has a path to the backup node.
	-- ----
	for v_row in select P.pa_client
			from @NAMESPACE@.sl_path P
			where P.pa_server = p_failed_node
				and P.pa_client <> p_backup_node
				and not exists (select true from @NAMESPACE@.sl_path PP
							where PP.pa_server = p_backup_node
								and PP.pa_client = P.pa_client)
	loop
		raise exception 'Slony-I: cannot failover - node % has no path to the backup node',
				v_row.pa_client;
	end loop;

	-- ----
	-- Check all sets originating on the failed node
	-- ----
	for v_row in select set_id
			from @NAMESPACE@.sl_set
			where set_origin = p_failed_node
	loop
		-- ----
		-- Check that the backup node is subscribed to all sets
		-- that originate on the failed node
		-- ----
		select into v_row2 sub_forward, sub_active
				from @NAMESPACE@.sl_subscribe
				where sub_set = v_row.set_id
					and sub_receiver = p_backup_node;
		if not found then
			raise exception 'Slony-I: cannot failover - node % is not subscribed to set %',
					p_backup_node, v_row.set_id;
		end if;

		-- ----
		-- Check that the subscription is active
		-- ----
		if not v_row2.sub_active then
			raise exception 'Slony-I: cannot failover - subscription for set % is not active',
					v_row.set_id;
		end if;

		-- ----
		-- If there are other subscribers, the backup node needs to
		-- be a forwarder too.
		-- ----
		select into v_n count(*)
				from @NAMESPACE@.sl_subscribe
				where sub_set = v_row.set_id
					and sub_receiver <> p_backup_node;
		if v_n > 0 and not v_row2.sub_forward then
			raise exception 'Slony-I: cannot failover - node % is not a forwarder of set %',
					p_backup_node, v_row.set_id;
		end if;
	end loop;

	-- ----
	-- Terminate all connections of the failed node the hard way
	-- ----
	perform @NAMESPACE@.terminateNodeConnections(p_failed_node);

	-- ----
	-- Move the sets
	-- ----
	for v_row in select S.set_id, (select count(*)
					from @NAMESPACE@.sl_subscribe SUB
					where S.set_id = SUB.sub_set
						and SUB.sub_receiver <> p_backup_node
						and SUB.sub_provider = p_failed_node)
					as num_direct_receivers 
			from @NAMESPACE@.sl_set S
			where S.set_origin = p_failed_node
			for update
	loop
		-- ----
		-- If the backup node is the only direct subscriber ...
		-- ----
		if v_row.num_direct_receivers = 0 then
		        raise notice 'failedNode: set % has no other direct receivers - move now', v_row.set_id;
			-- ----
			-- backup_node is the only direct subscriber, move the set
			-- right now. On the backup node itself that includes restoring
			-- all user mode triggers, removing the protection trigger,
			-- adding the log trigger, removing the subscription and the
			-- obsolete setsync status.
			-- ----
			if p_backup_node = @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
				update @NAMESPACE@.sl_set set set_origin = p_backup_node
						where set_id = v_row.set_id;

				delete from @NAMESPACE@.sl_setsync
						where ssy_setid = v_row.set_id;

				for v_row2 in select * from @NAMESPACE@.sl_table
						where tab_set = v_row.set_id
						order by tab_id
				loop
					perform @NAMESPACE@.alterTableConfigureTriggers(v_row2.tab_id);
				end loop;
			end if;

			delete from @NAMESPACE@.sl_subscribe
					where sub_set = v_row.set_id
						and sub_receiver = p_backup_node;
		else
			raise notice 'failedNode: set % has other direct receivers - change providers only', v_row.set_id;
			-- ----
			-- Backup node is not the only direct subscriber or not
			-- a direct subscriber at all. 
			-- This means that at this moment, we redirect all possible
			-- direct subscribers to receive from the backup node, and the
			-- backup node itself to receive from another one.
			-- The admin utility will wait for the slon engine to
			-- restart and then call failedNode2() on the node with
			-- the highest SYNC and redirect this to it on
			-- backup node later.
			-- ----
			update @NAMESPACE@.sl_subscribe
					set sub_provider = (select min(SS.sub_receiver)
							from @NAMESPACE@.sl_subscribe SS
							where SS.sub_set = v_row.set_id
								and SS.sub_receiver <> p_backup_node
								and SS.sub_forward
								and exists (
									select 1 from @NAMESPACE@.sl_path
										where pa_server = SS.sub_receiver
										  and pa_client = p_backup_node
								))
					where sub_set = v_row.set_id
						and sub_receiver = p_backup_node;
			update @NAMESPACE@.sl_subscribe
					set sub_provider = (select min(SS.sub_receiver)
							from @NAMESPACE@.sl_subscribe SS
							where SS.sub_set = v_row.set_id
								and SS.sub_receiver <> p_failed_node
								and SS.sub_forward
								and exists (
									select 1 from @NAMESPACE@.sl_path
										where pa_server = SS.sub_receiver
										  and pa_client = @NAMESPACE@.sl_subscribe.sub_receiver
								))
					where sub_set = v_row.set_id
						and sub_receiver <> p_backup_node;
			update @NAMESPACE@.sl_subscribe
					set sub_provider = p_backup_node
					where sub_set = v_row.set_id
						and sub_receiver <> p_backup_node
						and exists (
							select 1 from @NAMESPACE@.sl_path
								where pa_server = p_backup_node
								  and pa_client = @NAMESPACE@.sl_subscribe.sub_receiver
						);
			delete from @NAMESPACE@.sl_subscribe
					where sub_set = v_row.set_id
						and sub_receiver = p_backup_node;				
		end if;
	end loop;
	

	-- Rewrite sl_listen table
	perform @NAMESPACE@.RebuildListenEntries();

	-- Run addPartialLogIndices() to try to add indices to unused sl_log_? table
	perform @NAMESPACE@.addPartialLogIndices();

	-- ----
	-- Make sure the node daemon will restart
	-- ----
	notify "_@CLUSTERNAME@_Restart";

	-- ----
	-- That is it - so far.
	-- ----
	return p_failed_node;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.failedNode(int4,int4) is
'Initiate failover from failed_node to backup_node.  This function must be called on all nodes, 
and then waited for the restart of all node daemons.';

-- ----------------------------------------------------------------------
-- FUNCTION failedNode2 (failed_node, backup_node, set_id, ev_seqno, ev_seqfake)
--
--	On the node that has the highest sequence number of the failed node,
--	fake the FAILED_NODE event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.failedNode2 (int4, int4, int4, int8, int8)
returns bigint
as $$
declare
	p_failed_node		alias for $1;
	p_backup_node		alias for $2;
	p_set_id			alias for $3;
	p_ev_seqno			alias for $4;
	p_ev_seqfake		alias for $5;
	v_row				record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	select * into v_row
			from @NAMESPACE@.sl_event
			where ev_origin = p_failed_node
			and ev_seqno = p_ev_seqno;
	if not found then
		raise exception 'Slony-I: event %,% not found',
				p_failed_node, p_ev_seqno;
	end if;

	insert into @NAMESPACE@.sl_event
			(ev_origin, ev_seqno, ev_timestamp,
			ev_snapshot, 
			ev_type, ev_data1, ev_data2, ev_data3)
			values 
			(p_failed_node, p_ev_seqfake, CURRENT_TIMESTAMP,
			v_row.ev_snapshot, 
			'FAILOVER_SET', p_failed_node::text, p_backup_node::text,
			p_set_id::text);
	insert into @NAMESPACE@.sl_confirm
			(con_origin, con_received, con_seqno, con_timestamp)
			values
			(p_failed_node, @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@'),
			p_ev_seqfake, CURRENT_TIMESTAMP);
	notify "_@CLUSTERNAME@_Restart";

	perform @NAMESPACE@.failoverSet_int(p_failed_node,
			p_backup_node, p_set_id, p_ev_seqfake);

	return p_ev_seqfake;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.failedNode2 (int4, int4, int4, int8, int8) is
'FUNCTION failedNode2 (failed_node, backup_node, set_id, ev_seqno, ev_seqfake)

On the node that has the highest sequence number of the failed node,
fake the FAILOVER_SET event.';

-- ----------------------------------------------------------------------
-- FUNCTION failoverSet_int (failed_node, backup_node, set_id, wait_seqno)
--
--	Finish failover for one set.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.failoverSet_int (int4, int4, int4, int8)
returns int4
as $$
declare
	p_failed_node		alias for $1;
	p_backup_node		alias for $2;
	p_set_id			alias for $3;
	p_wait_seqno		alias for $4;
	v_row				record;
	v_last_sync			int8;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Change the origin of the set now to the backup node.
	-- On the backup node this includes changing all the
	-- trigger and protection stuff
	-- ----
	if p_backup_node = @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
		delete from @NAMESPACE@.sl_setsync
				where ssy_setid = p_set_id;
		delete from @NAMESPACE@.sl_subscribe
				where sub_set = p_set_id
					and sub_receiver = p_backup_node;
		update @NAMESPACE@.sl_set
				set set_origin = p_backup_node
				where set_id = p_set_id;

		for v_row in select * from @NAMESPACE@.sl_table
				where tab_set = p_set_id
				order by tab_id
		loop
			perform @NAMESPACE@.alterTableConfigureTriggers(v_row.tab_id);
		end loop;
		insert into @NAMESPACE@.sl_event
				(ev_origin, ev_seqno, ev_timestamp,
				ev_snapshot, 
				ev_type, ev_data1, ev_data2, ev_data3, ev_data4)
				values
				(p_backup_node, "pg_catalog".nextval('@NAMESPACE@.sl_event_seq'), CURRENT_TIMESTAMP,
				pg_catalog.txid_current_snapshot(),
				'ACCEPT_SET', p_set_id::text,
				p_failed_node::text, p_backup_node::text,
				p_wait_seqno::text);
	else
		delete from @NAMESPACE@.sl_subscribe
				where sub_set = p_set_id
					and sub_receiver = p_backup_node;
		update @NAMESPACE@.sl_set
				set set_origin = p_backup_node
				where set_id = p_set_id;
	end if;

	update @NAMESPACE@.sl_node
		   set no_active=false WHERE 
		   no_id=p_failed_node;

	-- Rewrite sl_listen table
	perform @NAMESPACE@.RebuildListenEntries();

	-- ----
	-- If we are a subscriber of the set ourself, change our
	-- setsync status to reflect the new set origin.
	-- ----
	if exists (select true from @NAMESPACE@.sl_subscribe
			where sub_set = p_set_id
				and sub_receiver = @NAMESPACE@.getLocalNodeId(
						'_@CLUSTERNAME@'))
	then
		delete from @NAMESPACE@.sl_setsync
				where ssy_setid = p_set_id;

		select coalesce(max(ev_seqno), 0) into v_last_sync
				from @NAMESPACE@.sl_event
				where ev_origin = p_backup_node
					and ev_type = 'SYNC';
		if v_last_sync > 0 then
			insert into @NAMESPACE@.sl_setsync
					(ssy_setid, ssy_origin, ssy_seqno,
					ssy_snapshot, ssy_action_list)
					select p_set_id, p_backup_node, v_last_sync,
					ev_snapshot, NULL
					from @NAMESPACE@.sl_event
					where ev_origin = p_backup_node
						and ev_seqno = v_last_sync;
		else
			insert into @NAMESPACE@.sl_setsync
					(ssy_setid, ssy_origin, ssy_seqno,
					ssy_snapshot, ssy_action_list)
					values (p_set_id, p_backup_node, '0',
					'1:1:', NULL);
		end if;
				
	end if;

	return p_failed_node;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.failoverSet_int (int4, int4, int4, int8) is
'FUNCTION failoverSet_int (failed_node, backup_node, set_id, wait_seqno)

Finish failover for one set.';

-- ----------------------------------------------------------------------
-- FUNCTION uninstallNode ()
--
--	Reset the whole database to standalone by removing the whole
--	replication system.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.uninstallNode ()
returns int4
as $$
declare
	v_tab_row		record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	raise notice 'Slony-I: Please drop schema "_@CLUSTERNAME@"';
	return 0;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.uninstallNode() is
'Reset the whole database to standalone by removing the whole
replication system.';

-- ----------------------------------------------------------------------
-- FUNCTION cloneNodePrepare ()
--
--	Duplicate a nodes configuration under a different no_id in
--	preparation for the node to be copied with standard DB tools.
-- ----------------------------------------------------------------------
drop function if exists @NAMESPACE@.cloneNodePrepare (int4, int4, text); -- Needed because function signature has changed!
create or replace function @NAMESPACE@.cloneNodePrepare (int4, int4, text)
returns bigint
as $$
declare
	p_no_id			alias for $1;
	p_no_provider	alias for $2;
	p_no_comment	alias for $3;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	perform @NAMESPACE@.cloneNodePrepare_int (p_no_id, p_no_provider, p_no_comment);
	return  @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'CLONE_NODE',
									p_no_id::text, p_no_provider::text,
									p_no_comment::text);
end;
$$ language plpgsql;

comment on function @NAMESPACE@.cloneNodePrepare(int4, int4, text) is
'Prepare for cloning a node.';

-- ----------------------------------------------------------------------
-- FUNCTION cloneNodePrepare_int ()
--
--	Internal part of cloneNodePrepare()
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.cloneNodePrepare_int (int4, int4, text)
returns int4
as $$
declare
	p_no_id			alias for $1;
	p_no_provider	alias for $2;
	p_no_comment	alias for $3;
begin
	insert into @NAMESPACE@.sl_node
		(no_id, no_active, no_comment)
		select p_no_id, no_active, p_no_comment
		from @NAMESPACE@.sl_node
		where no_id = p_no_provider;

	insert into @NAMESPACE@.sl_path
		(pa_server, pa_client, pa_conninfo, pa_connretry)
		select pa_server, p_no_id, 'Event pending', pa_connretry
		from @NAMESPACE@.sl_path
		where pa_client = p_no_provider;
	insert into @NAMESPACE@.sl_path
		(pa_server, pa_client, pa_conninfo, pa_connretry)
		select p_no_id, pa_client, 'Event pending', pa_connretry
		from @NAMESPACE@.sl_path
		where pa_server = p_no_provider;

	insert into @NAMESPACE@.sl_subscribe
		(sub_set, sub_provider, sub_receiver, sub_forward, sub_active)
		select sub_set, sub_provider, p_no_id, sub_forward, sub_active
		from @NAMESPACE@.sl_subscribe
		where sub_receiver = p_no_provider;

	insert into @NAMESPACE@.sl_confirm
		(con_origin, con_received, con_seqno, con_timestamp)
		select con_origin, p_no_id, con_seqno, con_timestamp
		from @NAMESPACE@.sl_confirm
		where con_received = p_no_provider;

	perform @NAMESPACE@.RebuildListenEntries();

	return 0;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.cloneNodePrepare_int(int4, int4, text) is
'Internal part of cloneNodePrepare().';

-- ----------------------------------------------------------------------
-- FUNCTION cloneNodeFinish ()
--
--	Finish the cloning process on the new node.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.cloneNodeFinish (int4, int4)
returns int4
as $$
declare
	p_no_id			alias for $1;
	p_no_provider	alias for $2;
	v_row			record;
begin
	perform "pg_catalog".setval('@NAMESPACE@.sl_local_node_id', p_no_id);

	for v_row in select sub_set from @NAMESPACE@.sl_subscribe
			where sub_receiver = p_no_id
	loop
		perform @NAMESPACE@.updateReloid(v_row.sub_set, p_no_id);
	end loop;

	perform @NAMESPACE@.RebuildListenEntries();

	delete from @NAMESPACE@.sl_confirm
		where con_received = p_no_id;
	insert into @NAMESPACE@.sl_confirm
		(con_origin, con_received, con_seqno, con_timestamp)
		select con_origin, p_no_id, con_seqno, con_timestamp
		from @NAMESPACE@.sl_confirm
		where con_received = p_no_provider;
	insert into @NAMESPACE@.sl_confirm
		(con_origin, con_received, con_seqno, con_timestamp)
		select p_no_provider, p_no_id, 
				(select max(ev_seqno) from @NAMESPACE@.sl_event
					where ev_origin = p_no_provider), current_timestamp;

	return 0;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.cloneNodeFinish(int4, int4) is
'Internal part of cloneNodePrepare().';

-- ----------------------------------------------------------------------
-- FUNCTION storePath (pa_server, pa_client, pa_conninfo, pa_connretry)
--
--	Generate the STORE_PATH event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.storePath (int4, int4, text, int4)
returns bigint
as $$
declare
	p_pa_server		alias for $1;
	p_pa_client		alias for $2;
	p_pa_conninfo	alias for $3;
	p_pa_connretry	alias for $4;
begin
	perform @NAMESPACE@.storePath_int(p_pa_server, p_pa_client,
			p_pa_conninfo, p_pa_connretry);
	return  @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'STORE_PATH', 
			p_pa_server::text, p_pa_client::text, 
			p_pa_conninfo::text, p_pa_connretry::text);
end;
$$ language plpgsql;

comment on function @NAMESPACE@.storePath (int4, int4, text, int4) is
'FUNCTION storePath (pa_server, pa_client, pa_conninfo, pa_connretry)

Generate the STORE_PATH event indicating that node pa_client can
access node pa_server using DSN pa_conninfo';


-- ----------------------------------------------------------------------
-- FUNCTION storePath_int (pa_server, pa_client, pa_conninfo, pa_connretry)
--
--	Process the STORE_PATH event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.storePath_int (int4, int4, text, int4)
returns int4
as $$
declare
	p_pa_server		alias for $1;
	p_pa_client		alias for $2;
	p_pa_conninfo	alias for $3;
	p_pa_connretry	alias for $4;
	v_dummy			int4;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Check if the path already exists
	-- ----
	select 1 into v_dummy
			from @NAMESPACE@.sl_path
			where pa_server = p_pa_server
			and pa_client = p_pa_client
			for update;
	if found then
		-- ----
		-- Path exists, update pa_conninfo
		-- ----
		update @NAMESPACE@.sl_path
				set pa_conninfo = p_pa_conninfo,
					pa_connretry = p_pa_connretry
				where pa_server = p_pa_server
				and pa_client = p_pa_client;
	else
		-- ----
		-- New path
		--
		-- In case we receive STORE_PATH events before we know
		-- about the nodes involved in this, we generate those nodes
		-- as pending.
		-- ----
		if not exists (select 1 from @NAMESPACE@.sl_node
						where no_id = p_pa_server) then
			perform @NAMESPACE@.storeNode_int (p_pa_server, '<event pending>');
		end if;
		if not exists (select 1 from @NAMESPACE@.sl_node
						where no_id = p_pa_client) then
			perform @NAMESPACE@.storeNode_int (p_pa_client, '<event pending>');
		end if;
		insert into @NAMESPACE@.sl_path
				(pa_server, pa_client, pa_conninfo, pa_connretry) values
				(p_pa_server, p_pa_client, p_pa_conninfo, p_pa_connretry);
	end if;

	-- Rewrite sl_listen table
	perform @NAMESPACE@.RebuildListenEntries();

	return 0;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.storePath_int (int4, int4, text, int4) is
'FUNCTION storePath (pa_server, pa_client, pa_conninfo, pa_connretry)

Process the STORE_PATH event indicating that node pa_client can
access node pa_server using DSN pa_conninfo';

-- ----------------------------------------------------------------------
-- FUNCTION dropPath (pa_server, pa_client)
--
--	Generate the DROP_PATH event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.dropPath (int4, int4)
returns bigint
as $$
declare
	p_pa_server		alias for $1;
	p_pa_client		alias for $2;
	v_row			record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- There should be no existing subscriptions. Auto unsubscribing
	-- is considered too dangerous. 
	-- ----
	for v_row in select sub_set, sub_provider, sub_receiver
			from @NAMESPACE@.sl_subscribe
			where sub_provider = p_pa_server
			and sub_receiver = p_pa_client
	loop
		raise exception 
			'Slony-I: Path cannot be dropped, subscription of set % needs it',
			v_row.sub_set;
	end loop;

	-- ----
	-- Drop all sl_listen entries that depend on this path
	-- ----
	for v_row in select li_origin, li_provider, li_receiver
			from @NAMESPACE@.sl_listen
			where li_provider = p_pa_server
			and li_receiver = p_pa_client
	loop
		perform @NAMESPACE@.dropListen(
				v_row.li_origin, v_row.li_provider, v_row.li_receiver);
	end loop;

	-- ----
	-- Now drop the path and create the event
	-- ----
	perform @NAMESPACE@.dropPath_int(p_pa_server, p_pa_client);

	-- Rewrite sl_listen table
	perform @NAMESPACE@.RebuildListenEntries();

	return  @NAMESPACE@.createEvent ('_@CLUSTERNAME@', 'DROP_PATH',
			p_pa_server::text, p_pa_client::text);
end;
$$ language plpgsql;

comment on function @NAMESPACE@.dropPath (int4, int4) is
  'Generate DROP_PATH event to drop path from pa_server to pa_client';

-- ----------------------------------------------------------------------
-- FUNCTION dropPath_int (pa_server, pa_client)
--
--	Process the DROP_NODE event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.dropPath_int (int4, int4)
returns int4
as $$
declare
	p_pa_server		alias for $1;
	p_pa_client		alias for $2;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Remove any dangling sl_listen entries with the server
	-- as provider and the client as receiver. This must have
	-- been cleared out before, but obviously was not.
	-- ----
	delete from @NAMESPACE@.sl_listen
			where li_provider = p_pa_server
			and li_receiver = p_pa_client;

	delete from @NAMESPACE@.sl_path
			where pa_server = p_pa_server
			and pa_client = p_pa_client;

	if found then
		-- Rewrite sl_listen table
		perform @NAMESPACE@.RebuildListenEntries();

		return 1;
	else
		-- Rewrite sl_listen table
		perform @NAMESPACE@.RebuildListenEntries();

		return 0;
	end if;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.dropPath_int (int4, int4) is
'Process DROP_PATH event to drop path from pa_server to pa_client';

-- ----------------------------------------------------------------------
-- FUNCTION storeListen (origin, provider, receiver)
--
--	Generate the STORE_LISTEN event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.storeListen (int4, int4, int4)
returns bigint
as $$
declare
	p_origin		alias for $1;
	p_provider	alias for $2;
	p_receiver	alias for $3;
begin
	perform @NAMESPACE@.storeListen_int (p_origin, p_provider, p_receiver);
	return  @NAMESPACE@.createEvent ('_@CLUSTERNAME@', 'STORE_LISTEN',
			p_origin::text, p_provider::text, p_receiver::text);
end;
$$ language plpgsql
	called on null input;

comment on function @NAMESPACE@.storeListen(int4,int4,int4) is
'FUNCTION storeListen (li_origin, li_provider, li_receiver)

generate STORE_LISTEN event, indicating that receiver node li_receiver
listens to node li_provider in order to get messages coming from node
li_origin.';

-- ----------------------------------------------------------------------
-- FUNCTION storeListen_int (li_origin, li_provider, li_receiver)
--
--	Process the STORE_LISTEN event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.storeListen_int (int4, int4, int4)
returns int4
as $$
declare
	p_li_origin		alias for $1;
	p_li_provider	alias for $2;
	p_li_receiver	alias for $3;
	v_exists		int4;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	select 1 into v_exists
			from @NAMESPACE@.sl_listen
			where li_origin = p_li_origin
			and li_provider = p_li_provider
			and li_receiver = p_li_receiver;
	if not found then
		-- ----
		-- In case we receive STORE_LISTEN events before we know
		-- about the nodes involved in this, we generate those nodes
		-- as pending.
		-- ----
		if not exists (select 1 from @NAMESPACE@.sl_node
						where no_id = p_li_origin) then
			perform @NAMESPACE@.storeNode_int (p_li_origin, '<event pending>');
		end if;
		if not exists (select 1 from @NAMESPACE@.sl_node
						where no_id = p_li_provider) then
			perform @NAMESPACE@.storeNode_int (p_li_provider, '<event pending>');
		end if;
		if not exists (select 1 from @NAMESPACE@.sl_node
						where no_id = p_li_receiver) then
			perform @NAMESPACE@.storeNode_int (p_li_receiver, '<event pending>');
		end if;

		insert into @NAMESPACE@.sl_listen
				(li_origin, li_provider, li_receiver) values
				(p_li_origin, p_li_provider, p_li_receiver);
	end if;

	return 0;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.storeListen_int(int4,int4,int4) is
'FUNCTION storeListen_int (li_origin, li_provider, li_receiver)

Process STORE_LISTEN event, indicating that receiver node li_receiver
listens to node li_provider in order to get messages coming from node
li_origin.';


-- ----------------------------------------------------------------------
-- FUNCTION dropListen (li_origin, li_provider, li_receiver)
--
--	Generate the DROP_LISTEN event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.dropListen (int4, int4, int4)
returns bigint
as $$
declare
	p_li_origin		alias for $1;
	p_li_provider	alias for $2;
	p_li_receiver	alias for $3;
begin
	perform @NAMESPACE@.dropListen_int(p_li_origin, 
			p_li_provider, p_li_receiver);
	
	return  @NAMESPACE@.createEvent ('_@CLUSTERNAME@', 'DROP_LISTEN',
			p_li_origin::text, p_li_provider::text, p_li_receiver::text);
end;
$$ language plpgsql;

comment on function @NAMESPACE@.dropListen(int4, int4, int4) is
'dropListen (li_origin, li_provider, li_receiver)

Generate the DROP_LISTEN event.';

-- ----------------------------------------------------------------------
-- FUNCTION dropListen_int (li_origin, li_provider, li_receiver)
--
--	Process the DROP_LISTEN event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.dropListen_int (int4, int4, int4)
returns int4
as $$
declare
	p_li_origin		alias for $1;
	p_li_provider	alias for $2;
	p_li_receiver	alias for $3;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	delete from @NAMESPACE@.sl_listen
			where li_origin = p_li_origin
			and li_provider = p_li_provider
			and li_receiver = p_li_receiver;
	if found then
		return 1;
	else
		return 0;
	end if;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.dropListen_int(int4, int4, int4) is
'dropListen (li_origin, li_provider, li_receiver)

Process the DROP_LISTEN event, deleting the sl_listen entry for
the indicated (origin,provider,receiver) combination.';


-- ----------------------------------------------------------------------
-- FUNCTION storeSet (set_id, set_comment)
--
--	Generate the STORE_SET event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.storeSet (int4, text)
returns bigint
as $$
declare
	p_set_id			alias for $1;
	p_set_comment		alias for $2;
	v_local_node_id		int4;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	v_local_node_id := @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');

	insert into @NAMESPACE@.sl_set
			(set_id, set_origin, set_comment) values
			(p_set_id, v_local_node_id, p_set_comment);

	return @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'STORE_SET', 
			p_set_id::text, v_local_node_id::text, p_set_comment::text);
end;
$$ language plpgsql;
comment on function @NAMESPACE@.storeSet(int4, text) is
'Generate STORE_SET event for set set_id with human readable comment set_comment';

-- ----------------------------------------------------------------------
-- FUNCTION storeSet_int (set_id, set_origin, set_comment)
--
--	Process the STORE_SET event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.storeSet_int (int4, int4, text)
returns int4
as $$
declare
	p_set_id			alias for $1;
	p_set_origin		alias for $2;
	p_set_comment		alias for $3;
	v_dummy				int4;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	select 1 into v_dummy
			from @NAMESPACE@.sl_set
			where set_id = p_set_id
			for update;
	if found then 
		update @NAMESPACE@.sl_set
				set set_comment = p_set_comment
				where set_id = p_set_id;
	else
		if not exists (select 1 from @NAMESPACE@.sl_node
						where no_id = p_set_origin) then
			perform @NAMESPACE@.storeNode_int (p_set_origin, '<event pending>');
		end if;
		insert into @NAMESPACE@.sl_set
				(set_id, set_origin, set_comment) values
				(p_set_id, p_set_origin, p_set_comment);
	end if;

	-- Run addPartialLogIndices() to try to add indices to unused sl_log_? table
	perform @NAMESPACE@.addPartialLogIndices();

	return p_set_id;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.storeSet_int(int4, int4, text) is
'storeSet_int (set_id, set_origin, set_comment)

Process the STORE_SET event, indicating the new set with given ID,
origin node, and human readable comment.';


-- ----------------------------------------------------------------------
-- FUNCTION lockSet (set_id)
--
--	Add a special trigger to all tables of a set that disables
--	access to it.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.lockSet (int4)
returns int4
as $$
declare
	p_set_id			alias for $1;
	v_local_node_id		int4;
	v_set_row			record;
	v_tab_row			record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Check that the set exists and that we are the origin
	-- and that it is not already locked.
	-- ----
	v_local_node_id := @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');
	select * into v_set_row from @NAMESPACE@.sl_set
			where set_id = p_set_id
			for update;
	if not found then
		raise exception 'Slony-I: set % not found', p_set_id;
	end if;
	if v_set_row.set_origin <> v_local_node_id then
		raise exception 'Slony-I: set % does not originate on local node',
				p_set_id;
	end if;
	if v_set_row.set_locked notnull then
		raise exception 'Slony-I: set % is already locked', p_set_id;
	end if;

	-- ----
	-- Place the lockedSet trigger on all tables in the set.
	-- ----
	for v_tab_row in select T.tab_id,
			@NAMESPACE@.slon_quote_brute(PGN.nspname) || '.' ||
			@NAMESPACE@.slon_quote_brute(PGC.relname) as tab_fqname
			from @NAMESPACE@.sl_table T,
				"pg_catalog".pg_class PGC, "pg_catalog".pg_namespace PGN
			where T.tab_set = p_set_id
				and T.tab_reloid = PGC.oid
				and PGC.relnamespace = PGN.oid
			order by tab_id
	loop
		execute 'create trigger "_@CLUSTERNAME@_lockedset" ' || 
				'before insert or update or delete on ' ||
				v_tab_row.tab_fqname || ' for each row execute procedure
				@NAMESPACE@.lockedSet (''_@CLUSTERNAME@'');';
	end loop;

	-- ----
	-- Remember our snapshots xmax as for the set locking
	-- ----
	update @NAMESPACE@.sl_set
			set set_locked = "pg_catalog".txid_snapshot_xmax("pg_catalog".txid_current_snapshot())
			where set_id = p_set_id;

	return p_set_id;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.lockSet(int4) is 
'lockSet(set_id)

Add a special trigger to all tables of a set that disables access to
it.';


-- ----------------------------------------------------------------------
-- FUNCTION unlockSet (set_id)
--
--	Remove the special trigger from all tables of a set that disables
--	access to it.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.unlockSet (int4)
returns int4
as $$
declare
	p_set_id			alias for $1;
	v_local_node_id		int4;
	v_set_row			record;
	v_tab_row			record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Check that the set exists and that we are the origin
	-- and that it is not already locked.
	-- ----
	v_local_node_id := @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');
	select * into v_set_row from @NAMESPACE@.sl_set
			where set_id = p_set_id
			for update;
	if not found then
		raise exception 'Slony-I: set % not found', p_set_id;
	end if;
	if v_set_row.set_origin <> v_local_node_id then
		raise exception 'Slony-I: set % does not originate on local node',
				p_set_id;
	end if;
	if v_set_row.set_locked isnull then
		raise exception 'Slony-I: set % is not locked', p_set_id;
	end if;

	-- ----
	-- Drop the lockedSet trigger from all tables in the set.
	-- ----
	for v_tab_row in select T.tab_id,
			@NAMESPACE@.slon_quote_brute(PGN.nspname) || '.' ||
			@NAMESPACE@.slon_quote_brute(PGC.relname) as tab_fqname
			from @NAMESPACE@.sl_table T,
				"pg_catalog".pg_class PGC, "pg_catalog".pg_namespace PGN
			where T.tab_set = p_set_id
				and T.tab_reloid = PGC.oid
				and PGC.relnamespace = PGN.oid
			order by tab_id
	loop
		execute 'drop trigger "_@CLUSTERNAME@_lockedset" ' || 
				'on ' || v_tab_row.tab_fqname;
	end loop;

	-- ----
	-- Clear out the set_locked field
	-- ----
	update @NAMESPACE@.sl_set
			set set_locked = NULL
			where set_id = p_set_id;

	return p_set_id;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.unlockSet(int4) is
'Remove the special trigger from all tables of a set that disables access to it.';

-- ----------------------------------------------------------------------
-- FUNCTION moveSet (set_id, new_origin)
--
--	Generate the MOVE_SET event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.moveSet (int4, int4)
returns bigint
as $$
declare
	p_set_id			alias for $1;
	p_new_origin		alias for $2;
	v_local_node_id		int4;
	v_set_row			record;
	v_sub_row			record;
	v_sync_seqno		int8;
	v_lv_row			record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Check that the set is locked and that this locking
	-- happened long enough ago.
	-- ----
	v_local_node_id := @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');
	select * into v_set_row from @NAMESPACE@.sl_set
			where set_id = p_set_id
			for update;
	if not found then
		raise exception 'Slony-I: set % not found', p_set_id;
	end if;
	if v_set_row.set_origin <> v_local_node_id then
		raise exception 'Slony-I: set % does not originate on local node',
				p_set_id;
	end if;
	if v_set_row.set_locked isnull then
		raise exception 'Slony-I: set % is not locked', p_set_id;
	end if;
	if v_set_row.set_locked > "pg_catalog".txid_snapshot_xmin("pg_catalog".txid_current_snapshot()) then
		raise exception 'Slony-I: cannot move set % yet, transactions < % are still in progress',
				p_set_id, v_set_row.set_locked;
	end if;

	-- ----
	-- Unlock the set
	-- ----
	perform @NAMESPACE@.unlockSet(p_set_id);

	-- ----
	-- Check that the new_origin is an active subscriber of the set
	-- ----
	select * into v_sub_row from @NAMESPACE@.sl_subscribe
			where sub_set = p_set_id
			and sub_receiver = p_new_origin;
	if not found then
		raise exception 'Slony-I: set % is not subscribed by node %',
				p_set_id, p_new_origin;
	end if;
	if not v_sub_row.sub_active then
		raise exception 'Slony-I: subsctiption of node % for set % is inactive',
				p_new_origin, p_set_id;
	end if;

	-- ----
	-- Reconfigure everything
	-- ----
	perform @NAMESPACE@.moveSet_int(p_set_id, v_local_node_id,
			p_new_origin, 0);

	perform @NAMESPACE@.RebuildListenEntries();

	-- ----
	-- At this time we hold access exclusive locks for every table
	-- in the set. But we did move the set to the new origin, so the
	-- createEvent() we are doing now will not record the sequences.
	-- ----
	v_sync_seqno := @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'SYNC');
	insert into @NAMESPACE@.sl_seqlog 
			(seql_seqid, seql_origin, seql_ev_seqno, seql_last_value)
			select seq_id, v_local_node_id, v_sync_seqno, seq_last_value
			from @NAMESPACE@.sl_seqlastvalue
			where seq_set = p_set_id;
					
	-- ----
	-- Finally we generate the real event
	-- ----
	return @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'MOVE_SET', 
			p_set_id::text, v_local_node_id::text, p_new_origin::text);
end;
$$ language plpgsql;
comment on function @NAMESPACE@.moveSet(int4, int4) is 
'moveSet(set_id, new_origin)

Generate MOVE_SET event to request that the origin for set set_id be moved to node new_origin';

-- ----------------------------------------------------------------------
-- FUNCTION moveSet_int (set_id, old_origin, new_origin, wait_seqno)
--
--	Process the MOVE_SET event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.moveSet_int (int4, int4, int4, int8)
returns int4
as $$
declare
	p_set_id			alias for $1;
	p_old_origin		alias for $2;
	p_new_origin		alias for $3;
	p_wait_seqno		alias for $4;
	v_local_node_id		int4;
	v_tab_row			record;
	v_sub_row			record;
	v_sub_node			int4;
	v_sub_last			int4;
	v_sub_next			int4;
	v_last_sync			int8;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Get our local node ID
	-- ----
	v_local_node_id := @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');

	-- On the new origin, raise an event - ACCEPT_SET
	if v_local_node_id = p_new_origin then
		-- Create a SYNC event as well so that the ACCEPT_SET has
		-- the same snapshot as the last SYNC generated by the new
		-- origin. This snapshot will be used by other nodes to
		-- finalize the setsync status.
		perform @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'SYNC', NULL);
		perform @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'ACCEPT_SET', 
			p_set_id::text, p_old_origin::text, 
			p_new_origin::text, p_wait_seqno::text);
	end if;

	-- ----
	-- Next we have to reverse the subscription path
	-- ----
	v_sub_last = p_new_origin;
	select sub_provider into v_sub_node
			from @NAMESPACE@.sl_subscribe
			where sub_set = p_set_id
			and sub_receiver = p_new_origin;
	if not found then
		raise exception 'Slony-I: subscription path broken in moveSet_int';
	end if;
	while v_sub_node <> p_old_origin loop
		-- ----
		-- Tracing node by node, the old receiver is now in
		-- v_sub_last and the old provider is in v_sub_node.
		-- ----

		-- ----
		-- Get the current provider of this node as next
		-- and change the provider to the previous one in
		-- the reverse chain.
		-- ----
		select sub_provider into v_sub_next
				from @NAMESPACE@.sl_subscribe
				where sub_set = p_set_id
					and sub_receiver = v_sub_node
				for update;
		if not found then
			raise exception 'Slony-I: subscription path broken in moveSet_int';
		end if;
		update @NAMESPACE@.sl_subscribe
				set sub_provider = v_sub_last
				where sub_set = p_set_id
					and sub_receiver = v_sub_node;

		v_sub_last = v_sub_node;
		v_sub_node = v_sub_next;
	end loop;

	-- ----
	-- This includes creating a subscription for the old origin
	-- ----
	insert into @NAMESPACE@.sl_subscribe
			(sub_set, sub_provider, sub_receiver,
			sub_forward, sub_active)
			values (p_set_id, v_sub_last, p_old_origin, true, true);
	if v_local_node_id = p_old_origin then
		select coalesce(max(ev_seqno), 0) into v_last_sync 
				from @NAMESPACE@.sl_event
				where ev_origin = p_new_origin
					and ev_type = 'SYNC';
		if v_last_sync > 0 then
			insert into @NAMESPACE@.sl_setsync
					(ssy_setid, ssy_origin, ssy_seqno,
					ssy_snapshot, ssy_action_list)
					select p_set_id, p_new_origin, v_last_sync,
					ev_snapshot, NULL
					from @NAMESPACE@.sl_event
					where ev_origin = p_new_origin
						and ev_seqno = v_last_sync;
		else
			insert into @NAMESPACE@.sl_setsync
					(ssy_setid, ssy_origin, ssy_seqno,
					ssy_snapshot, ssy_action_list)
					values (p_set_id, p_new_origin, '0',
					'1:1:', NULL);
		end if;
	end if;

	-- ----
	-- Now change the ownership of the set.
	-- ----
	update @NAMESPACE@.sl_set
			set set_origin = p_new_origin
			where set_id = p_set_id;

	-- ----
	-- On the new origin, delete the obsolete setsync information
	-- and the subscription.
	-- ----
	if v_local_node_id = p_new_origin then
		delete from @NAMESPACE@.sl_setsync
				where ssy_setid = p_set_id;
	else
		if v_local_node_id <> p_old_origin then
			--
			-- On every other node, change the setsync so that it will
			-- pick up from the new origins last known sync.
			--
			delete from @NAMESPACE@.sl_setsync
					where ssy_setid = p_set_id;
			select coalesce(max(ev_seqno), 0) into v_last_sync
					from @NAMESPACE@.sl_event
					where ev_origin = p_new_origin
						and ev_type = 'SYNC';
			if v_last_sync > 0 then
				insert into @NAMESPACE@.sl_setsync
						(ssy_setid, ssy_origin, ssy_seqno,
						ssy_snapshot, ssy_action_list)
						select p_set_id, p_new_origin, v_last_sync,
						ev_snapshot, NULL
						from @NAMESPACE@.sl_event
						where ev_origin = p_new_origin
							and ev_seqno = v_last_sync;
			else
				insert into @NAMESPACE@.sl_setsync
						(ssy_setid, ssy_origin, ssy_seqno,
						ssy_snapshot, ssy_action_list)
						values (p_set_id, p_new_origin,
						'0', '1:1:', NULL);
			end if;
		end if;
	end if;
	delete from @NAMESPACE@.sl_subscribe
			where sub_set = p_set_id
			and sub_receiver = p_new_origin;

	-- Regenerate sl_listen since we revised the subscriptions
	perform @NAMESPACE@.RebuildListenEntries();

	-- Run addPartialLogIndices() to try to add indices to unused sl_log_? table
	perform @NAMESPACE@.addPartialLogIndices();

	-- ----
	-- If we are the new or old origin, we have to
	-- adjust the log and deny access trigger configuration.
	-- ----
	if v_local_node_id = p_old_origin or v_local_node_id = p_new_origin then
		for v_tab_row in select tab_id from @NAMESPACE@.sl_table
				where tab_set = p_set_id
				order by tab_id
		loop
			perform @NAMESPACE@.alterTableConfigureTriggers(v_tab_row.tab_id);
		end loop;
	end if;

	return p_set_id;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.moveSet_int(int4, int4, int4, int8) is 
'moveSet(set_id, old_origin, new_origin, wait_seqno)

Process MOVE_SET event to request that the origin for set set_id be
moved from old_origin to node new_origin';

-- ----------------------------------------------------------------------
-- FUNCTION dropSet (set_id)
--
--	Generate the DROP_SET event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.dropSet (int4)
returns bigint
as $$
declare
	p_set_id			alias for $1;
	v_origin			int4;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;
	
	-- ----
	-- Check that the set exists and originates here
	-- ----
	select set_origin into v_origin from @NAMESPACE@.sl_set
			where set_id = p_set_id;
	if not found then
		raise exception 'Slony-I: set % not found', p_set_id;
	end if;
	if v_origin != @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
		raise exception 'Slony-I: set % does not originate on local node',
				p_set_id;
	end if;

	-- ----
	-- Call the internal drop set functionality and generate the event
	-- ----
	perform @NAMESPACE@.dropSet_int(p_set_id);
	return  @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'DROP_SET', 
			p_set_id::text);
end;
$$ language plpgsql;
comment on function @NAMESPACE@.dropSet(int4) is 
'Generate DROP_SET event to drop replication of set set_id';

-- ----------------------------------------------------------------------
-- FUNCTION dropSet_int (set_id)
--
--	Process the DROP_SET event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.dropSet_int (int4)
returns int4
as $$
declare
	p_set_id			alias for $1;
	v_tab_row			record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;
	
	-- ----
	-- Restore all tables original triggers and rules and remove
	-- our replication stuff.
	-- ----
	for v_tab_row in select tab_id from @NAMESPACE@.sl_table
			where tab_set = p_set_id
			order by tab_id
	loop
		perform @NAMESPACE@.alterTableDropTriggers(v_tab_row.tab_id);
	end loop;

	-- ----
	-- Remove all traces of the set configuration
	-- ----
	delete from @NAMESPACE@.sl_sequence
			where seq_set = p_set_id;
	delete from @NAMESPACE@.sl_table
			where tab_set = p_set_id;
	delete from @NAMESPACE@.sl_subscribe
			where sub_set = p_set_id;
	delete from @NAMESPACE@.sl_setsync
			where ssy_setid = p_set_id;
	delete from @NAMESPACE@.sl_set
			where set_id = p_set_id;

	-- Regenerate sl_listen since we revised the subscriptions
	perform @NAMESPACE@.RebuildListenEntries();

	-- Run addPartialLogIndices() to try to add indices to unused sl_log_? table
	perform @NAMESPACE@.addPartialLogIndices();

	return p_set_id;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.dropSet(int4) is 
'Process DROP_SET event to drop replication of set set_id.  This involves:
- Removing log and deny access triggers
- Removing all traces of the set configuration, including sequences, tables, subscribers, syncs, and the set itself';

-- ----------------------------------------------------------------------
-- FUNCTION mergeSet (set_id, add_id)
--
--	Generate the MERGE_SET event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.mergeSet (int4, int4)
returns bigint
as $$
declare
	p_set_id			alias for $1;
	p_add_id			alias for $2;
	v_origin			int4;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;
	
	-- ----
	-- Check that both sets exist and originate here
	-- ----
	if p_set_id = p_add_id then
		raise exception 'Slony-I: merged set ids cannot be identical';
	end if;
	select set_origin into v_origin from @NAMESPACE@.sl_set
			where set_id = p_set_id;
	if not found then
		raise exception 'Slony-I: set % not found', p_set_id;
	end if;
	if v_origin != @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
		raise exception 'Slony-I: set % does not originate on local node',
				p_set_id;
	end if;

	select set_origin into v_origin from @NAMESPACE@.sl_set
			where set_id = p_add_id;
	if not found then
		raise exception 'Slony-I: set % not found', p_add_id;
	end if;
	if v_origin != @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
		raise exception 'Slony-I: set % does not originate on local node',
				p_add_id;
	end if;

	-- ----
	-- Check that both sets are subscribed by the same set of nodes
	-- ----
	if exists (select true from @NAMESPACE@.sl_subscribe SUB1
				where SUB1.sub_set = p_set_id
				and SUB1.sub_receiver not in (select SUB2.sub_receiver
						from @NAMESPACE@.sl_subscribe SUB2
						where SUB2.sub_set = p_add_id))
	then
		raise exception 'Slony-I: subscriber lists of set % and % are different',
				p_set_id, p_add_id;
	end if;

	if exists (select true from @NAMESPACE@.sl_subscribe SUB1
				where SUB1.sub_set = p_add_id
				and SUB1.sub_receiver not in (select SUB2.sub_receiver
						from @NAMESPACE@.sl_subscribe SUB2
						where SUB2.sub_set = p_set_id))
	then
		raise exception 'Slony-I: subscriber lists of set % and % are different',
				p_add_id, p_set_id;
	end if;

	-- ----
	-- Check that all ENABLE_SUBSCRIPTION events for the set are confirmed
	-- ----
	if exists (select true from @NAMESPACE@.sl_event
			where ev_type = 'ENABLE_SUBSCRIPTION'
			and ev_data1 = p_add_id::text
			and ev_seqno > (select max(con_seqno) from @NAMESPACE@.sl_confirm
					where con_origin = ev_origin
					and con_received::text = ev_data3))
	then
		raise exception 'Slony-I: set % has subscriptions in progress - cannot merge',
				p_add_id;
	end if;

	-- ----
	-- Create a SYNC event, merge the sets, create a MERGE_SET event
	-- ----
	perform @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'SYNC', NULL);
	perform @NAMESPACE@.mergeSet_int(p_set_id, p_add_id);
	return  @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'MERGE_SET', 
			p_set_id::text, p_add_id::text);
end;
$$ language plpgsql;
comment on function @NAMESPACE@.mergeSet(int4, int4) is 
'Generate MERGE_SET event to request that sets be merged together.

Both sets must exist, and originate on the same node.  They must be
subscribed by the same set of nodes.';

-- ----------------------------------------------------------------------
-- FUNCTION mergeSet_int (set_id, add_id)
--
--	Process the MERGE_SET event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.mergeSet_int (int4, int4)
returns int4
as $$
declare
	p_set_id			alias for $1;
	p_add_id			alias for $2;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;
	
	update @NAMESPACE@.sl_sequence
			set seq_set = p_set_id
			where seq_set = p_add_id;
	update @NAMESPACE@.sl_table
			set tab_set = p_set_id
			where tab_set = p_add_id;
	delete from @NAMESPACE@.sl_subscribe
			where sub_set = p_add_id;
	delete from @NAMESPACE@.sl_setsync
			where ssy_setid = p_add_id;
	delete from @NAMESPACE@.sl_set
			where set_id = p_add_id;

	return p_set_id;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.mergeSet_int(int4,int4) is
'mergeSet_int(set_id, add_id) - Perform MERGE_SET event, merging all objects from 
set add_id into set set_id.';

-- ----------------------------------------------------------------------
-- FUNCTION setAddTable (set_id, tab_id, tab_fqname, tab_idxname,
--					tab_comment)
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.setAddTable(int4, int4, text, name, text)
returns bigint
as $$
declare
	p_set_id			alias for $1;
	p_tab_id			alias for $2;
	p_fqname			alias for $3;
	p_tab_idxname		alias for $4;
	p_tab_comment		alias for $5;
	v_set_origin		int4;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Check that we are the origin of the set
	-- ----
	select set_origin into v_set_origin
			from @NAMESPACE@.sl_set
			where set_id = p_set_id;
	if not found then
		raise exception 'Slony-I: setAddTable(): set % not found', p_set_id;
	end if;
	if v_set_origin != @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
		raise exception 'Slony-I: setAddTable(): set % has remote origin', p_set_id;
	end if;

	if exists (select true from @NAMESPACE@.sl_subscribe
			where sub_set = p_set_id)
	then
		raise exception 'Slony-I: cannot add table to currently subscribed set % - must attach to an unsubscribed set',
				p_set_id;
	end if;

	-- ----
	-- Add the table to the set and generate the SET_ADD_TABLE event
	-- ----
	perform @NAMESPACE@.setAddTable_int(p_set_id, p_tab_id, p_fqname,
			p_tab_idxname, p_tab_comment);
	return  @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'SET_ADD_TABLE',
			p_set_id::text, p_tab_id::text, p_fqname::text,
			p_tab_idxname::text, p_tab_comment::text);
end;
$$ language plpgsql;
comment on function @NAMESPACE@.setAddTable(int4, int4, text, name, text) is
'setAddTable (set_id, tab_id, tab_fqname, tab_idxname, tab_comment)

Add table tab_fqname to replication set on origin node, and generate
SET_ADD_TABLE event to allow this to propagate to other nodes.

Note that the table id, tab_id, must be unique ACROSS ALL SETS.';

-- ----------------------------------------------------------------------
-- FUNCTION setAddTable_int (set_id, tab_id, tab_fqname, tab_idxname,
--						tab_comment)
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.setAddTable_int(int4, int4, text, name, text)
returns int4
as $$
declare

	p_set_id		alias for $1;
	p_tab_id		alias for $2;
	p_fqname		alias for $3;
	p_tab_idxname		alias for $4;
	p_tab_comment		alias for $5;
	v_tab_relname		name;
	v_tab_nspname		name;
	v_local_node_id		int4;
	v_set_origin		int4;
	v_sub_provider		int4;
	v_relkind		char;
	v_tab_reloid		oid;
	v_pkcand_nn		boolean;
	v_prec			record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- For sets with a remote origin, check that we are subscribed 
	-- to that set. Otherwise we ignore the table because it might 
	-- not even exist in our database.
	-- ----
	v_local_node_id := @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');
	select set_origin into v_set_origin
			from @NAMESPACE@.sl_set
			where set_id = p_set_id;
	if not found then
		raise exception 'Slony-I: setAddTable_int(): set % not found',
				p_set_id;
	end if;
	if v_set_origin != v_local_node_id then
		select sub_provider into v_sub_provider
				from @NAMESPACE@.sl_subscribe
				where sub_set = p_set_id
				and sub_receiver = @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');
		if not found then
			return 0;
		end if;
	end if;
	
	-- ----
	-- Get the tables OID and check that it is a real table
	-- ----
	select PGC.oid, PGC.relkind, PGC.relname, PGN.nspname into v_tab_reloid, v_relkind, v_tab_relname, v_tab_nspname
			from "pg_catalog".pg_class PGC, "pg_catalog".pg_namespace PGN
			where PGC.relnamespace = PGN.oid
			and @NAMESPACE@.slon_quote_input(p_fqname) = @NAMESPACE@.slon_quote_brute(PGN.nspname) ||
					'.' || @NAMESPACE@.slon_quote_brute(PGC.relname);
	if not found then
		raise exception 'Slony-I: setAddTable_int(): table % not found', 
				p_fqname;
	end if;
	if v_relkind != 'r' then
		raise exception 'Slony-I: setAddTable_int(): % is not a regular table',
				p_fqname;
	end if;

	if not exists (select indexrelid
			from "pg_catalog".pg_index PGX, "pg_catalog".pg_class PGC
			where PGX.indrelid = v_tab_reloid
				and PGX.indexrelid = PGC.oid
				and PGC.relname = p_tab_idxname)
	then
		raise exception 'Slony-I: setAddTable_int(): table % has no index %',
				p_fqname, p_tab_idxname;
	end if;

	-- ----
	-- Verify that the columns in the PK (or candidate) are not NULLABLE
	-- ----

	v_pkcand_nn := 'f';
	for v_prec in select attname from "pg_catalog".pg_attribute where attrelid = 
                        (select oid from "pg_catalog".pg_class where oid = v_tab_reloid) 
                    and attname in (select attname from "pg_catalog".pg_attribute where 
                                    attrelid = (select oid from "pg_catalog".pg_class PGC, 
                                    "pg_catalog".pg_index PGX where 
                                    PGC.relname = p_tab_idxname and PGX.indexrelid=PGC.oid and
                                    PGX.indrelid = v_tab_reloid)) and attnotnull <> 't'
	loop
		raise notice 'Slony-I: setAddTable_int: table % PK column % nullable', p_fqname, v_prec.attname;
		v_pkcand_nn := 't';
	end loop;
	if v_pkcand_nn then
		raise exception 'Slony-I: setAddTable_int: table % not replicable!', p_fqname;
	end if;

	select * into v_prec from @NAMESPACE@.sl_table where tab_id = p_tab_id;
	if not found then
		v_pkcand_nn := 't';  -- No-op -- All is well
	else
		raise exception 'Slony-I: setAddTable_int: table id % has already been assigned!', p_tab_id;
	end if;

	-- ----
	-- Add the table to sl_table and create the trigger on it.
	-- ----
	insert into @NAMESPACE@.sl_table
			(tab_id, tab_reloid, tab_relname, tab_nspname, 
			tab_set, tab_idxname, tab_altered, tab_comment) 
			values
			(p_tab_id, v_tab_reloid, v_tab_relname, v_tab_nspname,
			p_set_id, p_tab_idxname, false, p_tab_comment);
	perform @NAMESPACE@.alterTableAddTriggers(p_tab_id);

	return p_tab_id;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.setAddTable_int(int4, int4, text, name, text) is
'setAddTable_int (set_id, tab_id, tab_fqname, tab_idxname, tab_comment)

This function processes the SET_ADD_TABLE event on remote nodes,
adding a table to replication if the remote node is subscribing to its
replication set.';

-- ----------------------------------------------------------------------
-- FUNCTION setDropTable (tab_id)
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.setDropTable(int4)
returns bigint
as $$
declare
	p_tab_id		alias for $1;
	v_set_id		int4;
	v_set_origin		int4;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

        -- ----
	-- Determine the set_id
        -- ----
	select tab_set into v_set_id from @NAMESPACE@.sl_table where tab_id = p_tab_id;

	-- ----
	-- Ensure table exists
	-- ----
	if not found then
		raise exception 'Slony-I: setDropTable_int(): table % not found',
			p_tab_id;
	end if;

	-- ----
	-- Check that we are the origin of the set
	-- ----
	select set_origin into v_set_origin
			from @NAMESPACE@.sl_set
			where set_id = v_set_id;
	if not found then
		raise exception 'Slony-I: setDropTable(): set % not found', v_set_id;
	end if;
	if v_set_origin != @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
		raise exception 'Slony-I: setDropTable(): set % has remote origin', v_set_id;
	end if;

	-- ----
	-- Drop the table from the set and generate the SET_ADD_TABLE event
	-- ----
	perform @NAMESPACE@.setDropTable_int(p_tab_id);
	return  @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'SET_DROP_TABLE', 
				p_tab_id::text);
end;
$$ language plpgsql;
comment on function @NAMESPACE@.setDropTable(int4) is
'setDropTable (tab_id)

Drop table tab_id from set on origin node, and generate SET_DROP_TABLE
event to allow this to propagate to other nodes.';

-- ----------------------------------------------------------------------
-- FUNCTION setDropTable_int (tab_id)
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.setDropTable_int(int4)
returns int4
as $$
declare
	p_tab_id		alias for $1;
	v_set_id		int4;
	v_local_node_id		int4;
	v_set_origin		int4;
	v_sub_provider		int4;
	v_tab_reloid		oid;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

        -- ----
	-- Determine the set_id
        -- ----
	select tab_set into v_set_id from @NAMESPACE@.sl_table where tab_id = p_tab_id;

	-- ----
	-- Ensure table exists
	-- ----
	if not found then
		return 0;
	end if;

	-- ----
	-- For sets with a remote origin, check that we are subscribed 
	-- to that set. Otherwise we ignore the table because it might 
	-- not even exist in our database.
	-- ----
	v_local_node_id := @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');
	select set_origin into v_set_origin
			from @NAMESPACE@.sl_set
			where set_id = v_set_id;
	if not found then
		raise exception 'Slony-I: setDropTable_int(): set % not found',
				v_set_id;
	end if;
	if v_set_origin != v_local_node_id then
		select sub_provider into v_sub_provider
				from @NAMESPACE@.sl_subscribe
				where sub_set = v_set_id
				and sub_receiver = @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');
		if not found then
			return 0;
		end if;
	end if;
	
	-- ----
	-- Drop the table from sl_table and drop trigger from it.
	-- ----
	perform @NAMESPACE@.alterTableDropTriggers(p_tab_id);
	delete from @NAMESPACE@.sl_table where tab_id = p_tab_id;
	return p_tab_id;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.setDropTable_int(int4) is
'setDropTable_int (tab_id)

This function processes the SET_DROP_TABLE event on remote nodes,
dropping a table from replication if the remote node is subscribing to
its replication set.';

-- ----------------------------------------------------------------------
-- FUNCTION setAddSequence (set_id, seq_id, seq_fqname, seq_comment)
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.setAddSequence (int4, int4, text, text)
returns bigint
as $$
declare
	p_set_id			alias for $1;
	p_seq_id			alias for $2;
	p_fqname			alias for $3;
	p_seq_comment		alias for $4;
	v_set_origin		int4;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Check that we are the origin of the set
	-- ----
	select set_origin into v_set_origin
			from @NAMESPACE@.sl_set
			where set_id = p_set_id;
	if not found then
		raise exception 'Slony-I: setAddSequence(): set % not found', p_set_id;
	end if;
	if v_set_origin != @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
		raise exception 'Slony-I: setAddSequence(): set % has remote origin - submit to origin node', p_set_id;
	end if;

	if exists (select true from @NAMESPACE@.sl_subscribe
			where sub_set = p_set_id)
	then
		raise exception 'Slony-I: cannot add sequence to currently subscribed set %',
				p_set_id;
	end if;

	-- ----
	-- Add the sequence to the set and generate the SET_ADD_SEQUENCE event
	-- ----
	perform @NAMESPACE@.setAddSequence_int(p_set_id, p_seq_id, p_fqname,
			p_seq_comment);
	return  @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'SET_ADD_SEQUENCE',
						p_set_id::text, p_seq_id::text, 
						p_fqname::text, p_seq_comment::text);
end;
$$ language plpgsql;
comment on function @NAMESPACE@.setAddSequence (int4, int4, text, text) is
'setAddSequence (set_id, seq_id, seq_fqname, seq_comment)

On the origin node for set set_id, add sequence seq_fqname to the
replication set, and raise SET_ADD_SEQUENCE to cause this to replicate
to subscriber nodes.';

-- ----------------------------------------------------------------------
-- FUNCTION setAddSequence_int (set_id, seq_id, seq_fqname, seq_comment
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.setAddSequence_int(int4, int4, text, text)
returns int4
as $$
declare
	p_set_id			alias for $1;
	p_seq_id			alias for $2;
	p_fqname			alias for $3;
	p_seq_comment		alias for $4;
	v_local_node_id		int4;
	v_set_origin		int4;
	v_sub_provider		int4;
	v_relkind			char;
	v_seq_reloid		oid;
	v_seq_relname		name;
	v_seq_nspname		name;
	v_sync_row			record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- For sets with a remote origin, check that we are subscribed 
	-- to that set. Otherwise we ignore the sequence because it might 
	-- not even exist in our database.
	-- ----
	v_local_node_id := @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');
	select set_origin into v_set_origin
			from @NAMESPACE@.sl_set
			where set_id = p_set_id;
	if not found then
		raise exception 'Slony-I: setAddSequence_int(): set % not found',
				p_set_id;
	end if;
	if v_set_origin != v_local_node_id then
		select sub_provider into v_sub_provider
				from @NAMESPACE@.sl_subscribe
				where sub_set = p_set_id
				and sub_receiver = @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');
		if not found then
			return 0;
		end if;
	end if;
	
	-- ----
	-- Get the sequences OID and check that it is a sequence
	-- ----
	select PGC.oid, PGC.relkind, PGC.relname, PGN.nspname 
		into v_seq_reloid, v_relkind, v_seq_relname, v_seq_nspname
			from "pg_catalog".pg_class PGC, "pg_catalog".pg_namespace PGN
			where PGC.relnamespace = PGN.oid
			and @NAMESPACE@.slon_quote_input(p_fqname) = @NAMESPACE@.slon_quote_brute(PGN.nspname) ||
					'.' || @NAMESPACE@.slon_quote_brute(PGC.relname);
	if not found then
		raise exception 'Slony-I: setAddSequence_int(): sequence % not found', 
				p_fqname;
	end if;
	if v_relkind != 'S' then
		raise exception 'Slony-I: setAddSequence_int(): % is not a sequence',
				p_fqname;
	end if;

        select 1 into v_sync_row from @NAMESPACE@.sl_sequence where seq_id = p_seq_id;
	if not found then
               v_relkind := 'o';   -- all is OK
        else
                raise exception 'Slony-I: setAddSequence_int(): sequence ID % has already been assigned', p_seq_id;
        end if;

	-- ----
	-- Add the sequence to sl_sequence
	-- ----
	insert into @NAMESPACE@.sl_sequence
		(seq_id, seq_reloid, seq_relname, seq_nspname, seq_set, seq_comment) 
		values
		(p_seq_id, v_seq_reloid, v_seq_relname, v_seq_nspname,  p_set_id, p_seq_comment);

	-- ----
	-- On the set origin, fake a sl_seqlog row for the last sync event
	-- ----
	if v_set_origin = v_local_node_id then
		for v_sync_row in select coalesce (max(ev_seqno), 0) as ev_seqno
				from @NAMESPACE@.sl_event
				where ev_origin = v_local_node_id
					and ev_type = 'SYNC'
		loop
			insert into @NAMESPACE@.sl_seqlog
					(seql_seqid, seql_origin, seql_ev_seqno, 
					seql_last_value) values
					(p_seq_id, v_local_node_id, v_sync_row.ev_seqno,
					@NAMESPACE@.sequenceLastValue(p_fqname));
		end loop;
	end if;

	return p_seq_id;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.setAddSequence_int(int4, int4, text, text) is
'setAddSequence_int (set_id, seq_id, seq_fqname, seq_comment)

This processes the SET_ADD_SEQUENCE event.  On remote nodes that
subscribe to set_id, add the sequence to the replication set.';

-- ----------------------------------------------------------------------
-- FUNCTION setDropSequence (seq_id)
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.setDropSequence (int4)
returns bigint
as $$
declare
	p_seq_id		alias for $1;
	v_set_id		int4;
	v_set_origin		int4;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Determine set id for this sequence
	-- ----
	select seq_set into v_set_id from @NAMESPACE@.sl_sequence where seq_id = p_seq_id;

	-- ----
	-- Ensure sequence exists
	-- ----
	if not found then
		raise exception 'Slony-I: setDropSequence_int(): sequence % not found',
			p_seq_id;
	end if;

	-- ----
	-- Check that we are the origin of the set
	-- ----
	select set_origin into v_set_origin
			from @NAMESPACE@.sl_set
			where set_id = v_set_id;
	if not found then
		raise exception 'Slony-I: setDropSequence(): set % not found', v_set_id;
	end if;
	if v_set_origin != @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
		raise exception 'Slony-I: setDropSequence(): set % has origin at another node - submit this to that node', v_set_id;
	end if;

	-- ----
	-- Add the sequence to the set and generate the SET_ADD_SEQUENCE event
	-- ----
	perform @NAMESPACE@.setDropSequence_int(p_seq_id);
	return  @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'SET_DROP_SEQUENCE',
					p_seq_id::text);
end;
$$ language plpgsql;
comment on function @NAMESPACE@.setDropSequence (int4) is
'setDropSequence (seq_id)

On the origin node for the set, drop sequence seq_id from replication
set, and raise SET_DROP_SEQUENCE to cause this to replicate to
subscriber nodes.';

-- ----------------------------------------------------------------------
-- FUNCTION setDropSequence_int (seq_id)
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.setDropSequence_int(int4)
returns int4
as $$
declare
	p_seq_id		alias for $1;
	v_set_id		int4;
	v_local_node_id		int4;
	v_set_origin		int4;
	v_sub_provider		int4;
	v_relkind			char;
	v_sync_row			record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Determine set id for this sequence
	-- ----
	select seq_set into v_set_id from @NAMESPACE@.sl_sequence where seq_id = p_seq_id;

	-- ----
	-- Ensure sequence exists
	-- ----
	if not found then
		return 0;
	end if;

	-- ----
	-- For sets with a remote origin, check that we are subscribed 
	-- to that set. Otherwise we ignore the sequence because it might 
	-- not even exist in our database.
	-- ----
	v_local_node_id := @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');
	select set_origin into v_set_origin
			from @NAMESPACE@.sl_set
			where set_id = v_set_id;
	if not found then
		raise exception 'Slony-I: setDropSequence_int(): set % not found',
				v_set_id;
	end if;
	if v_set_origin != v_local_node_id then
		select sub_provider into v_sub_provider
				from @NAMESPACE@.sl_subscribe
				where sub_set = v_set_id
				and sub_receiver = @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');
		if not found then
			return 0;
		end if;
	end if;

	-- ----
	-- drop the sequence from sl_sequence, sl_seqlog
	-- ----
	delete from @NAMESPACE@.sl_seqlog where seql_seqid = p_seq_id;
	delete from @NAMESPACE@.sl_sequence where seq_id = p_seq_id;

	return p_seq_id;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.setDropSequence_int(int4) is
'setDropSequence_int (seq_id)

This processes the SET_DROP_SEQUENCE event.  On remote nodes that
subscribe to the set containing sequence seq_id, drop the sequence
from the replication set.';


-- ----------------------------------------------------------------------
-- FUNCTION setMoveTable (tab_id, new_set_id)
--
--	Generate the SET_MOVE_TABLE event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.setMoveTable (int4, int4)
returns bigint
as $$
declare
	p_tab_id			alias for $1;
	p_new_set_id		alias for $2;
	v_old_set_id		int4;
	v_origin			int4;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Get the tables current set
	-- ----
	select tab_set into v_old_set_id from @NAMESPACE@.sl_table
			where tab_id = p_tab_id;
	if not found then
		raise exception 'Slony-I: table %d not found', p_tab_id;
	end if;
	
	-- ----
	-- Check that both sets exist and originate here
	-- ----
	if p_new_set_id = v_old_set_id then
		raise exception 'Slony-I: set ids cannot be identical';
	end if;
	select set_origin into v_origin from @NAMESPACE@.sl_set
			where set_id = p_new_set_id;
	if not found then
		raise exception 'Slony-I: set % not found', p_new_set_id;
	end if;
	if v_origin != @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
		raise exception 'Slony-I: set % does not originate on local node',
				p_new_set_id;
	end if;

	select set_origin into v_origin from @NAMESPACE@.sl_set
			where set_id = v_old_set_id;
	if not found then
		raise exception 'Slony-I: set % not found', v_old_set_id;
	end if;
	if v_origin != @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
		raise exception 'Slony-I: set % does not originate on local node',
				v_old_set_id;
	end if;

	-- ----
	-- Check that both sets are subscribed by the same set of nodes
	-- ----
	if exists (select true from @NAMESPACE@.sl_subscribe SUB1
				where SUB1.sub_set = p_new_set_id
				and SUB1.sub_receiver not in (select SUB2.sub_receiver
						from @NAMESPACE@.sl_subscribe SUB2
						where SUB2.sub_set = v_old_set_id))
	then
		raise exception 'Slony-I: subscriber lists of set % and % are different',
				p_new_set_id, v_old_set_id;
	end if;

	if exists (select true from @NAMESPACE@.sl_subscribe SUB1
				where SUB1.sub_set = v_old_set_id
				and SUB1.sub_receiver not in (select SUB2.sub_receiver
						from @NAMESPACE@.sl_subscribe SUB2
						where SUB2.sub_set = p_new_set_id))
	then
		raise exception 'Slony-I: subscriber lists of set % and % are different',
				v_old_set_id, p_new_set_id;
	end if;

	-- ----
	-- Change the set the table belongs to
	-- ----
	perform @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'SYNC', NULL);
	perform @NAMESPACE@.setMoveTable_int(p_tab_id, p_new_set_id);
	return  @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'SET_MOVE_TABLE', 
			p_tab_id::text, p_new_set_id::text);
end;
$$ language plpgsql;

comment on function @NAMESPACE@.setMoveTable(int4,int4) is
'This generates the SET_MOVE_TABLE event.  If the set that the table is
in is identically subscribed to the set that the table is to be moved 
into, then the SET_MOVE_TABLE event is raised.';


-- ----------------------------------------------------------------------
-- FUNCTION setMoveTable_int (tab_id, new_set_id)
--
--	Process the SET_MOVE_TABLE event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.setMoveTable_int (int4, int4)
returns int4
as $$
declare
	p_tab_id			alias for $1;
	p_new_set_id		alias for $2;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;
	
	-- ----
	-- Move the table to the new set
	-- ----
	update @NAMESPACE@.sl_table
			set tab_set = p_new_set_id
			where tab_id = p_tab_id;

	return p_tab_id;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.setMoveTable(int4,int4) is
'This processes the SET_MOVE_TABLE event.  The table is moved 
to the destination set.';

-- ----------------------------------------------------------------------
-- FUNCTION setMoveSequence (seq_id, new_set_id)
--
--	Generate the SET_MOVE_SEQUENCE event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.setMoveSequence (int4, int4)
returns bigint
as $$
declare
	p_seq_id			alias for $1;
	p_new_set_id		alias for $2;
	v_old_set_id		int4;
	v_origin			int4;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Get the sequences current set
	-- ----
	select seq_set into v_old_set_id from @NAMESPACE@.sl_sequence
			where seq_id = p_seq_id;
	if not found then
		raise exception 'Slony-I: setMoveSequence(): sequence %d not found', p_seq_id;
	end if;
	
	-- ----
	-- Check that both sets exist and originate here
	-- ----
	if p_new_set_id = v_old_set_id then
		raise exception 'Slony-I: setMoveSequence(): set ids cannot be identical';
	end if;
	select set_origin into v_origin from @NAMESPACE@.sl_set
			where set_id = p_new_set_id;
	if not found then
		raise exception 'Slony-I: setMoveSequence(): set % not found', p_new_set_id;
	end if;
	if v_origin != @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
		raise exception 'Slony-I: setMoveSequence(): set % does not originate on local node',
				p_new_set_id;
	end if;

	select set_origin into v_origin from @NAMESPACE@.sl_set
			where set_id = v_old_set_id;
	if not found then
		raise exception 'Slony-I: set % not found', v_old_set_id;
	end if;
	if v_origin != @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
		raise exception 'Slony-I: set % does not originate on local node',
				v_old_set_id;
	end if;

	-- ----
	-- Check that both sets are subscribed by the same set of nodes
	-- ----
	if exists (select true from @NAMESPACE@.sl_subscribe SUB1
				where SUB1.sub_set = p_new_set_id
				and SUB1.sub_receiver not in (select SUB2.sub_receiver
						from @NAMESPACE@.sl_subscribe SUB2
						where SUB2.sub_set = v_old_set_id))
	then
		raise exception 'Slony-I: subscriber lists of set % and % are different',
				p_new_set_id, v_old_set_id;
	end if;

	if exists (select true from @NAMESPACE@.sl_subscribe SUB1
				where SUB1.sub_set = v_old_set_id
				and SUB1.sub_receiver not in (select SUB2.sub_receiver
						from @NAMESPACE@.sl_subscribe SUB2
						where SUB2.sub_set = p_new_set_id))
	then
		raise exception 'Slony-I: subscriber lists of set % and % are different',
				v_old_set_id, p_new_set_id;
	end if;

	-- ----
	-- Change the set the sequence belongs to
	-- ----
	perform @NAMESPACE@.setMoveSequence_int(p_seq_id, p_new_set_id);
	return  @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'SET_MOVE_SEQUENCE', 
			p_seq_id::text, p_new_set_id::text);
end;
$$ language plpgsql;

comment on function @NAMESPACE@.setMoveSequence (int4, int4) is
'setMoveSequence(p_seq_id, p_new_set_id) - This generates the
SET_MOVE_SEQUENCE event, after validation, notably that both sets
exist, are distinct, and have exactly the same subscription lists';


-- ----------------------------------------------------------------------
-- FUNCTION setMoveSequence_int (seq_id, new_set_id)
--
--	Process the SET_MOVE_SEQUENCE event.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.setMoveSequence_int (int4, int4)
returns int4
as $$
declare
	p_seq_id			alias for $1;
	p_new_set_id		alias for $2;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;
	
	-- ----
	-- Move the sequence to the new set
	-- ----
	update @NAMESPACE@.sl_sequence
			set seq_set = p_new_set_id
			where seq_id = p_seq_id;

	return p_seq_id;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.setMoveSequence_int (int4, int4) is
'setMoveSequence_int(p_seq_id, p_new_set_id) - processes the
SET_MOVE_SEQUENCE event, moving a sequence to another replication
set.';

-- ----------------------------------------------------------------------
-- FUNCTION sequenceSetValue (seq_id, seq_origin, ev_seqno, last_value)
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.sequenceSetValue(int4, int4, int8, int8) returns int4
as $$
declare
	p_seq_id			alias for $1;
	p_seq_origin		alias for $2;
	p_ev_seqno			alias for $3;
	p_last_value		alias for $4;
	v_fqname			text;
begin
	-- ----
	-- Get the sequences fully qualified name
	-- ----
	select @NAMESPACE@.slon_quote_brute(PGN.nspname) || '.' ||
			@NAMESPACE@.slon_quote_brute(PGC.relname) into v_fqname
		from @NAMESPACE@.sl_sequence SQ,
			"pg_catalog".pg_class PGC, "pg_catalog".pg_namespace PGN
		where SQ.seq_id = p_seq_id
			and SQ.seq_reloid = PGC.oid
			and PGC.relnamespace = PGN.oid;
	if not found then
		raise exception 'Slony-I: sequenceSetValue(): sequence % not found', p_seq_id;
	end if;

	-- ----
	-- Update it to the new value
	-- ----
	execute 'select setval(''' || v_fqname ||
			''', ' || p_last_value::text || ')';

	insert into @NAMESPACE@.sl_seqlog
			(seql_seqid, seql_origin, seql_ev_seqno, seql_last_value)
			values (p_seq_id, p_seq_origin, p_ev_seqno, p_last_value);

	return p_seq_id;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.sequenceSetValue(int4, int4, int8, int8) is
'sequenceSetValue (seq_id, seq_origin, ev_seqno, last_value)
Set sequence seq_id to have new value last_value.
';

-- ----------------------------------------------------------------------
-- FUNCTION ddlScript_prepare (set_id, only_on_node)
--
--	Generate the DDL_SCRIPT event
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.ddlScript_prepare (int4, int4)
returns integer
as $$
declare
	p_set_id			alias for $1;
	p_only_on_node		alias for $2;
	v_set_origin		int4;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Check that the set exists and originates here
	-- ----
	select set_origin into v_set_origin
			from @NAMESPACE@.sl_set
			where set_id = p_set_id
			for update;
	if not found then
		raise exception 'Slony-I: set % not found', p_set_id;
	end if;
	if p_only_on_node = -1 then
		if v_set_origin <> @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
			raise exception 'Slony-I: set % does not originate on local node',
				p_set_id;
		end if;
		-- ----
		-- Create a SYNC event
		-- ----
		perform @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'SYNC', NULL);
	else
		-- If running "ONLY ON NODE", there are two possibilities:
		-- 1.  Running on origin, where denyaccess() triggers are already shut off
		-- 2.  Running on replica, where we need the LOCAL role to suppress denyaccess() triggers
		execute 'create temp table _slony1_saved_session_replication_role (
					setting text);';
		execute 'insert into _slony1_saved_session_replication_role
					select setting from pg_catalog.pg_settings
					where name = ''session_replication_role'';';
		if (v_set_origin <> @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@')) then
			execute 'set session_replication_role to local;';
		end if;
	end if;
	return 1;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.ddlScript_prepare (int4, int4) is 
'Prepare for DDL script execution on origin';

-- 	perform @NAMESPACE@.ddlScript_int(p_set_id, p_script, p_only_on_node);

-- ----------------------------------------------------------------------
-- FUNCTION ddlScript_complete (set_id, script, only_on_node)
--
--	Generate the DDL_SCRIPT event
-- ----------------------------------------------------------------------
drop function if exists @NAMESPACE@.ddlScript_complete (int4, text, int4);  -- Needed because function signature has changed!

create or replace function @NAMESPACE@.ddlScript_complete (int4, text, int4)
returns bigint
as $$
declare
	p_set_id			alias for $1;
	p_script			alias for $2;
	p_only_on_node		alias for $3;
	v_set_origin		int4;
	v_query				text;
	v_row				record;
begin
	perform @NAMESPACE@.updateRelname(p_set_id, p_only_on_node);
	if p_only_on_node = -1 then
		return  @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'DDL_SCRIPT', 
			p_set_id::text, p_script::text, p_only_on_node::text);
	end if;
	if p_only_on_node <> -1 then
		for v_row in execute
			'select setting from _slony1_saved_session_replication_role' loop
			v_query := 'set session_replication_role to ' || v_row.setting;
		end loop;
		execute v_query;
		execute 'drop table _slony1_saved_session_replication_role';
	end if;
	return NULL;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.ddlScript_complete(int4, text, int4) is
'ddlScript_complete(set_id, script, only_on_node)

After script has run on origin, this fixes up relnames, restores
triggers, and generates a DDL_SCRIPT event to request it to be run on
replicated slaves.';

-- ----------------------------------------------------------------------
-- FUNCTION ddlScript_prepare_int (set_id, only_on_node)
--
--	Prepare for the DDL_SCRIPT event
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.ddlScript_prepare_int (int4, int4)
returns int4
as $$
declare
	p_set_id			alias for $1;
	p_only_on_node		alias for $2;
	v_set_origin		int4;
	v_no_id				int4;
	v_row				record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Check that we either are the set origin or a current
	-- subscriber of the set.
	-- ----
	v_no_id := @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');
	select set_origin into v_set_origin
			from @NAMESPACE@.sl_set
			where set_id = p_set_id
			for update;
	if not found then
		raise exception 'Slony-I: set % not found', p_set_id;
	end if;
	if v_set_origin <> v_no_id
			and not exists (select 1 from @NAMESPACE@.sl_subscribe
						where sub_set = p_set_id
						and sub_receiver = v_no_id)
	then
		return 0;
	end if;

	-- ----
	-- If execution on only one node is requested, check that
	-- we are that node.
	-- ----
	if p_only_on_node > 0 and p_only_on_node <> v_no_id then
		return 0;
	end if;

	return p_set_id;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.ddlScript_prepare_int (int4, int4) is
'ddlScript_prepare_int (set_id, only_on_node)

Do preparatory work for a DDL script, restoring 
triggers/rules to original state.';


-- ----------------------------------------------------------------------
-- FUNCTION ddlScript_complete_int (set_id, only_on_node)
--
--	Complete the DDL_SCRIPT event
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.ddlScript_complete_int (int4, int4)
returns int4
as $$
declare
	p_set_id			alias for $1;
	p_only_on_node		alias for $2;
	v_row				record;
begin
	return p_set_id;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.ddlScript_complete_int(int4, int4) is
'ddlScript_complete_int(set_id, script, only_on_node)

Complete processing the DDL_SCRIPT event.  This puts tables back into
replicated mode.';

-- ----------------------------------------------------------------------
-- FUNCTION alterTableAddTriggers (tab_id)
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.alterTableAddTriggers (int4)
returns int4
as $$
declare
	p_tab_id			alias for $1;
	v_no_id				int4;
	v_tab_row			record;
	v_tab_fqname		text;
	v_tab_attkind		text;
	v_n					int4;
	v_trec	record;
	v_tgbad	boolean;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Get our local node ID
	-- ----
	v_no_id := @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');

	-- ----
	-- Get the sl_table row and the current origin of the table. 
	-- ----
	select T.tab_reloid, T.tab_set, T.tab_idxname, 
			S.set_origin, PGX.indexrelid,
			@NAMESPACE@.slon_quote_brute(PGN.nspname) || '.' ||
			@NAMESPACE@.slon_quote_brute(PGC.relname) as tab_fqname
			into v_tab_row
			from @NAMESPACE@.sl_table T, @NAMESPACE@.sl_set S,
				"pg_catalog".pg_class PGC, "pg_catalog".pg_namespace PGN,
				"pg_catalog".pg_index PGX, "pg_catalog".pg_class PGXC
			where T.tab_id = p_tab_id
				and T.tab_set = S.set_id
				and T.tab_reloid = PGC.oid
				and PGC.relnamespace = PGN.oid
				and PGX.indrelid = T.tab_reloid
				and PGX.indexrelid = PGXC.oid
				and PGXC.relname = T.tab_idxname
				for update;
	if not found then
		raise exception 'Slony-I: alterTableAddTriggers(): Table with id % not found', p_tab_id;
	end if;
	v_tab_fqname = v_tab_row.tab_fqname;

	v_tab_attkind := @NAMESPACE@.determineAttKindUnique(v_tab_row.tab_fqname, 
						v_tab_row.tab_idxname);

	execute 'lock table ' || v_tab_fqname || ' in access exclusive mode';

	-- ----
	-- Create the log and the deny access triggers
	-- ----
	execute 'create trigger "_@CLUSTERNAME@_logtrigger"' || 
			' after insert or update or delete on ' ||
			v_tab_fqname || ' for each row execute procedure @NAMESPACE@.logTrigger (' ||
                               pg_catalog.quote_literal('_@CLUSTERNAME@') || ',' || 
				pg_catalog.quote_literal(p_tab_id::text) || ',' || 
				pg_catalog.quote_literal(v_tab_attkind) || ');';

	execute 'create trigger "_@CLUSTERNAME@_denyaccess" ' || 
			'before insert or update or delete on ' ||
			v_tab_fqname || ' for each row execute procedure ' ||
			'@NAMESPACE@.denyAccess (' || pg_catalog.quote_literal('_@CLUSTERNAME@') || ');';

	perform @NAMESPACE@.alterTableConfigureTriggers (p_tab_id);
	return p_tab_id;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.alterTableAddTriggers(int4) is
'alterTableAddTriggers(tab_id)

Adds the log and deny access triggers to a replicated table.';

-- ----------------------------------------------------------------------
-- FUNCTION alterTableDropTriggers (tab_id)
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.alterTableDropTriggers (int4)
returns int4
as $$
declare
	p_tab_id			alias for $1;
	v_no_id				int4;
	v_tab_row			record;
	v_tab_fqname		text;
	v_n					int4;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Get our local node ID
	-- ----
	v_no_id := @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');

	-- ----
	-- Get the sl_table row and the current tables origin.
	-- ----
	select T.tab_reloid, T.tab_set,
			S.set_origin, PGX.indexrelid,
			@NAMESPACE@.slon_quote_brute(PGN.nspname) || '.' ||
			@NAMESPACE@.slon_quote_brute(PGC.relname) as tab_fqname
			into v_tab_row
			from @NAMESPACE@.sl_table T, @NAMESPACE@.sl_set S,
				"pg_catalog".pg_class PGC, "pg_catalog".pg_namespace PGN,
				"pg_catalog".pg_index PGX, "pg_catalog".pg_class PGXC
			where T.tab_id = p_tab_id
				and T.tab_set = S.set_id
				and T.tab_reloid = PGC.oid
				and PGC.relnamespace = PGN.oid
				and PGX.indrelid = T.tab_reloid
				and PGX.indexrelid = PGXC.oid
				and PGXC.relname = T.tab_idxname
				for update;
	if not found then
		raise exception 'Slony-I: alterTableDropTriggers(): Table with id % not found', p_tab_id;
	end if;
	v_tab_fqname = v_tab_row.tab_fqname;

	execute 'lock table ' || v_tab_fqname || ' in access exclusive mode';

	-- ----
	-- Drop both triggers
	-- ----
	execute 'drop trigger "_@CLUSTERNAME@_logtrigger" on ' || 
			v_tab_fqname;

	execute 'drop trigger "_@CLUSTERNAME@_denyaccess" on ' || 
			v_tab_fqname;
				
	return p_tab_id;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.alterTableDropTriggers (int4) is
'alterTableDropTriggers (tab_id)

Remove the log and deny access triggers from a table.';

-- ----------------------------------------------------------------------
-- FUNCTION alterTableConfigureTriggers (tab_id)
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.alterTableConfigureTriggers (int4)
returns int4
as $$
declare
	p_tab_id			alias for $1;
	v_no_id				int4;
	v_tab_row			record;
	v_tab_fqname		text;
	v_n					int4;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Get our local node ID
	-- ----
	v_no_id := @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');

	-- ----
	-- Get the sl_table row and the current tables origin.
	-- ----
	select T.tab_reloid, T.tab_set,
			S.set_origin, PGX.indexrelid,
			@NAMESPACE@.slon_quote_brute(PGN.nspname) || '.' ||
			@NAMESPACE@.slon_quote_brute(PGC.relname) as tab_fqname
			into v_tab_row
			from @NAMESPACE@.sl_table T, @NAMESPACE@.sl_set S,
				"pg_catalog".pg_class PGC, "pg_catalog".pg_namespace PGN,
				"pg_catalog".pg_index PGX, "pg_catalog".pg_class PGXC
			where T.tab_id = p_tab_id
				and T.tab_set = S.set_id
				and T.tab_reloid = PGC.oid
				and PGC.relnamespace = PGN.oid
				and PGX.indrelid = T.tab_reloid
				and PGX.indexrelid = PGXC.oid
				and PGXC.relname = T.tab_idxname
				for update;
	if not found then
		raise exception 'Slony-I: alterTableConfigureTriggers(): Table with id % not found', p_tab_id;
	end if;
	v_tab_fqname = v_tab_row.tab_fqname;

	-- ----
	-- Configuration depends on the origin of the table
	-- ----
	if v_tab_row.set_origin = v_no_id then
		-- ----
		-- On the origin the log trigger is configured like a default
		-- user trigger and the deny access trigger is disabled.
		-- ----
		execute 'alter table ' || v_tab_fqname ||
				' enable trigger "_@CLUSTERNAME@_logtrigger"';
		execute 'alter table ' || v_tab_fqname ||
				' disable trigger "_@CLUSTERNAME@_denyaccess"';
	else
		-- ----
		-- On a replica the log trigger is disabled and the
		-- deny access trigger fires in origin session role.
		-- ----
		execute 'alter table ' || v_tab_fqname ||
				' disable trigger "_@CLUSTERNAME@_logtrigger"';
		execute 'alter table ' || v_tab_fqname ||
				' enable trigger "_@CLUSTERNAME@_denyaccess"';

	end if;

	return p_tab_id;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.alterTableConfigureTriggers (int4) is
'alterTableConfigureTriggers (tab_id)

Set the enable/disable configuration for the replication triggers
according to the origin of the set.';

-- ----------------------------------------------------------------------
-- FUNCTION subscribeSet (sub_set, sub_provider, sub_receiver, sub_forward, omit_copy)
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.subscribeSet (int4, int4, int4, bool, bool)
returns bigint
as $$
declare
	p_sub_set			alias for $1;
	p_sub_provider		alias for $2;
	p_sub_receiver		alias for $3;
	p_sub_forward		alias for $4;
	p_omit_copy		alias for $5;
	v_set_origin		int4;
	v_ev_seqno			int8;
	v_rec			record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	raise notice 'subscribe set: omit_copy=%', p_omit_copy;



	--
	-- Check that the receiver exists
	--
	if not exists (select no_id from @NAMESPACE@.sl_node where no_id=
	       	      p_sub_receiver) then
		      raise exception 'Slony-I: subscribeSet() the receiver does not exist receiver id:%' , p_sub_receiver;
	end if;

	-- ----
	-- Check that the origin and provider of the set are remote
	-- ----
	select set_origin into v_set_origin
			from @NAMESPACE@.sl_set
			where set_id = p_sub_set;
	if not found then
		raise exception 'Slony-I: subscribeSet(): set % not found', p_sub_set;
	end if;
	if v_set_origin = p_sub_receiver then
		raise exception 
				'Slony-I: subscribeSet(): set origin and receiver cannot be identical';
	end if;
	if p_sub_receiver = p_sub_provider then
		raise exception 
				'Slony-I: subscribeSet(): set provider and receiver cannot be identical';
	end if;
	-- ----
	-- Check that this is called on the origin node
	-- ----
	if v_set_origin != @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
		raise exception 'Slony-I: subscribeSet() must be called on origin';
	end if;

	-- ---
	-- Verify that the provider is either the origin or an active subscriber
	-- Bug report #1362
	-- ---
	if v_set_origin <> p_sub_provider then
		if not exists (select 1 from @NAMESPACE@.sl_subscribe
			where sub_set = p_sub_set and 
                              sub_receiver = p_sub_provider and
			      sub_forward and sub_active) then
			raise exception 'Slony-I: subscribeSet(): provider % is not an active forwarding node for replication set %', p_sub_provider, p_sub_set;
		end if;
	end if;

	-- ----
	-- Create the SUBSCRIBE_SET event
	-- ----
	v_ev_seqno :=  @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'SUBSCRIBE_SET', 
			p_sub_set::text, p_sub_provider::text, p_sub_receiver::text, 
			case p_sub_forward when true then 't' else 'f' end,
			case p_omit_copy when true then 't' else 'f' end
                        );

	-- ----
	-- Call the internal procedure to store the subscription
	-- ----
	perform @NAMESPACE@.subscribeSet_int(p_sub_set, p_sub_provider,
			p_sub_receiver, p_sub_forward, p_omit_copy);

	return v_ev_seqno;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.subscribeSet (int4, int4, int4, bool, bool) is
'subscribeSet (sub_set, sub_provider, sub_receiver, sub_forward, omit_copy)

Makes sure that the receiver is not the provider, then stores the
subscription, and publishes the SUBSCRIBE_SET event to other nodes.

If omit_copy is true, then no data copy will be done.
';

-- -------------------------------------------------------------------------------------------
-- FUNCTION subscribeSet_int (sub_set, sub_provider, sub_receiver, sub_forward, omit_copy)
-- -------------------------------------------------------------------------------------------
create or replace function @NAMESPACE@.subscribeSet_int (int4, int4, int4, bool, bool)
returns int4
as $$
declare
	p_sub_set			alias for $1;
	p_sub_provider		alias for $2;
	p_sub_receiver		alias for $3;
	p_sub_forward		alias for $4;
	p_omit_copy		alias for $5;
	v_set_origin		int4;
	v_sub_row			record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	raise notice 'subscribe set: omit_copy=%', p_omit_copy;

	-- ----
	-- Provider change is only allowed for active sets
	-- ----
	if p_sub_receiver = @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
		select sub_active into v_sub_row from @NAMESPACE@.sl_subscribe
				where sub_set = p_sub_set
				and sub_receiver = p_sub_receiver;
		if found then
			if not v_sub_row.sub_active then
				raise exception 'Slony-I: subscribeSet_int(): set % is not active, cannot change provider',
						p_sub_set;
			end if;
		end if;
	end if;

	-- ----
	-- Try to change provider and/or forward for an existing subscription
	-- ----
	update @NAMESPACE@.sl_subscribe
			set sub_provider = p_sub_provider,
				sub_forward = p_sub_forward
			where sub_set = p_sub_set
			and sub_receiver = p_sub_receiver;
	if found then
		-- ----
		-- Rewrite sl_listen table
		-- ----
		perform @NAMESPACE@.RebuildListenEntries();

		return p_sub_set;
	end if;

	-- ----
	-- Not found, insert a new one
	-- ----
	if not exists (select true from @NAMESPACE@.sl_path
			where pa_server = p_sub_provider
			and pa_client = p_sub_receiver)
	then
		insert into @NAMESPACE@.sl_path
				(pa_server, pa_client, pa_conninfo, pa_connretry)
				values 
				(p_sub_provider, p_sub_receiver, 
				'<event pending>', 10);
	end if;
	insert into @NAMESPACE@.sl_subscribe
			(sub_set, sub_provider, sub_receiver, sub_forward, sub_active)
			values (p_sub_set, p_sub_provider, p_sub_receiver,
				p_sub_forward, false);

	-- ----
	-- If the set origin is here, then enable the subscription
	-- ----
	select set_origin into v_set_origin
			from @NAMESPACE@.sl_set
			where set_id = p_sub_set;
	if not found then
		raise exception 'Slony-I: subscribeSet_int(): set % not found', p_sub_set;
	end if;

	if v_set_origin = @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
		perform @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'ENABLE_SUBSCRIPTION', 
				p_sub_set::text, p_sub_provider::text, p_sub_receiver::text, 
				case p_sub_forward when true then 't' else 'f' end,
				case p_omit_copy when true then 't' else 'f' end
				);
		perform @NAMESPACE@.enableSubscription(p_sub_set, 
				p_sub_provider, p_sub_receiver);
	end if;

	-- ----
	-- Rewrite sl_listen table
	-- ----
	perform @NAMESPACE@.RebuildListenEntries();

	return p_sub_set;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.subscribeSet_int (int4, int4, int4, bool, bool) is
'subscribeSet_int (sub_set, sub_provider, sub_receiver, sub_forward, omit_copy)

Internal actions for subscribing receiver sub_receiver to subscription
set sub_set.';

-- ----------------------------------------------------------------------
-- FUNCTION unsubscribeSet (sub_set, sub_receiver)
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.unsubscribeSet (int4, int4)
returns bigint
as $$
declare
	p_sub_set			alias for $1;
	p_sub_receiver		alias for $2;
	v_tab_row			record;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Check that this is called on the receiver node
	-- ----
	if p_sub_receiver != @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') then
		raise exception 'Slony-I: unsubscribeSet() must be called on receiver';
	end if;

	-- ----
	-- Check that this does not break any chains
	-- ----
	if exists (select true from @NAMESPACE@.sl_subscribe
			where sub_set = p_sub_set
				and sub_provider = p_sub_receiver)
	then
		raise exception 'Slony-I: Cannot unsubscribe set % while being provider',
				p_sub_set;
	end if;

	-- ----
	-- Remove the replication triggers.
	-- ----
	for v_tab_row in select tab_id from @NAMESPACE@.sl_table
			where tab_set = p_sub_set
			order by tab_id
	loop
		perform @NAMESPACE@.alterTableDropTriggers(v_tab_row.tab_id);
	end loop;

	-- ----
	-- Remove the setsync status. This will also cause the
	-- worker thread to ignore the set and stop replicating
	-- right now.
	-- ----
	delete from @NAMESPACE@.sl_setsync
			where ssy_setid = p_sub_set;

	-- ----
	-- Remove all sl_table and sl_sequence entries for this set.
	-- Should we ever subscribe again, the initial data
	-- copy process will create new ones.
	-- ----
	delete from @NAMESPACE@.sl_table
			where tab_set = p_sub_set;
	delete from @NAMESPACE@.sl_sequence
			where seq_set = p_sub_set;

	-- ----
	-- Call the internal procedure to drop the subscription
	-- ----
	perform @NAMESPACE@.unsubscribeSet_int(p_sub_set, p_sub_receiver);

	-- Rewrite sl_listen table
	perform @NAMESPACE@.RebuildListenEntries();

	-- ----
	-- Create the UNSUBSCRIBE_SET event
	-- ----
	return  @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'UNSUBSCRIBE_SET', 
			p_sub_set::text, p_sub_receiver::text);
end;
$$ language plpgsql;
comment on function @NAMESPACE@.unsubscribeSet (int4, int4) is
'unsubscribeSet (sub_set, sub_receiver) 

Unsubscribe node sub_receiver from subscription set sub_set.  This is
invoked on the receiver node.  It verifies that this does not break
any chains (e.g. - where sub_receiver is a provider for another node),
then restores tables, drops Slony-specific keys, drops table entries
for the set, drops the subscription, and generates an UNSUBSCRIBE_SET
node to publish that the node is being dropped.';

-- ----------------------------------------------------------------------
-- FUNCTION unsubscribeSet_int (sub_set, sub_receiver)
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.unsubscribeSet_int (int4, int4)
returns int4
as $$
declare
	p_sub_set			alias for $1;
	p_sub_receiver		alias for $2;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- All the real work is done before event generation on the
	-- subscriber.
	-- ----
	delete from @NAMESPACE@.sl_subscribe
			where sub_set = p_sub_set
				and sub_receiver = p_sub_receiver;

	-- Rewrite sl_listen table
	perform @NAMESPACE@.RebuildListenEntries();

	return p_sub_set;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.unsubscribeSet_int (int4, int4) is
'unsubscribeSet_int (sub_set, sub_receiver)

All the REAL work of removing the subscriber is done before the event
is generated, so this function just has to drop the references to the
subscription in sl_subscribe.';

-- ----------------------------------------------------------------------
-- FUNCTION enableSubscription (sub_set, sub_provider, sub_receiver, omit_copy)
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.enableSubscription (int4, int4, int4)
returns int4
as $$
declare
	p_sub_set			alias for $1;
	p_sub_provider		alias for $2;
	p_sub_receiver		alias for $3;
begin
	return  @NAMESPACE@.enableSubscription_int (p_sub_set, 
			p_sub_provider, p_sub_receiver);
end;
$$ language plpgsql;

comment on function @NAMESPACE@.enableSubscription (int4, int4, int4) is 
'enableSubscription (sub_set, sub_provider, sub_receiver)

Indicates that sub_receiver intends subscribing to set sub_set from
sub_provider.  Work is all done by the internal function
enableSubscription_int (sub_set, sub_provider, sub_receiver).';

-- -----------------------------------------------------------------------------------
-- FUNCTION enableSubscription_int (sub_set, sub_provider, sub_receiver)
-- -----------------------------------------------------------------------------------
create or replace function @NAMESPACE@.enableSubscription_int (int4, int4, int4)
returns int4
as $$
declare
	p_sub_set			alias for $1;
	p_sub_provider		alias for $2;
	p_sub_receiver		alias for $3;
	v_n					int4;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- The real work is done in the replication engine. All
	-- we have to do here is remembering that it happened.
	-- ----

	-- ----
	-- Well, not only ... we might be missing an important event here
	-- ----
	if not exists (select true from @NAMESPACE@.sl_path
			where pa_server = p_sub_provider
			and pa_client = p_sub_receiver)
	then
		insert into @NAMESPACE@.sl_path
				(pa_server, pa_client, pa_conninfo, pa_connretry)
				values 
				(p_sub_provider, p_sub_receiver, 
				'<event pending>', 10);
	end if;

	update @NAMESPACE@.sl_subscribe
			set sub_active = 't'
			where sub_set = p_sub_set
			and sub_receiver = p_sub_receiver;
	get diagnostics v_n = row_count;
	if v_n = 0 then
		insert into @NAMESPACE@.sl_subscribe
				(sub_set, sub_provider, sub_receiver,
				sub_forward, sub_active)
				values
				(p_sub_set, p_sub_provider, p_sub_receiver,
				false, true);
	end if;

	-- Rewrite sl_listen table
	perform @NAMESPACE@.RebuildListenEntries();

	return p_sub_set;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.enableSubscription_int (int4, int4, int4) is
'enableSubscription_int (sub_set, sub_provider, sub_receiver)

Internal function to enable subscription of node sub_receiver to set
sub_set via node sub_provider.

slon does most of the work; all we need do here is to remember that it
happened.  The function updates sl_subscribe, indicating that the
subscription has become active.';

-- ----------------------------------------------------------------------
-- FUNCTION forwardConfirm (p_con_origin, p_con_received, p_con_seqno, p_con_timestamp)
--
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.forwardConfirm (int4, int4, int8, timestamp)
returns bigint
as $$
declare
	p_con_origin	alias for $1;
	p_con_received	alias for $2;
	p_con_seqno		alias for $3;
	p_con_timestamp	alias for $4;
	v_max_seqno		bigint;
begin
	select into v_max_seqno coalesce(max(con_seqno), 0)
			from @NAMESPACE@.sl_confirm
			where con_origin = p_con_origin
			and con_received = p_con_received;
	if v_max_seqno < p_con_seqno then
		insert into @NAMESPACE@.sl_confirm 
				(con_origin, con_received, con_seqno, con_timestamp)
				values (p_con_origin, p_con_received, p_con_seqno,
					p_con_timestamp);
		v_max_seqno = p_con_seqno;
	end if;

	return v_max_seqno;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.forwardConfirm (int4, int4, int8, timestamp) is
'forwardConfirm (p_con_origin, p_con_received, p_con_seqno, p_con_timestamp)

Confirms (recorded in sl_confirm) that items from p_con_origin up to
p_con_seqno have been received by node p_con_received as of
p_con_timestamp, and raises an event to forward this confirmation.';

-- ----------------------------------------------------------------------
-- FUNCTION cleanupEvent (interval, deletelogs)
--
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.cleanupEvent (interval, boolean)
returns int4
as $$
declare
	p_interval alias for $1;
	p_deletelogs alias for $2;
	v_max_row	record;
	v_min_row	record;
	v_max_sync	int8;
	v_origin	int8;
	v_seqno		int8;
	v_xmin		bigint;
	v_rc            int8;
begin
	-- ----
	-- First remove all confirmations where origin/receiver no longer exist
	-- ----
	delete from @NAMESPACE@.sl_confirm
				where con_origin not in (select no_id from @NAMESPACE@.sl_node);
	delete from @NAMESPACE@.sl_confirm
				where con_received not in (select no_id from @NAMESPACE@.sl_node);
	-- ----
	-- Next remove all but the oldest confirm row per origin,receiver pair.
	-- Ignore confirmations that are younger than 10 minutes. We currently
	-- have an not confirmed suspicion that a possibly lost transaction due
	-- to a server crash might have been visible to another session, and
	-- that this led to log data that is needed again got removed.
	-- ----
	for v_max_row in select con_origin, con_received, max(con_seqno) as con_seqno
				from @NAMESPACE@.sl_confirm
				where con_timestamp < (CURRENT_TIMESTAMP - p_interval)
				group by con_origin, con_received
	loop
		delete from @NAMESPACE@.sl_confirm
				where con_origin = v_max_row.con_origin
				and con_received = v_max_row.con_received
				and con_seqno < v_max_row.con_seqno;
	end loop;

	-- ----
	-- Then remove all events that are confirmed by all nodes in the
	-- whole cluster up to the last SYNC
	-- ----
	for v_min_row in select con_origin, min(con_seqno) as con_seqno
				from @NAMESPACE@.sl_confirm
				group by con_origin
	loop
		select coalesce(max(ev_seqno), 0) into v_max_sync
				from @NAMESPACE@.sl_event
				where ev_origin = v_min_row.con_origin
				and ev_seqno <= v_min_row.con_seqno
				and ev_type = 'SYNC';
		if v_max_sync > 0 then
			delete from @NAMESPACE@.sl_event
					where ev_origin = v_min_row.con_origin
					and ev_seqno < v_max_sync;
		end if;
	end loop;

	-- ----
	-- If cluster has only one node, then remove all events up to
	-- the last SYNC - Bug #1538
        -- http://gborg.postgresql.org/project/slony1/bugs/bugupdate.php?1538
	-- ----

	select * into v_min_row from @NAMESPACE@.sl_node where
			no_id <> @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') limit 1;
	if not found then
		select ev_origin, ev_seqno into v_min_row from @NAMESPACE@.sl_event
		where ev_origin = @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@')
		order by ev_origin desc, ev_seqno desc limit 1;
		raise notice 'Slony-I: cleanupEvent(): Single node - deleting events < %', v_min_row.ev_seqno;
			delete from @NAMESPACE@.sl_event
			where
				ev_origin = v_min_row.ev_origin and
				ev_seqno < v_min_row.ev_seqno;

        end if;

	if exists (select * from "pg_catalog".pg_class c, "pg_catalog".pg_namespace n, "pg_catalog".pg_attribute a where c.relname = 'sl_seqlog' and n.oid = c.relnamespace and a.attrelid = c.oid and a.attname = 'oid') then
                execute 'alter table @NAMESPACE@.sl_seqlog set without oids;';
	end if;		
	-- ----
	-- Also remove stale entries from the nodelock table.
	-- ----
	perform @NAMESPACE@.cleanupNodelock();

	-- ----
	-- Find the eldest event left, for each origin
	-- ----
        for v_origin, v_seqno, v_xmin in
	  select ev_origin, ev_seqno, "pg_catalog".txid_snapshot_xmin(ev_snapshot) from @NAMESPACE@.sl_event
          where (ev_origin, ev_seqno) in (select ev_origin, min(ev_seqno) from @NAMESPACE@.sl_event where ev_type = 'SYNC' group by ev_origin)
	loop
		if p_deletelogs then
			delete from @NAMESPACE@.sl_log_1 where log_origin = v_origin and log_txid < v_xmin;		
			delete from @NAMESPACE@.sl_log_2 where log_origin = v_origin and log_txid < v_xmin;		
		end if;
		delete from @NAMESPACE@.sl_seqlog where seql_origin = v_origin and seql_ev_seqno < v_seqno;
        end loop;
	
	v_rc := @NAMESPACE@.logswitch_finish();
	if v_rc = 0 then   -- no switch in progress
		perform @NAMESPACE@.logswitch_start();
	end if;

	return 0;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.cleanupEvent (interval, boolean) is
'cleaning old data out of sl_confirm, sl_event.  Removes all but the
last sl_confirm row per (origin,receiver), and then removes all events
that are confirmed by all nodes in the whole cluster up to the last
SYNC.  Deletes now-orphaned entries from sl_log_* if delete_logs parameter is set';


-- ----------------------------------------------------------------------
-- FUNCTION determineIdxnameUnique (tab_fqname, indexname)
--
--	Given a tablename, check that a unique index exists or return
--	the tables primary key index name.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.determineIdxnameUnique(text, name) returns name
as $$
declare
	p_tab_fqname	alias for $1;
	v_tab_fqname_quoted	text default '';
	p_idx_name		alias for $2;
	v_idxrow		record;
begin
	v_tab_fqname_quoted := @NAMESPACE@.slon_quote_input(p_tab_fqname);
	--
	-- Ensure that the table exists
	--
	if (select PGC.relname
				from "pg_catalog".pg_class PGC,
					"pg_catalog".pg_namespace PGN
				where @NAMESPACE@.slon_quote_brute(PGN.nspname) || '.' ||
					@NAMESPACE@.slon_quote_brute(PGC.relname) = v_tab_fqname_quoted
					and PGN.oid = PGC.relnamespace) is null then
		raise exception 'Slony-I: determineIdxnameUnique(): table % not found', v_tab_fqname_quoted;
	end if;

	--
	-- Lookup the tables primary key or the specified unique index
	--
	if p_idx_name isnull then
		select PGXC.relname
				into v_idxrow
				from "pg_catalog".pg_class PGC,
					"pg_catalog".pg_namespace PGN,
					"pg_catalog".pg_index PGX,
					"pg_catalog".pg_class PGXC
				where @NAMESPACE@.slon_quote_brute(PGN.nspname) || '.' ||
					@NAMESPACE@.slon_quote_brute(PGC.relname) = v_tab_fqname_quoted
					and PGN.oid = PGC.relnamespace
					and PGX.indrelid = PGC.oid
					and PGX.indexrelid = PGXC.oid
					and PGX.indisprimary;
		if not found then
			raise exception 'Slony-I: table % has no primary key',
					v_tab_fqname_quoted;
		end if;
	else
		select PGXC.relname
				into v_idxrow
				from "pg_catalog".pg_class PGC,
					"pg_catalog".pg_namespace PGN,
					"pg_catalog".pg_index PGX,
					"pg_catalog".pg_class PGXC
				where @NAMESPACE@.slon_quote_brute(PGN.nspname) || '.' ||
					@NAMESPACE@.slon_quote_brute(PGC.relname) = v_tab_fqname_quoted
					and PGN.oid = PGC.relnamespace
					and PGX.indrelid = PGC.oid
					and PGX.indexrelid = PGXC.oid
					and PGX.indisunique
					and @NAMESPACE@.slon_quote_brute(PGXC.relname) = @NAMESPACE@.slon_quote_input(p_idx_name);
		if not found then
			raise exception 'Slony-I: table % has no unique index %',
					v_tab_fqname_quoted, p_idx_name;
		end if;
	end if;

	--
	-- Return the found index name
	--
	return v_idxrow.relname;
end;
$$ language plpgsql called on null input;
comment on function @NAMESPACE@.determineIdxnameUnique(text, name) is
'FUNCTION determineIdxnameUnique (tab_fqname, indexname)

Given a tablename, tab_fqname, check that the unique index, indexname,
exists or return the primary key index name for the table.  If there
is no unique index, it raises an exception.';


-- ----------------------------------------------------------------------
-- FUNCTION determineAttKindUnique (tab_fqname, indexname)
--
--	Given a tablename, return the Slony-I specific attkind (used for
--	the log trigger) of the table. Use the specified unique index or
--	the primary key (if indexname is NULL).
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.determineAttkindUnique(text, name) returns text
as $$
declare
	p_tab_fqname	alias for $1;
	v_tab_fqname_quoted	text default '';
	p_idx_name		alias for $2;
	v_idx_name_quoted	text;
	v_idxrow		record;
	v_attrow		record;
	v_i				integer;
	v_attno			int2;
	v_attkind		text default '';
	v_attfound		bool;
begin
	v_tab_fqname_quoted := @NAMESPACE@.slon_quote_input(p_tab_fqname);
	v_idx_name_quoted := @NAMESPACE@.slon_quote_brute(p_idx_name);
	--
	-- Ensure that the table exists
	--
	if (select PGC.relname
				from "pg_catalog".pg_class PGC,
					"pg_catalog".pg_namespace PGN
				where @NAMESPACE@.slon_quote_brute(PGN.nspname) || '.' ||
					@NAMESPACE@.slon_quote_brute(PGC.relname) = v_tab_fqname_quoted
					and PGN.oid = PGC.relnamespace) is null then
		raise exception 'Slony-I: table % not found', v_tab_fqname_quoted;
	end if;

	--
	-- Lookup the tables primary key or the specified unique index
	--
	if p_idx_name isnull then
		raise exception 'Slony-I: index name must be specified';
	else
		select PGXC.relname, PGX.indexrelid, PGX.indkey
				into v_idxrow
				from "pg_catalog".pg_class PGC,
					"pg_catalog".pg_namespace PGN,
					"pg_catalog".pg_index PGX,
					"pg_catalog".pg_class PGXC
				where @NAMESPACE@.slon_quote_brute(PGN.nspname) || '.' ||
					@NAMESPACE@.slon_quote_brute(PGC.relname) = v_tab_fqname_quoted
					and PGN.oid = PGC.relnamespace
					and PGX.indrelid = PGC.oid
					and PGX.indexrelid = PGXC.oid
					and PGX.indisunique
					and @NAMESPACE@.slon_quote_brute(PGXC.relname) = v_idx_name_quoted;
		if not found then
			raise exception 'Slony-I: table % has no unique index %',
					v_tab_fqname_quoted, v_idx_name_quoted;
		end if;
	end if;

	--
	-- Loop over the tables attributes and check if they are
	-- index attributes. If so, add a "k" to the return value,
	-- otherwise add a "v".
	--
	for v_attrow in select PGA.attnum, PGA.attname
			from "pg_catalog".pg_class PGC,
			    "pg_catalog".pg_namespace PGN,
				"pg_catalog".pg_attribute PGA
			where @NAMESPACE@.slon_quote_brute(PGN.nspname) || '.' ||
			    @NAMESPACE@.slon_quote_brute(PGC.relname) = v_tab_fqname_quoted
				and PGN.oid = PGC.relnamespace
				and PGA.attrelid = PGC.oid
				and not PGA.attisdropped
				and PGA.attnum > 0
			order by attnum
	loop
		v_attfound = 'f';

		v_i := 0;
		loop
			select indkey[v_i] into v_attno from "pg_catalog".pg_index
					where indexrelid = v_idxrow.indexrelid;
			if v_attno isnull or v_attno = 0 then
				exit;
			end if;
			if v_attrow.attnum = v_attno then
				v_attfound = 't';
				exit;
			end if;
			v_i := v_i + 1;
		end loop;

		if v_attfound then
			v_attkind := v_attkind || 'k';
		else
			v_attkind := v_attkind || 'v';
		end if;
	end loop;

	-- Strip off trailing v characters as they are not needed by the logtrigger
	v_attkind := pg_catalog.rtrim(v_attkind, 'v');

	--
	-- Return the resulting attkind
	--
	return v_attkind;
end;
$$ language plpgsql called on null input;

comment on function @NAMESPACE@.determineAttkindUnique(text, name) is
'determineAttKindUnique (tab_fqname, indexname)

Given a tablename, return the Slony-I specific attkind (used for the
log trigger) of the table. Use the specified unique index or the
primary key (if indexname is NULL).';


-- ----------------------------------------------------------------------
-- FUNCTION RebuildListenEntries ()
--
--	Revises sl_listen rules based on contents of sl_path and
--              sl_subscribe
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.RebuildListenEntries()
returns int
as $$
declare
	v_row	record;
begin
	-- First remove the entire configuration
	delete from @NAMESPACE@.sl_listen;

	-- Second populate the sl_listen configuration with a full
	-- network of all possible paths.
	insert into @NAMESPACE@.sl_listen
				(li_origin, li_provider, li_receiver)
			select pa_server, pa_server, pa_client from @NAMESPACE@.sl_path;
	while true loop
		insert into @NAMESPACE@.sl_listen
					(li_origin, li_provider, li_receiver)
			select distinct li_origin, pa_server, pa_client
				from @NAMESPACE@.sl_listen, @NAMESPACE@.sl_path
				where li_receiver = pa_server
				  and li_origin <> pa_client
			except
			select li_origin, li_provider, li_receiver
				from @NAMESPACE@.sl_listen;

		if not found then
			exit;
		end if;
	end loop;

	-- We now replace specific event-origin,receiver combinations
	-- with a configuration that tries to avoid events arriving at
	-- a node before the data provider actually has the data ready.

	-- Loop over every possible pair of receiver and event origin
	for v_row in select N1.no_id as receiver, N2.no_id as origin
			from @NAMESPACE@.sl_node as N1, @NAMESPACE@.sl_node as N2
			where N1.no_id <> N2.no_id
	loop
		-- 1st choice:
		-- If we use the event origin as a data provider for any
		-- set that originates on that very node, we are a direct
		-- subscriber to that origin and listen there only.
		if exists (select true from @NAMESPACE@.sl_set, @NAMESPACE@.sl_subscribe				, @NAMESPACE@.sl_node p		   		
				where set_origin = v_row.origin
				  and sub_set = set_id
				  and sub_provider = v_row.origin
				  and sub_receiver = v_row.receiver
				  and sub_active
				  and p.no_active
				  and p.no_id=sub_provider
				  )
		then
			delete from @NAMESPACE@.sl_listen
				where li_origin = v_row.origin
				  and li_receiver = v_row.receiver;
			insert into @NAMESPACE@.sl_listen (li_origin, li_provider, li_receiver)
				values (v_row.origin, v_row.origin, v_row.receiver);
			continue;
		end if;

		-- 2nd choice:
		-- If we are subscribed to any set originating on this
		-- event origin, we want to listen on all data providers
		-- we use for this origin. We are a cascaded subscriber
		-- for sets from this node.
		if exists (select true from @NAMESPACE@.sl_set, @NAMESPACE@.sl_subscribe
						where set_origin = v_row.origin
						  and sub_set = set_id
						  and sub_receiver = v_row.receiver
						  and sub_active)
		then
			delete from @NAMESPACE@.sl_listen
					where li_origin = v_row.origin
					  and li_receiver = v_row.receiver;
			insert into @NAMESPACE@.sl_listen (li_origin, li_provider, li_receiver)
					select distinct set_origin, sub_provider, v_row.receiver
						from @NAMESPACE@.sl_set, @NAMESPACE@.sl_subscribe
						where set_origin = v_row.origin
						  and sub_set = set_id
						  and sub_receiver = v_row.receiver
						  and sub_active;
			continue;
		end if;

	end loop ;

	return null ;
end ;
$$ language 'plpgsql';

comment on function @NAMESPACE@.RebuildListenEntries() is
'RebuildListenEntries()

Invoked by various subscription and path modifying functions, this
rewrites the sl_listen entries, adding in all the ones required to
allow communications between nodes in the Slony-I cluster.';


-- ----------------------------------------------------------------------
-- FUNCTION generate_sync_event (interval)
--
--	This code can be used to create SYNC events every once in a while
--      even if the 'master' slon daemon is down
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.generate_sync_event(interval)
returns int4
as $$
declare
	p_interval     alias for $1;
	v_node_row     record;

BEGIN
	select 1 into v_node_row from @NAMESPACE@.sl_event 
       	  where ev_type = 'SYNC' and ev_origin = @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@')
          and ev_timestamp > now() - p_interval limit 1;
	if not found then
		-- If there has been no SYNC in the last interval, then push one
		perform @NAMESPACE@.createEvent('_@CLUSTERNAME@', 'SYNC', NULL);
		return 1;
	else
		return 0;
	end if;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.generate_sync_event(interval) is
  'Generate a sync event if there has not been one in the requested interval, and this is a provider node.';

-- ----------------------------------------------------------------------
-- FUNCTION updateRelname (set_id, only_on_node)
--
--      Reset the relnames          
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.updateRelname (int4, int4)
returns int4
as $$
declare
        p_set_id                alias for $1;
        p_only_on_node          alias for $2;
        v_no_id                 int4;
        v_set_origin            int4;
begin
        -- ----
        -- Grab the central configuration lock
        -- ----
        lock table @NAMESPACE@.sl_config_lock;

        -- ----
        -- Check that we either are the set origin or a current
        -- subscriber of the set.
        -- ----
        v_no_id := @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');
        select set_origin into v_set_origin
                        from @NAMESPACE@.sl_set
                        where set_id = p_set_id
                        for update;
        if not found then
                raise exception 'Slony-I: set % not found', p_set_id;
        end if;
        if v_set_origin <> v_no_id
                and not exists (select 1 from @NAMESPACE@.sl_subscribe
                        where sub_set = p_set_id
                        and sub_receiver = v_no_id)
        then
                return 0;
        end if;
    
        -- ----
        -- If execution on only one node is requested, check that
        -- we are that node.
        -- ----
        if p_only_on_node > 0 and p_only_on_node <> v_no_id then
                return 0;
        end if;
        update @NAMESPACE@.sl_table set 
                tab_relname = PGC.relname, tab_nspname = PGN.nspname
                from pg_catalog.pg_class PGC, pg_catalog.pg_namespace PGN 
                where @NAMESPACE@.sl_table.tab_reloid = PGC.oid
                        and PGC.relnamespace = PGN.oid;
        update @NAMESPACE@.sl_sequence set
                seq_relname = PGC.relname, seq_nspname = PGN.nspname
                from pg_catalog.pg_class PGC, pg_catalog.pg_namespace PGN
                where @NAMESPACE@.sl_sequence.seq_reloid = PGC.oid
                and PGC.relnamespace = PGN.oid;
        return p_set_id;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.updateRelname(int4, int4) is
'updateRelname(set_id, only_on_node)';

-- ----------------------------------------------------------------------
-- FUNCTION updateReloid (set_id, only_on_node)
--
--      Reset the relnames
-- ----------------------------------------------------------------------
drop function if exists @NAMESPACE@.updateReloid (int4, int4);
create or replace function @NAMESPACE@.updateReloid (int4, int4)
returns bigint
as $$
declare
        p_set_id                alias for $1;
        p_only_on_node          alias for $2;
        v_no_id                 int4;
        v_set_origin            int4;
	prec			record;
begin
        -- ----
        -- Grab the central configuration lock
        -- ----
        lock table @NAMESPACE@.sl_config_lock;

        -- ----
        -- Check that we either are the set origin or a current
        -- subscriber of the set.
        -- ----
        v_no_id := @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@');
        select set_origin into v_set_origin
                        from @NAMESPACE@.sl_set
                        where set_id = p_set_id
                        for update;
        if not found then
                raise exception 'Slony-I: set % not found', p_set_id;
        end if;
        if v_set_origin <> v_no_id
                and not exists (select 1 from @NAMESPACE@.sl_subscribe
                        where sub_set = p_set_id
                        and sub_receiver = v_no_id)
        then
                return 0;
        end if;

        -- ----
        -- If execution on only one node is requested, check that
        -- we are that node.
        -- ----
        if p_only_on_node > 0 and p_only_on_node <> v_no_id then
                return 0;
        end if;

	-- Update OIDs for tables to values pulled from non-table objects in pg_class
	-- This ensures that we won't have collisions when repairing the oids
	for prec in select tab_id from @NAMESPACE@.sl_table loop
		update @NAMESPACE@.sl_table set tab_reloid = (select oid from pg_class pc where relkind <> 'r' and not exists (select 1 from @NAMESPACE@.sl_table t2 where t2.tab_reloid = pc.oid) limit 1)
		where tab_id = prec.tab_id;
	end loop;

	for prec in select tab_id, tab_relname, tab_nspname from @NAMESPACE@.sl_table loop
	        update @NAMESPACE@.sl_table set
        	        tab_reloid = (select PGC.oid
	                from pg_catalog.pg_class PGC, pg_catalog.pg_namespace PGN
	                where @NAMESPACE@.slon_quote_brute(PGC.relname) = @NAMESPACE@.slon_quote_brute(prec.tab_relname)
	                        and PGC.relnamespace = PGN.oid
				and @NAMESPACE@.slon_quote_brute(PGN.nspname) = @NAMESPACE@.slon_quote_brute(prec.tab_nspname))
		where tab_id = prec.tab_id;
	end loop;

	for prec in select seq_id from @NAMESPACE@.sl_sequence loop
		update @NAMESPACE@.sl_sequence set seq_reloid = (select oid from pg_class pc where relkind <> 'S' and not exists (select 1 from @NAMESPACE@.sl_sequence t2 where t2.seq_reloid = pc.oid) limit 1)
		where seq_id = prec.seq_id;
	end loop;

	for prec in select seq_id, seq_relname, seq_nspname from @NAMESPACE@.sl_sequence loop
	        update @NAMESPACE@.sl_sequence set
	                seq_reloid = (select PGC.oid
	                from pg_catalog.pg_class PGC, pg_catalog.pg_namespace PGN
	                where @NAMESPACE@.slon_quote_brute(PGC.relname) = @NAMESPACE@.slon_quote_brute(prec.seq_relname)
                	and PGC.relnamespace = PGN.oid
			and @NAMESPACE@.slon_quote_brute(PGN.nspname) = @NAMESPACE@.slon_quote_brute(prec.seq_nspname))
		where seq_id = prec.seq_id;
	end loop;

	return 1;
end;
$$ language plpgsql;
comment on function @NAMESPACE@.updateReloid(int4, int4) is
'updateReloid(set_id, only_on_node)

Updates the respective reloids in sl_table and sl_seqeunce based on
their respective FQN';


-- ----------------------------------------------------------------------
-- FUNCTION logswitch_start()
--
--	Called by slonik to initiate a switch from sl_log_1 to sl_log_2 and
--  visa versa.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.logswitch_start()
returns int4 as $$
DECLARE
	v_current_status	int4;
BEGIN
	-- ----
	-- Grab the central configuration lock to prevent race conditions
	-- while changing the sl_log_status sequence value.
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Get the current log status.
	-- ----
	select last_value into v_current_status from @NAMESPACE@.sl_log_status;

	-- ----
	-- status = 0: sl_log_1 active, sl_log_2 clean
	-- Initiate a switch to sl_log_2.
	-- ----
	if v_current_status = 0 then
		perform "pg_catalog".setval('@NAMESPACE@.sl_log_status', 3);
		perform @NAMESPACE@.registry_set_timestamp(
				'logswitch.laststart', now()::timestamp);
		raise notice 'Slony-I: Logswitch to sl_log_2 initiated';
		return 2;
	end if;

	-- ----
	-- status = 1: sl_log_2 active, sl_log_1 clean
	-- Initiate a switch to sl_log_1.
	-- ----
	if v_current_status = 1 then
		perform "pg_catalog".setval('@NAMESPACE@.sl_log_status', 2);
		perform @NAMESPACE@.registry_set_timestamp(
				'logswitch.laststart', now()::timestamp);
		raise notice 'Slony-I: Logswitch to sl_log_1 initiated';
		return 1;
	end if;

	raise exception 'Previous logswitch still in progress';
END;
$$ language plpgsql;
comment on function @NAMESPACE@.logswitch_start() is
'logswitch_start()

Initiate a log table switch if none is in progress';

-- ----------------------------------------------------------------------
-- FUNCTION logswitch_finish()
--
--	Called from the cleanup thread to eventually finish a logswitch
--  that is in progress.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.logswitch_finish()
returns int4 as $$
DECLARE
	v_current_status	int4;
	v_dummy				record;
	v_origin	int8;
	v_seqno		int8;
	v_xmin		bigint;
	v_purgeable boolean;
BEGIN
	-- ----
	-- Grab the central configuration lock to prevent race conditions
	-- while changing the sl_log_status sequence value.
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	-- ----
	-- Get the current log status.
	-- ----
	select last_value into v_current_status from @NAMESPACE@.sl_log_status;

	-- ----
	-- status value 0 or 1 means that there is no log switch in progress
	-- ----
	if v_current_status = 0 or v_current_status = 1 then
		return 0;
	end if;

	-- ----
	-- status = 2: sl_log_1 active, cleanup sl_log_2
	-- ----
	if v_current_status = 2 then
		v_purgeable := 'true';
		
		-- ----
		-- Attempt to lock sl_log_2 in order to make sure there are no other transactions 
		-- currently writing to it. Exit if it is still in use. This prevents TRUNCATE from 
		-- blocking writers to sl_log_2 while it is waiting for a lock. It also prevents it 
		-- immediately truncating log data generated inside the transaction which was active 
		-- when logswitch_finish() was called (and was blocking TRUNCATE) as soon as that 
		-- transaction is committed.
		-- ----
		begin
			lock table @NAMESPACE@.sl_log_2 in exclusive mode nowait;
		exception when lock_not_available then
			raise notice 'Slony-I: could not lock sl_log_2 - sl_log_2 not truncated';
			return -1;
		end;

		-- ----
		-- The cleanup thread calls us after it did the delete and
		-- vacuum of both log tables. If sl_log_2 is empty now, we
		-- can truncate it and the log switch is done.
		-- ----
	        for v_origin, v_seqno, v_xmin in
		  select ev_origin, ev_seqno, "pg_catalog".txid_snapshot_xmin(ev_snapshot) from @NAMESPACE@.sl_event
	          where (ev_origin, ev_seqno) in (select ev_origin, min(ev_seqno) from @NAMESPACE@.sl_event where ev_type = 'SYNC' group by ev_origin)
		loop
			if exists (select 1 from @NAMESPACE@.sl_log_2 where log_origin = v_origin and log_txid >= v_xmin limit 1) then
				v_purgeable := 'false';
			end if;
	        end loop;
		if not v_purgeable then
			-- ----
			-- Found a row ... log switch is still in progress.
			-- ----
			raise notice 'Slony-I: log switch to sl_log_1 still in progress - sl_log_2 not truncated';
			return -1;
		end if;

		raise notice 'Slony-I: log switch to sl_log_1 complete - truncate sl_log_2';
		truncate @NAMESPACE@.sl_log_2;
		if exists (select * from "pg_catalog".pg_class c, "pg_catalog".pg_namespace n, "pg_catalog".pg_attribute a where c.relname = 'sl_log_2' and n.oid = c.relnamespace and a.attrelid = c.oid and a.attname = 'oid') then
	                execute 'alter table @NAMESPACE@.sl_log_2 set without oids;';
		end if;		
		perform "pg_catalog".setval('@NAMESPACE@.sl_log_status', 0);
		-- Run addPartialLogIndices() to try to add indices to unused sl_log_? table
		perform @NAMESPACE@.addPartialLogIndices();

		return 1;
	end if;

	-- ----
	-- status = 3: sl_log_2 active, cleanup sl_log_1
	-- ----
	if v_current_status = 3 then
		v_purgeable := 'true';

		-- ----
		-- Attempt to lock sl_log_1 in order to make sure there are no other transactions 
		-- currently writing to it. Exit if it is still in use. This prevents TRUNCATE from 
		-- blocking writes to sl_log_1 while it is waiting for a lock. It also prevents it 
		-- immediately truncating log data generated inside the transaction which was active 
		-- when logswitch_finish() was called (and was blocking TRUNCATE) as soon as that 
		-- transaction is committed.
		-- ----
		begin
			lock table @NAMESPACE@.sl_log_1 in exclusive mode nowait;
		exception when lock_not_available then
			raise notice 'Slony-I: could not lock sl_log_1 - sl_log_1 not truncated';
			return -1;
		end;

		-- ----
		-- The cleanup thread calls us after it did the delete and
		-- vacuum of both log tables. If sl_log_2 is empty now, we
		-- can truncate it and the log switch is done.
		-- ----
	        for v_origin, v_seqno, v_xmin in
		  select ev_origin, ev_seqno, "pg_catalog".txid_snapshot_xmin(ev_snapshot) from @NAMESPACE@.sl_event
	          where (ev_origin, ev_seqno) in (select ev_origin, min(ev_seqno) from @NAMESPACE@.sl_event where ev_type = 'SYNC' group by ev_origin)
		loop
			if (exists (select 1 from @NAMESPACE@.sl_log_1 where log_origin = v_origin and log_txid >= v_xmin limit 1)) then
				v_purgeable := 'false';
			end if;
	        end loop;
		if not v_purgeable then
			-- ----
			-- Found a row ... log switch is still in progress.
			-- ----
			raise notice 'Slony-I: log switch to sl_log_2 still in progress - sl_log_1 not truncated';
			return -1;
		end if;

		raise notice 'Slony-I: log switch to sl_log_2 complete - truncate sl_log_1';
		truncate @NAMESPACE@.sl_log_1;
		if exists (select * from "pg_catalog".pg_class c, "pg_catalog".pg_namespace n, "pg_catalog".pg_attribute a where c.relname = 'sl_log_1' and n.oid = c.relnamespace and a.attrelid = c.oid and a.attname = 'oid') then
	                execute 'alter table @NAMESPACE@.sl_log_1 set without oids;';
		end if;		
		perform "pg_catalog".setval('@NAMESPACE@.sl_log_status', 1);
		-- Run addPartialLogIndices() to try to add indices to unused sl_log_? table
		perform @NAMESPACE@.addPartialLogIndices();
		return 2;
	end if;
END;
$$ language plpgsql;
comment on function @NAMESPACE@.logswitch_finish() is
'logswitch_finish()

Attempt to finalize a log table switch in progress
return values:
  -1 if switch in progress, but not complete
   0 if no switch in progress
   1 if performed truncate on sl_log_2
   2 if performed truncate on sl_log_1
';


-- ----------------------------------------------------------------------
-- FUNCTION addPartialLogIndices ()
-- Add partial indices to sl_log_? tables that aren't currently in use
-- ----------------------------------------------------------------------

create or replace function @NAMESPACE@.addPartialLogIndices () returns integer as $$
DECLARE
	v_current_status	int4;
	v_log			int4;
	v_dummy		record;
	v_dummy2	record;
	idef 		text;
	v_count		int4;
        v_iname         text;
	v_ilen int4;
	v_maxlen int4;
BEGIN
	v_count := 0;
	select last_value into v_current_status from @NAMESPACE@.sl_log_status;

	-- If status is 2 or 3 --> in process of cleanup --> unsafe to create indices
	if v_current_status in (2, 3) then
		return 0;
	end if;

	if v_current_status = 0 then   -- Which log should get indices?
		v_log := 2;
	else
		v_log := 1;
	end if;
--                                       PartInd_test_db_sl_log_2-node-1
	-- Add missing indices...
	for v_dummy in select distinct set_origin from @NAMESPACE@.sl_set loop
            v_iname := 'PartInd_@CLUSTERNAME@_sl_log_' || v_log::text || '-node-' || v_dummy.set_origin;
	   -- raise notice 'Consider adding partial index % on sl_log_%', v_iname, v_log;
	   -- raise notice 'schema: [_@CLUSTERNAME@] tablename:[sl_log_%]', v_log;
            select * into v_dummy2 from pg_catalog.pg_indexes where tablename = 'sl_log_' || v_log::text and  indexname = v_iname;
            if not found then
		-- raise notice 'index was not found - add it!';
        v_iname := 'PartInd_@CLUSTERNAME@_sl_log_' || v_log::text || '-node-' || v_dummy.set_origin;
		v_ilen := pg_catalog.length(v_iname);
		v_maxlen := pg_catalog.current_setting('max_identifier_length'::text)::int4;
                if v_ilen > v_maxlen then
		   raise exception 'Length of proposed index name [%] > max_identifier_length [%] - cluster name probably too long', v_ilen, v_maxlen;
		end if;

		idef := 'create index "' || v_iname || 
                        '" on @NAMESPACE@.sl_log_' || v_log::text || ' USING btree(log_txid) where (log_origin = ' || v_dummy.set_origin::text || ');';
		execute idef;
		v_count := v_count + 1;
            else
                -- raise notice 'Index % already present - skipping', v_iname;
            end if;
	end loop;

	-- Remove unneeded indices...
	for v_dummy in select indexname from pg_catalog.pg_indexes i where i.tablename = 'sl_log_' || v_log::text and
                       i.indexname like ('PartInd_@CLUSTERNAME@_sl_log_' || v_log::text || '-node-%') and
                       not exists (select 1 from @NAMESPACE@.sl_set where
				i.indexname = 'PartInd_@CLUSTERNAME@_sl_log_' || v_log::text || '-node-' || set_origin::text)
	loop
		-- raise notice 'Dropping obsolete index %d', v_dummy.indexname;
		idef := 'drop index @NAMESPACE@."' || v_dummy.indexname || '";';
		execute idef;
		v_count := v_count - 1;
	end loop;
	return v_count;
END
$$ language plpgsql;


comment on function @NAMESPACE@.addPartialLogIndices () is 
'Add partial indexes, if possible, to the unused sl_log_? table for
all origin nodes, and drop any that are no longer needed.

This function presently gets run any time set origins are manipulated
(FAILOVER, STORE SET, MOVE SET, DROP SET), as well as each time the
system switches between sl_log_1 and sl_log_2.';


-- ----------------------------------------------------------------------
-- FUNCTION upgradeSchema(old_version)
-- upgrade sl_node
--
--	Called by slonik during the function upgrade process. 
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.add_missing_table_field (text, text, text, text) 
returns bool as $$
DECLARE
  p_namespace alias for $1;
  p_table     alias for $2;
  p_field     alias for $3;
  p_type      alias for $4;
  v_row       record;
  v_query     text;
BEGIN
  select 1 into v_row from pg_namespace n, pg_class c, pg_attribute a
     where @NAMESPACE@.slon_quote_brute(n.nspname) = p_namespace and 
         c.relnamespace = n.oid and
         @NAMESPACE@.slon_quote_brute(c.relname) = p_table and
         a.attrelid = c.oid and
         @NAMESPACE@.slon_quote_brute(a.attname) = p_field;
  if not found then
    raise notice 'Upgrade table %.% - add field %', p_namespace, p_table, p_field;
    v_query := 'alter table ' || p_namespace || '.' || p_table || ' add column ';
    v_query := v_query || p_field || ' ' || p_type || ';';
    execute v_query;
    return 't';
  else
    return 'f';
  end if;
END;$$ language plpgsql;

comment on function @NAMESPACE@.add_missing_table_field (text, text, text, text) 
is 'Add a column of a given type to a table if it is missing';

create or replace function @NAMESPACE@.upgradeSchema(text)
returns text as $$

declare
        p_old   	alias for $1;
		v_tab_row	record;
begin
	-- If old version is pre-2.0, then we require a special upgrade process
	if p_old like '1.%' then
		raise exception 'Upgrading to Slony-I 2.x requires running slony_upgrade_20';
	end if;

	return p_old;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.upgradeSchema(text) is
    'Called during "update functions" by slonik to perform schema changes';

-- ----------------------------------------------------------------------
-- VIEW sl_status
--
--	This view shows the local nodes last event sequence number
--	and how far all remote nodes have processed events.
--
--	This view can NOT be loaded in slony1_base.sql (where it
--	naturally would belong) because of using a C function that
--	is defined in this file.
-- ----------------------------------------------------------------------
create or replace view @NAMESPACE@.sl_status as select
	E.ev_origin as st_origin,
	C.con_received as st_received,
	E.ev_seqno as st_last_event,
	E.ev_timestamp as st_last_event_ts,
	C.con_seqno as st_last_received,
	C.con_timestamp as st_last_received_ts,
	CE.ev_timestamp as st_last_received_event_ts,
	E.ev_seqno - C.con_seqno as st_lag_num_events,
	current_timestamp - CE.ev_timestamp as st_lag_time
	from @NAMESPACE@.sl_event E, @NAMESPACE@.sl_confirm C,
		@NAMESPACE@.sl_event CE
	where E.ev_origin = C.con_origin
	and CE.ev_origin = E.ev_origin
	and CE.ev_seqno = C.con_seqno
	and (E.ev_origin, E.ev_seqno) in 
		(select ev_origin, max(ev_seqno)
			from @NAMESPACE@.sl_event
			where ev_origin = @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@')
			group by 1
		)
	and (C.con_origin, C.con_received, C.con_seqno) in
		(select con_origin, con_received, max(con_seqno)
			from @NAMESPACE@.sl_confirm
			where con_origin = @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@')
			group by 1, 2
		);

comment on view @NAMESPACE@.sl_status is 'View showing how far behind remote nodes are.';

create or replace function @NAMESPACE@.copyFields(integer) 
returns text
as $$
declare
	result text;
	prefix text;
	prec record;
begin
	result := '';
	prefix := '(';   -- Initially, prefix is the opening paren

	for prec in select @NAMESPACE@.slon_quote_input(a.attname) as column from @NAMESPACE@.sl_table t, pg_catalog.pg_attribute a where t.tab_id = $1 and t.tab_reloid = a.attrelid and a.attnum > 0 and a.attisdropped = false order by attnum
	loop
		result := result || prefix || prec.column;
		prefix := ',';   -- Subsequently, prepend columns with commas
	end loop;
	result := result || ')';
	return result;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.copyFields(integer) is
'Return a string consisting of what should be appended to a COPY statement
to specify fields for the passed-in tab_id.  

In PG versions > 7.3, this looks like (field1,field2,...fieldn)';

-- ----------------------------------------------------------------------
-- FUNCTION prepareTableForCopy(tab_id)
--
--	Remove all content from a table before the subscription
--	content is loaded via COPY and disable index maintenance.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.prepareTableForCopy(int4)
returns int4
as $$
declare
	p_tab_id		alias for $1;
	v_tab_oid		oid;
	v_tab_fqname	text;
begin
	-- ----
	-- Get the OID and fully qualified name for the table
	-- ---
	select	PGC.oid,
			@NAMESPACE@.slon_quote_brute(PGN.nspname) || '.' ||
			@NAMESPACE@.slon_quote_brute(PGC.relname) as tab_fqname
		into v_tab_oid, v_tab_fqname
			from @NAMESPACE@.sl_table T,   
				"pg_catalog".pg_class PGC, "pg_catalog".pg_namespace PGN
				where T.tab_id = p_tab_id
				and T.tab_reloid = PGC.oid
				and PGC.relnamespace = PGN.oid;
	if not found then
		raise exception 'Table with ID % not found in sl_table', p_tab_id;
	end if;

	-- ----
	-- Try using truncate to empty the table and fallback to
	-- delete on error.
	-- ----
	perform @NAMESPACE@.TruncateOnlyTable(v_tab_fqname);
	raise notice 'truncate of % succeeded', v_tab_fqname;
	-- ----
	-- Setting pg_class.relhasindex to false will cause copy not to
	-- maintain any indexes. At the end of the copy we will reenable
	-- them and reindex the table. This bulk creating of indexes is
	-- faster.
	-- ----
	update pg_class set relhasindex = 'f' where oid = v_tab_oid;

	return 1;
	exception when others then
		raise notice 'truncate of % failed - doing delete', v_tab_fqname;
		update pg_class set relhasindex = 'f' where oid = v_tab_oid;
		execute 'delete from only ' || @NAMESPACE@.slon_quote_input(v_tab_fqname);
		return 0;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.prepareTableForCopy(int4) is
'Delete all data and suppress index maintenance';

-- ----------------------------------------------------------------------
-- FUNCTION finishTableAfterCopy(tab_id)
--
--	Reenable index maintenance and reindex the table after COPY.
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.finishTableAfterCopy(int4)
returns int4
as $$
declare
	p_tab_id		alias for $1;
	v_tab_oid		oid;
	v_tab_fqname	text;
begin
	-- ----
	-- Get the tables OID and fully qualified name
	-- ---
	select	PGC.oid,
			@NAMESPACE@.slon_quote_brute(PGN.nspname) || '.' ||
			@NAMESPACE@.slon_quote_brute(PGC.relname) as tab_fqname
		into v_tab_oid, v_tab_fqname
			from @NAMESPACE@.sl_table T,   
				"pg_catalog".pg_class PGC, "pg_catalog".pg_namespace PGN
				where T.tab_id = p_tab_id
				and T.tab_reloid = PGC.oid
				and PGC.relnamespace = PGN.oid;
	if not found then
		raise exception 'Table with ID % not found in sl_table', p_tab_id;
	end if;

	-- ----
	-- Reenable indexes and reindex the table.
	-- ----
	update pg_class set relhasindex = 't' where oid = v_tab_oid;
	execute 'reindex table ' || @NAMESPACE@.slon_quote_input(v_tab_fqname);

	return 1;
end;
$$ language plpgsql;

comment on function @NAMESPACE@.finishTableAfterCopy(int4) is
'Reenable index maintenance and reindex the table';

create or replace function @NAMESPACE@.setup_vactables_type () returns integer as $$
begin
	if not exists (select 1 from pg_catalog.pg_type t, pg_catalog.pg_namespace n
			where n.nspname = '_@CLUSTERNAME@' and t.typnamespace = n.oid and
			t.typname = 'vactables') then
		execute 'create type @NAMESPACE@.vactables as (nspname name, relname name);';
	end if;
	return 1;
end
$$ language plpgsql;

comment on function @NAMESPACE@.setup_vactables_type () is 
'Function to be run as part of loading slony1_funcs.sql that creates the vactables type if it is missing';

select @NAMESPACE@.setup_vactables_type();

drop function @NAMESPACE@.setup_vactables_type ();

-- ----------------------------------------------------------------------
-- FUNCTION TablesToVacuum()
--
--	Make function be STRICT
-- ----------------------------------------------------------------------
create or replace function @NAMESPACE@.TablesToVacuum () returns setof @NAMESPACE@.vactables as $$
declare
	prec @NAMESPACE@.vactables%rowtype;
begin
	prec.nspname := '_@CLUSTERNAME@';
	prec.relname := 'sl_event';
	if @NAMESPACE@.ShouldSlonyVacuumTable(prec.nspname, prec.relname) then
		return next prec;
	end if;
	prec.nspname := '_@CLUSTERNAME@';
	prec.relname := 'sl_confirm';
	if @NAMESPACE@.ShouldSlonyVacuumTable(prec.nspname, prec.relname) then
		return next prec;
	end if;
	prec.nspname := '_@CLUSTERNAME@';
	prec.relname := 'sl_setsync';
	if @NAMESPACE@.ShouldSlonyVacuumTable(prec.nspname, prec.relname) then
		return next prec;
	end if;
	prec.nspname := '_@CLUSTERNAME@';
	prec.relname := 'sl_seqlog';
	if @NAMESPACE@.ShouldSlonyVacuumTable(prec.nspname, prec.relname) then
		return next prec;
	end if;
	prec.nspname := '_@CLUSTERNAME@';
	prec.relname := 'sl_archive_counter';
	if @NAMESPACE@.ShouldSlonyVacuumTable(prec.nspname, prec.relname) then
		return next prec;
	end if;
	prec.nspname := 'pg_catalog';
	prec.relname := 'pg_listener';
	if @NAMESPACE@.ShouldSlonyVacuumTable(prec.nspname, prec.relname) then
		return next prec;
	end if;
	prec.nspname := 'pg_catalog';
	prec.relname := 'pg_statistic';
	if @NAMESPACE@.ShouldSlonyVacuumTable(prec.nspname, prec.relname) then
		return next prec;
	end if;

   return;
end
$$ language plpgsql;

comment on function @NAMESPACE@.TablesToVacuum () is 
'Return a list of tables that require frequent vacuuming.  The
function is used so that the list is not hardcoded into C code.';

-- -------------------------------------------------------------------------
-- FUNCTION add_empty_table_to_replication (set_id, tab_id, tab_nspname,
--         tab_tabname, tab_idxname, tab_comment)
-- -------------------------------------------------------------------------
create or replace function @NAMESPACE@.add_empty_table_to_replication(int4, int4, text, text, text, text) returns bigint as $$
declare
  p_set_id alias for $1;
  p_tab_id alias for $2;
  p_nspname alias for $3;
  p_tabname alias for $4;
  p_idxname alias for $5;
  p_comment alias for $6;

  prec record;
  v_origin int4;
  v_isorigin boolean;
  v_fqname text;
  v_query text;
  v_rows integer;
  v_idxname text;

begin
-- Need to validate that the set exists; the set will tell us if this is the origin
  select set_origin into v_origin from @NAMESPACE@.sl_set where set_id = p_set_id;
  if not found then
	raise exception 'add_empty_table_to_replication: set % not found!', p_set_id;
  end if;

-- Need to be aware of whether or not this node is origin for the set
   v_isorigin := ( v_origin = @NAMESPACE@.getLocalNodeId('_@CLUSTERNAME@') );

   v_fqname := '"' || p_nspname || '"."' || p_tabname || '"';
-- Take out a lock on the table
   v_query := 'lock ' || v_fqname || ';';
   execute v_query;

   if v_isorigin then
	-- On the origin, verify that the table is empty, failing if it has any tuples
        v_query := 'select 1 as tuple from ' || v_fqname || ' limit 1;';
	execute v_query into prec;
        GET DIAGNOSTICS v_rows = ROW_COUNT;
	if v_rows = 0 then
		raise notice 'add_empty_table_to_replication: table % empty on origin - OK', v_fqname;
	else
		raise exception 'add_empty_table_to_replication: table % contained tuples on origin node %', v_fqname, v_origin;
	end if;
   else
	-- On other nodes, TRUNCATE the table
        v_query := 'truncate ' || v_fqname || ';';
	execute v_query;
   end if;
-- If p_idxname is NULL, then look up the PK index, and RAISE EXCEPTION if one does not exist
   if p_idxname is NULL then
	select c2.relname into prec from pg_catalog.pg_index i, pg_catalog.pg_class c1, pg_catalog.pg_class c2, pg_catalog.pg_namespace n where i.indrelid = c1.oid and i.indexrelid = c2.oid and c1.relname = p_tabname and i.indisprimary and n.nspname = p_nspname and n.oid = c1.relnamespace;
	if not found then
		raise exception 'add_empty_table_to_replication: table % has no primary key and no candidate specified!', v_fqname;
	else
		v_idxname := prec.relname;
	end if;
   else
	v_idxname := p_idxname;
   end if;
   return @NAMESPACE@.setAddTable_int(p_set_id, p_tab_id, v_fqname, v_idxname, p_comment);
end
$$ language plpgsql;

comment on function @NAMESPACE@.add_empty_table_to_replication(int4, int4, text, text, text, text) is
'Verify that a table is empty, and add it to replication.  
tab_idxname is optional - if NULL, then we use the primary key.';

-- -------------------------------------------------------------------------
-- FUNCTION replicate_partition (tab_id, tab_nspname, tab_tabname,
--         tab_idxname, tab_comment)
-- -------------------------------------------------------------------------
create or replace function @NAMESPACE@.replicate_partition(int4, text, text, text, text) returns bigint as $$
declare
  p_tab_id alias for $1;
  p_nspname alias for $2;
  p_tabname alias for $3;
  p_idxname alias for $4;
  p_comment alias for $5;

  prec record;
  prec2 record;
  v_set_id int4;

begin
-- Look up the parent table; fail if it does not exist
   select c1.oid into prec from pg_catalog.pg_class c1, pg_catalog.pg_class c2, pg_catalog.pg_inherits i, pg_catalog.pg_namespace n where c1.oid = i.inhparent  and c2.oid = i.inhrelid and n.oid = c2.relnamespace and n.nspname = p_nspname and c2.relname = p_tabname;
   if not found then
	raise exception 'replicate_partition: No parent table found for %.%!', p_nspname, p_tabname;
   end if;

-- The parent table tells us what replication set to use
   select tab_set into prec2 from @NAMESPACE@.sl_table where tab_reloid = prec.oid;
   if not found then
	raise exception 'replicate_partition: Parent table % for new partition %.% is not replicated!', prec.oid, p_nspname, p_tabname;
   end if;

   v_set_id := prec2.tab_set;

-- Now, we have all the parameters necessary to run add_empty_table_to_replication...
   return @NAMESPACE@.add_empty_table_to_replication(v_set_id, p_tab_id, p_nspname, p_tabname, p_idxname, p_comment);
end
$$ language plpgsql;

comment on function @NAMESPACE@.replicate_partition(int4, text, text, text, text) is
'Add a partition table to replication.
tab_idxname is optional - if NULL, then we use the primary key.
This function looks up replication configuration via the parent table.';

create or replace function @NAMESPACE@.reshapeSubscription (int4, int4, int4) returns int4 as $$
declare
	p_sub_set			alias for $1;
	p_sub_provider		alias for $2;
	p_sub_receiver		alias for $3;
begin
	-- ----
	-- Grab the central configuration lock
	-- ----
	lock table @NAMESPACE@.sl_config_lock;

	update @NAMESPACE@.sl_subscribe set sub_provider=p_sub_provider
		   WHERE sub_set=p_sub_set AND sub_receiver=p_sub_receiver;
	if found then
	   perform @NAMESPACE@.RebuildListenEntries();
	   notify "_@CLUSTERNAME@_Restart";
	end if;
	return 0;
end
$$ language plpgsql;

comment on function @NAMESPACE@.reshapeSubscription(int4,int4,int4) is
'Run on a receiver/subscriber node when the provider for that
subscription is being changed.  Slonik will invoke this method
before the SUBSCRIBE_SET event propogates to the receiver
so listen paths can be updated.';