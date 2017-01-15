##DZ_SWAGGER_VERS
The version table contains a record of each version in DZ_SWAGGER.  If you are not interested in multiple versions, just enter a single record as TRUNK and use that version id for all your data elements.

|||
|----------|------------------------------------------------------------------------------------------------------|
|VERSIONID|The version identifier may be any value of your choosing though I use TRUNK and SAMPLE as examples.|
|IS_DEFAULT|TRUE/FALSE flag not currently utilized.|
|VERSION_OWNER|Free text for data management purposes, not used by the logic.|
|VERSION_CREATED|Free date for data management purposes, not used by the logic.|
|VERSION_NOTES|Free text for data management purposes, not used by the logic.|

##DZ_SWAGGER_HEAD
The head table contains all the information defining a swagger specification header.  If you will only ever produce a single specification then you only ever need one head record.

|||
|----------|------------------------------------------------------------------------------------------------------|
|HEADER_ID|The header identifier may be any value of your choosing.|
|INFO_TITLE|[Swagger Info Object](http://swagger.io/specification/#info-object-17) **title**|
|INFO_DESCRIPTION|[Swagger Info Object](http://swagger.io/specification/#info-object-17) **description**|
|INFO_TERMSOFSERVICE|[Swagger Info Object](http://swagger.io/specification/#info-object-17) **termsOfService**|
|INFO_CONTACT_NAME|[Swagger Contact Object](http://swagger.io/specification/#contactObject) **name**|
|INFO_CONTACT_URL|[Swagger Contact Object](http://swagger.io/specification/#contactObject) **url**|
|INFO_CONTACT_EMAIL|[Swagger Contact Object](http://swagger.io/specification/#contactObject) **email**|
|INFO_LICENSE_NAME|[Swagger License Object](http://swagger.io/specification/#license-object-25) **name**|
|INFO_LICENSE_URL|[Swagger License Object](http://swagger.io/specification/#license-object-25) **url**|
|INFO_VERSION|[Swagger Info Object](http://swagger.io/specification/#info-object-17) **version**|
|SWAGGER_HOST|[Swagger Object](http://swagger.io/specification/#swagger-object-14) **host**|
|SWAGGER_BASEPATH|[Swagger Object](http://swagger.io/specification/#swagger-object-14) **basePath**|
|SCHEMES_HTTPS|TRUE/FALSE flag whether to provide "https" in the schemes element|
|CONSUMES_JSON|TRUE/FALSE flag whether to provide "application/json" in the consumes element|
|CONSUMES_XML|TRUE/FALSE flag  whether to provide "text/xml" in the consumes element|
|PRODUCES_JSON|TRUE/FALSE flag  whether to provide "application/json" in the produces element|
|PRODUCES_XML|TRUE/FALSE flag  whether to provide "text/xml" in the produces element|
|INFO_DESC_UPDATED|Free date for data management purposes, not used by the logic.|
|INFO_DESC_AUTHOR|Free text for data management purposes, not used by the logic.|
|INFO_DESC_NOTES|Free text for data management purposes, not used by the logic.|
|VERSIONID||

##DZ_SWAGGER_PATH

|||
|----------|------------------------------------------------------------------------------------------------------|
|PATH_GROUP_ID|The path group identifier may be any value of your choosing.|
|SWAGGER_PATH||
|SWAGGER_HTTP_METHOD||
|PATH_SUMMARY||
|PATH_DESCRIPTION||
|PATH_ORDER||
|OBJECT_OWNER||
|OBJECT_NAME||
|PROCEDURE_NAME||
|OBJECT_OVERLORD||
|PATH_DESC_UPDATED||
|PATH_DESC_AUTHOR||
|PATH_DESC_NOTES||
|VERSIONID||

##DZ_SWAGGER_PATH_TAGS

|||
|----------|------------------------------------------------------------------------------------------------------|
|SWAGGER_PATH||
|SWAGGER_HTTP_METHOD||
|SWAGGER_TAG||
|VERSIONID||

##DZ_SWAGGER_PATH_PARM

|||
|----------|------------------------------------------------------------------------------------------------------|
|SWAGGER_PATH||
|SWAGGER_HTTP_METHOD||
|SWAGGER_PARM_ID||
|PATH_PARAM_SORT||
|VERSIONID||

##DZ_SWAGGER_PARM

|||
|----------|------------------------------------------------------------------------------------------------------|
|SWAGGER_PARM_ID||
|SWAGGER_PARM||
|PARM_DESCRIPTION||
|PARM_TYPE||
|PARM_DEFAULT_STRING||
|PARM_DEFAULT_NUMBER||
|PARM_REQUIRED||
|PARM_UNDOCUMENTED||
|PARAM_SORT||
|PARM_DESC_UPDATED||
|PARM_DESC_AUTHOR||
|PARM_DESC_NOTES||
|VERSIONID||

##DZ_SWAGGER_PARM_ENUM

|||
|----------|------------------------------------------------------------------------------------------------------|
|SWAGGER_PARM_ID||
|ENUM_VALUE_STRING||
|ENUM_VALUE_NUMBER||
|ENUM_VALUE_ORDER||
|VERSIONID||

##DZ_SWAGGER_RESP

|||
|----------|------------------------------------------------------------------------------------------------------|
|SWAGGER_PATH||
|SWAGGER_HTTP_METHOD||
|SWAGGER_RESPONSE||
|RESPONSE_SCHEMA_DEF||
|RESPONSE_SCHEMA_TYPE||
|RESPONSE_DESCRIPTION||
|RESPONSE_DESC_UPDATED||
|RESPONSE_DESC_AUTHOR||
|RESPONSE_DESC_NOTES||
|VERSIONID||

##DZ_SWAGGER_DEFINITION

|||
|----------|------------------------------------------------------------------------------------------------------|
|DEFINITION||
|DEFINITION_TYPE||
|DEFINITION_XML_NAME||
|DEFINITION_DESC||
|DEFINITION_DESC_UPDATED||
|DEFINITION_DESC_AUTHOR||
|DEFINITION_DESC_NOTES||
|TABLE_OWNER||
|TABLE_NAME||
|TABLE_MAPPING||
|VERSIONID||

##DZ_SWAGGER_DEF_PROP

|||
|----------|------------------------------------------------------------------------------------------------------|
|DEFINITION||
|DEFINITION_TYPE||
|PROPERTY_ID||
|PROPERTY_ORDER||
|COLUMN_NAME||
|VERSIONID||

##DZ_SWAGGER_PROPERTY

|||
|----------|------------------------------------------------------------------------------------------------------|
|PROPERTY_ID||
|PROPERTY||
|PROPERTY_TYPE||
|PROPERTY_REFERENCE||
|PROPERTY_FORMAT||
|PROPERTY_TITLE||
|PROPERTY_EXP_STRING||
|PROPERTY_EXP_NUMBER||
|PROPERTY_DESCRIPTION||
|PROPERTY_DESC_UPDATED||
|PROPERTY_DESC_AUTHOR||
|PROPERTY_DESC_NOTES||
|VERSIONID||

##DZ_SWAGGER_CONDENSE

|||
|----------|------------------------------------------------------------------------------------------------------|
|CONDENSE_KEY||
|CONDENSE_VALUE||
|VERSIONID||

