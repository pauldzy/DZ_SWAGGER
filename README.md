# DZ_SWAGGER
PLSQL module for the creation, storage and production of Open API service definitions.

Oracle mod_plsql and APEX allow for the exposure as services of as many parameters and data elements that you have procedures and tables to produce.  A complex dataset may generates hundreds - even thousands - of often changing inputs and outputs for which users must track and comprehend to consume the service.  Using the [OpenAPI (Swagger) specification](http://swagger.io/specification), service details may be documented and published using JSON or YAML documents.  However managing and generating such documentation may be a large undertaking when the underlying services are ever-expanding and ever-changing.  As a new service comes online it may use some or even most of the components of existing services.  This then leads to copy-and-paste nightmares as common elements are updated in one specification and not in others.

Generally the approach is something along the lines of [SwaggerHub](https://app.swaggerhub.com) which provides a solid and powerful platform for managing, versioning and publishing specifications.  However, it still can be challenging when a universe of swagger elements needs to be sliced and diced on the fly into different specifications with some elements in common and other separate.

Furthermore as mod_plsql derives from Oracle procedures and Oracle tables, ideally it would be swell if we could audit procedure parameters against swagger parameters and table columns against swagger definition properties to detect changes.  One solution would be to store the swagger elements in the database and then build the swagger definition on the fly.  So that is really what DZ_SWAGGER is - a system to store Swagger elements in Oracle, build specifications in JSON or YAML, and optionally do audits of the specifications against Oracle resources.  

DZ_SWAGGER is thus a set of tabular resources to store Swagger elements and a set of logic to generate Swagger specifications from the table.  The one item missing is the logic to take an existing Swagger specification and unload it into the tables.  You can see a partial implementation in the maint package.  Essentially the new JSON parsing features of 12cR1 are fairly worthless.  Perhaps 12cR2 will fix these issues.

## Sample Data
A [sample dataset](https://github.com/pauldzy/DZ_SWAGGER/blob/master/Actions/SAMPLE_DATASET.sql) is provided for evaluation purposes.  This data is not part of the deployment script and thus optional. The sample data uses a version id of SAMPLE.

## Usage
DZ_SWAGGER uses Oracle types to encapsulate the serialization logic.  As these are database types they may be invoked directly from SQL.  The top level type is DZ_SWAGGER_TYP and almost certainly where you'd want to tie into your specification handling.  To simply fetch all elements of my sample dataset as a single unified definition:

```
SELECT dz_swagger_typ(
    p_header_id => 'WATERS'
   ,p_versionid => 'SAMPLE'
).toJSON() 
FROM dual;
```
or to produce pretty printed JSON
```
SELECT dz_swagger_typ(
    p_header_id => 'WATERS'
   ,p_versionid => 'SAMPLE'
).toJSON(
   p_pretty_print => 0
) 
FROM dual;
```
==> [output](json.txt)

or if YAML is desired
```
SELECT dz_swagger_typ(
    p_header_id => 'WATERS'
   ,p_versionid => 'SAMPLE'
).toYAML() 
FROM dual;
```
==> [output](yaml.txt)

## Data Model
![Entity Relationship](ERD.png)

See [detailed table definitions](DEFS.md) for more information on fields and their usage.

## JSON Schema Extension
As Swagger properties are a superset of JSON Schema, one would think flipping between and Swagger and JSON Schema **should** be pretty simple.  However there is really nothing out there for doing the swap nor guidance for the swap.  As its mostly a matter of removing Swagger elements from the definition output, I've included logic to output JSON Schema by endpoint and method:

```
SELECT dz_swagger_jsonsch_typ(
    p_swagger_path        => '/NavigationServiceGeoJSON'
   ,p_swagger_http_method => 'get'
   ,p_swagger_method      => '200'
   ,p_versionid           => 'SAMPLE'
).toJSON(0)
FROM dual;
```
==> [output](jsonschema.txt)

## Loading Existing Swagger Specifications into DZ_SWAGGER
As mentioned above the only workflow to add a specification to DZ_SWAGGER is to load each table with the needed elements by hand.  As this involves understanding the data model and quite a bit of up-front work you may not find DZ_SWAGGER of much utility.  I continue to ponder ideas of how to unload existing specifications into Oracle.  I am always interested in your suggestions. 

## Installation
DZ_SWAGGER is dependent on the [DZ_JSON](https://github.com/pauldzy/DZ_JSON) module.  The host schema needs to have CREATE VIEW permissions and storage permissions on a tablespace.  Having read and write permissions on a directory object is helpful for backup purposes but not required.  First install DZ_JSON and then secondly install DZ_SWAGGER.  DZ_SWAGGER tables will be created if they do not already exist.  Generally the assumption is you manage the specification with the host schema and generate the specifications using any schema (via AUTHID CURRENT_USER).

## Collaboration
Forks and pulls are **most** welcome.  The deployment script and deployment documentation files in the repository root are generated by my [build system](https://github.com/pauldzy/Speculative_PLSQL_CI) which obviously you do not have.  You can just ignore those files and when I merge your pulls my system will autogenerate updated files for GitHub.


