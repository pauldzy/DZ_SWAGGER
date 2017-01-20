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
|INFO_DESC_UPDATED|Free date for specification management purposes, not used by the logic.|
|INFO_DESC_AUTHOR|Free text for specification management purposes, not used by the logic.|
|INFO_DESC_NOTES|Free text for specification management purposes, not used by the logic.|
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
|PATH_DESC_UPDATED|Free date for specification management purposes, not used by the logic.|
|PATH_DESC_AUTHOR|Free text for specification management purposes, not used by the logic.|
|PATH_DESC_NOTES|Free text for specification management purposes, not used by the logic.|
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
|PARM_REQUIRED|TRUE/FALSE flag to mark a [Swagger parameter](http://swagger.io/specification/#parameterObject) as required or not.|
|PARM_UNDOCUMENTED|TRUE/FALSE flag to mark a parameter as hidden from the specification output.  You may wish to leave some parameters undocumented or temporarily hidden for an amount of time.|
|PARAM_SORT|Unused at this time.|
|PARM_DESC_UPDATED|Free date for specification management purposes, not used by the logic.|
|PARM_DESC_AUTHOR|Free text for specification management purposes, not used by the logic.|
|PARM_DESC_NOTES|Free text for specification management purposes, not used by the logic.|
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
|RESPONSE_DESC_UPDATED|Free date for specification management purposes, not used by the logic.|
|RESPONSE_DESC_AUTHOR|Free text for specification management purposes, not used by the logic.|
|RESPONSE_DESC_NOTES|Free text for specification management purposes, not used by the logic.|
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
|PROPERTY_DESC_UPDATED|Free date for specification management purposes, not used by the logic.|
|PROPERTY_DESC_AUTHOR|Free text for specification management purposes, not used by the logic.|
|PROPERTY_DESC_NOTES|Free text for specification management purposes, not used by the logic.|
|VERSIONID||

##DZ_SWAGGER_CONDENSE
The condense table is provided to optionally allow definition identifiers to be altered in the output specification.  Essentially its quite difficult with complex specifications to name all your definitions as short UUIDs or obscure small keywords.  You almost always want to tag your objects with indications of the depth and heredity of the object.  E.g. this one is root.grandparent.mom.son.type and that one is root.grandparent.uncle.type.  Otherwise keeping track of things is rather difficult.  However you may not want this detail in the specification (though you might).  You can optionally add regex replaces in this table to condense or alter your key names however you like.   

|||
|----------|------------------------------------------------------------------------------------------------------|
|CONDENSE_KEY|regex expression to find in definition output|
|CONDENSE_VALUE|value to use in place of the regex match|
|VERSIONID||

