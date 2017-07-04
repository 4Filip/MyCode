/*Blitz*/
EXEC sp_Blitz @Help = 1							-- FK Get all info about proc
EXEC sp_Blitz @ignorePrioritiesAbove = 50		-- FK Brent runs ...
EXEC sp_Blitz @CheckUserDatabaseObjects = 0		-- FK when you don't control what is in database
EXEC sp_Blitz @OutputDatabaseName = 'DBATools', @outputschemaname = 'db', @outputTableName = 'BlitzResults'

EXEC sp_Blitz @SkipChecksDatabase = 'DBAtools', @SkipChecksSchema = 'dbo', @SkipChecksTable = 'BlitzChecksToSkip'; 
			USE DBAtools;
			GO
			CREATE TABLE dbo.BlitzChecksToSkip (ServerName NVARCHAR(128), DatabaseName NVARCHAR(128), CheckID INT);
			/* This example skips all checks on the server named Skippy: */
			INSERT INTO dbo.BlitzChecksToSkip 
			  (ServerName, DatabaseName, CheckID)
			  VALUES('Skippy', NULL, NULL);
			GO
			/* This example skips all checks on the database named HorribleDB: */
			INSERT INTO dbo.BlitzChecksToSkip 
			  (ServerName, DatabaseName, CheckID)
			  VALUES(NULL, 'HorribleDB', NULL);
			GO
			/* This example skips check #42 on all servers, all databases: */
			INSERT INTO dbo.BlitzChecksToSkip 
			  (ServerName, DatabaseName, CheckID)
			  VALUES(NULL, NULL, 42);
			GO

	-- Original
	EXEC sp_Blitz @CheckUserDatabaseObjects = 1, @CheckServerInfo = 1
	EXEC sp_Blitz @CheckUserDatabaseObjects = 1, @CheckServerInfo = 1, @OutputDatabaseName = 'ChangeMe', @OutputSchemaName = 'dbo', @OutputTableName = 'Blitz'

/*BlitzCache*/
-- Performace tunning
-- sp_BlitzCache®: Find Your Worst-Performing Queries

You have a SQL Server and you’re not sure which queries are causing your biggest performance problems. You don’t know where to start or if there are hidden queries that are making your main queries slower.

You want a fast tool to find the worst queries in the SQL Server plan cache, tell you why they’re bad, and even tell you what you can do about them.
EXEC sp_BlitzCache @Help = 1
EXEC sp_BlitzCache @SortOrder = 'all'
EXEC sp_BlitzCache @SortOrder = 'all avg'	-- 'reads', cpu, duration, xpm, memory grant, recent compilations
EXEC sp_BlitzCache @SortOrder = 'reads', @Top = 50
EXEC sp_BlitzCache @ExpertMode = 1
EXEC sp_BlitzCache @DatabaseName = 'ChangeMe'		-- FK
EXEC sp_BlitzCache @MinimumExecutionCount = 10
EXEC sp_BlitzCache @OutputDatabaseName = 'ChangeMe', @OutputSchemaName = 'dbo', @OutputTableName = 'BlitzCache'
EXEC sp_BlitzCache @OutputDatabaseName = 'DBAtools', @SkipChecksSchema = 'dbo', @OutputTableName = 'BlitzCacheResults'; 

	--Common sp_BlitzCache parameters
	--@SortOrder – find the worst queries sorted by reads, CPU, duration, executions, memory grant, or recent compilations. Just use sp_BlitzCache @SortOrder = ‘reads’ for example.
	--@Top – by default, we only look at the top 10 queries, but you can use a larger number here like @Top = 50. Just know that the more queries you analyze, the slower it goes.
	--@ExpertMode = 1 – turns on the more-detailed analysis of things like memory grants. (Some of this information is only available in current SP/CUs of SQL Server 2012/2014, and all 2016.)
	--@ExportToExcel = 1 – excludes result set columns that would make Excel blow chunks when you copy/paste the results into Excel, like the execution plans. Good for sharing the plan cache metrics with other folks on your team.
	--@Help = 1 – explains the rest of sp_BlitzCache’s parameters, plus the output columns as well.

/*BlitzFirst*/
	--Troubleshoot Slow SQL Servers. 1st Check you run!
	--I kept getting emails and phone calls that said, “The SQL Server is running slow right now, and they told me to ask Brent.” Each time, I’d have to:
	--Look at sp_who or sp_who2 or sp_WhoIsActive for blocking or long-running queries
	--Review the SQL Server Agent jobs to see if a backup, DBCC, or index maintenance job was running
	--Query wait statistics to figure out SQL Server’s current bottleneck
	--Look at Perfmon counters for CPU use, slow drive response times, or low Page Life Expectancy

EXEC sp_BlitzFirst @ExpertMode = 1
EXEC sp_BlitzFirst @Seconds = 5, @ExpertMode = 1
EXEC sp_BlitzFirst @SinceStartup = 1
EXEC sp_BlitzFirst @Seconds = 5, @ExpertMode = 1, @ShowSleepingSPIDs = 1

/*BlitzIndex*/
	--Do you have duplicate indexes wasting your storage and memory?
	--Would you like help to find unused indexes that are bloating your backups?
	--Have wide clustering keys snuck into your schema, inflating your indexes?
	--Are there active heaps lurking in your database, causing strange fragmentation?
	--Is blocking creeping up behind you before you can realize it?
	--Our free sp_BlitzIndex® stored procedure quickly does a sanity check on your database and diagnoses your indexes major disorders, 
	--	then reports back to you. Each disorder has a URL that explains what to look for and how to handle the issue.
	--sp_BlitzIndex® also saves YOUR sanity when index tuning, by giving you the option to see both the “missing” and existing indexes 
	--	for a table in a single view– when prevents you from going crazy and adding duplicate indexes.

EXEC sp_BlitzIndex @GetAllDatabases = 1, @Mode = 4
EXEC sp_BlitzIndex @DatabaseName = 'StackOverflow', @Mode = 4
EXEC sp_BlitzIndex @DatabaseName = 'ChangeMe', @Mode = 4
EXEC sp_BlitzIndex @DatabaseName = 'StackOverflow', @Mode = 4, @SkipPartitions = 0, @SkipStatistics = 0
EXEC sp_BlitzIndex @DatabaseName = 'ChangeMe', @Mode = 4, @SkipPartitions = 0, @SkipStatistics = 0

EXEC sp_BlitzIndex @GetAllDatabases = 1, @Mode = 1
EXEC sp_BlitzIndex @GetAllDatabases = 1, @Mode = 2
EXEC sp_BlitzIndex @GetAllDatabases = 1, @Mode = 3

EXEC sp_BlitzIndex @GetAllDatabases = 1, @BringThePain = 1
		-- get command for just 1 table:
		EXEC dbo.sp_BlitzIndex @DatabaseName='dpa_ignite', @SchemaName='dbo', @TableName='CONST_5';

EXEC sp_BlitzIndex @Mode = 1
EXEC sp_BlitzIndex @Mode = 2
EXEC sp_BlitzIndex @Mode = 3
EXEC sp_BlitzIndex @Mode = 4		-- just for 1 database for all details


