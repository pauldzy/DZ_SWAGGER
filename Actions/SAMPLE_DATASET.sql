/* DZ_SWAGGER_VERS */
Insert into DZ_SWAGGER_VERS
   (versionid, is_default, version_owner, version_created, version_notes)
 Values
   ('SAMPLE', 'TRUE', 'WATERS', TO_DATE('1/7/2017', 'MM/DD/YYYY'), 'Sample Dataset');
COMMIT;
/* DZ_SWAGGER_PROPERTY */
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.interests', 'interests', 'array', 'UpstreamDownstreamSearchV3.Service.program_attributes_frspub.interests', 'TRUE', 
    'Interests', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('GeoJSON.bbox', 'bbox', 'array', 'number', 'TRUE', 
    'GeoJSON Bbox', 'GeoJSON bounding box array.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('Navigation20.Service.data', 'data', 'reference', 'Navigation20.Service.data', 'TRUE', 
    'Results', 'Service payload containing the results of a successful request.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('PointIndexing.Service.data', 'data', 'reference', 'PointIndexing.Service.data', 'TRUE', 
    'Results', 'Service payload containing the results of a successful request.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('PointIndexing.Service.end_point', 'end_point', 'reference', 'GeoJSON.feature', 'TRUE', 
    'End Snap Point', 'Service payload containing the results of a successful request.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('PointIndexing.Service.start_point', 'start_point', 'reference', 'GeoJSON.feature', 'TRUE', 
    'End Snap Point', 'Service payload containing the results of a successful request.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('PointIndexing.Service.indexing_line', 'indexing_line', 'reference', 'GeoJSON.feature', 'TRUE', 
    'End Snap Point', 'Service payload containing the results of a successful request.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('PointIndexing.Service.flowlines', 'flowlines', 'reference', 'PointIndexing.Service.flowlines', 'TRUE', 
    'End Snap Point', 'Service payload containing the results of a successful request.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('PointIndexing.Service.flowlines.features', 'features', 'array', 'PointIndexing.Service.flowlines.features', 'TRUE', 
    'End Snap Point', 'Service payload containing the results of a successful request.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'properties', 'reference', 'PointIndexing.Service.flowlines.properties', 'TRUE', 
    'Properties', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('catchment_featureid', 'catchment_featureid', 'integer', 'TRUE', 'Catchment Feature ID', 
    'Identifier of the NHDPlus catchment with which the feature is associated.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('reporting_year', 'reporting_year', 'string', 'TRUE', 'Reporting Year', 
    'TRI environmental medium reporting year.  Current reporting year is 2015.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('environmental_medium', 'environmental_medium', 'string', 'TRUE', 'Environmental Medium', 
    'TRI environmental medium code value.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.medium', 'medium', 'array', 'UpstreamDownstreamSearchV3.Service.program_attributes_frspub.medium', 'TRUE', 
    'TRI Environmental Medium', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('indexing_line_length', 'indexing_line_length', 'number', 'TRUE', 'Indexing Line Length (km)', 
    'Length of the indexing path in kilometers.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('snap_measure', 'snap_measure', 'number', 'TRUE', 'Snap Measure', 
    'The LRS measure on flowline of indexing end point.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('snap_distancekm', 'snap_distancekm', 'number', 'TRUE', 'Snap Length (km)', 
    'Length of the indexing path in kilometers.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('flowdir', 'flowdir', 'integer', 'TRUE', 'Flow Direction Flag', 
    'Integer flag indicating if flowline feature has directed flow (1) or not (0).', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('resolution', 'resolution', 'integer', 'TRUE', 'Resolution Indicator Flag', 
    'Integer flag indicating if the flowline represents Local (1), High (2) or Medium (3) NHD features.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_format, property_allow_null, 
    property_title, property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('fdate', 'fdate', 'string', 'date-time', 'TRUE', 
    'Feature Date', 'Date indicating the vintage of the source NHD feature.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('streamlevel', 'streamlevel', 'integer', 'TRUE', 'Stream Level', 
    'StreamLevel is a numeric code that traces main paths of water flow upstream through the drainage network.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('streamorder', 'streamorder', 'integer', 'TRUE', 'Stream Order', 
    'StreamOrder order in NHDPlus is a modified version of stream order as defined by Strahler. The Strahler stream order algorithm does not account for flow splits in the network. The NHDPlus algorithm for stream order does take flow splits into consideration.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('wbarea_fcode', 'wbarea_fcode', 'integer', 'TRUE', 'Waterbody/Area Feature Code', 
    'Feature code of the waterbody/area associated with artificial path flowlines.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('wbarea_ftype', 'wbarea_ftype', 'integer', 'TRUE', 'Waterbody/Area Feature Type', 
    'Feature type of the waterbody/area associated with artificial path flowlines.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.sic_codes', 'sic_codes', 'array', 'UpstreamDownstreamSearchV3.Service.program_attributes_frspub.sic_codes', 'TRUE', 
    'SIC Codes', 'FRS SIC codes.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('active_status', 'active_status', 'string', 'TRUE', 'Active Status', 
    'FRS Interest active status.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('interest_type', 'interest_type', 'string', 'TRUE', 'Environmental Interest Type', 
    'The environmental permit or regulatory program that applies to the facility site (e.g., TRI Reporter, NPDES Major, Air Stationary Source Major, Hazardous Waste TSD, Hazardous Waste LQG, Superfund NPL)', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('sic_code', 'sic_code', 'string', 'TRUE', 'SIC Code Identifier', 
    'The code that represents the economic activity of a company (four-digits).', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('sic_description', 'sic_description', 'string', 'TRUE', 'SIC Code Description', 
    'The meaning of the SIC code.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('primary_indicator', 'primary_indicator', 'string', 'TRUE', 'SIC Primary Indicator', 
    'The name that indicates whether the associated SIC Code represents the primary activity occurring at the facility site. Allowable Values are ''Primary'', ''Secondary'', or ''Unknown''.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.programs', 'programs', 'array', 'UpstreamDownstreamSearchV3.Service.program_attributes_frspub.programs', 'TRUE', 
    'Programs', 'FRS program codes.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('state_code', 'state_code', 'string', 'TRUE', 'State USPS Code', 
    'The U.S. Postal Service abbreviation that represents the state or state equivalent for the U.S. and Canada.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('tribal_land_code', 'tribal_land_code', 'string', 'TRUE', 'Tribal Land Indicator Code', 
    'Code indicating whether or not the facility site is located on tribal land.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('tribal_land_name', 'tribal_land_name', 'string', 'TRUE', 'Tribal Land Name', 
    'The name of the Tribal Reservation, statistical area, or Public Domain Allotment.  If the tribal entity has no land base, the name of the tribal entity is used as the Tribal Land Name. Examples: Colorado River Indian Reservation, Ponca Tribal Designated Statistical Area, Wampanoag Tribe of Gay Head (Aquinnah) of Massachusetts.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('pgm_sys_acrnm', 'pgm_sys_acrnm', 'string', 'TRUE', 'Environmental Information System Abbreviated Name', 
    'The abbreviated name that represents the name of an information management system for an environmental program.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('pgm_sys_id', 'pgm_sys_id', 'string', 'TRUE', 'Environmental Information System Identification Number', 
    'The identification number, such as the permit number, assigned by an information management system that represents a facility site, waste site, operable unit, or other feature tracked by that Environmental Information System.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('fmeasure', 'fmeasure', 'number', 'TRUE', 'From Measure', 
    'Measure along the reach, in percent from downstream end, where a linear event begins (from).', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('tmeasure', 'tmeasure', 'number', 'TRUE', 'To Measure', 
    'Measure along the reach, in percent from downstream end, where a linear event ends (to).', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('start_permanent_identifier', 'start_permanent_identifier', 'string', 'TRUE', 'Start Permanent Identifier', 
    'Permanent Identifier of the flowline from which the navigation occurs. ', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('permanent_identifier', 'permanent_identifier', 'string', 'TRUE', 'Permanent Identifier', 
    'Global unique identifier assigned to each event feature.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('start_comid', 'start_comid', 'integer', 'TRUE', 'Start ComID', 
    'NHDPlus ComID of the flowline from which the navigation occurs. ', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('comid', 'comid', 'integer', 'TRUE', 'ComID', 
    'Unique integer identifier for NHDPlus features.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('total_distancekm', 'total_distancekm', 'number', 'TRUE', 'Running Total Distance', 
    'Running distance in kilometers of the navigation from the start point to this feature.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('total_flowtimehour', 'total_flowtimehour', 'number', 'TRUE', 'Running Total Flow Time', 
    'Running flow time in hours of the navigation from the start point to this feature.  Currently nonfunctional.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('hydroseq', 'hydroseq', 'integer', 'TRUE', 'Hydrosequence ID', 
    'Hydrologic sequence number; places flowlines in hydrologic order; processing NHDFlowline features in ascending order, encounters the features from downstream to upstream; processing the NHDFlowline features in descending order, encounters the features from upstream to downstream.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('levelpathid', 'levelpathid', 'integer', 'TRUE', 'Level Path ID', 
    'Hydrologic sequence number of most downstream NHDFlowline feature in the level path.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('terminalpathid', 'terminalpathid', 'integer', 'TRUE', 'Terminal Path Identifier', 
    'Hydrologic sequence number of terminal NHDFlowline feature.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('uphydroseq', 'uphydroseq', 'integer', 'TRUE', 'Up Hydrosequence', 
    'Upstream mainstem hydrologic sequence number.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('dnhydroseq', 'dnhydroseq', 'integer', 'TRUE', 'Down Hydrosequence Identifier', 
    'Downstream mainstem hydrologic sequence number.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('pathlength', 'pathlength', 'number', 'TRUE', 'Path Length', 
    'Distance to the terminal NHDFlowline feature downstream along the main path.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('lengthkm', 'lengthkm', 'number', 'TRUE', 'Length (km)', 
    'Length of linear feature, Albers Equal Area Conic, length 8.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('pathtime', 'pathtime', 'number', 'TRUE', 'Path Time', 
    'Flow time to the terminal NHDFlowline feature downstream along the main path.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('travtime', 'travtime', 'number', 'TRUE', 'Travel Time', 
    'Travel flow time of the NHDPlus flowline.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('ftype', 'ftype', 'integer', 'TRUE', 'NHD Feature Type Identifier', 
    'Three digit integer value, unique identifier of a feature type.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('fcode', 'fcode', 'integer', 'TRUE', 'NHD Feature Code Identifier', 
    'Five-digit integer value comprised of the feature type and combinations of characteristics and values.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('gnis_id', 'gnis_id', 'string', 'TRUE', 'NHDPlus GNIS ID', 
    'Unique identifier assigned by GNIS, length 10.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('gnis_name', 'gnis_name', 'string', 'TRUE', 'NHDPlus GNIS Name', 
    'Proper name, specific term, or expression by which a particular geographic entity is known, length 65.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('wbarea_permanent_identifier', 'wbarea_permanent_identifier', 'string', 'TRUE', 'Waterbody/Area Permanent Identifier', 
    'Permanent_Identifier of the waterbody through which the Flowline (Artificial Path) flows.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('wbarea_comid', 'wbarea_comid', 'integer', 'TRUE', 'Waterbody/Area ComID', 
    'ComID of the waterbody through which the Flowline (Artificial Path) flows.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('event_lengthkm', 'event_lengthkm', 'number', 'TRUE', 'Event Length (km)', 
    'Length of the linear event in kilometers.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('event_areasqkm', 'event_areasqkm', 'number', 'TRUE', 'Event Area (sqkm)', 
    'Area of the areal event in square kilometers.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.features', 'features', 'array', 'UpstreamDownstreamSearchV3.Service.event_line_results.features', 'TRUE', 
    'Features', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.features', 'features', 'array', 'UpstreamDownstreamSearchV3.Service.event_area_results.features', 'TRUE', 
    'Features', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.features', 'features', 'array', 'UpstreamDownstreamSearchV3.Service.event_point_results.features', 'TRUE', 
    'Features', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'properties', 'reference', 'UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'TRUE', 
    'Properties', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'properties', 'reference', 'UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'TRUE', 
    'Properties', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'properties', 'reference', 'UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'TRUE', 
    'Properties', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('primary_name', 'primary_name', 'string', 'TRUE', 'Facility Site Name', 
    'The public or commercial name of a facility site (i.e., the full name that commonly appears on invoices, signs, or other business documents, or as assigned by the state when the name is ambiguous).', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('prj_seq', 'prj_seq', 'integer', 'TRUE', 'Project Identifier', 
    'System generated sequence number to uniquely reference a project record', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('pre_rgn_code', 'pre_rgn_code', 'string', 'TRUE', 'Non-point Source Project Region', 
    'The regional identifier for pre-award projects that have not been assigned to a grant.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('pre_state', 'pre_state', 'string', 'TRUE', 'Non-point Source Project State', 
    'The state identifier for pre-award projects that have not been assigned to a grant.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('prj_complete_actual_ind', 'prj_complete_actual_ind', 'string', 'TRUE', 'Project Start Actual Indicator', 
    'Indicator to signify whether the start date value represents a project that has truly started.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('prj_start_actual_ind', 'prj_start_actual_ind', 'string', 'TRUE', 'Project Start Actual Indicator', 
    'Indicator to signify whether the start date value represents a project that has truly started.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('prj_title', 'prj_title', 'string', 'TRUE', 'Project Title', 
    'A brief narrative description of the project.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('plttyp_code', 'plttyp_code', 'string', 'TRUE', 'Pollutant Type Code', 
    'A selection that indicates the type of pollutant addressed in this drainage area.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('prj_type_code', 'prj_type_code', 'string', 'TRUE', 'Project Functional Category Code', 
    'Reference value identifying the Functional Category Record.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('permit_name', 'permit_name', 'string', 'TRUE', 'NPDES Permit Name', 
    'Permit Name from ICIS permitting database.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('approp_year', 'approp_year', 'string', 'TRUE', 'Appropriation Year', 
    'Project appropriation year.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('cycle_year.ATTAINS', 'cycle_year', 'string', 'TRUE', 'ATTAINS Cycle Year', 
    'The even-numbered year associated with the list or assessment (e.g., 1996, 1998, 2000). This field is included for all entries. ', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('detailed_source_id', 'detailed_source_id', 'integer', 'TRUE', 'Detailed Source ID', 
    'Numeric ID assigned to the probable source. ', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('detailed_source_name', 'detailed_source_name', 'string', 'TRUE', 'Detailed Source Name', 
    'The name of the probable source.  This field is optional and only available for states that submit integrated data.  Blank fields indicate that the state did not report this information in their data submission. ', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('parent_source_id', 'parent_source_id', 'integer', 'TRUE', 'Parent Source ID', 
    'ID associated with the "parent" probable source. The parent probable source represents an EPA-assigned, general categorization for the specific, state-reported probable sources. This field is optional.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('parent_source_name', 'parent_source_name', 'string', 'TRUE', 'Parent Source Name', 
    'Probable source group such as ?Agriculture? or ?Hydromodification.?  The parent probable source group represents an EPA-assigned, general categorization for the specific, state-reported probable source.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('parent_cause_id', 'parent_cause_id', 'integer', 'TRUE', 'Parent Cause ID', 
    'ID associated with the "parent" impairment cause. The parent cause of impairment represents an EPA-assigned, general categorization for the specific, state-reported impairment causes. This field is included for all entries.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('event_permanent_identifier', 'event_permanent_identifier', 'string', 'TRUE', 'Event Permanent Identifier', 
    '40-char GUID value that uniquely identifies the occurrence of each event.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('water_type', 'water_type', 'string', 'TRUE', 'Water Type', 
    'A description of the type of water that the assessment unit represents.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('waterbody_type_display', 'waterbody_type_display', 'string', 'TRUE', 'Waterbody Type Display Name', 
    'Display version of water type, for use in web reports.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('statewide_ind', 'statewide_ind', 'string', 'TRUE', 'Statewide Indicator', 
    'Indicator to identify whether this project is statewide.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('nhdplus_comid', 'nhdplus_comid', 'integer', 'TRUE', 'NHDPlus ComID', 
    'An integer unique id for each NHD feature.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('nhd_gnis_id', 'nhd_gnis_id', 'string', 'TRUE', 'NHDPlus GNIS ID', 
    'Unique identifier assigned by GNIS, length 10.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('ir_status', 'ir_state', 'string', 'TRUE', 'Integrated Report State Status', 
    'Flag (Y/N) indicating whether the state data submission is integrated or a separate 303(d) and 305(b).  If a state data submission is not IR, there are certain data elements that are not available in a 303(d) submission (e.g., designated uses and probable sources).', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('measure', 'measure', 'number', 'TRUE', 'Event Measure', 
    'Measure along the reach, in percent from downstream end, where a point event is located.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('eventtype', 'eventtype', 'number', 'TRUE', 'Event Type Identifier', 
    'Domain value indicating the program for which the event has been created. See https://www.epa.gov/waterdata/rad-event-programs for values of each Reach Address Database program. ', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('geogstate', 'geogstate', 'string', 'TRUE', 'Geographic State', 
    'Abbreviation of the state where the event takes place regardless of the source originator. In most cases this will be the same as source_originator, but they may differ in cases such that tribes, state cooperators, and other non-state specific organizations manage the data. This distinction allows for both state based and management-based analysis.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_format, property_allow_null, 
    property_title, property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('end_date', 'end_date', 'string', 'date-time', 'TRUE', 
    'End Date', 'The date by which the event is considered to be closed.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('reachcode', 'reachcode', 'string', 'TRUE', 'Reach Code', 
    'Unique identifier composed of two parts. The first eight digits is the subbasin code as defined by FIPS 103. The next
six digits are randomly assigned, sequential numbers that are unique within a Cataloging Unit, length 14.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('nhd_gnis_name', 'nhd_gnis_name', 'string', 'TRUE', 'NHDPlus GNIS Name', 
    'Proper name, specific term, or expression by which a particular geographic entity is known, length 65.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('registry_id', 'registry_id', 'string', 'TRUE', 'Facility Registry Identifier', 
    'The identification number assigned by the EPA Facility Registry System to uniquely identify a facility site.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('water_type_size', 'water_type_size', 'number', 'TRUE', 'Water Type Size', 
    'Size of the assessed waterbody (e.g. miles, acres). This field is optional and not included for all entries.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('waterbody_type_group', 'waterbody_type_group', 'string', 'TRUE', 'Waterbody Type Group Name', 
    'A description of the "parent" type of water that the assessment unit represents.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('detailed_use_desc', 'detailed_use_desc', 'string', 'TRUE', 'Detailed Use Description', 
    'Water use description as defined by EPAS Water Quality Standards System.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('nhd_permanent_identifier', 'nhd_permanent_identifier', 'string', 'TRUE', 'NHDPlus Permanent Identifier', 
    'An unique identifier for each NHD feature, may be a string value of the integer ComID a global unique identifier.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('status', 'status', 'string', 'TRUE', 'Status', 
    'Service response status indicating the success or failure of the service request.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.data', 'data', 'reference', 'UpstreamDownstreamSearchV3.Service.data', 'TRUE', 
    'Results', 'Service payload containing the results of a successful request.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results', 'navigation_results', 'reference', 'UpstreamDownstreamSearchV3.Service.navigation_results', 'TRUE', 
    'Navigation Results Object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('type.FeatureCollection', 'type', 'string', 'TRUE', 'Type', 
    'GeoJSON Feature type attribute', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.features', 'features', 'array', 'UpstreamDownstreamSearchV3.Service.navigation_results.features', 'TRUE', 
    'Features', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('type.Feature', 'type', 'string', 'TRUE', 'Type', 
    'GeoJSON FeatureCollection type attribute', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('type.Geometry', 'type', 'string', 'TRUE', 'Type', 
    'GeoJSON Geometry type attribute', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('GeoJSON.geometry', 'geometry', 'reference', 'GeoJSON.geometry', 'TRUE', 
    'GeoJSON Geometry Object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('GeoJSON.coordinates', 'coordinates', 'array', 'number', 'TRUE', 
    'Coordinates', 'Array of coordinates representing the GeoJSON geometry', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('session_id', 'session_id', 'string', 'TRUE', 'Session ID', 
    'Global unique identifier for a given service request.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results', 'event_point_results', 'reference', 'UpstreamDownstreamSearchV3.Service.event_point_results', 'TRUE', 
    'Point Event Results Object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results', 'event_line_results', 'reference', 'UpstreamDownstreamSearchV3.Service.event_line_results', 'TRUE', 
    'Line Event Results Object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results', 'event_area_results', 'reference', 'UpstreamDownstreamSearchV3.Service.event_area_results', 'TRUE', 
    'Area Event Results Object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'properties', 'reference', 'UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'TRUE', 
    'Properties', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_format, property_allow_null, 
    property_title, property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('reachsmdate', 'reachsmdate', 'string', 'date-time', 'TRUE', 
    'Reach Version Date', 'Reach version date indicating the last change to the feature identified by the reach code.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('source_originator', 'source_originator', 'string', 'TRUE', 'Source Originator', 
    'Originator of the event.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('source_featureid', 'source_featureid', 'string', 'TRUE', 'Source Feature ID', 
    'Identifier of the entity used in the source data.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('source_datadesc', 'source_datadesc', 'string', 'TRUE', 'Source Data Description', 
    'Description of the entity.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('featuredetailurl', 'featuredetailurl', 'string', 'TRUE', 'Feature Detail Url Resource', 
    'URL where detailed event entity data can be found.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('cycle_year.RAD', 'cycle_year', 'string', 'TRUE', 'Event Cycle Year', 
    'Optional field indicating a year for which the event is considered to be valid. Only a subset of programs track events via cycle year.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_format, property_allow_null, 
    property_title, property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('start_date', 'start_date', 'string', 'date-time', 'TRUE', 
    'Start Date', 'The date by which the event first is considered to be valid.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('wbd_huc12', 'wbd_huc12', 'string', 'TRUE', 'Watershed Boundary Dataset HUC12 ', 
    'WBD HUC12 unit that most encompasses the feature.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('program_key', 'program_key', 'string', 'TRUE', 'Program Key', 
    'Combined unique identifier for use in systems only allowing single key table joins (e.g. Esri GIS systems).', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d', 'program_attributes_303d', 'reference', 'UpstreamDownstreamSearchV3.Service.program_attributes_303d', 'TRUE', 
    'ATTAINS 303(d) Program Attributes', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'program_attributes_grts', 'reference', 'UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'TRUE', 
    'Grants Reporting and Tracking System Program Attributes', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_npdes', 'program_attributes_npdes', 'reference', 'UpstreamDownstreamSearchV3.Service.program_attributes_npdes', 'TRUE', 
    'National Pollutant Discharge Elimination System Program Attributes', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub', 'program_attributes_frspub', 'reference', 'UpstreamDownstreamSearchV3.Service.program_attributes_frspub', 'TRUE', 
    'Facility Registration System Program Attributes', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('listed_water_id', 'listed_water_id', 'string', 'TRUE', 'Listed Water ID', 
    'Unique ID assigned to each state-listed waterbody or segment. The first two characters are the state abbreviation. The following characters are the water''s Waterbody System ID, another state-derived ID, or an arbitrary ID assigned by the state. This field is included for all entries.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('state', 'state', 'string', 'TRUE', 'State', 
    'The state abbreviation (US Postal) for the state. This field is included for all entries.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('listed_water_name', 'listed_water_name', 'string', 'TRUE', 'Listed Water Name', 
    'Water name used by the state.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('size_unit', 'size_unit', 'string', 'TRUE', 'Size Unit', 
    'The standard unit of measure to use for this water type (miles, acres, square miles).', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d.causes', 'causes', 'array', 'UpstreamDownstreamSearchV3.Service.program_attributes_303d.causes', 'TRUE', 
    'Causes', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_305b.sources', 'ir_sources', 'array', 'UpstreamDownstreamSearchV3.Service.program_attributes_305b.sources', 'TRUE', 
    'Sources', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_305b.uses', 'ir_uses', 'array', 'UpstreamDownstreamSearchV3.Service.program_attributes_305b.uses', 'TRUE', 
    'Uses', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('detailed_cause_id', 'detailed_cause_id', 'integer', 'TRUE', 'Detailed Cause ID', 
    'Numeric ID assigned to the cause of impairment.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('detailed_cause_name', 'detailed_cause_name', 'string', 'TRUE', 'Detailed Cause Name', 
    'The name of the cause of impairment. This field is included for all entries.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('parent_cause_name', 'parent_cause_name', 'string', 'TRUE', 'Parent Cause Name', 
    'Cause of impairment group name such as ''Pathogens'' or ''Sediment.''', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('detailed_use_id', 'detailed_use_id', 'integer', 'TRUE', 'Detailed Use ID', 
    'EPA unique Identifier assigned to a designated use.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('parent_use_id', 'parent_use_id', 'integer', 'TRUE', 'Parent Use ID', 
    'ID associated with the "parent" use. A parent is a higher category of at least two category levels.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('parent_use_desc', 'parent_use_desc', 'string', 'TRUE', 'Parent Use Description', 
    'Water use description as defined by EPAS Water Quality Standards System.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_target, property_allow_null, 
    property_title, property_desc_updated, property_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts.pollutants', 'pollutants', 'array', 'UpstreamDownstreamSearchV3.Service.program_attributes_grts.pollutants', 'TRUE', 
    'Pollutants', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('plttyp_name', 'plttyp_name', 'string', 'TRUE', 'Pollutant Description', 
    'Description of pollutant addressed by project.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('prj_type', 'prj_type', 'string', 'TRUE', 'Project Functional Category Description', 
    'Description of the functional category.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_format, property_allow_null, 
    property_title, property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('prj_complete_date', 'prj_complete_date', 'string', 'date-time', 'TRUE', 
    'Project End Date', 'The completion date of the project.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_format, property_allow_null, 
    property_title, property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('prj_start_date', 'prj_start_date', 'string', 'date-time', 'TRUE', 
    'Project Start Date', 'The start date of the project.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('prj_no', 'prj_no', 'string', 'TRUE', 'Project Number', 
    'Unique Identifier for a project within the assigned grant', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('grant_no', 'grant_no', 'string', 'TRUE', 'GRTS Grant Number', 
    'Reference value identifying the Grant record.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('prjdrar_seq', 'prjdrar_seq', 'integer', 'TRUE', 'Project Drainage Identifier', 
    'System generated sequence number to uniquely reference a project drainage record.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PROPERTY
   (property_id, property, property_type, property_allow_null, property_title, 
    property_description, property_desc_updated, property_desc_author, versionid)
 Values
   ('npdes_permit_nmbr', 'npdes_permit_nmbr', 'string', 'TRUE', 'NPDES Permit Number', 
    'Permit Number from ICIS permitting database.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
COMMIT;
/* DZ_SWAGGER_PATH_TAGS */
Insert into DZ_SWAGGER_PATH_TAGS
   (swagger_path, swagger_tag, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'Navigation', 'SAMPLE');
Insert into DZ_SWAGGER_PATH_TAGS
   (swagger_path, swagger_tag, versionid)
 Values
   ('/PointIndexing.ServiceGeoJSON', 'Indexing', 'SAMPLE');
Insert into DZ_SWAGGER_PATH_TAGS
   (swagger_path, swagger_tag, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'Event Discovery', 'SAMPLE');
Insert into DZ_SWAGGER_PATH_TAGS
   (swagger_path, swagger_tag, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'Navigation', 'SAMPLE');
COMMIT;
/* DZ_SWAGGER_PATH_RESP */
Insert into DZ_SWAGGER_PATH_RESP
   (swagger_path, swagger_http_method, swagger_response, response_schema_def, response_schema_type, 
    response_description, response_desc_updated, response_desc_author, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', '200', 'Navigation20.Service.root', 'object', 
    'Returns a standardized object containing a status message and a data container.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PATH_RESP
   (swagger_path, swagger_http_method, swagger_response, response_schema_def, response_schema_type, 
    response_description, response_desc_updated, response_desc_author, versionid)
 Values
   ('/PointIndexing.ServiceGeoJSON', 'get', '200', 'PointIndexing.Service.root', 'object', 
    'Returns a standardized object containing a status message and a data container.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PATH_RESP
   (swagger_path, swagger_http_method, swagger_response, response_schema_def, response_schema_type, 
    response_description, response_desc_updated, response_desc_author, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', '200', 'UpstreamDownstreamSearchV3.Service.root', 'object', 
    'Returns a standardized object containing a status message and a data container.', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
COMMIT;
/* DZ_SWAGGER_PATH_PARM */
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', 'query', 'pNavigationType', 10, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', 'query', 'pStartComID', 20, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', 'query', 'pStartPermanentIdentifier', 30, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', 'query', 'pStartReachcode', 40, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', 'query', 'pStartMeasure', 50, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', 'query', 'pStopComID', 60, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', 'query', 'pStopPermanentIdentifier', 70, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', 'query', 'pStopReachcode', 80, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', 'query', 'pStopMeasure', 90, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', 'query', 'pMaxDistanceKm', 100, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', 'query', 'pMaxFlowTimeHour', 110, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', 'query', 'optOutPrettyPrint', 120, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', 'query', 'optOutPruneNumber', 130, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', 'query', 'optJSONPCallback', 140, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', 'query', 'optCache', 150, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', 'query', 'optGEOJSONbbox', 160, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', 'query', 'callback', 170, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/PointIndexing.ServiceGeoJSON', 'get', 'query', 'pGeometry', 10, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/PointIndexing.ServiceGeoJSON', 'get', 'query', 'pGeometryMod', 20, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/PointIndexing.ServiceGeoJSON', 'get', 'query', 'pIndexingMethod', 30, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/PointIndexing.ServiceGeoJSON', 'get', 'query', 'pFcodeAllow', 40, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/PointIndexing.ServiceGeoJSON', 'get', 'query', 'pFcodeAllowMod', 50, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/PointIndexing.ServiceGeoJSON', 'get', 'query', 'pFcodeDeny', 60, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/PointIndexing.ServiceGeoJSON', 'get', 'query', 'pFcodeDenyMod', 70, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/PointIndexing.ServiceGeoJSON', 'get', 'query', 'pDistanceMaxDistKm', 80, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/PointIndexing.ServiceGeoJSON', 'get', 'query', 'pRaindropPathMaxDistKm', 90, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/PointIndexing.ServiceGeoJSON', 'get', 'query', 'pRaindropSnapMaxDistKm', 100, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/PointIndexing.ServiceGeoJSON', 'get', 'query', 'optOutPrettyPrint', 110, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/PointIndexing.ServiceGeoJSON', 'get', 'query', 'optOutPruneNumber', 120, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/PointIndexing.ServiceGeoJSON', 'get', 'query', 'optClientRef', 130, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/PointIndexing.ServiceGeoJSON', 'get', 'query', 'optJSONPCallback', 140, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pNavigationType', 10, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pStartComID', 20, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pStartPermanentIdentifier', 30, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pStartReachcode', 40, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pStartMeasure', 50, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pStopComID', 60, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pStopPermanentIdentifier', 70, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pStopReachcode', 80, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pStopMeasure', 90, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pMaxDistanceKm', 100, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pMaxFlowTimeHour', 110, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pEventTypeList', 120, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pEventTypeListMod', 130, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pArchiveCycleList', 140, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pArchiveCycleListMod', 150, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pReturnNavigationResults', 160, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pAddFlowlineAttributes', 170, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pAddFlowlineGeometry', 180, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pAddEventGeometry', 190, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'pReturnProgramAttributes', 200, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'optOutPrettyPrint', 210, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'optOutPruneNumber', 220, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'optJSONPCallback', 230, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'optCache', 240, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'optClientRef', 250, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'optGEOJSONbbox', 260, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_PARM
   (swagger_path, swagger_http_method, parameter_in_type, swagger_parm_id, path_param_sort, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', 'query', 'callback', 270, 'SAMPLE');
COMMIT;
/* DZ_SWAGGER_PATH */
Insert into DZ_SWAGGER_PATH
   (path_group_id, swagger_path, path_summary, path_description, path_order, path_desc_updated, path_desc_author, versionid)
 Values
   ('WATERS', '/Navigation20.ServiceGeoJSON', 'NHDPlus Navigation - Alternative Service', 'This service provides navigation on the NHDPlus network utilizing the Oracle network data model.', 
    20, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PATH
   (path_group_id, swagger_path, path_summary, path_description, path_order, path_desc_updated, path_desc_author, versionid)
 Values
   ('WATERS', '/PointIndexing.ServiceGeoJSON', 'NHDPlus Point Indexing', 'This service provides point indexing to NHDPlus using either distance or raindrop association.', 
    10, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PATH
   (path_group_id, swagger_path, path_summary, path_description, path_order, path_desc_updated, path_desc_author, versionid)
 Values
   ('WATERS', '/UpstreamDownstreamSearchV3.Service', 'Upstream Downstream Search V3 Service', 'This service provides navigation and discovery of Reach Address Database events on the NHDPlus network providing detailed program attributes with results.', 
    30, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
COMMIT;
/* DZ_SWAGGER_PATH_METHOD */
Insert into DZ_SWAGGER_PATH_METHOD
   (swagger_path, swagger_http_method, consumes_json, consumes_xml, consumes_form, produces_json, produces_xml, versionid)
 Values
   ('/Navigation20.ServiceGeoJSON', 'get', NULL, NULL, NULL, NULL, NULL, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_METHOD
   (swagger_path, swagger_http_method, consumes_json, consumes_xml, consumes_form, produces_json, produces_xml, versionid)
 Values
   ('/PointIndexing.ServiceGeoJSON', 'get', NULL, NULL, NULL, NULL, NULL, 'SAMPLE');
Insert into DZ_SWAGGER_PATH_METHOD
   (swagger_path, swagger_http_method, consumes_json, consumes_xml, consumes_form, produces_json, produces_xml, versionid)
 Values
   ('/UpstreamDownstreamSearchV3.Service', 'get', NULL, NULL, NULL, NULL, NULL, 'SAMPLE');
COMMIT;
/* DZ_SWAGGER_PARM_ENUM */
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('pIndexingMethod', 'DISTANCE', 10, 'SAMPLE');
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('pIndexingMethod', 'RAINDROP', 20, 'SAMPLE');
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('pNavigationType', 'UT', 10, 'SAMPLE');
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('pNavigationType', 'UM', 20, 'SAMPLE');
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('pNavigationType', 'DD', 30, 'SAMPLE');
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('pNavigationType', 'DM', 40, 'SAMPLE');
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('pNavigationType', 'PP', 50, 'SAMPLE');
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('pReturnNavigationResults', 'TRUE', 10, 'SAMPLE');
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('pReturnNavigationResults', 'FALSE', 20, 'SAMPLE');
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('pAddFlowlineAttributes', 'TRUE', 10, 'SAMPLE');
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('pAddFlowlineAttributes', 'FALSE', 20, 'SAMPLE');
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('pAddFlowlineGeometry', 'TRUE', 10, 'SAMPLE');
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('pAddFlowlineGeometry', 'FALSE', 20, 'SAMPLE');
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('pAddEventGeometry', 'TRUE', 10, 'SAMPLE');
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('pAddEventGeometry', 'FALSE', 20, 'SAMPLE');
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('pReturnProgramAttributes', 'TRUE', 10, 'SAMPLE');
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('pReturnProgramAttributes', 'FALSE', 20, 'SAMPLE');
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('optGEOJSONbbox', 'TRUE', 10, 'SAMPLE');
Insert into DZ_SWAGGER_PARM_ENUM
   (swagger_parm_id, enum_value_string, enum_value_order, versionid)
 Values
   ('optGEOJSONbbox', 'FALSE', 20, 'SAMPLE');
COMMIT;
/* DZ_SWAGGER_PARM */
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pGeometry', 'pGeometry', 'Input point geometry to index to the NHDPlus.', 'string', 'TRUE', 
    'FALSE', 10, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pGeometryMod', 'pGeometryMod', 'Modifier explaining the input geometry format.  See https://www.epa.gov/waterdata/waters-http-services for a more information on geometry format types.', 'string', 'TRUE', 
    'FALSE', 10, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pIndexingMethod', 'pIndexingMethod', 'Method to use in service call, either ''DISTANCE'' or ''RAINDROP''. Use the raindrop method with caution understanding what kind of results the method produces.', 'string', 'TRUE', 
    'FALSE', 10, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pFcodeAllow', 'pFcodeAllow', 'List of NHD FCODEs to allow when choosing an indexing destination. ', 'string', 'TRUE', 
    'FALSE', 10, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pFcodeAllowMod', 'pFcodeAllowMod', 'Modifier explaining the array format used in FcodeAllow.  Leave parameter empty accept default of comma-delimited list.', 'string', 'TRUE', 
    'FALSE', 10, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pFcodeDeny', 'pFcodeDeny', 'List of NHD FCODEs to deny when choosing an indexing destination. ', 'string', 'TRUE', 
    'FALSE', 10, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pFcodeDenyMod', 'pFcodeDenyMod', 'Modifier explaining the array format used in FcodeDeny.  Leave parameter empty accept default of comma-delimited list.', 'string', 'TRUE', 
    'FALSE', 10, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pDistanceMaxDistKM', 'pDistanceMaxDistKM', 'The maximum distance in kilometers to snap to a qualifying NHDPlus flowline.', 'string', 'TRUE', 
    'FALSE', 10, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pRaindropPathMaxDistKM', 'pRaindropPathMaxDistKM', 'The maximum distance in KM to travel during a raindrop indexing action. Note this refers to the actual raindrop traversal, not the final distance snap which is controlled by the pRaindropSnapMaxDistKM parameter.', 'string', 'TRUE', 
    'FALSE', 10, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pRaindropSnapMaxDistKM', 'pRaindropSnapMaxDistKM', 'The maximum distance in kilometers of the final path to flowline snap used in raindrop indexing.', 'string', 'TRUE', 
    'FALSE', 10, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pNavigationType', 'pNavigationType', 'Navigation methodolody for network discovery of events:
> UT = upstream with tributaries navigation
> UM = upstream mainstem navigation
> DD = downstream with divergences navigation
> DM = downstream mainstem navigation
> PP = point-to-point downstream navigation', 'string', 'TRUE', 
    'FALSE', 10, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pStartComID', 'pStartComID', 'NHDPlus flowline integer ComID to begin navigating from.', 'string', 'FALSE', 
    'FALSE', 20, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pStartPermanentIdentifier', 'pStartPermanentIdentifier', 'NHDPlus flowline Permanent Identifier string value to begin navigating from.', 'string', 'FALSE', 
    'FALSE', 30, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pStartReachcode', 'pStartReachcode', 'NHDPlus flowline reach code to begin navigating from.  Must be length 14 and contain all digits.', 'string', 'FALSE', 
    'FALSE', 40, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pStartMeasure', 'pStartMeasure', 'Measure on the NHDPlus reach code to begin navigating from.  Must be between 0 and 100 inclusive, or NULL. A value of NULL means that a measure will be calculated to be either the bottom or the top of the NHD flowline (depending on whether the navigation type is upstream or downstream and whether it is a start or stop measure).', 'string', 'FALSE', 
    'FALSE', 50, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pStopComID', 'pStopComID', 'NHDPlus flowline integer ComID to stop navigating at.  Only used in point-to-point navigation.', 'string', 'FALSE', 
    'FALSE', 60, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pStopPermanentIdentifier', 'pStopPermanentIdentifier', 'NHDPlus flowline Permanent Identifier string value to stop navigating at.  Only used in point-to-point navigation.', 'string', 'FALSE', 
    'FALSE', 70, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pStopReachcode', 'pStopReachcode', 'NHDPlus reach code to stop navigating at.  Only used in point-to-point navigation.', 'string', 'FALSE', 
    'FALSE', 80, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pStopMeasure', 'pStopMeasure', 'Measure on the NHD reach code to stop navigating at.  Must be between 0 and 100 inclusive, or NULL. A value of NULL means that a measure will be calculated to be either the bottom or the top of the NHD flowline (depending on whether the navigation type is upstream or downstream and whether it is a start or stop measure).  Only used in point-to-point navigation.', 'string', 'FALSE', 
    'FALSE', 90, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pMaxDistanceKm', 'pMaxDistanceKm', 'Maximum distance in kilometers to navigate.  Only valid with UT, UM, DD and DM navigation.', 'string', 'FALSE', 
    'FALSE', 100, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pMaxFlowTimeHour', 'pMaxFlowTimeHour', 'Maximum flow time in hours to navigate.  Only valid with UT, UM, DD and DM navigation.  Currently inoperable.', 'string', 'FALSE', 
    'FALSE', 110, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pEventTypeList', 'pEventTypeList', 'Array of program eventtype identifiers to search for along the navigation route. See the complete list of RAD program abbreviations at https://www.epa.gov/waterdata/rad-event-programs.', 'string', 'FALSE', 
    'FALSE', 120, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pEventTypeListMod', 'pEventTypeListMod', 'Modifier explaining the array format used in pEventTypeList.  Leave empty to accept a comma-delimited list format.', 'string', 'FALSE', 
    'FALSE', 130, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pArchiveCycleList', 'pArchiveCycleList', 'Array of cycle year identifiers to search in Reach Address Database archives.  Currently inoperable.', 'string', 'FALSE', 
    'FALSE', 140, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pArchiveCycleListMod', 'pArchiveCycleListMod', 'Modifier explaining the array format used in pArchiveCycleList.  Leave empty to accept a comma-delimited list format.', 'string', 'FALSE', 
    'FALSE', 150, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pReturnNavigationResults', 'pReturnNavigationResults', 'TRUE/FALSE flag to include Navigation results.  As the navigation results may be a large payload, forgoing the results may improve performance.  Note that this switch does not actually avoid navigation itself, just the serialization and return of the data.', 'string', 'FALSE', 
    'FALSE', 160, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pAddFlowlineAttributes', 'pAddFlowlineAttributes', 'TRUE/FALSE flag to populate navigation results with additional flowline attributes.  Setting this to FALSE will provide a small performance boost at the cost of less information.  Note the nhd_gnis_id and nhd_gnis_name results in the event payload will always be NULL when this switch is FALSE.', 'string', 'FALSE', 
    'FALSE', 170, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pAddFlowlineGeometry', 'pAddFlowlineGeometry', 'TRUE/FALSE flag to populate navigation results with flowline geometry data.  Setting this to FALSE will provide tabular navigation results without the geometry resulting in a smaller payload.  Note the GeoJSON collection format is not really valid with a null geometry and may require special handling.', 'string', 'FALSE', 
    'FALSE', 180, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pAddEventGeometry', 'pAddEventGeometry', 'TRUE/FALSE flag to populate event results with event geometry data.  Setting this to FALSE will provide tabular event results without the geometry resulting in a smaller payload.  Note the GeoJSON collection format is not really valid with a null geometry and may require special handling.', 'string', 'FALSE', 
    'FALSE', 190, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('pReturnProgramAttributes', 'pReturnProgramAttributes', 'TRUE/FALSE flag to populate event results with additional program specific tabular attributes.  Extracting program attributes will degrade performance and should be only used if such attributes are actually required.', 'string', 'FALSE', 
    'FALSE', 200, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('optOutPrettyPrint', 'optOutPrettyPrint', 'Optional feature to format output with logical indentations and linefeeds to promote visualization and debugging efforts. Numeric value indicates the number of three-space indentations to begin pretty printing efforts at. Value of 0 begins at the left margin. Simply pass NULL or leave empty for compact results. Pretty printed results should be avoided in production.', 'string', 'FALSE', 
    'FALSE', 210, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('optOutPruneNumber', 'optOutPruneNumber', 'Optional feature to truncate geometry coordinates to a given amount of precision.  Oracle spatial is able to generate numeric values with up to 32 places of precision which is excessive for web mapping purposes.  Set this value to a reasonable number to lessen the size of the payload.', 'string', 'FALSE', 
    'FALSE', 220, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('optJSONPCallback', 'optJSONPCallback', 'Optional feature for enclosing results in a JSONP wrapper.  Use a valid JavaScript function string.  This is a synonym to the callback parameter provided for backwards compatibility.', 'string', 'FALSE', 
    'FALSE', 230, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('optCache', 'optCache', 'Optional feature used to set HTTP header cache of output.', 'string', 'FALSE', 
    'FALSE', 240, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('optClientRef', 'optClientRef', 'Optional feature used to tag service logs with additional information.  If you are having issues and seek support adding a distinctive value via this parameter will allow EPA support staff to identify your requests in the logs more easily.', 'string', 'FALSE', 
    'FALSE', 250, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('optGEOJSONbbox', 'optGEOJSONbbox', 'TRUE/FALSE flag to add a bounding box object to all GeoJSON feature collections in the output.  As the bounding box is determined at runtime, a value of TRUE will degrade performance.  Do not use unless your application has a need for this feature.', 'string', 'FALSE', 
    'FALSE', 260, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_PARM
   (swagger_parm_id, swagger_parm, parm_description, parm_type, parm_required, 
    parm_undocumented, param_sort, parm_desc_updated, parm_desc_author, versionid)
 Values
   ('callback', 'callback', 'Optional feature for enclosing results in a JSONP wrapper.  Use a valid JavaScript function string.', 'string', 'FALSE', 
    'FALSE', 270, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
COMMIT;
/* DZ_SWAGGER_HEAD */
Insert into DZ_SWAGGER_HEAD
   (header_id, info_title, info_description, info_contact_name, info_contact_url, 
    info_license_name, info_license_url, info_version, swagger_host, swagger_basepath, 
    schemes_https, consumes_json, consumes_xml, consumes_form, produces_json, produces_xml, 
    info_desc_updated, info_desc_author, versionid)
 Values
   ('WATERS', 'U.S. EPA Office of Water WATERS Services', 'The Watershed Assessment, Tracking ' || CHR(38) || ' Environmental Results System (WATERS) unites water quality information previously available only from several independent and unconnected databases.  WATERS provides a suite of interoperable services that expose components that perform complex analysis and supporting strategic datasets.', 'US EPA Office of Water', 'https://www.epa.gov/aboutepa/about-office-water', 
    'Creative Commons Zero Public Domain Dedication', 'https://creativecommons.org/publicdomain/zero/1.0/', '0.0.0', 'ofmpub.epa.gov', '/waters10', 
    'TRUE', NULL, NULL, 'TRUE', 'TRUE', NULL, TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
COMMIT;
/* DZ_SWAGGER_DEF_PROP */
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'reachsmdate', 60, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'measure', 70, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'eventtype', 80, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'event_permanent_identifier', 90, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'source_originator', 100, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'source_featureid', 110, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'source_datadesc', 120, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'featuredetailurl', 130, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'geogstate', 140, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'cycle_year.RAD', 150, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'start_date', 160, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'end_date', 170, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'wbd_huc12', 180, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'program_key', 190, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_303d', 200, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_grts', 210, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_npdes', 220, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_frspub', 230, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d', 'object', 'cycle_year.ATTAINS', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d', 'object', 'listed_water_id', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d', 'object', 'state', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d', 'object', 'listed_water_name', 40, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d', 'object', 'water_type', 50, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d', 'object', 'water_type_size', 60, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d', 'object', 'waterbody_type_group', 70, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d', 'object', 'size_unit', 80, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d', 'object', 'waterbody_type_display', 90, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d', 'object', 'ir_status', 100, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_303d.causes', 110, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_305b.sources', 120, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_305b.uses', 130, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d.causes', 'object', 'detailed_cause_id', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d.causes', 'object', 'detailed_cause_name', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d.causes', 'object', 'parent_cause_id', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d.causes', 'object', 'parent_cause_name', 40, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_305b.sources', 'object', 'detailed_source_id', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_305b.sources', 'object', 'detailed_source_name', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_305b.sources', 'object', 'parent_source_name', 40, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_305b.uses', 'object', 'detailed_use_id', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_305b.uses', 'object', 'detailed_use_desc', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_305b.uses', 'object', 'parent_use_id', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_305b.uses', 'object', 'parent_use_desc', 40, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_305b.sources', 'object', 'parent_source_id', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'object', 'prjdrar_seq', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'object', 'prj_seq', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'object', 'grant_no', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'object', 'prj_no', 40, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'object', 'approp_year', 50, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'object', 'pre_state', 60, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'object', 'pre_rgn_code', 70, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'object', 'prj_start_date', 80, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'object', 'prj_start_actual_ind', 90, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'object', 'prj_complete_date', 100, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'object', 'prj_complete_actual_ind', 110, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'object', 'prj_title', 120, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'object', 'statewide_ind', 130, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'object', 'prj_type_code', 140, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'object', 'prj_type', 150, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_grts.pollutants', 160, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts.pollutants', 'object', 'plttyp_code', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts.pollutants', 'object', 'plttyp_name', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_npdes', 'object', 'npdes_permit_nmbr', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_npdes', 'object', 'permit_name', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_npdes', 'object', 'registry_id', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_npdes', 'object', 'primary_name', 40, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_npdes', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_frspub.interests', 50, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_npdes', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_frspub.sic_codes', 60, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.interests', 'object', 'interest_type', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.interests', 'object', 'active_status', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.sic_codes', 'object', 'sic_code', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.sic_codes', 'object', 'sic_description', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.sic_codes', 'object', 'primary_indicator', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub', 'object', 'registry_id', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub', 'object', 'primary_name', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub', 'object', 'state_code', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub', 'object', 'tribal_land_code', 40, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub', 'object', 'tribal_land_name', 50, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_frspub.programs', 60, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.programs', 'object', 'pgm_sys_acrnm', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.programs', 'object', 'pgm_sys_id', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.programs', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_frspub.interests', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.programs', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_frspub.sic_codes', 40, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'start_permanent_identifier', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'permanent_identifier', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'start_comid', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'comid', 40, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'reachcode', 50, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'fmeasure', 60, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'tmeasure', 70, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'total_distancekm', 80, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'total_flowtimehour', 90, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'hydroseq', 100, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'levelpathid', 110, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'terminalpathid', 120, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'uphydroseq', 130, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'dnhydroseq', 140, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'pathlength', 150, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'lengthkm', 160, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'pathtime', 170, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'travtime', 180, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'reachsmdate', 190, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'ftype', 200, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'fcode', 210, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'gnis_id', 220, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'gnis_name', 230, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'wbarea_permanent_identifier', 240, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'wbarea_comid', 250, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', 'wbd_huc12', 260, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'nhd_permanent_identifier', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'nhdplus_comid', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'nhd_gnis_id', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'nhd_gnis_name', 40, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'reachcode', 50, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'reachsmdate', 60, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'fmeasure', 70, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'tmeasure', 80, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'eventtype', 90, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'event_permanent_identifier', 100, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'source_originator', 110, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'source_featureid', 120, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'source_datadesc', 130, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'featuredetailurl', 140, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'event_lengthkm', 150, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'geogstate', 160, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'cycle_year.RAD', 170, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.root', 'object', 'PointIndexing.Service.data', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.data', 'object', 'session_id', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('Navigation20.Service.data', 'object', 'session_id', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('Navigation20.Service.data', 'object', 'UpstreamDownstreamSearchV3.Service.navigation_results', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('Navigation20.Service.root', 'object', 'status', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('Navigation20.Service.root', 'object', 'Navigation20.Service.data', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.root', 'object', 'status', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.data', 'object', 'PointIndexing.Service.start_point', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.data', 'object', 'PointIndexing.Service.end_point', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.data', 'object', 'PointIndexing.Service.indexing_line', 40, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.data', 'object', 'indexing_line_length', 50, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.data', 'object', 'PointIndexing.Service.flowlines', 60, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines', 'object', 'type.FeatureCollection', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines', 'object', 'GeoJSON.bbox', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines', 'object', 'PointIndexing.Service.flowlines.features', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results', 'object', 'GeoJSON.bbox', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results', 'object', 'GeoJSON.bbox', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results', 'object', 'GeoJSON.bbox', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results', 'object', 'GeoJSON.bbox', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.features', 'object', 'type.Feature', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.features', 'object', 'GeoJSON.geometry', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.features', 'object', 'PointIndexing.Service.flowlines.properties', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'permanent_identifier', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'comid', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'fdate', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'resolution', 40, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'gnis_id', 50, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'gnis_name', 60, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'lengthkm', 70, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'reachcode', 80, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'flowdir', 90, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'wbarea_permanent_identifier', 100, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'wbarea_comid', 110, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'ftype', 120, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'fcode', 130, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'reachsmdate', 140, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'fmeasure', 150, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'tmeasure', 160, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'wbarea_ftype', 170, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'wbarea_fcode', 180, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'wbd_huc12', 190, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'catchment_featureid', 200, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'streamlevel', 210, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'streamorder', 220, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'hydroseq', 230, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'levelpathid', 240, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'terminalpathid', 250, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'uphydroseq', 260, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'dnhydroseq', 270, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'snap_measure', 280, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', 'snap_distancekm', 290, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.programs', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_frspub.medium', 50, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.medium', 'object', 'reporting_year', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.medium', 'object', 'environmental_medium', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('GeoJSON.feature', 'object', 'type.Feature', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('GeoJSON.feature', 'object', 'GeoJSON.bbox', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('GeoJSON.feature', 'object', 'GeoJSON.geometry', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'total_distancekm', 47, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'total_flowtimehour', 48, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'catchment_featureid', 49, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'total_distancekm', 47, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'total_flowtimehour', 48, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'catchment_featureid', 49, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'total_distancekm', 47, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'total_flowtimehour', 48, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'catchment_featureid', 49, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'start_date', 180, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.root', 'object', 'UpstreamDownstreamSearchV3.Service.data', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.root', 'object', 'status', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.data', 'object', 'session_id', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.data', 'object', 'UpstreamDownstreamSearchV3.Service.navigation_results', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.data', 'object', 'UpstreamDownstreamSearchV3.Service.event_point_results', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.data', 'object', 'UpstreamDownstreamSearchV3.Service.event_line_results', 40, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.data', 'object', 'UpstreamDownstreamSearchV3.Service.event_area_results', 50, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'end_date', 190, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'wbd_huc12', 200, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'program_key', 210, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_303d', 220, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_grts', 230, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_npdes', 240, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_frspub', 250, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'nhd_permanent_identifier', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'nhdplus_comid', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'nhd_gnis_id', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'nhd_gnis_name', 40, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'reachcode', 50, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'reachsmdate', 60, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'eventtype', 70, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'event_permanent_identifier', 80, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'source_originator', 90, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'source_featureid', 100, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'source_datadesc', 110, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'featuredetailurl', 120, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'geogstate', 140, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'cycle_year.RAD', 150, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'event_areasqkm', 130, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'start_date', 160, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'end_date', 170, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'wbd_huc12', 180, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'program_key', 190, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_303d', 200, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_grts', 210, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_npdes', 220, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', 'UpstreamDownstreamSearchV3.Service.program_attributes_frspub', 230, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results', 'object', 'type.FeatureCollection', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results', 'object', 'type.FeatureCollection', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results', 'object', 'type.FeatureCollection', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results', 'object', 'UpstreamDownstreamSearchV3.Service.event_point_results.features', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results', 'object', 'UpstreamDownstreamSearchV3.Service.event_line_results.features', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results', 'object', 'UpstreamDownstreamSearchV3.Service.event_area_results.features', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.features', 'object', 'type.Feature', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.features', 'object', 'GeoJSON.geometry', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.features', 'object', 'UpstreamDownstreamSearchV3.Service.event_point_results.properties', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.features', 'object', 'type.Feature', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.features', 'object', 'type.Feature', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.features', 'object', 'GeoJSON.geometry', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.features', 'object', 'GeoJSON.geometry', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.features', 'object', 'UpstreamDownstreamSearchV3.Service.event_line_results.properties', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.features', 'object', 'UpstreamDownstreamSearchV3.Service.event_area_results.properties', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results', 'object', 'type.FeatureCollection', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results', 'object', 'UpstreamDownstreamSearchV3.Service.navigation_results.features', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.features', 'object', 'type.Feature', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.features', 'object', 'GeoJSON.geometry', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.features', 'object', 'UpstreamDownstreamSearchV3.Service.navigation_results.properties', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('GeoJSON.geometry', 'object', 'type.Geometry', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('GeoJSON.geometry', 'object', 'GeoJSON.coordinates', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'nhd_permanent_identifier', 10, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'nhdplus_comid', 20, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'nhd_gnis_id', 30, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'nhd_gnis_name', 40, 'TRUE', 
    'SAMPLE');
Insert into DZ_SWAGGER_DEF_PROP
   (definition, definition_type, property_id, property_order, property_required, 
    versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', 'reachcode', 50, 'TRUE', 
    'SAMPLE');
COMMIT;
/* DZ_SWAGGER_DEFINITION */
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('Navigation20.Service.root', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('Navigation20.Service.data', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('PointIndexing.Service.flowlines.properties', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('PointIndexing.Service.flowlines.features', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('PointIndexing.Service.root', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('PointIndexing.Service.data', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('PointIndexing.Service.start_point', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('PointIndexing.Service.end_point', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('PointIndexing.Service.indexing_line', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('PointIndexing.Service.flowlines', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.medium', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('GeoJSON.feature', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.root', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.data', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('GeoJSON.geometry', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.properties', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.properties', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.properties', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.properties', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_303d.causes', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_305b.sources', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_305b.uses', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_grts.pollutants', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_npdes', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.programs', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.interests', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes_frspub.sic_codes', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results.features', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results.features', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results.features', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
Insert into DZ_SWAGGER_DEFINITION
   (definition, definition_type, definition_desc_updated, definition_desc_author, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results.features', 'object', TO_DATE('1/14/2017', 'MM/DD/YYYY'), 'PDZIEMIE', 'SAMPLE');
COMMIT;
/* DZ_SWAGGER_CONDENSE */
Insert into DZ_SWAGGER_CONDENSE
   (condense_key, condense_value, versionid)
 Values
   ('GeoJSON.feature', 'fea', 'SAMPLE');
Insert into DZ_SWAGGER_CONDENSE
   (condense_key, condense_value, versionid)
 Values
   ('GeoJSON.geometry', 'geo', 'SAMPLE');
Insert into DZ_SWAGGER_CONDENSE
   (condense_key, condense_value, versionid)
 Values
   ('Navigation20.Service', 'n20', 'SAMPLE');
Insert into DZ_SWAGGER_CONDENSE
   (condense_key, condense_value, versionid)
 Values
   ('PointIndexing.Service', 'pi', 'SAMPLE');
Insert into DZ_SWAGGER_CONDENSE
   (condense_key, condense_value, versionid)
 Values
   ('PointIndexing.Service.flowlines', 'pifl', 'SAMPLE');
Insert into DZ_SWAGGER_CONDENSE
   (condense_key, condense_value, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.', 'updnv3', 'SAMPLE');
Insert into DZ_SWAGGER_CONDENSE
   (condense_key, condense_value, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_area_results', 'updnv3ea', 'SAMPLE');
Insert into DZ_SWAGGER_CONDENSE
   (condense_key, condense_value, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_line_results', 'updnv3el', 'SAMPLE');
Insert into DZ_SWAGGER_CONDENSE
   (condense_key, condense_value, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.event_point_results', 'updnv3ep', 'SAMPLE');
Insert into DZ_SWAGGER_CONDENSE
   (condense_key, condense_value, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.navigation_results', 'updnv3n', 'SAMPLE');
Insert into DZ_SWAGGER_CONDENSE
   (condense_key, condense_value, versionid)
 Values
   ('UpstreamDownstreamSearchV3.Service.program_attributes', 'updnv3pa', 'SAMPLE');
COMMIT;
