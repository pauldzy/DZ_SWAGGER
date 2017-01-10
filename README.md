# EPA-DZ_SWAGGER
PLSQL module for the creation, storage and production of Open API service definitions

Oracle mod_plsql and APEX allow for the exposure as services of as many parameters and data elements that you have procedures and tables to produce.  A complex dataset may generates hundreds - even thousands - of often changing inputs and outputs for which users must track and comprehend to consume the service.  Using the OpenAPI (Swagger) specification, service details may be documented and published using JSON or YAML documents.  However managing and generating YAML documentation may be a large undertaking when the underlying services are ever expanding and ever changing.  As a new service comes online it may use most of the components of existing services.  This then leads to copy-and-paste nightmares as common elements are updated in one specification and not in others.  

Generally the solution is something along the lines of [SwaggerHub](https://app.swaggerhub.com) which provides a solid and powerful platform for managing and publishing specifications.  However, it still can be challenging when a universe of swagger elements needs to be sliced and diced on the fly into different specifications with some elements in common and other separate.

Furthermore as mod_plsql derives from Oracle procedures and Oracle tables, ideally it would be swell if we could audit procedure parameters against swagger parameters and table columns against swagger definition properties to detect changes.  The long and short is that we then need to store the swagger elements in the database and then build the swagger definition on the fly.  So that is really what DZ_SWAGGER is: a system to store Swagger elements in Oracle, build specifications in JSON or YAML, and optionally do audits fof the specification against Oracle resources.  

DZ_SWAGGER is thus a set of tabular resources to store Swagger elements and a set of logic to generate Swagger specifications from the table.  
