if object_id('tempdb..#google_ads_conversion') is not null
    drop table #google_ads_conversion
 
create table #google_ads_conversion(
[Google Click ID] varchar (2500)
,[Conversion Name] varchar (250)
,[Conversion Time] varchar (50)
,[Conversion Value] int
,[Conversion Currency] varchar(250)
,[Domain Group] varchar (250)
);

Insert into #google_ads_conversion
EXEC edw.stage.google_ads_conversions @DomainGroup = 'APFM', @start_date = NULL;

Insert into #google_ads_conversion
EXEC edw.stage.google_ads_conversions @DomainGroup = 'SA', @start_date = NULL;

Truncate table edw.stage.google_ads_conversion_flat;

INSERT Into EDW.[stage].[google_ads_conversion_flat]
(
[Google Click ID]
, [Conversion Name]
, [Conversion Time]
, [Conversion Value]
, [Conversion Currency]
, [Domain Group]
)
SELECT
[Google Click ID]
, [Conversion Name]
, CONVERT(VARCHAR(23), [Conversion Time],121)
, [Conversion Value]
, [Conversion Currency]
, [Domain Group]
From #google_ads_conversion;