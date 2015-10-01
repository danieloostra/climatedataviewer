CREATE OR REPLACE FUNCTION update_catalog_property(p_catalog_id int, p_catalog_property_id int, p_name text, p_value text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select catalog_property_id into id from catalog_property where catalog_property_id=p_catalog_property_id;
		if(id is null) then
			return -1;
		end if;
		update catalog_property set "catalog_id"=p_catalog_id, "name"=p_name, "value"=p_value where catalog_property_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_catalog_xlink(p_catalog_id int, p_catalog_xlink_id int, p_value text, p_xlink text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select catalog_xlink_id into id from catalog_xlink where catalog_xlink_id=p_catalog_xlink_id;
		if(id is null) then
			return -1;
		end if;
		update catalog_xlink set "catalog_id"=p_catalog_id, "value"=p_value where catalog_xlink_id=id;
		BEGIN
			update catalog_xlink set "xlink" = cast(p_xlink as xlink) where catalog_xlink_id=id;
		EXCEPTION
			when others then
				update catalog_xlink set "xlink_nonstandard" = p_xlink where catalog_xlink_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_catalogref(p_catalogref_id int) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select catalogref_id into id from catalogref where catalogref_id=p_catalogref_id;
		if(id is null) then
			return -1;
		end if;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_catalogref_documentation(p_catalogref_id int, p_catalogref_documentation_id int, p_value text, p_documentationenum text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select catalogref_documentation_id into id from catalogref_documentation where catalogref_documentation_id=p_catalogref_documentation_id;
		if(id is null) then
			return -1;
		end if;
		update catalogref_documentation set "catalogref_id"=p_catalogref_id, "value"=p_value where catalogref_documentation_id=id;
		BEGIN
			update catalogref_documentation set "documentationenum" = cast(p_documentationenum as documentationenum) where catalogref_documentation_id=id;
		EXCEPTION
			when others then
				update catalogref_documentation set "documentationenum_nonstandard" = p_documentationenum where catalogref_documentation_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_catalogref_documentation_namespace(p_catalogref_documentation_id int, p_catalogref_documentation_namespace_id int, p_namespace text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select catalogref_documentation_namespace_id into id from catalogref_documentation_namespace where catalogref_documentation_namespace_id=p_catalogref_documentation_namespace_id;
		if(id is null) then
			return -1;
		end if;
		update catalogref_documentation_namespace set "catalogref_documentation_id"=p_catalogref_documentation_id, "namespace"=p_namespace where catalogref_documentation_namespace_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_catalogref_documentation_xlink(p_catalogref_documentation_id int, p_catalogref_documentation_xlink_id int, p_value text, p_xlink text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select catalogref_documentation_xlink_id into id from catalogref_documentation_xlink where catalogref_documentation_xlink_id=p_catalogref_documentation_xlink_id;
		if(id is null) then
			return -1;
		end if;
		update catalogref_documentation_xlink set "catalogref_documentation_id"=p_catalogref_documentation_id, "value"=p_value where catalogref_documentation_xlink_id=id;
		BEGIN
			update catalogref_documentation_xlink set "xlink" = cast(p_xlink as xlink) where catalogref_documentation_xlink_id=id;
		EXCEPTION
			when others then
				update catalogref_documentation_xlink set "xlink_nonstandard" = p_xlink where catalogref_documentation_xlink_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_catalogref_xlink(p_catalogref_id int, p_catalogref_xlink_id int, p_value text, p_xlink text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select catalogref_xlink_id into id from catalogref_xlink where catalogref_xlink_id=p_catalogref_xlink_id;
		if(id is null) then
			return -1;
		end if;
		update catalogref_xlink set "catalogref_id"=p_catalogref_id, "value"=p_value where catalogref_xlink_id=id;
		BEGIN
			update catalogref_xlink set "xlink" = cast(p_xlink as xlink) where catalogref_xlink_id=id;
		EXCEPTION
			when others then
				update catalogref_xlink set "xlink_nonstandard" = p_xlink where catalogref_xlink_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_dataset(p_dataset_id int, p_alias text, p_authority text, p_d_id text, p_harvest text, p_name text, p_resourcecontrol text, p_serviceName text, p_urlPath text, p_collectiontype text, p_datasize_unit text, p_dataType text, p_status text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select dataset_id into id from dataset where dataset_id=p_dataset_id;
		if(id is null) then
			return -1;
		end if;
		update dataset set "alias"=p_alias, "authority"=p_authority, "d_id"=p_d_id, "harvest"=p_harvest, "name"=p_name, "resourcecontrol"=p_resourcecontrol, "serviceName"=p_serviceName, "urlPath"=p_urlPath where dataset_id=id;
		BEGIN
			update dataset set "collectiontype" = cast(p_collectiontype as collectiontype) where dataset_id=id;
		EXCEPTION
			when others then
				update dataset set "collectiontype_nonstandard" = p_collectiontype where dataset_id=id;
		END;
		BEGIN
			update dataset set "datasize_unit" = cast(p_datasize_unit as datasize_unit) where dataset_id=id;
		EXCEPTION
			when others then
				update dataset set "datasize_unit_nonstandard" = p_datasize_unit where dataset_id=id;
		END;
		BEGIN
			update dataset set "dataType" = cast(p_dataType as dataType) where dataset_id=id;
		EXCEPTION
			when others then
				update dataset set "dataType_nonstandard" = p_dataType where dataset_id=id;
		END;
		update dataset set "status" = cast(p_status as status) where dataset_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_dataset_access(p_dataset_id int, p_dataset_access_id int, p_servicename text, p_urlpath text, p_dataformat text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select dataset_access_id into id from dataset_access where dataset_access_id=p_dataset_access_id;
		if(id is null) then
			return -1;
		end if;
		update dataset_access set "dataset_id"=p_dataset_id, "servicename"=p_servicename, "urlpath"=p_urlpath where dataset_access_id=id;
		BEGIN
			update dataset_access set "dataformat" = cast(p_dataformat as dataformat) where dataset_access_id=id;
		EXCEPTION
			when others then
				update dataset_access set "dataformat_nonstandard" = p_dataformat where dataset_access_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_dataset_access_datasize(p_dataset_access_id int, p_dataset_access_datasize_id int, p_value text, p_units text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select dataset_access_datasize_id into id from dataset_access_datasize where dataset_access_datasize_id=p_dataset_access_datasize_id;
		if(id is null) then
			return -1;
		end if;
		update dataset_access_datasize set "dataset_access_id"=p_dataset_access_id, "value"=p_value where dataset_access_datasize_id=id;
		BEGIN
			update dataset_access_datasize set "units" = cast(p_units as units) where dataset_access_datasize_id=id;
		EXCEPTION
			when others then
				update dataset_access_datasize set "units_nonstandard" = p_units where dataset_access_datasize_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_dataset_ncml(p_dataset_id int, p_dataset_ncml_id int) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select dataset_ncml_id into id from dataset_ncml where dataset_ncml_id=p_dataset_ncml_id;
		if(id is null) then
			return -1;
		end if;
		update dataset_ncml set "dataset_id"=p_dataset_id where dataset_ncml_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_dataset_property(p_dataset_id int, p_dataset_property_id int, p_name text, p_value text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select dataset_property_id into id from dataset_property where dataset_property_id=p_dataset_property_id;
		if(id is null) then
			return -1;
		end if;
		update dataset_property set "dataset_id"=p_dataset_id, "name"=p_name, "value"=p_value where dataset_property_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_metadata(p_metadata_id int, p_inherited text, p_metadatatype text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select metadata_id into id from metadata where metadata_id=p_metadata_id;
		if(id is null) then
			return -1;
		end if;
		BEGIN
			update metadata set "inherited" = cast(p_inherited as inherited) where metadata_id=id;
		EXCEPTION
			when others then
				update metadata set "inherited_nonstandard" = p_inherited where metadata_id=id;
		END;
		BEGIN
			update metadata set "metadatatype" = cast(p_metadatatype as metadatatype) where metadata_id=id;
		EXCEPTION
			when others then
				update metadata set "metadatatype_nonstandard" = p_metadatatype where metadata_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_metadata_namespace(p_metadata_id int, p_metadata_namespace_id int, p_namespace text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select metadata_namespace_id into id from metadata_namespace where metadata_namespace_id=p_metadata_namespace_id;
		if(id is null) then
			return -1;
		end if;
		update metadata_namespace set "metadata_id"=p_metadata_id, "namespace"=p_namespace where metadata_namespace_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_metadata_xlink(p_metadata_id int, p_metadata_xlink_id int, p_value text, p_xlink text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select metadata_xlink_id into id from metadata_xlink where metadata_xlink_id=p_metadata_xlink_id;
		if(id is null) then
			return -1;
		end if;
		update metadata_xlink set "metadata_id"=p_metadata_id, "value"=p_value where metadata_xlink_id=id;
		BEGIN
			update metadata_xlink set "xlink" = cast(p_xlink as xlink) where metadata_xlink_id=id;
		EXCEPTION
			when others then
				update metadata_xlink set "xlink_nonstandard" = p_xlink where metadata_xlink_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_service(p_service_id int, p_base text, p_desc text, p_name text, p_suffix text, p_serviceType text, p_status text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select service_id into id from service where service_id=p_service_id;
		if(id is null) then
			return -1;
		end if;
		update service set "base"=p_base, "desc"=p_desc, "name"=p_name, "suffix"=p_suffix where service_id=id;
		BEGIN
			update service set "serviceType" = cast(p_serviceType as serviceType) where service_id=id;
		EXCEPTION
			when others then
				update service set "serviceType_nonstandard" = p_serviceType where service_id=id;
		END;
		update service set "status" = cast(p_status as status) where service_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_service_datasetroot(p_service_id int, p_service_datasetroot_id int, p_location text, p_path text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select service_datasetroot_id into id from service_datasetroot where service_datasetroot_id=p_service_datasetroot_id;
		if(id is null) then
			return -1;
		end if;
		update service_datasetroot set "service_id"=p_service_id, "location"=p_location, "path"=p_path where service_datasetroot_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_service_property(p_service_id int, p_service_property_id int, p_name text, p_value text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select service_property_id into id from service_property where service_property_id=p_service_property_id;
		if(id is null) then
			return -1;
		end if;
		update service_property set "service_id"=p_service_id, "name"=p_name, "value"=p_value where service_property_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg(p_tmg_id int) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_id into id from tmg where tmg_id=p_tmg_id;
		if(id is null) then
			return -1;
		end if;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_authority(p_tmg_id int, p_tmg_authority_id int, p_authority text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_authority_id into id from tmg_authority where tmg_authority_id=p_tmg_authority_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_authority set "tmg_id"=p_tmg_id, "authority"=p_authority where tmg_authority_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_contributor(p_tmg_id int, p_tmg_contributor_id int, p_name text, p_role text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_contributor_id into id from tmg_contributor where tmg_contributor_id=p_tmg_contributor_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_contributor set "tmg_id"=p_tmg_id, "name"=p_name, "role"=p_role where tmg_contributor_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_creator(p_tmg_id int, p_tmg_creator_id int) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_creator_id into id from tmg_creator where tmg_creator_id=p_tmg_creator_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_creator set "tmg_id"=p_tmg_id where tmg_creator_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_creator_contact(p_tmg_creator_id int, p_tmg_creator_contact_id int, p_email text, p_url text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_creator_contact_id into id from tmg_creator_contact where tmg_creator_contact_id=p_tmg_creator_contact_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_creator_contact set "tmg_creator_id"=p_tmg_creator_id, "email"=p_email, "url"=p_url where tmg_creator_contact_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_creator_name(p_tmg_creator_id int, p_tmg_creator_name_id int, p_value text, p_vocabulary text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_creator_name_id into id from tmg_creator_name where tmg_creator_name_id=p_tmg_creator_name_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_creator_name set "tmg_creator_id"=p_tmg_creator_id, "value"=p_value, "vocabulary"=p_vocabulary where tmg_creator_name_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_dataformat(p_tmg_id int, p_tmg_dataformat_id int, p_dataformat text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_dataformat_id into id from tmg_dataformat where tmg_dataformat_id=p_tmg_dataformat_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_dataformat set "tmg_id"=p_tmg_id where tmg_dataformat_id=id;
		BEGIN
			update tmg_dataformat set "dataformat" = cast(p_dataformat as dataformat) where tmg_dataformat_id=id;
		EXCEPTION
			when others then
				update tmg_dataformat set "dataformat_nonstandard" = p_dataformat where tmg_dataformat_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_datasize(p_tmg_id int, p_tmg_datasize_id int, p_value text, p_units text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_datasize_id into id from tmg_datasize where tmg_datasize_id=p_tmg_datasize_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_datasize set "tmg_id"=p_tmg_id, "value"=p_value where tmg_datasize_id=id;
		BEGIN
			update tmg_datasize set "units" = cast(p_units as units) where tmg_datasize_id=id;
		EXCEPTION
			when others then
				update tmg_datasize set "units_nonstandard" = p_units where tmg_datasize_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_datatype(p_tmg_id int, p_tmg_datatype_id int, p_datatype text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_datatype_id into id from tmg_datatype where tmg_datatype_id=p_tmg_datatype_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_datatype set "tmg_id"=p_tmg_id where tmg_datatype_id=id;
		BEGIN
			update tmg_datatype set "datatype" = cast(p_datatype as datatype) where tmg_datatype_id=id;
		EXCEPTION
			when others then
				update tmg_datatype set "datatype_nonstandard" = p_datatype where tmg_datatype_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_date(p_tmg_id int, p_tmg_date_id int, p_format text, p_value text, p_dateenum text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_date_id into id from tmg_date where tmg_date_id=p_tmg_date_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_date set "tmg_id"=p_tmg_id, "format"=p_format, "value"=p_value where tmg_date_id=id;
		BEGIN
			update tmg_date set "dateenum" = cast(p_dateenum as dateenum) where tmg_date_id=id;
		EXCEPTION
			when others then
				update tmg_date set "dateenum_nonstandard" = p_dateenum where tmg_date_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_documentation(p_tmg_id int, p_tmg_documentation_id int, p_value text, p_documentationenum text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_documentation_id into id from tmg_documentation where tmg_documentation_id=p_tmg_documentation_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_documentation set "tmg_id"=p_tmg_id, "value"=p_value where tmg_documentation_id=id;
		BEGIN
			update tmg_documentation set "documentationenum" = cast(p_documentationenum as documentationenum) where tmg_documentation_id=id;
		EXCEPTION
			when others then
				update tmg_documentation set "documentationenum_nonstandard" = p_documentationenum where tmg_documentation_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_documentation_namespace(p_tmg_documentation_id int, p_tmg_documentation_namespace_id int, p_namespace text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_documentation_namespace_id into id from tmg_documentation_namespace where tmg_documentation_namespace_id=p_tmg_documentation_namespace_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_documentation_namespace set "tmg_documentation_id"=p_tmg_documentation_id, "namespace"=p_namespace where tmg_documentation_namespace_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_documentation_xlink(p_tmg_documentation_id int, p_tmg_documentation_xlink_id int, p_value text, p_xlink text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_documentation_xlink_id into id from tmg_documentation_xlink where tmg_documentation_xlink_id=p_tmg_documentation_xlink_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_documentation_xlink set "tmg_documentation_id"=p_tmg_documentation_id, "value"=p_value where tmg_documentation_xlink_id=id;
		BEGIN
			update tmg_documentation_xlink set "xlink" = cast(p_xlink as xlink) where tmg_documentation_xlink_id=id;
		EXCEPTION
			when others then
				update tmg_documentation_xlink set "xlink_nonstandard" = p_xlink where tmg_documentation_xlink_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_geospatialcoverage(p_tmg_id int, p_tmg_geospatialcoverage_id int, p_upordown text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_geospatialcoverage_id into id from tmg_geospatialcoverage where tmg_geospatialcoverage_id=p_tmg_geospatialcoverage_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_geospatialcoverage set "tmg_id"=p_tmg_id where tmg_geospatialcoverage_id=id;
		BEGIN
			update tmg_geospatialcoverage set "upordown" = cast(p_upordown as upordown) where tmg_geospatialcoverage_id=id;
		EXCEPTION
			when others then
				update tmg_geospatialcoverage set "upordown_nonstandard" = p_upordown where tmg_geospatialcoverage_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_geospatialcoverage_eastwest(p_tmg_geospatialcoverage_id int, p_tmg_geospatialcoverage_eastwest_id int, p_resolution text, p_size text, p_start text, p_units text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_geospatialcoverage_eastwest_id into id from tmg_geospatialcoverage_eastwest where tmg_geospatialcoverage_eastwest_id=p_tmg_geospatialcoverage_eastwest_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_geospatialcoverage_eastwest set "tmg_geospatialcoverage_id"=p_tmg_geospatialcoverage_id, "resolution"=p_resolution, "size"=p_size, "start"=p_start, "units"=p_units where tmg_geospatialcoverage_eastwest_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_geospatialcoverage_name(p_tmg_geospatialcoverage_id int, p_tmg_geospatialcoverage_name_id int, p_value text, p_vocabulary text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_geospatialcoverage_name_id into id from tmg_geospatialcoverage_name where tmg_geospatialcoverage_name_id=p_tmg_geospatialcoverage_name_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_geospatialcoverage_name set "tmg_geospatialcoverage_id"=p_tmg_geospatialcoverage_id, "value"=p_value, "vocabulary"=p_vocabulary where tmg_geospatialcoverage_name_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_geospatialcoverage_northsouth(p_tmg_geospatialcoverage_id int, p_tmg_geospatialcoverage_northsouth_id int, p_resolution text, p_size text, p_start text, p_units text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_geospatialcoverage_northsouth_id into id from tmg_geospatialcoverage_northsouth where tmg_geospatialcoverage_northsouth_id=p_tmg_geospatialcoverage_northsouth_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_geospatialcoverage_northsouth set "tmg_geospatialcoverage_id"=p_tmg_geospatialcoverage_id, "resolution"=p_resolution, "size"=p_size, "start"=p_start, "units"=p_units where tmg_geospatialcoverage_northsouth_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_geospatialcoverage_updown(p_tmg_geospatialcoverage_id int, p_tmg_geospatialcoverage_updown_id int, p_resolution text, p_size text, p_start text, p_units text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_geospatialcoverage_updown_id into id from tmg_geospatialcoverage_updown where tmg_geospatialcoverage_updown_id=p_tmg_geospatialcoverage_updown_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_geospatialcoverage_updown set "tmg_geospatialcoverage_id"=p_tmg_geospatialcoverage_id, "resolution"=p_resolution, "size"=p_size, "start"=p_start, "units"=p_units where tmg_geospatialcoverage_updown_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_keyword(p_tmg_id int, p_tmg_keyword_id int, p_value text, p_vocabulary text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_keyword_id into id from tmg_keyword where tmg_keyword_id=p_tmg_keyword_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_keyword set "tmg_id"=p_tmg_id, "value"=p_value, "vocabulary"=p_vocabulary where tmg_keyword_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_project(p_tmg_id int, p_tmg_project_id int, p_value text, p_vocabulary text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_project_id into id from tmg_project where tmg_project_id=p_tmg_project_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_project set "tmg_id"=p_tmg_id, "value"=p_value, "vocabulary"=p_vocabulary where tmg_project_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_property(p_tmg_id int, p_tmg_property_id int, p_name text, p_value text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_property_id into id from tmg_property where tmg_property_id=p_tmg_property_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_property set "tmg_id"=p_tmg_id, "name"=p_name, "value"=p_value where tmg_property_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_publisher(p_tmg_id int, p_tmg_publisher_id int) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_publisher_id into id from tmg_publisher where tmg_publisher_id=p_tmg_publisher_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_publisher set "tmg_id"=p_tmg_id where tmg_publisher_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_publisher_contact(p_tmg_publisher_id int, p_tmg_publisher_contact_id int, p_email text, p_url text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_publisher_contact_id into id from tmg_publisher_contact where tmg_publisher_contact_id=p_tmg_publisher_contact_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_publisher_contact set "tmg_publisher_id"=p_tmg_publisher_id, "email"=p_email, "url"=p_url where tmg_publisher_contact_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_publisher_name(p_tmg_publisher_id int, p_tmg_publisher_name_id int, p_value text, p_vocabulary text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_publisher_name_id into id from tmg_publisher_name where tmg_publisher_name_id=p_tmg_publisher_name_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_publisher_name set "tmg_publisher_id"=p_tmg_publisher_id, "value"=p_value, "vocabulary"=p_vocabulary where tmg_publisher_name_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_servicename(p_tmg_id int, p_tmg_servicename_id int, p_servicename text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_servicename_id into id from tmg_servicename where tmg_servicename_id=p_tmg_servicename_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_servicename set "tmg_id"=p_tmg_id, "servicename"=p_servicename where tmg_servicename_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_timecoverage(p_tmg_id int, p_tmg_timecoverage_id int, p_resolution text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_timecoverage_id into id from tmg_timecoverage where tmg_timecoverage_id=p_tmg_timecoverage_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_timecoverage set "tmg_id"=p_tmg_id, "resolution"=p_resolution where tmg_timecoverage_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_timecoverage_duration(p_tmg_timecoverage_id int, p_tmg_timecoverage_duration_id int, p_duration text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_timecoverage_duration_id into id from tmg_timecoverage_duration where tmg_timecoverage_duration_id=p_tmg_timecoverage_duration_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_timecoverage_duration set "tmg_timecoverage_id"=p_tmg_timecoverage_id, "duration"=p_duration where tmg_timecoverage_duration_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_timecoverage_end(p_tmg_timecoverage_id int, p_tmg_timecoverage_end_id int, p_format text, p_value text, p_dateenum text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_timecoverage_end_id into id from tmg_timecoverage_end where tmg_timecoverage_end_id=p_tmg_timecoverage_end_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_timecoverage_end set "tmg_timecoverage_id"=p_tmg_timecoverage_id, "format"=p_format, "value"=p_value where tmg_timecoverage_end_id=id;
		BEGIN
			update tmg_timecoverage_end set "dateenum" = cast(p_dateenum as dateenum) where tmg_timecoverage_end_id=id;
		EXCEPTION
			when others then
				update tmg_timecoverage_end set "dateenum_nonstandard" = p_dateenum where tmg_timecoverage_end_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_timecoverage_resolution(p_tmg_timecoverage_id int, p_tmg_timecoverage_resolution_id int, p_duration text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_timecoverage_resolution_id into id from tmg_timecoverage_resolution where tmg_timecoverage_resolution_id=p_tmg_timecoverage_resolution_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_timecoverage_resolution set "tmg_timecoverage_id"=p_tmg_timecoverage_id, "duration"=p_duration where tmg_timecoverage_resolution_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_timecoverage_start(p_tmg_timecoverage_id int, p_tmg_timecoverage_start_id int, p_format text, p_value text, p_dateenum text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_timecoverage_start_id into id from tmg_timecoverage_start where tmg_timecoverage_start_id=p_tmg_timecoverage_start_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_timecoverage_start set "tmg_timecoverage_id"=p_tmg_timecoverage_id, "format"=p_format, "value"=p_value where tmg_timecoverage_start_id=id;
		BEGIN
			update tmg_timecoverage_start set "dateenum" = cast(p_dateenum as dateenum) where tmg_timecoverage_start_id=id;
		EXCEPTION
			when others then
				update tmg_timecoverage_start set "dateenum_nonstandard" = p_dateenum where tmg_timecoverage_start_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_variables(p_tmg_id int, p_tmg_variables_id int, p_vocabulary text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_variables_id into id from tmg_variables where tmg_variables_id=p_tmg_variables_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_variables set "tmg_id"=p_tmg_id where tmg_variables_id=id;
		BEGIN
			update tmg_variables set "vocabulary" = cast(p_vocabulary as vocabulary) where tmg_variables_id=id;
		EXCEPTION
			when others then
				update tmg_variables set "vocabulary_nonstandard" = p_vocabulary where tmg_variables_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_variables_variable(p_tmg_variables_id int, p_tmg_variables_variable_id int, p_name text, p_units text, p_vocabulary_name text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_variables_variable_id into id from tmg_variables_variable where tmg_variables_variable_id=p_tmg_variables_variable_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_variables_variable set "tmg_variables_id"=p_tmg_variables_id, "name"=p_name, "units"=p_units, "vocabulary_name"=p_vocabulary_name where tmg_variables_variable_id=id;

		return id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_tmg_variables_variablemap(p_tmg_variables_id int, p_tmg_variables_variablemap_id int, p_value text, p_xlink text) RETURNS int AS $$
DECLARE
	id int;
BEGIN
		select tmg_variables_variablemap_id into id from tmg_variables_variablemap where tmg_variables_variablemap_id=p_tmg_variables_variablemap_id;
		if(id is null) then
			return -1;
		end if;
		update tmg_variables_variablemap set "tmg_variables_id"=p_tmg_variables_id, "value"=p_value where tmg_variables_variablemap_id=id;
		BEGIN
			update tmg_variables_variablemap set "xlink" = cast(p_xlink as xlink) where tmg_variables_variablemap_id=id;
		EXCEPTION
			when others then
				update tmg_variables_variablemap set "xlink_nonstandard" = p_xlink where tmg_variables_variablemap_id=id;
		END;

		return id;
END;
$$ LANGUAGE plpgsql;

