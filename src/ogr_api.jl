

"""
    OGR_G_CreateFromWkb(unsigned char *,
                        OGRSpatialReferenceH,
                        OGRGeometryH *,
                        int) -> OGRErr

Create a geometry object of the appropriate type from it's well known binary representation.

### Parameters
* **pabyData**: pointer to the input BLOB data.
* **hSRS**: handle to the spatial reference to be assigned to the created geometry object. This may be NULL.
* **phGeometry**: the newly created geometry object will be assigned to the indicated handle on return. This will be NULL in case of failure. If not NULL, *phGeometry should be freed with OGR_G_DestroyGeometry() after use.
* **nBytes**: the number of bytes of data available in pabyData, or -1 if it is not known, but assumed to be sufficient.

### Returns
OGRERR_NONE if all goes well, otherwise any of OGRERR_NOT_ENOUGH_DATA, OGRERR_UNSUPPORTED_GEOMETRY_TYPE, or OGRERR_CORRUPT_DATA may be returned.
"""
function createfromwkb(arg1::Ptr{Cuchar},arg2::OGRSpatialReferenceH,arg3::Ptr{OGRGeometryH},arg4::Integer)
    ccall((:OGR_G_CreateFromWkb,libgdal),OGRErr,(Ptr{Cuchar},OGRSpatialReferenceH,Ptr{OGRGeometryH},Cint),arg1,arg2,arg3,arg4)
end


"""
    OGR_G_CreateFromWkt(char **,
                        OGRSpatialReferenceH,
                        OGRGeometryH *) -> OGRErr

Create a geometry object of the appropriate type from it's well known text representation.

### Parameters
* **ppszData**: input zero terminated string containing well known text representation of the geometry to be created. The pointer is updated to point just beyond that last character consumed.
* **hSRS**: handle to the spatial reference to be assigned to the created geometry object. This may be NULL.
* **phGeometry**: the newly created geometry object will be assigned to the indicated handle on return. This will be NULL if the method fails. If not NULL, *phGeometry should be freed with OGR_G_DestroyGeometry() after use.

### Returns
OGRERR_NONE if all goes well, otherwise any of OGRERR_NOT_ENOUGH_DATA, OGRERR_UNSUPPORTED_GEOMETRY_TYPE, or OGRERR_CORRUPT_DATA may be returned.
"""
function createfromwkt(arg1::Vector{UTF8String},arg2::OGRSpatialReferenceH,arg3::Ptr{OGRGeometryH})
    ccall((:OGR_G_CreateFromWkt,libgdal),OGRErr,(Ptr{Ptr{UInt8}},OGRSpatialReferenceH,Ptr{OGRGeometryH}),arg1,arg2,arg3)
end


"""
    OGR_G_CreateFromFgf(unsigned char *,
                        OGRSpatialReferenceH,
                        OGRGeometryH *,
                        int,
                        int *) -> OGRErr
"""
function createfromfgf(arg1::Ptr{Cuchar},arg2::OGRSpatialReferenceH,arg3::Ptr{OGRGeometryH},arg4::Integer,arg5::Vector{Cint})
    ccall((:OGR_G_CreateFromFgf,libgdal),OGRErr,(Ptr{Cuchar},OGRSpatialReferenceH,Ptr{OGRGeometryH},Cint,Ptr{Cint}),arg1,arg2,arg3,arg4,arg5)
end


"""
    OGR_G_DestroyGeometry(OGRGeometryH) -> void

Destroy geometry object.

### Parameters
* **hGeom**: handle to the geometry to delete.
"""
function destroygeometry(arg1::OGRGeometryH)
    ccall((:OGR_G_DestroyGeometry,libgdal),Void,(OGRGeometryH,),arg1)
end


"""
    OGR_G_CreateGeometry(OGRwkbGeometryType) -> OGRGeometryH

Create an empty geometry of desired type.

### Parameters
* **eGeometryType**: the type code of the geometry to be created.

### Returns
handle to the newly create geometry or NULL on failure. Should be freed with OGR_G_DestroyGeometry() after use.
"""
function creategeometry(arg1::OGRwkbGeometryType)
    checknull(ccall((:OGR_G_CreateGeometry,libgdal),OGRGeometryH,(OGRwkbGeometryType,),arg1))
end


"""
    OGR_G_ApproximateArcAngles(double dfCenterX,
                               double dfCenterY,
                               double dfZ,
                               double dfPrimaryRadius,
                               double dfSecondaryAxis,
                               double dfRotation,
                               double dfStartAngle,
                               double dfEndAngle,
                               double dfMaxAngleStepSizeDegrees) -> OGRGeometryH

Stroke arc to linestring.

### Parameters
* **dfCenterX**: center X
* **dfCenterY**: center Y
* **dfZ**: center Z
* **dfPrimaryRadius**: X radius of ellipse.
* **dfSecondaryRadius**: Y radius of ellipse.
* **dfRotation**: rotation of the ellipse clockwise.
* **dfStartAngle**: angle to first point on arc (clockwise of X-positive)
* **dfEndAngle**: angle to last point on arc (clockwise of X-positive)
* **dfMaxAngleStepSizeDegrees**: the largest step in degrees along the arc, zero to use the default setting.

### Returns
OGRLineString geometry representing an approximation of the arc.
"""
function approximatearcangles(dfCenterX::Real,dfCenterY::Real,dfZ::Real,dfPrimaryRadius::Real,dfSecondaryAxis::Real,dfRotation::Real,dfStartAngle::Real,dfEndAngle::Real,dfMaxAngleStepSizeDegrees::Real)
    checknull(ccall((:OGR_G_ApproximateArcAngles,libgdal),OGRGeometryH,(Cdouble,Cdouble,Cdouble,Cdouble,Cdouble,Cdouble,Cdouble,Cdouble,Cdouble),dfCenterX,dfCenterY,dfZ,dfPrimaryRadius,dfSecondaryAxis,dfRotation,dfStartAngle,dfEndAngle,dfMaxAngleStepSizeDegrees))
end


"""
    OGR_G_ForceToPolygon(OGRGeometryH) -> OGRGeometryH

Convert to polygon.

### Parameters
* **hGeom**: handle to the geometry to convert (ownership surrendered).

### Returns
the converted geometry (ownership to caller).
"""
function forcetopolygon(arg1::OGRGeometryH)
    checknull(ccall((:OGR_G_ForceToPolygon,libgdal),OGRGeometryH,(OGRGeometryH,),arg1))
end


"""
    OGR_G_ForceToLineString(OGRGeometryH) -> OGRGeometryH

Convert to line string.

### Parameters
* **hGeom**: handle to the geometry to convert (ownership surrendered).

### Returns
the converted geometry (ownership to caller).
"""
function forcetolinestring(arg1::OGRGeometryH)
    checknull(ccall((:OGR_G_ForceToLineString,libgdal),OGRGeometryH,(OGRGeometryH,),arg1))
end


"""
    OGR_G_ForceToMultiPolygon(OGRGeometryH) -> OGRGeometryH

Convert to multipolygon.

### Parameters
* **hGeom**: handle to the geometry to convert (ownership surrendered).

### Returns
the converted geometry (ownership to caller).
"""
function forcetomultipolygon(arg1::OGRGeometryH)
    checknull(ccall((:OGR_G_ForceToMultiPolygon,libgdal),OGRGeometryH,(OGRGeometryH,),arg1))
end


"""
    OGR_G_ForceToMultiPoint(OGRGeometryH) -> OGRGeometryH

Convert to multipoint.

### Parameters
* **hGeom**: handle to the geometry to convert (ownership surrendered).

### Returns
the converted geometry (ownership to caller).
"""
function forcetomultipoint(arg1::OGRGeometryH)
    checknull(ccall((:OGR_G_ForceToMultiPoint,libgdal),OGRGeometryH,(OGRGeometryH,),arg1))
end


"""
    OGR_G_ForceToMultiLineString(OGRGeometryH) -> OGRGeometryH

Convert to multilinestring.

### Parameters
* **hGeom**: handle to the geometry to convert (ownership surrendered).

### Returns
the converted geometry (ownership to caller).
"""
function forcetomultilinestring(arg1::OGRGeometryH)
    checknull(ccall((:OGR_G_ForceToMultiLineString,libgdal),OGRGeometryH,(OGRGeometryH,),arg1))
end


"""
    OGR_G_ForceTo(OGRGeometryH hGeom,
                  OGRwkbGeometryType eTargetType,
                  char ** papszOptions) -> OGRGeometryH

Convert to another geometry type.

### Parameters
* **hGeom**: the input geometry - ownership is passed to the method.
* **eTargetType**: target output geometry type.
* **papszOptions**: options as a null-terminated list of strings or NULL.

### Returns
new geometry.
"""
function forceto(hGeom::OGRGeometryH,eTargetType::OGRwkbGeometryType,papszOptions::Vector{UTF8String})
    checknull(ccall((:OGR_G_ForceTo,libgdal),OGRGeometryH,(OGRGeometryH,OGRwkbGeometryType,Ptr{Ptr{UInt8}}),hGeom,eTargetType,papszOptions))
end


"""
    OGR_G_GetDimension(OGRGeometryH) -> int

Get the dimension of this geometry.

### Parameters
* **hGeom**: handle on the geometry to get the dimension from.

### Returns
0 for points, 1 for lines and 2 for surfaces.
"""
function getdimension(arg1::OGRGeometryH)
    ccall((:OGR_G_GetDimension,libgdal),Cint,(OGRGeometryH,),arg1)
end


"""
    OGR_G_GetCoordinateDimension(OGRGeometryH) -> int

Get the dimension of the coordinates in this geometry.

### Parameters
* **hGeom**: handle on the geometry to get the dimension of the coordinates from.

### Returns
in practice this will return 2 or 3. It can also return 0 in the case of an empty point.
"""
function getcoordinatedimension(arg1::OGRGeometryH)
    ccall((:OGR_G_GetCoordinateDimension,libgdal),Cint,(OGRGeometryH,),arg1)
end


"""
    OGR_G_SetCoordinateDimension(OGRGeometryH,
                                 int) -> void

Set the coordinate dimension.

### Parameters
* **hGeom**: handle on the geometry to set the dimension of the coordinates.
* **nNewDimension**: New coordinate dimension value, either 2 or 3.
"""
function setcoordinatedimension(arg1::OGRGeometryH,arg2::Integer)
    ccall((:OGR_G_SetCoordinateDimension,libgdal),Void,(OGRGeometryH,Cint),arg1,arg2)
end


"""
    OGR_G_Clone(OGRGeometryH) -> OGRGeometryH

Make a copy of this object.

### Parameters
* **hGeom**: handle on the geometry to clone from.

### Returns
an handle on the copy of the geometry with the spatial reference system as the original.
"""
function clone(arg1::OGRGeometryH)
    checknull(ccall((:OGR_G_Clone,libgdal),OGRGeometryH,(OGRGeometryH,),arg1))
end


"""
    OGR_G_GetEnvelope(OGRGeometryH,
                      OGREnvelope *) -> void

Computes and returns the bounding envelope for this geometry in the passed psEnvelope structure.

### Parameters
* **hGeom**: handle of the geometry to get envelope from.
* **psEnvelope**: the structure in which to place the results.
"""
function getenvelope(arg1::OGRGeometryH,arg2::Ptr{OGREnvelope})
    ccall((:OGR_G_GetEnvelope,libgdal),Void,(OGRGeometryH,Ptr{OGREnvelope}),arg1,arg2)
end


"""
    OGR_G_GetEnvelope3D(OGRGeometryH,
                        OGREnvelope3D *) -> void

Computes and returns the bounding envelope (3D) for this geometry in the passed psEnvelope structure.

### Parameters
* **hGeom**: handle of the geometry to get envelope from.
* **psEnvelope**: the structure in which to place the results.
"""
function getenvelope3d(arg1::OGRGeometryH,arg2::Ptr{OGREnvelope3D})
    ccall((:OGR_G_GetEnvelope3D,libgdal),Void,(OGRGeometryH,Ptr{OGREnvelope3D}),arg1,arg2)
end


"""
    OGR_G_ImportFromWkb(OGRGeometryH,
                        unsigned char *,
                        int) -> OGRErr

Assign geometry from well known binary data.

### Parameters
* **hGeom**: handle on the geometry to assign the well know binary data to.
* **pabyData**: the binary input data.
* **nSize**: the size of pabyData in bytes, or zero if not known.

### Returns
OGRERR_NONE if all goes well, otherwise any of OGRERR_NOT_ENOUGH_DATA, OGRERR_UNSUPPORTED_GEOMETRY_TYPE, or OGRERR_CORRUPT_DATA may be returned.
"""
function importfromwkb(arg1::OGRGeometryH,arg2::Ptr{Cuchar},arg3::Integer)
    ccall((:OGR_G_ImportFromWkb,libgdal),OGRErr,(OGRGeometryH,Ptr{Cuchar},Cint),arg1,arg2,arg3)
end


"""
    OGR_G_ExportToWkb(OGRGeometryH,
                      OGRwkbByteOrder,
                      unsigned char *) -> OGRErr

Convert a geometry well known binary format.

### Parameters
* **hGeom**: handle on the geometry to convert to a well know binary data from.
* **eOrder**: One of wkbXDR or wkbNDR indicating MSB or LSB byte order respectively.
* **pabyDstBuffer**: a buffer into which the binary representation is written. This buffer must be at least OGR_G_WkbSize() byte in size.

### Returns
Currently OGRERR_NONE is always returned.
"""
function exporttowkb(arg1::OGRGeometryH,arg2::OGRwkbByteOrder,arg3::Ptr{Cuchar})
    ccall((:OGR_G_ExportToWkb,libgdal),OGRErr,(OGRGeometryH,OGRwkbByteOrder,Ptr{Cuchar}),arg1,arg2,arg3)
end


"""
    OGR_G_ExportToIsoWkb(OGRGeometryH,
                         OGRwkbByteOrder,
                         unsigned char *) -> OGRErr

Convert a geometry into SFSQL 1.2 / ISO SQL/MM Part 3 well known binary format.

### Parameters
* **hGeom**: handle on the geometry to convert to a well know binary data from.
* **eOrder**: One of wkbXDR or wkbNDR indicating MSB or LSB byte order respectively.
* **pabyDstBuffer**: a buffer into which the binary representation is written. This buffer must be at least OGR_G_WkbSize() byte in size.

### Returns
Currently OGRERR_NONE is always returned.
"""
function exporttoisowkb(arg1::OGRGeometryH,arg2::OGRwkbByteOrder,arg3::Ptr{Cuchar})
    ccall((:OGR_G_ExportToIsoWkb,libgdal),OGRErr,(OGRGeometryH,OGRwkbByteOrder,Ptr{Cuchar}),arg1,arg2,arg3)
end


"""
    OGR_G_WkbSize(OGRGeometryH hGeom) -> int

Returns size of related binary representation.

### Parameters
* **hGeom**: handle on the geometry to get the binary size from.

### Returns
size of binary representation in bytes.
"""
function wkbsize(hGeom::OGRGeometryH)
    ccall((:OGR_G_WkbSize,libgdal),Cint,(OGRGeometryH,),hGeom)
end


"""
    OGR_G_ImportFromWkt(OGRGeometryH,
                        char **) -> OGRErr

Assign geometry from well known text data.

### Parameters
* **hGeom**: handle on the geometry to assign well know text data to.
* **ppszSrcText**: pointer to a pointer to the source text. The pointer is updated to pointer after the consumed text.

### Returns
OGRERR_NONE if all goes well, otherwise any of OGRERR_NOT_ENOUGH_DATA, OGRERR_UNSUPPORTED_GEOMETRY_TYPE, or OGRERR_CORRUPT_DATA may be returned.
"""
function importfromwkt(arg1::OGRGeometryH,arg2::Vector{UTF8String})
    ccall((:OGR_G_ImportFromWkt,libgdal),OGRErr,(OGRGeometryH,Ptr{Ptr{UInt8}}),arg1,arg2)
end


"""
    OGR_G_ExportToWkt(OGRGeometryH,
                      char **) -> OGRErr

Convert a geometry into well known text format.

### Parameters
* **hGeom**: handle on the geometry to convert to a text format from.
* **ppszSrcText**: a text buffer is allocated by the program, and assigned to the passed pointer. After use, *ppszDstText should be freed with OGRFree().

### Returns
Currently OGRERR_NONE is always returned.
"""
function exporttowkt(arg1::OGRGeometryH,arg2::Vector{UTF8String})
    ccall((:OGR_G_ExportToWkt,libgdal),OGRErr,(OGRGeometryH,Ptr{Ptr{UInt8}}),arg1,arg2)
end


"""
    OGR_G_ExportToIsoWkt(OGRGeometryH,
                         char **) -> OGRErr

Convert a geometry into SFSQL 1.2 / ISO SQL/MM Part 3 well known text format.

### Parameters
* **hGeom**: handle on the geometry to convert to a text format from.
* **ppszSrcText**: a text buffer is allocated by the program, and assigned to the passed pointer. After use, *ppszDstText should be freed with OGRFree().

### Returns
Currently OGRERR_NONE is always returned.
"""
function exporttoisowkt(arg1::OGRGeometryH,arg2::Vector{UTF8String})
    ccall((:OGR_G_ExportToIsoWkt,libgdal),OGRErr,(OGRGeometryH,Ptr{Ptr{UInt8}}),arg1,arg2)
end


"""
    OGR_G_GetGeometryType(OGRGeometryH) -> OGRwkbGeometryType

Fetch geometry type.

### Parameters
* **hGeom**: handle on the geometry to get type from.

### Returns
the geometry type code.
"""
function getgeometrytype(arg1::OGRGeometryH)
    ccall((:OGR_G_GetGeometryType,libgdal),OGRwkbGeometryType,(OGRGeometryH,),arg1)
end


"""
    OGR_G_GetGeometryName(OGRGeometryH) -> const char *

Fetch WKT name for geometry type.

### Parameters
* **hGeom**: handle on the geometry to get name from.

### Returns
name used for this geometry type in well known text format.
"""
function getgeometryname(arg1::OGRGeometryH)
    bytestring(ccall((:OGR_G_GetGeometryName,libgdal),Ptr{UInt8},(OGRGeometryH,),arg1))
end


"""
    OGR_G_DumpReadable(OGRGeometryH,
                       FILE *,
                       const char *) -> void

Dump geometry in well known text format to indicated output file.

### Parameters
* **hGeom**: handle on the geometry to dump.
* **fp**: the text file to write the geometry to.
* **pszPrefix**: the prefix to put on each line of output.
"""
function dumpreadable(arg1::OGRGeometryH,arg2::Ptr{FILE},arg3::AbstractString)
    ccall((:OGR_G_DumpReadable,libgdal),Void,(OGRGeometryH,Ptr{FILE},Ptr{UInt8}),arg1,arg2,arg3)
end


"""
    OGR_G_FlattenTo2D(OGRGeometryH) -> void

Convert geometry to strictly 2D.

### Parameters
* **hGeom**: handle on the geometry to convert.
"""
function flattento2d(arg1::OGRGeometryH)
    ccall((:OGR_G_FlattenTo2D,libgdal),Void,(OGRGeometryH,),arg1)
end


"""
    OGR_G_CloseRings(OGRGeometryH) -> void

Force rings to be closed.

### Parameters
* **hGeom**: handle to the geometry.
"""
function closerings(arg1::OGRGeometryH)
    ccall((:OGR_G_CloseRings,libgdal),Void,(OGRGeometryH,),arg1)
end


"""
    OGR_G_CreateFromGML(const char * pszGML) -> OGRGeometryH

Create geometry from GML.

### Parameters
* **pszGML**: The GML fragment for the geometry.

### Returns
a geometry on succes, or NULL on error.
"""
function createfromgml(arg1::AbstractString)
    checknull(ccall((:OGR_G_CreateFromGML,libgdal),OGRGeometryH,(Ptr{UInt8},),arg1))
end


"""
    OGR_G_ExportToGML(OGRGeometryH hGeometry) -> char *

Convert a geometry into GML format.

### Parameters
* **hGeometry**: handle to the geometry.

### Returns
A GML fragment or NULL in case of error.
"""
function exporttogml(arg1::OGRGeometryH)
    bytestring(ccall((:OGR_G_ExportToGML,libgdal),Ptr{UInt8},(OGRGeometryH,),arg1))
end


"""
    OGR_G_ExportToGMLEx(OGRGeometryH hGeometry,
                        char ** papszOptions) -> char *

Convert a geometry into GML format.

### Parameters
* **hGeometry**: handle to the geometry.
* **papszOptions**: NULL-terminated list of options.

### Returns
A GML fragment or NULL in case of error.
"""
function exporttogmlex(arg1::OGRGeometryH,papszOptions::Vector{UTF8String})
    bytestring(ccall((:OGR_G_ExportToGMLEx,libgdal),Ptr{UInt8},(OGRGeometryH,Ptr{Ptr{UInt8}}),arg1,papszOptions))
end


"""
    OGR_G_CreateFromGMLTree(const CPLXMLNode * psTree) -> OGRGeometryH
"""
function createfromgmltree(arg1::Ptr{CPLXMLNode})
    checknull(ccall((:OGR_G_CreateFromGMLTree,libgdal),OGRGeometryH,(Ptr{CPLXMLNode},),arg1))
end


"""
    OGR_G_ExportToGMLTree(OGRGeometryH hGeometry) -> CPLXMLNode *
"""
function exporttogmltree(arg1::OGRGeometryH)
    ccall((:OGR_G_ExportToGMLTree,libgdal),Ptr{CPLXMLNode},(OGRGeometryH,),arg1)
end


"""
    OGR_G_ExportEnvelopeToGMLTree(OGRGeometryH hGeometry) -> CPLXMLNode *
"""
function exportenvelopetogmltree(arg1::OGRGeometryH)
    ccall((:OGR_G_ExportEnvelopeToGMLTree,libgdal),Ptr{CPLXMLNode},(OGRGeometryH,),arg1)
end


"""
    OGR_G_ExportToKML(OGRGeometryH hGeometry,
                      const char * pszAltitudeMode) -> char *

Convert a geometry into KML format.

### Parameters
* **hGeometry**: handle to the geometry.
* **pszAltitudeMode**: value to write in altitudeMode element, or NULL.

### Returns
A KML fragment or NULL in case of error.
"""
function exporttokml(arg1::OGRGeometryH,pszAltitudeMode::AbstractString)
    bytestring(ccall((:OGR_G_ExportToKML,libgdal),Ptr{UInt8},(OGRGeometryH,Ptr{UInt8}),arg1,pszAltitudeMode))
end


"""
    OGR_G_ExportToJson(OGRGeometryH) -> char *

Convert a geometry into GeoJSON format.

### Parameters
* **hGeometry**: handle to the geometry.

### Returns
A GeoJSON fragment or NULL in case of error.
"""
function exporttojson(arg1::OGRGeometryH)
    bytestring(ccall((:OGR_G_ExportToJson,libgdal),Ptr{UInt8},(OGRGeometryH,),arg1))
end


"""
    OGR_G_ExportToJsonEx(OGRGeometryH,
                         char ** papszOptions) -> char *

Convert a geometry into GeoJSON format.

### Parameters
* **hGeometry**: handle to the geometry.
* **papszOptions**: a null terminated list of options. For now, only COORDINATE_PRECISION=int_number where int_number is the maximum number of figures after decimal separator to write in coordinates.

### Returns
A GeoJSON fragment or NULL in case of error.
"""
function exporttojsonex(arg1::OGRGeometryH,papszOptions::Vector{UTF8String})
    bytestring(ccall((:OGR_G_ExportToJsonEx,libgdal),Ptr{UInt8},(OGRGeometryH,Ptr{Ptr{UInt8}}),arg1,papszOptions))
end


"""
    OGR_G_CreateGeometryFromJson(const char *) -> OGRGeometryH
"""
function creategeometryfromjson(arg1::AbstractString)
    checknull(ccall((:OGR_G_CreateGeometryFromJson,libgdal),OGRGeometryH,(Ptr{UInt8},),arg1))
end


"""
    OGR_G_AssignSpatialReference(OGRGeometryH,
                                 OGRSpatialReferenceH) -> void

Assign spatial reference to this object.

### Parameters
* **hGeom**: handle on the geometry to apply the new spatial reference system.
* **hSRS**: handle on the new spatial reference system to apply.
"""
function assignspatialreference(arg1::OGRGeometryH,arg2::OGRSpatialReferenceH)
    ccall((:OGR_G_AssignSpatialReference,libgdal),Void,(OGRGeometryH,OGRSpatialReferenceH),arg1,arg2)
end


"""
    OGR_G_GetSpatialReference(OGRGeometryH) -> OGRSpatialReferenceH

Returns spatial reference system for geometry.

### Parameters
* **hGeom**: handle on the geometry to get spatial reference from.

### Returns
a reference to the spatial reference geometry.
"""
function getspatialreference(arg1::OGRGeometryH)
    checknull(ccall((:OGR_G_GetSpatialReference,libgdal),OGRSpatialReferenceH,(OGRGeometryH,),arg1))
end


"""
    OGR_G_Transform(OGRGeometryH,
                    OGRCoordinateTransformationH) -> OGRErr

Apply arbitrary coordinate transformation to geometry.

### Parameters
* **hGeom**: handle on the geometry to apply the transform to.
* **hTransform**: handle on the transformation to apply.

### Returns
OGRERR_NONE on success or an error code.
"""
function transform(arg1::OGRGeometryH,arg2::OGRCoordinateTransformationH)
    ccall((:OGR_G_Transform,libgdal),OGRErr,(OGRGeometryH,OGRCoordinateTransformationH),arg1,arg2)
end


"""
    OGR_G_TransformTo(OGRGeometryH,
                      OGRSpatialReferenceH) -> OGRErr

Transform geometry to new spatial reference system.

### Parameters
* **hGeom**: handle on the geometry to apply the transform to.
* **hSRS**: handle on the spatial reference system to apply.

### Returns
OGRERR_NONE on success, or an error code.
"""
function transformto(arg1::OGRGeometryH,arg2::OGRSpatialReferenceH)
    ccall((:OGR_G_TransformTo,libgdal),OGRErr,(OGRGeometryH,OGRSpatialReferenceH),arg1,arg2)
end


"""
    OGR_G_Simplify(OGRGeometryH hThis,
                   double tolerance) -> OGRGeometryH

Compute a simplified geometry.

### Parameters
* **hThis**: the geometry.
* **dTolerance**: the distance tolerance for the simplification.

### Returns
the simplified geometry or NULL if an error occurs.
"""
function simplify(hThis::OGRGeometryH,tolerance::Real)
    checknull(ccall((:OGR_G_Simplify,libgdal),OGRGeometryH,(OGRGeometryH,Cdouble),hThis,tolerance))
end


"""
    OGR_G_SimplifyPreserveTopology(OGRGeometryH hThis,
                                   double tolerance) -> OGRGeometryH

Simplify the geometry while preserving topology.

### Parameters
* **hThis**: the geometry.
* **dTolerance**: the distance tolerance for the simplification.

### Returns
the simplified geometry or NULL if an error occurs.
"""
function simplifypreservetopology(hThis::OGRGeometryH,tolerance::Real)
    checknull(ccall((:OGR_G_SimplifyPreserveTopology,libgdal),OGRGeometryH,(OGRGeometryH,Cdouble),hThis,tolerance))
end


"""
    OGR_G_Segmentize(OGRGeometryH hGeom,
                     double dfMaxLength) -> void

Modify the geometry such it has no segment longer then the given distance.

### Parameters
* **hGeom**: handle on the geometry to segmentize
* **dfMaxLength**: the maximum distance between 2 points after segmentization
"""
function segmentize(hGeom::OGRGeometryH,dfMaxLength::Real)
    ccall((:OGR_G_Segmentize,libgdal),Void,(OGRGeometryH,Cdouble),hGeom,dfMaxLength)
end


"""
    OGR_G_Intersects(OGRGeometryH,
                     OGRGeometryH) -> int

Do these features intersect?

### Parameters
* **hGeom**: handle on the first geometry.
* **hOtherGeom**: handle on the other geometry to test against.

### Returns
TRUE if the geometries intersect, otherwise FALSE.
"""
function intersects(arg1::OGRGeometryH,arg2::OGRGeometryH)
    ccall((:OGR_G_Intersects,libgdal),Cint,(OGRGeometryH,OGRGeometryH),arg1,arg2)
end


"""
    OGR_G_Equals(OGRGeometryH,
                 OGRGeometryH) -> int

Returns TRUE if two geometries are equivalent.

### Parameters
* **hGeom**: handle on the first geometry.
* **hOther**: handle on the other geometry to test against.

### Returns
TRUE if equivalent or FALSE otherwise.
"""
function equals(arg1::OGRGeometryH,arg2::OGRGeometryH)
    ccall((:OGR_G_Equals,libgdal),Cint,(OGRGeometryH,OGRGeometryH),arg1,arg2)
end


"""
    OGR_G_Disjoint(OGRGeometryH,
                   OGRGeometryH) -> int

Test for disjointness.

### Parameters
* **hThis**: the geometry to compare.
* **hOther**: the other geometry to compare.

### Returns
TRUE if they are disjoint, otherwise FALSE.
"""
function disjoint(arg1::OGRGeometryH,arg2::OGRGeometryH)
    ccall((:OGR_G_Disjoint,libgdal),Cint,(OGRGeometryH,OGRGeometryH),arg1,arg2)
end


"""
    OGR_G_Touches(OGRGeometryH,
                  OGRGeometryH) -> int

Test for touching.

### Parameters
* **hThis**: the geometry to compare.
* **hOther**: the other geometry to compare.

### Returns
TRUE if they are touching, otherwise FALSE.
"""
function touches(arg1::OGRGeometryH,arg2::OGRGeometryH)
    ccall((:OGR_G_Touches,libgdal),Cint,(OGRGeometryH,OGRGeometryH),arg1,arg2)
end


"""
    OGR_G_Crosses(OGRGeometryH,
                  OGRGeometryH) -> int

Test for crossing.

### Parameters
* **hThis**: the geometry to compare.
* **hOther**: the other geometry to compare.

### Returns
TRUE if they are crossing, otherwise FALSE.
"""
function crosses(arg1::OGRGeometryH,arg2::OGRGeometryH)
    ccall((:OGR_G_Crosses,libgdal),Cint,(OGRGeometryH,OGRGeometryH),arg1,arg2)
end


"""
    OGR_G_Within(OGRGeometryH,
                 OGRGeometryH) -> int

Test for containment.

### Parameters
* **hThis**: the geometry to compare.
* **hOther**: the other geometry to compare.

### Returns
TRUE if hThis is within hOther, otherwise FALSE.
"""
function within(arg1::OGRGeometryH,arg2::OGRGeometryH)
    ccall((:OGR_G_Within,libgdal),Cint,(OGRGeometryH,OGRGeometryH),arg1,arg2)
end


"""
    OGR_G_Contains(OGRGeometryH,
                   OGRGeometryH) -> int

Test for containment.

### Parameters
* **hThis**: the geometry to compare.
* **hOther**: the other geometry to compare.

### Returns
TRUE if hThis contains hOther geometry, otherwise FALSE.
"""
function contains(arg1::OGRGeometryH,arg2::OGRGeometryH)
    ccall((:OGR_G_Contains,libgdal),Cint,(OGRGeometryH,OGRGeometryH),arg1,arg2)
end


"""
    OGR_G_Overlaps(OGRGeometryH,
                   OGRGeometryH) -> int

Test for overlap.

### Parameters
* **hThis**: the geometry to compare.
* **hOther**: the other geometry to compare.

### Returns
TRUE if they are overlapping, otherwise FALSE.
"""
function overlaps(arg1::OGRGeometryH,arg2::OGRGeometryH)
    ccall((:OGR_G_Overlaps,libgdal),Cint,(OGRGeometryH,OGRGeometryH),arg1,arg2)
end


"""
    OGR_G_Boundary(OGRGeometryH) -> OGRGeometryH

Compute boundary.

### Parameters
* **hTarget**: The Geometry to calculate the boundary of.

### Returns
a handle to a newly allocated geometry now owned by the caller, or NULL on failure.
"""
function boundary(arg1::OGRGeometryH)
    checknull(ccall((:OGR_G_Boundary,libgdal),OGRGeometryH,(OGRGeometryH,),arg1))
end


"""
    OGR_G_ConvexHull(OGRGeometryH) -> OGRGeometryH

Compute convex hull.

### Parameters
* **hTarget**: The Geometry to calculate the convex hull of.

### Returns
a handle to a newly allocated geometry now owned by the caller, or NULL on failure.
"""
function convexhull(arg1::OGRGeometryH)
    checknull(ccall((:OGR_G_ConvexHull,libgdal),OGRGeometryH,(OGRGeometryH,),arg1))
end


"""
    OGR_G_Buffer(OGRGeometryH,
                 double,
                 int) -> OGRGeometryH

Compute buffer of geometry.

### Parameters
* **hTarget**: the geometry.
* **dfDist**: the buffer distance to be applied. Should be expressed into the same unit as the coordinates of the geometry.
* **nQuadSegs**: the number of segments used to approximate a 90 degree (quadrant) of curvature.

### Returns
the newly created geometry, or NULL if an error occurs.
"""
function buffer(arg1::OGRGeometryH,arg2::Real,arg3::Integer)
    checknull(ccall((:OGR_G_Buffer,libgdal),OGRGeometryH,(OGRGeometryH,Cdouble,Cint),arg1,arg2,arg3))
end


"""
    OGR_G_Intersection(OGRGeometryH,
                       OGRGeometryH) -> OGRGeometryH

Compute intersection.

### Parameters
* **hThis**: the geometry.
* **hOther**: the other geometry.

### Returns
a new geometry representing the intersection or NULL if there is no intersection or an error occurs.
"""
function intersection(arg1::OGRGeometryH,arg2::OGRGeometryH)
    checknull(ccall((:OGR_G_Intersection,libgdal),OGRGeometryH,(OGRGeometryH,OGRGeometryH),arg1,arg2))
end


"""
    OGR_G_Union(OGRGeometryH,
                OGRGeometryH) -> OGRGeometryH

Compute union.

### Parameters
* **hThis**: the geometry.
* **hOther**: the other geometry.

### Returns
a new geometry representing the union or NULL if an error occurs.
"""
function union(arg1::OGRGeometryH,arg2::OGRGeometryH)
    checknull(ccall((:OGR_G_Union,libgdal),OGRGeometryH,(OGRGeometryH,OGRGeometryH),arg1,arg2))
end


"""
    OGR_G_UnionCascaded(OGRGeometryH) -> OGRGeometryH

Compute union using cascading.

### Parameters
* **hThis**: the geometry.

### Returns
a new geometry representing the union or NULL if an error occurs.
"""
function unioncascaded(arg1::OGRGeometryH)
    checknull(ccall((:OGR_G_UnionCascaded,libgdal),OGRGeometryH,(OGRGeometryH,),arg1))
end


"""
    OGR_G_PointOnSurface(OGRGeometryH) -> OGRGeometryH

Returns a point guaranteed to lie on the surface.

### Parameters
* **hGeom**: the geometry to operate on.

### Returns
a point guaranteed to lie on the surface or NULL if an error occured.
"""
function pointonsurface(arg1::OGRGeometryH)
    checknull(ccall((:OGR_G_PointOnSurface,libgdal),OGRGeometryH,(OGRGeometryH,),arg1))
end


"""
    OGR_G_Difference(OGRGeometryH,
                     OGRGeometryH) -> OGRGeometryH

Compute difference.

### Parameters
* **hThis**: the geometry.
* **hOther**: the other geometry.

### Returns
a new geometry representing the difference or NULL if the difference is empty or an error occurs.
"""
function difference(arg1::OGRGeometryH,arg2::OGRGeometryH)
    checknull(ccall((:OGR_G_Difference,libgdal),OGRGeometryH,(OGRGeometryH,OGRGeometryH),arg1,arg2))
end


"""
    OGR_G_SymDifference(OGRGeometryH,
                        OGRGeometryH) -> OGRGeometryH

Compute symmetric difference.

### Parameters
* **hThis**: the geometry.
* **hOther**: the other geometry.

### Returns
a new geometry representing the symmetric difference or NULL if the difference is empty or an error occurs.
"""
function symdifference(arg1::OGRGeometryH,arg2::OGRGeometryH)
    checknull(ccall((:OGR_G_SymDifference,libgdal),OGRGeometryH,(OGRGeometryH,OGRGeometryH),arg1,arg2))
end


"""
    OGR_G_Distance(OGRGeometryH,
                   OGRGeometryH) -> double

Compute distance between two geometries.

### Parameters
* **hFirst**: the first geometry to compare against.
* **hOther**: the other geometry to compare against.

### Returns
the distance between the geometries or -1 if an error occurs.
"""
function distance(arg1::OGRGeometryH,arg2::OGRGeometryH)
    ccall((:OGR_G_Distance,libgdal),Cdouble,(OGRGeometryH,OGRGeometryH),arg1,arg2)
end


"""
    OGR_G_Length(OGRGeometryH hGeom) -> double

Compute length of a geometry.

### Parameters
* **hGeom**: the geometry to operate on.

### Returns
the lenght or 0.0 for unsupported geometry types.
"""
function length(arg1::OGRGeometryH)
    ccall((:OGR_G_Length,libgdal),Cdouble,(OGRGeometryH,),arg1)
end


"""
    OGR_G_Area(OGRGeometryH hGeom) -> double

Compute geometry area.

### Parameters
* **hGeom**: the geometry to operate on.

### Returns
the area or 0.0 for unsupported geometry types.
"""
function area(arg1::OGRGeometryH)
    ccall((:OGR_G_Area,libgdal),Cdouble,(OGRGeometryH,),arg1)
end


"""
    OGR_G_Centroid(OGRGeometryH,
                   OGRGeometryH) -> int

Compute the geometry centroid.

### Returns
OGRERR_NONE on success or OGRERR_FAILURE on error.
"""
function centroid(arg1::OGRGeometryH,arg2::OGRGeometryH)
    ccall((:OGR_G_Centroid,libgdal),Cint,(OGRGeometryH,OGRGeometryH),arg1,arg2)
end


"""
    OGR_G_Value(OGRGeometryH hGeom,
                double dfDistance) -> OGRGeometryH

Fetch point at given distance along curve.

### Parameters
* **hGeom**: curve geometry.
* **dfDistance**: distance along the curve at which to sample position. This distance should be between zero and get_Length() for this curve.

### Returns
a point or NULL.
"""
function value(arg1::OGRGeometryH,dfDistance::Real)
    checknull(ccall((:OGR_G_Value,libgdal),OGRGeometryH,(OGRGeometryH,Cdouble),arg1,dfDistance))
end


"""
    OGR_G_Empty(OGRGeometryH) -> void

Clear geometry information.

### Parameters
* **hGeom**: handle on the geometry to empty.
"""
function empty(arg1::OGRGeometryH)
    ccall((:OGR_G_Empty,libgdal),Void,(OGRGeometryH,),arg1)
end


"""
    OGR_G_IsEmpty(OGRGeometryH) -> int

Test if the geometry is empty.

### Parameters
* **hGeom**: The Geometry to test.

### Returns
TRUE if the geometry has no points, otherwise FALSE.
"""
function isempty(arg1::OGRGeometryH)
    ccall((:OGR_G_IsEmpty,libgdal),Cint,(OGRGeometryH,),arg1)
end


"""
    OGR_G_IsValid(OGRGeometryH) -> int

Test if the geometry is valid.

### Parameters
* **hGeom**: The Geometry to test.

### Returns
TRUE if the geometry has no points, otherwise FALSE.
"""
function isvalid(arg1::OGRGeometryH)
    ccall((:OGR_G_IsValid,libgdal),Cint,(OGRGeometryH,),arg1)
end


"""
    OGR_G_IsSimple(OGRGeometryH) -> int

Returns TRUE if the geometry is simple.

### Parameters
* **hGeom**: The Geometry to test.

### Returns
TRUE if object is simple, otherwise FALSE.
"""
function issimple(arg1::OGRGeometryH)
    ccall((:OGR_G_IsSimple,libgdal),Cint,(OGRGeometryH,),arg1)
end


"""
    OGR_G_IsRing(OGRGeometryH) -> int

Test if the geometry is a ring.

### Parameters
* **hGeom**: The Geometry to test.

### Returns
TRUE if the geometry has no points, otherwise FALSE.
"""
function isring(arg1::OGRGeometryH)
    ccall((:OGR_G_IsRing,libgdal),Cint,(OGRGeometryH,),arg1)
end


"""
    OGR_G_Polygonize(OGRGeometryH) -> OGRGeometryH

Polygonizes a set of sparse edges.

### Parameters
* **hTarget**: The Geometry to be polygonized.

### Returns
a handle to a newly allocated geometry now owned by the caller, or NULL on failure.
"""
function polygonize(arg1::OGRGeometryH)
    checknull(ccall((:OGR_G_Polygonize,libgdal),OGRGeometryH,(OGRGeometryH,),arg1))
end


"""
    OGR_G_Intersect(OGRGeometryH,
                    OGRGeometryH) -> int
"""
function intersect(arg1::OGRGeometryH,arg2::OGRGeometryH)
    ccall((:OGR_G_Intersect,libgdal),Cint,(OGRGeometryH,OGRGeometryH),arg1,arg2)
end


"""
    OGR_G_Equal(OGRGeometryH,
                OGRGeometryH) -> int
"""
function equal(arg1::OGRGeometryH,arg2::OGRGeometryH)
    ccall((:OGR_G_Equal,libgdal),Cint,(OGRGeometryH,OGRGeometryH),arg1,arg2)
end


"""
    OGR_G_SymmetricDifference(OGRGeometryH,
                              OGRGeometryH) -> OGRGeometryH

Compute symmetric difference (deprecated)
"""
function symmetricdifference(arg1::OGRGeometryH,arg2::OGRGeometryH)
    checknull(ccall((:OGR_G_SymmetricDifference,libgdal),OGRGeometryH,(OGRGeometryH,OGRGeometryH),arg1,arg2))
end


"""
    OGR_G_GetArea(OGRGeometryH hGeom) -> double

Compute geometry area (deprecated)
"""
function getarea(arg1::OGRGeometryH)
    ccall((:OGR_G_GetArea,libgdal),Cdouble,(OGRGeometryH,),arg1)
end


"""
    OGR_G_GetBoundary(OGRGeometryH) -> OGRGeometryH

Compute boundary (deprecated)
"""
function getboundary(arg1::OGRGeometryH)
    checknull(ccall((:OGR_G_GetBoundary,libgdal),OGRGeometryH,(OGRGeometryH,),arg1))
end


"""
    OGR_G_GetPointCount(OGRGeometryH hGeom) -> int

Fetch number of points from a geometry.

### Parameters
* **hGeom**: handle to the geometry from which to get the number of points.

### Returns
the number of points.
"""
function getpointcount(arg1::OGRGeometryH)
    ccall((:OGR_G_GetPointCount,libgdal),Cint,(OGRGeometryH,),arg1)
end


"""
    OGR_G_GetPoints(OGRGeometryH hGeom,
                    void * pabyX,
                    int nXStride,
                    void * pabyY,
                    int nYStride,
                    void * pabyZ,
                    int nZStride) -> int

Returns all points of line string.

### Parameters
* **hGeom**: handle to the geometry from which to get the coordinates.
* **pabyX**: a buffer of at least (sizeof(double) * nXStride * nPointCount) bytes, may be NULL.
* **nXStride**: the number of bytes between 2 elements of pabyX.
* **pabyY**: a buffer of at least (sizeof(double) * nYStride * nPointCount) bytes, may be NULL.
* **nYStride**: the number of bytes between 2 elements of pabyY.
* **pabyZ**: a buffer of at last size (sizeof(double) * nZStride * nPointCount) bytes, may be NULL.
* **nZStride**: the number of bytes between 2 elements of pabyZ.

### Returns
the number of points
"""
function getpoints(hGeom::OGRGeometryH,pabyX::Ptr{Void},nXStride::Integer,pabyY::Ptr{Void},nYStride::Integer,pabyZ::Ptr{Void},nZStride::Integer)
    ccall((:OGR_G_GetPoints,libgdal),Cint,(OGRGeometryH,Ptr{Void},Cint,Ptr{Void},Cint,Ptr{Void},Cint),hGeom,pabyX,nXStride,pabyY,nYStride,pabyZ,nZStride)
end


"""
    OGR_G_GetX(OGRGeometryH hGeom,
               int i) -> double

Fetch the x coordinate of a point from a geometry.

### Parameters
* **hGeom**: handle to the geometry from which to get the x coordinate.
* **i**: point to get the x coordinate.

### Returns
the X coordinate of this point.
"""
function getx(arg1::OGRGeometryH,arg2::Integer)
    ccall((:OGR_G_GetX,libgdal),Cdouble,(OGRGeometryH,Cint),arg1,arg2)
end


"""
    OGR_G_GetY(OGRGeometryH hGeom,
               int i) -> double

Fetch the x coordinate of a point from a geometry.

### Parameters
* **hGeom**: handle to the geometry from which to get the y coordinate.
* **i**: point to get the Y coordinate.

### Returns
the Y coordinate of this point.
"""
function gety(arg1::OGRGeometryH,arg2::Integer)
    ccall((:OGR_G_GetY,libgdal),Cdouble,(OGRGeometryH,Cint),arg1,arg2)
end


"""
    OGR_G_GetZ(OGRGeometryH hGeom,
               int i) -> double

Fetch the z coordinate of a point from a geometry.

### Parameters
* **hGeom**: handle to the geometry from which to get the Z coordinate.
* **i**: point to get the Z coordinate.

### Returns
the Z coordinate of this point.
"""
function getz(arg1::OGRGeometryH,arg2::Integer)
    ccall((:OGR_G_GetZ,libgdal),Cdouble,(OGRGeometryH,Cint),arg1,arg2)
end


"""
    OGR_G_GetPoint(OGRGeometryH hGeom,
                   int i,
                   double * pdfX,
                   double * pdfY,
                   double * pdfZ) -> void

Fetch a point in line string or a point geometry.

### Parameters
* **hGeom**: handle to the geometry from which to get the coordinates.
* **i**: the vertex to fetch, from 0 to getNumPoints()-1, zero for a point.
* **pdfX**: value of x coordinate.
* **pdfY**: value of y coordinate.
* **pdfZ**: value of z coordinate.
"""
function getpoint(arg1::OGRGeometryH,iPoint::Integer,arg2::Vector{Float64},arg3::Vector{Float64},arg4::Vector{Float64})
    ccall((:OGR_G_GetPoint,libgdal),Void,(OGRGeometryH,Cint,Ptr{Cdouble},Ptr{Cdouble},Ptr{Cdouble}),arg1,iPoint,arg2,arg3,arg4)
end


"""
    OGR_G_SetPointCount(OGRGeometryH hGeom,
                        int nNewPointCount) -> void

Set number of points in a geometry.

### Parameters
* **nNewPointCount**: the new number of points for geometry.
"""
function setpointcount(hGeom::OGRGeometryH,nNewPointCount::Integer)
    ccall((:OGR_G_SetPointCount,libgdal),Void,(OGRGeometryH,Cint),hGeom,nNewPointCount)
end


"""
    OGR_G_SetPoint(OGRGeometryH hGeom,
                   int i,
                   double dfX,
                   double dfY,
                   double dfZ) -> void

Set the location of a vertex in a point or linestring geometry.

### Parameters
* **hGeom**: handle to the geometry to add a vertex to.
* **i**: the index of the vertex to assign (zero based) or zero for a point.
* **dfX**: input X coordinate to assign.
* **dfY**: input Y coordinate to assign.
* **dfZ**: input Z coordinate to assign (defaults to zero).
"""
function setpoint(arg1::OGRGeometryH,iPoint::Integer,arg2::Real,arg3::Real,arg4::Real)
    ccall((:OGR_G_SetPoint,libgdal),Void,(OGRGeometryH,Cint,Cdouble,Cdouble,Cdouble),arg1,iPoint,arg2,arg3,arg4)
end


"""
    OGR_G_SetPoint_2D(OGRGeometryH hGeom,
                      int i,
                      double dfX,
                      double dfY) -> void

Set the location of a vertex in a point or linestring geometry.

### Parameters
* **hGeom**: handle to the geometry to add a vertex to.
* **i**: the index of the vertex to assign (zero based) or zero for a point.
* **dfX**: input X coordinate to assign.
* **dfY**: input Y coordinate to assign.
"""
function setpoint_2d(arg1::OGRGeometryH,iPoint::Integer,arg2::Real,arg3::Real)
    ccall((:OGR_G_SetPoint_2D,libgdal),Void,(OGRGeometryH,Cint,Cdouble,Cdouble),arg1,iPoint,arg2,arg3)
end


"""
    OGR_G_AddPoint(OGRGeometryH hGeom,
                   double dfX,
                   double dfY,
                   double dfZ) -> void

Add a point to a geometry (line string or point).

### Parameters
* **hGeom**: handle to the geometry to add a point to.
* **dfX**: x coordinate of point to add.
* **dfY**: y coordinate of point to add.
* **dfZ**: z coordinate of point to add.
"""
function addpoint(arg1::OGRGeometryH,arg2::Real,arg3::Real,arg4::Real)
    ccall((:OGR_G_AddPoint,libgdal),Void,(OGRGeometryH,Cdouble,Cdouble,Cdouble),arg1,arg2,arg3,arg4)
end


"""
    OGR_G_AddPoint_2D(OGRGeometryH hGeom,
                      double dfX,
                      double dfY) -> void

Add a point to a geometry (line string or point).

### Parameters
* **hGeom**: handle to the geometry to add a point to.
* **dfX**: x coordinate of point to add.
* **dfY**: y coordinate of point to add.
"""
function addpoint_2d(arg1::OGRGeometryH,arg2::Real,arg3::Real)
    ccall((:OGR_G_AddPoint_2D,libgdal),Void,(OGRGeometryH,Cdouble,Cdouble),arg1,arg2,arg3)
end


"""
    OGR_G_SetPoints(OGRGeometryH hGeom,
                    int nPointsIn,
                    void * pabyX,
                    int nXStride,
                    void * pabyY,
                    int nYStride,
                    void * pabyZ,
                    int nZStride) -> void

Assign all points in a point or a line string geometry.

### Parameters
* **hGeom**: handle to the geometry to set the coordinates.
* **nPointsIn**: number of points being passed in padfX and padfY.
* **padfX**: list of X coordinates of points being assigned.
* **nXStride**: the number of bytes between 2 elements of pabyX.
* **padfY**: list of Y coordinates of points being assigned.
* **nYStride**: the number of bytes between 2 elements of pabyY.
* **padfZ**: list of Z coordinates of points being assigned (defaults to NULL for 2D objects).
* **nZStride**: the number of bytes between 2 elements of pabyZ.
"""
function setpoints(hGeom::OGRGeometryH,nPointsIn::Integer,pabyX::Ptr{Void},nXStride::Integer,pabyY::Ptr{Void},nYStride::Integer,pabyZ::Ptr{Void},nZStride::Integer)
    ccall((:OGR_G_SetPoints,libgdal),Void,(OGRGeometryH,Cint,Ptr{Void},Cint,Ptr{Void},Cint,Ptr{Void},Cint),hGeom,nPointsIn,pabyX,nXStride,pabyY,nYStride,pabyZ,nZStride)
end


"""
    OGR_G_GetGeometryCount(OGRGeometryH hGeom) -> int

Fetch the number of elements in a geometry or number of geometries in container.

### Parameters
* **hGeom**: single geometry or geometry container from which to get the number of elements.

### Returns
the number of elements.
"""
function getgeometrycount(arg1::OGRGeometryH)
    ccall((:OGR_G_GetGeometryCount,libgdal),Cint,(OGRGeometryH,),arg1)
end


"""
    OGR_G_GetGeometryRef(OGRGeometryH hGeom,
                         int iSubGeom) -> OGRGeometryH

Fetch geometry from a geometry container.

### Parameters
* **hGeom**: handle to the geometry container from which to get a geometry from.
* **iSubGeom**: the index of the geometry to fetch, between 0 and getNumGeometries() - 1.

### Returns
handle to the requested geometry.
"""
function getgeometryref(arg1::OGRGeometryH,arg2::Integer)
    checknull(ccall((:OGR_G_GetGeometryRef,libgdal),OGRGeometryH,(OGRGeometryH,Cint),arg1,arg2))
end


"""
    OGR_G_AddGeometry(OGRGeometryH hGeom,
                      OGRGeometryH hNewSubGeom) -> OGRErr

Add a geometry to a geometry container.

### Parameters
* **hGeom**: existing geometry container.
* **hNewSubGeom**: geometry to add to the container.

### Returns
OGRERR_NONE if successful, or OGRERR_UNSUPPORTED_GEOMETRY_TYPE if the geometry type is illegal for the type of existing geometry.
"""
function addgeometry(arg1::OGRGeometryH,arg2::OGRGeometryH)
    ccall((:OGR_G_AddGeometry,libgdal),OGRErr,(OGRGeometryH,OGRGeometryH),arg1,arg2)
end


"""
    OGR_G_AddGeometryDirectly(OGRGeometryH hGeom,
                              OGRGeometryH hNewSubGeom) -> OGRErr

Add a geometry directly to an existing geometry container.

### Parameters
* **hGeom**: existing geometry.
* **hNewSubGeom**: geometry to add to the existing geometry.

### Returns
OGRERR_NONE if successful, or OGRERR_UNSUPPORTED_GEOMETRY_TYPE if the geometry type is illegal for the type of geometry container.
"""
function addgeometrydirectly(arg1::OGRGeometryH,arg2::OGRGeometryH)
    ccall((:OGR_G_AddGeometryDirectly,libgdal),OGRErr,(OGRGeometryH,OGRGeometryH),arg1,arg2)
end


"""
    OGR_G_RemoveGeometry(OGRGeometryH hGeom,
                         int iGeom,
                         int bDelete) -> OGRErr

Remove a geometry from an exiting geometry container.

### Parameters
* **hGeom**: the existing geometry to delete from.
* **iGeom**: the index of the geometry to delete. A value of -1 is a special flag meaning that all geometries should be removed.
* **bDelete**: if TRUE the geometry will be destroyed, otherwise it will not. The default is TRUE as the existing geometry is considered to own the geometries in it.

### Returns
OGRERR_NONE if successful, or OGRERR_FAILURE if the index is out of range.
"""
function removegeometry(arg1::OGRGeometryH,arg2::Integer,arg3::Integer)
    ccall((:OGR_G_RemoveGeometry,libgdal),OGRErr,(OGRGeometryH,Cint,Cint),arg1,arg2,arg3)
end


"""
    OGR_G_HasCurveGeometry(OGRGeometryH hGeom,
                           int bLookForNonLinear) -> int

Returns if this geometry is or has curve geometry.

### Parameters
* **hGeom**: the geometry to operate on.
* **bLookForNonLinear**: set it to TRUE to check if the geometry is or contains a CIRCULARSTRING.

### Returns
TRUE if this geometry is or has curve geometry.
"""
function hascurvegeometry(arg1::OGRGeometryH,bLookForNonLinear::Integer)
    ccall((:OGR_G_HasCurveGeometry,libgdal),Cint,(OGRGeometryH,Cint),arg1,bLookForNonLinear)
end


"""
    OGR_G_GetLinearGeometry(OGRGeometryH hGeom,
                            double dfMaxAngleStepSizeDegrees,
                            char ** papszOptions) -> OGRGeometryH

Return, possibly approximate, linear version of this geometry.

### Parameters
* **hGeom**: the geometry to operate on.
* **dfMaxAngleStepSizeDegrees**: the largest step in degrees along the arc, zero to use the default setting.
* **papszOptions**: options as a null-terminated list of strings or NULL. See OGRGeometryFactory::curveToLineString() for valid options.

### Returns
a new geometry.
"""
function getlineargeometry(hGeom::OGRGeometryH,dfMaxAngleStepSizeDegrees::Real,papszOptions::Vector{UTF8String})
    checknull(ccall((:OGR_G_GetLinearGeometry,libgdal),OGRGeometryH,(OGRGeometryH,Cdouble,Ptr{Ptr{UInt8}}),hGeom,dfMaxAngleStepSizeDegrees,papszOptions))
end


"""
    OGR_G_GetCurveGeometry(OGRGeometryH hGeom,
                           char ** papszOptions) -> OGRGeometryH

Return curve version of this geometry.

### Parameters
* **hGeom**: the geometry to operate on.
* **papszOptions**: options as a null-terminated list of strings. Unused for now. Must be set to NULL.

### Returns
a new geometry.
"""
function getcurvegeometry(hGeom::OGRGeometryH,papszOptions::Vector{UTF8String})
    checknull(ccall((:OGR_G_GetCurveGeometry,libgdal),OGRGeometryH,(OGRGeometryH,Ptr{Ptr{UInt8}}),hGeom,papszOptions))
end


"""
    OGRBuildPolygonFromEdges(OGRGeometryH hLinesAsCollection,
                             int bBestEffort,
                             int bAutoClose,
                             double dfTolerance,
                             OGRErr * peErr) -> OGRGeometryH

Build a ring from a bunch of arcs.

### Parameters
* **hLines**: handle to an OGRGeometryCollection (or OGRMultiLineString) containing the line string geometries to be built into rings.
* **bBestEffort**: not yet implemented???.
* **bAutoClose**: indicates if the ring should be close when first and last points of the ring are the same.
* **dfTolerance**: tolerance into which two arcs are considered close enough to be joined.
* **peErr**: OGRERR_NONE on success, or OGRERR_FAILURE on failure.

### Returns
an handle to the new geometry, a polygon.
"""
function buildpolygonfromedges(hLinesAsCollection::OGRGeometryH,bBestEffort::Integer,bAutoClose::Integer,dfTolerance::Real,peErr::Ptr{OGRErr})
    checknull(ccall((:OGRBuildPolygonFromEdges,libgdal),OGRGeometryH,(OGRGeometryH,Cint,Cint,Cdouble,Ptr{OGRErr}),hLinesAsCollection,bBestEffort,bAutoClose,dfTolerance,peErr))
end


"""
    OGRSetGenerate_DB2_V72_BYTE_ORDER(int bGenerate_DB2_V72_BYTE_ORDER) -> OGRErr

Special entry point to enable the hack for generating DB2 V7.2 style WKB.
"""
function setgenerate_db2_v72_byte_order(bGenerate_DB2_V72_BYTE_ORDER::Integer)
    ccall((:OGRSetGenerate_DB2_V72_BYTE_ORDER,libgdal),OGRErr,(Cint,),bGenerate_DB2_V72_BYTE_ORDER)
end


"""
    OGRGetGenerate_DB2_V72_BYTE_ORDER(void) -> int
"""
function getgenerate_db2_v72_byte_order()
    ccall((:OGRGetGenerate_DB2_V72_BYTE_ORDER,libgdal),Cint,())
end


"""
    OGRSetNonLinearGeometriesEnabledFlag(int bFlag) -> void

Set flag to enable/disable returning non-linear geometries in the C API.

### Parameters
* **bFlag**: TRUE if non-linear geometries might be returned (default value). FALSE to ask for non-linear geometries to be approximated as linear geometries.

### Returns
a point or NULL.
"""
function setnonlineargeometriesenabledflag(bFlag::Integer)
    ccall((:OGRSetNonLinearGeometriesEnabledFlag,libgdal),Void,(Cint,),bFlag)
end


"""
    OGRGetNonLinearGeometriesEnabledFlag(void) -> int

Get flag to enable/disable returning non-linear geometries in the C API.
"""
function getnonlineargeometriesenabledflag()
    ccall((:OGRGetNonLinearGeometriesEnabledFlag,libgdal),Cint,())
end


"""
    OGR_Fld_Create(const char *,
                   OGRFieldType) -> OGRFieldDefnH

Create a new field definition.

### Parameters
* **pszName**: the name of the new field definition.
* **eType**: the type of the new field definition.

### Returns
handle to the new field definition.
"""
function create(arg1::AbstractString,arg2::OGRFieldType)
    checknull(ccall((:OGR_Fld_Create,libgdal),OGRFieldDefnH,(Ptr{UInt8},OGRFieldType),arg1,arg2))
end


"""
    OGR_Fld_Destroy(OGRFieldDefnH) -> void

Destroy a field definition.

### Parameters
* **hDefn**: handle to the field definition to destroy.
"""
function destroy(arg1::OGRFieldDefnH)
    ccall((:OGR_Fld_Destroy,libgdal),Void,(OGRFieldDefnH,),arg1)
end


"""
    OGR_Fld_SetName(OGRFieldDefnH,
                    const char *) -> void

Reset the name of this field.

### Parameters
* **hDefn**: handle to the field definition to apply the new name to.
* **pszName**: the new name to apply.
"""
function setname(arg1::OGRFieldDefnH,arg2::AbstractString)
    ccall((:OGR_Fld_SetName,libgdal),Void,(OGRFieldDefnH,Ptr{UInt8}),arg1,arg2)
end


"""
    OGR_Fld_GetNameRef(OGRFieldDefnH) -> const char *

Fetch name of this field.

### Parameters
* **hDefn**: handle to the field definition.

### Returns
the name of the field definition.
"""
function getnameref(arg1::OGRFieldDefnH)
    bytestring(ccall((:OGR_Fld_GetNameRef,libgdal),Ptr{UInt8},(OGRFieldDefnH,),arg1))
end


"""
    OGR_Fld_GetType(OGRFieldDefnH) -> OGRFieldType

Fetch type of this field.

### Parameters
* **hDefn**: handle to the field definition to get type from.

### Returns
field type.
"""
function gettype(arg1::OGRFieldDefnH)
    ccall((:OGR_Fld_GetType,libgdal),OGRFieldType,(OGRFieldDefnH,),arg1)
end


"""
    OGR_Fld_SetType(OGRFieldDefnH,
                    OGRFieldType) -> void

Set the type of this field.

### Parameters
* **hDefn**: handle to the field definition to set type to.
* **eType**: the new field type.
"""
function settype(arg1::OGRFieldDefnH,arg2::OGRFieldType)
    ccall((:OGR_Fld_SetType,libgdal),Void,(OGRFieldDefnH,OGRFieldType),arg1,arg2)
end


"""
    OGR_Fld_GetSubType(OGRFieldDefnH) -> OGRFieldSubType

Fetch subtype of this field.

### Parameters
* **hDefn**: handle to the field definition to get subtype from.

### Returns
field subtype.
"""
function getsubtype(arg1::OGRFieldDefnH)
    ccall((:OGR_Fld_GetSubType,libgdal),OGRFieldSubType,(OGRFieldDefnH,),arg1)
end


"""
    OGR_Fld_SetSubType(OGRFieldDefnH,
                       OGRFieldSubType) -> void

Set the subtype of this field.

### Parameters
* **hDefn**: handle to the field definition to set type to.
* **eSubType**: the new field subtype.
"""
function setsubtype(arg1::OGRFieldDefnH,arg2::OGRFieldSubType)
    ccall((:OGR_Fld_SetSubType,libgdal),Void,(OGRFieldDefnH,OGRFieldSubType),arg1,arg2)
end


"""
    OGR_Fld_GetJustify(OGRFieldDefnH) -> OGRJustification

Get the justification for this field.

### Parameters
* **hDefn**: handle to the field definition to get justification from.

### Returns
the justification.
"""
function getjustify(arg1::OGRFieldDefnH)
    ccall((:OGR_Fld_GetJustify,libgdal),OGRJustification,(OGRFieldDefnH,),arg1)
end


"""
    OGR_Fld_SetJustify(OGRFieldDefnH,
                       OGRJustification) -> void

Set the justification for this field.

### Parameters
* **hDefn**: handle to the field definition to set justification to.
* **eJustify**: the new justification.
"""
function setjustify(arg1::OGRFieldDefnH,arg2::OGRJustification)
    ccall((:OGR_Fld_SetJustify,libgdal),Void,(OGRFieldDefnH,OGRJustification),arg1,arg2)
end


"""
    OGR_Fld_GetWidth(OGRFieldDefnH) -> int

Get the formatting width for this field.

### Parameters
* **hDefn**: handle to the field definition to get width from.

### Returns
the width, zero means no specified width.
"""
function getwidth(arg1::OGRFieldDefnH)
    ccall((:OGR_Fld_GetWidth,libgdal),Cint,(OGRFieldDefnH,),arg1)
end


"""
    OGR_Fld_SetWidth(OGRFieldDefnH,
                     int) -> void

Set the formatting width for this field in characters.

### Parameters
* **hDefn**: handle to the field definition to set width to.
* **nNewWidth**: the new width.
"""
function setwidth(arg1::OGRFieldDefnH,arg2::Integer)
    ccall((:OGR_Fld_SetWidth,libgdal),Void,(OGRFieldDefnH,Cint),arg1,arg2)
end


"""
    OGR_Fld_GetPrecision(OGRFieldDefnH) -> int

Get the formatting precision for this field.

### Parameters
* **hDefn**: handle to the field definition to get precision from.

### Returns
the precision.
"""
function getprecision(arg1::OGRFieldDefnH)
    ccall((:OGR_Fld_GetPrecision,libgdal),Cint,(OGRFieldDefnH,),arg1)
end


"""
    OGR_Fld_SetPrecision(OGRFieldDefnH,
                         int) -> void

Set the formatting precision for this field in characters.

### Parameters
* **hDefn**: handle to the field definition to set precision to.
* **nPrecision**: the new precision.
"""
function setprecision(arg1::OGRFieldDefnH,arg2::Integer)
    ccall((:OGR_Fld_SetPrecision,libgdal),Void,(OGRFieldDefnH,Cint),arg1,arg2)
end


"""
    OGR_Fld_Set(OGRFieldDefnH,
                const char *,
                OGRFieldType,
                int,
                int,
                OGRJustification) -> void

Set defining parameters for a field in one call.

### Parameters
* **hDefn**: handle to the field definition to set to.
* **pszNameIn**: the new name to assign.
* **eTypeIn**: the new type (one of the OFT values like OFTInteger).
* **nWidthIn**: the preferred formatting width. Defaults to zero indicating undefined.
* **nPrecisionIn**: number of decimals places for formatting, defaults to zero indicating undefined.
* **eJustifyIn**: the formatting justification (OJLeft or OJRight), defaults to OJUndefined.
"""
function set(arg1::OGRFieldDefnH,arg2::AbstractString,arg3::OGRFieldType,arg4::Integer,arg5::Integer,arg6::OGRJustification)
    ccall((:OGR_Fld_Set,libgdal),Void,(OGRFieldDefnH,Ptr{UInt8},OGRFieldType,Cint,Cint,OGRJustification),arg1,arg2,arg3,arg4,arg5,arg6)
end


"""
    OGR_Fld_IsIgnored(OGRFieldDefnH hDefn) -> int

Return whether this field should be omitted when fetching features.

### Parameters
* **hDefn**: handle to the field definition

### Returns
ignore state
"""
function isignored(hDefn::OGRFieldDefnH)
    ccall((:OGR_Fld_IsIgnored,libgdal),Cint,(OGRFieldDefnH,),hDefn)
end


"""
    OGR_Fld_SetIgnored(OGRFieldDefnH hDefn,
                       int) -> void

Set whether this field should be omitted when fetching features.

### Parameters
* **hDefn**: handle to the field definition
* **ignore**: ignore state
"""
function setignored(hDefn::OGRFieldDefnH,arg1::Integer)
    ccall((:OGR_Fld_SetIgnored,libgdal),Void,(OGRFieldDefnH,Cint),hDefn,arg1)
end


"""
    OGR_Fld_IsNullable(OGRFieldDefnH hDefn) -> int

Return whether this field can receive null values.

### Parameters
* **hDefn**: handle to the field definition

### Returns
TRUE if the field is authorized to be null.
"""
function isnullable(hDefn::OGRFieldDefnH)
    ccall((:OGR_Fld_IsNullable,libgdal),Cint,(OGRFieldDefnH,),hDefn)
end


"""
    OGR_Fld_SetNullable(OGRFieldDefnH hDefn,
                        int) -> void

Set whether this field can receive null values.

### Parameters
* **hDefn**: handle to the field definition
* **bNullableIn**: FALSE if the field must have a not-null constraint.
"""
function setnullable(hDefn::OGRFieldDefnH,arg1::Integer)
    ccall((:OGR_Fld_SetNullable,libgdal),Void,(OGRFieldDefnH,Cint),hDefn,arg1)
end


"""
    OGR_Fld_GetDefault(OGRFieldDefnH hDefn) -> const char *

Get default field value.

### Parameters
* **hDefn**: handle to the field definition.

### Returns
default field value or NULL.
"""
function getdefault(hDefn::OGRFieldDefnH)
    bytestring(ccall((:OGR_Fld_GetDefault,libgdal),Ptr{UInt8},(OGRFieldDefnH,),hDefn))
end


"""
    OGR_Fld_SetDefault(OGRFieldDefnH hDefn,
                       const char *) -> void

Set default field value.

### Parameters
* **hDefn**: handle to the field definition.
* **pszDefault**: new default field value or NULL pointer.
"""
function setdefault(hDefn::OGRFieldDefnH,arg1::AbstractString)
    ccall((:OGR_Fld_SetDefault,libgdal),Void,(OGRFieldDefnH,Ptr{UInt8}),hDefn,arg1)
end


"""
    OGR_Fld_IsDefaultDriverSpecific(OGRFieldDefnH hDefn) -> int

Returns whether the default value is driver specific.

### Parameters
* **hDefn**: handle to the field definition

### Returns
TRUE if the default value is driver specific.
"""
function isdefaultdriverspecific(hDefn::OGRFieldDefnH)
    ccall((:OGR_Fld_IsDefaultDriverSpecific,libgdal),Cint,(OGRFieldDefnH,),hDefn)
end


"""
    OGR_GetFieldTypeName(OGRFieldType) -> const char *

Fetch human readable name for a field type.

### Parameters
* **eType**: the field type to get name for.

### Returns
the name.
"""
function getfieldtypename(arg1::OGRFieldType)
    bytestring(ccall((:OGR_GetFieldTypeName,libgdal),Ptr{UInt8},(OGRFieldType,),arg1))
end


"""
    OGR_GetFieldSubTypeName(OGRFieldSubType) -> const char *

Fetch human readable name for a field subtype.

### Parameters
* **eSubType**: the field subtype to get name for.

### Returns
the name.
"""
function getfieldsubtypename(arg1::OGRFieldSubType)
    bytestring(ccall((:OGR_GetFieldSubTypeName,libgdal),Ptr{UInt8},(OGRFieldSubType,),arg1))
end


"""
    OGR_AreTypeSubTypeCompatible(OGRFieldType eType,
                                 OGRFieldSubType eSubType) -> int

Return if type and subtype are compatible.

### Parameters
* **eType**: the field type.
* **eSubType**: the field subtype.

### Returns
TRUE if type and subtype are compatible
"""
function aretypesubtypecompatible(eType::OGRFieldType,eSubType::OGRFieldSubType)
    ccall((:OGR_AreTypeSubTypeCompatible,libgdal),Cint,(OGRFieldType,OGRFieldSubType),eType,eSubType)
end


"""
    OGR_GFld_Create(const char *,
                    OGRwkbGeometryType) -> OGRGeomFieldDefnH

Create a new field geometry definition.

### Parameters
* **pszName**: the name of the new field definition.
* **eType**: the type of the new field definition.

### Returns
handle to the new field definition.
"""
function create(arg1::AbstractString,arg2::OGRwkbGeometryType)
    checknull(ccall((:OGR_GFld_Create,libgdal),OGRGeomFieldDefnH,(Ptr{UInt8},OGRwkbGeometryType),arg1,arg2))
end


"""
    OGR_GFld_Destroy(OGRGeomFieldDefnH) -> void

Destroy a geometry field definition.

### Parameters
* **hDefn**: handle to the geometry field definition to destroy.
"""
function destroy(arg1::OGRGeomFieldDefnH)
    ccall((:OGR_GFld_Destroy,libgdal),Void,(OGRGeomFieldDefnH,),arg1)
end


"""
    OGR_GFld_SetName(OGRGeomFieldDefnH,
                     const char *) -> void

Reset the name of this field.

### Parameters
* **hDefn**: handle to the geometry field definition to apply the new name to.
* **pszName**: the new name to apply.
"""
function setname(arg1::OGRGeomFieldDefnH,arg2::AbstractString)
    ccall((:OGR_GFld_SetName,libgdal),Void,(OGRGeomFieldDefnH,Ptr{UInt8}),arg1,arg2)
end


"""
    OGR_GFld_GetNameRef(OGRGeomFieldDefnH) -> const char *

Fetch name of this field.

### Parameters
* **hDefn**: handle to the geometry field definition.

### Returns
the name of the geometry field definition.
"""
function getnameref(arg1::OGRGeomFieldDefnH)
    bytestring(ccall((:OGR_GFld_GetNameRef,libgdal),Ptr{UInt8},(OGRGeomFieldDefnH,),arg1))
end


"""
    OGR_GFld_GetType(OGRGeomFieldDefnH) -> OGRwkbGeometryType

Fetch geometry type of this field.

### Parameters
* **hDefn**: handle to the geometry field definition to get type from.

### Returns
field geometry type.
"""
function gettype(arg1::OGRGeomFieldDefnH)
    ccall((:OGR_GFld_GetType,libgdal),OGRwkbGeometryType,(OGRGeomFieldDefnH,),arg1)
end


"""
    OGR_GFld_SetType(OGRGeomFieldDefnH,
                     OGRwkbGeometryType) -> void

Set the geometry type of this field.

### Parameters
* **hDefn**: handle to the geometry field definition to set type to.
* **eType**: the new field geometry type.
"""
function settype(arg1::OGRGeomFieldDefnH,arg2::OGRwkbGeometryType)
    ccall((:OGR_GFld_SetType,libgdal),Void,(OGRGeomFieldDefnH,OGRwkbGeometryType),arg1,arg2)
end


"""
    OGR_GFld_GetSpatialRef(OGRGeomFieldDefnH) -> OGRSpatialReferenceH

Fetch spatial reference system of this field.

### Parameters
* **hDefn**: handle to the geometry field definition

### Returns
field spatial reference system.
"""
function getspatialref(arg1::OGRGeomFieldDefnH)
    checknull(ccall((:OGR_GFld_GetSpatialRef,libgdal),OGRSpatialReferenceH,(OGRGeomFieldDefnH,),arg1))
end


"""
    OGR_GFld_SetSpatialRef(OGRGeomFieldDefnH,
                           OGRSpatialReferenceH hSRS) -> void

Set the spatial reference of this field.

### Parameters
* **hDefn**: handle to the geometry field definition
* **hSRS**: the new SRS to apply.
"""
function setspatialref(arg1::OGRGeomFieldDefnH,hSRS::OGRSpatialReferenceH)
    ccall((:OGR_GFld_SetSpatialRef,libgdal),Void,(OGRGeomFieldDefnH,OGRSpatialReferenceH),arg1,hSRS)
end


"""
    OGR_GFld_IsNullable(OGRGeomFieldDefnH hDefn) -> int

Return whether this geometry field can receive null values.

### Parameters
* **hDefn**: handle to the field definition

### Returns
TRUE if the field is authorized to be null.
"""
function isnullable(hDefn::OGRGeomFieldDefnH)
    ccall((:OGR_GFld_IsNullable,libgdal),Cint,(OGRGeomFieldDefnH,),hDefn)
end


"""
    OGR_GFld_SetNullable(OGRGeomFieldDefnH hDefn,
                         int) -> void

Set whether this geometry field can receive null values.

### Parameters
* **hDefn**: handle to the field definition
* **bNullableIn**: FALSE if the field must have a not-null constraint.
"""
function setnullable(hDefn::OGRGeomFieldDefnH,arg1::Integer)
    ccall((:OGR_GFld_SetNullable,libgdal),Void,(OGRGeomFieldDefnH,Cint),hDefn,arg1)
end


"""
    OGR_GFld_IsIgnored(OGRGeomFieldDefnH hDefn) -> int

Return whether this field should be omitted when fetching features.

### Parameters
* **hDefn**: handle to the geometry field definition

### Returns
ignore state
"""
function isignored(hDefn::OGRGeomFieldDefnH)
    ccall((:OGR_GFld_IsIgnored,libgdal),Cint,(OGRGeomFieldDefnH,),hDefn)
end


"""
    OGR_GFld_SetIgnored(OGRGeomFieldDefnH hDefn,
                        int) -> void

Set whether this field should be omitted when fetching features.

### Parameters
* **hDefn**: handle to the geometry field definition
* **ignore**: ignore state
"""
function setignored(hDefn::OGRGeomFieldDefnH,arg1::Integer)
    ccall((:OGR_GFld_SetIgnored,libgdal),Void,(OGRGeomFieldDefnH,Cint),hDefn,arg1)
end


"""
    OGR_FD_Create(const char *) -> OGRFeatureDefnH

Create a new feature definition object to hold the field definitions.

### Parameters
* **pszName**: the name to be assigned to this layer/class. It does not need to be unique.

### Returns
handle to the newly created feature definition.
"""
function create(arg1::AbstractString)
    checknull(ccall((:OGR_FD_Create,libgdal),OGRFeatureDefnH,(Ptr{UInt8},),arg1))
end


"""
    OGR_FD_Destroy(OGRFeatureDefnH) -> void

Destroy a feature definition object and release all memory associated with it.

### Parameters
* **hDefn**: handle to the feature definition to be destroyed.
"""
function destroy(arg1::OGRFeatureDefnH)
    ccall((:OGR_FD_Destroy,libgdal),Void,(OGRFeatureDefnH,),arg1)
end


"""
    OGR_FD_Release(OGRFeatureDefnH) -> void

Drop a reference, and destroy if unreferenced.

### Parameters
* **hDefn**: handle to the feature definition to be released.
"""
function release(arg1::OGRFeatureDefnH)
    ccall((:OGR_FD_Release,libgdal),Void,(OGRFeatureDefnH,),arg1)
end


"""
    OGR_FD_GetName(OGRFeatureDefnH) -> const char *

Get name of the OGRFeatureDefn passed as an argument.

### Parameters
* **hDefn**: handle to the feature definition to get the name from.

### Returns
the name. This name is internal and should not be modified, or freed.
"""
function getname(arg1::OGRFeatureDefnH)
    bytestring(ccall((:OGR_FD_GetName,libgdal),Ptr{UInt8},(OGRFeatureDefnH,),arg1))
end


"""
    OGR_FD_GetFieldCount(OGRFeatureDefnH) -> int

Fetch number of fields on the passed feature definition.

### Parameters
* **hDefn**: handle to the feature definition to get the fields count from.

### Returns
count of fields.
"""
function getfieldcount(arg1::OGRFeatureDefnH)
    ccall((:OGR_FD_GetFieldCount,libgdal),Cint,(OGRFeatureDefnH,),arg1)
end


"""
    OGR_FD_GetFieldDefn(OGRFeatureDefnH,
                        int) -> OGRFieldDefnH

Fetch field definition of the passed feature definition.

### Parameters
* **hDefn**: handle to the feature definition to get the field definition from.
* **iField**: the field to fetch, between 0 and GetFieldCount()-1.

### Returns
an handle to an internal field definition object or NULL if invalid index. This object should not be modified or freed by the application.
"""
function getfielddefn(arg1::OGRFeatureDefnH,arg2::Integer)
    checknull(ccall((:OGR_FD_GetFieldDefn,libgdal),OGRFieldDefnH,(OGRFeatureDefnH,Cint),arg1,arg2))
end


"""
    OGR_FD_GetFieldIndex(OGRFeatureDefnH,
                         const char *) -> int

Find field by name.

### Parameters
* **hDefn**: handle to the feature definition to get field index from.
* **pszFieldName**: the field name to search for.

### Returns
the field index, or -1 if no match found.
"""
function getfieldindex(arg1::OGRFeatureDefnH,arg2::AbstractString)
    ccall((:OGR_FD_GetFieldIndex,libgdal),Cint,(OGRFeatureDefnH,Ptr{UInt8}),arg1,arg2)
end


"""
    OGR_FD_AddFieldDefn(OGRFeatureDefnH,
                        OGRFieldDefnH) -> void

Add a new field definition to the passed feature definition.

### Parameters
* **hDefn**: handle to the feature definition to add the field definition to.
* **hNewField**: handle to the new field definition.
"""
function addfielddefn(arg1::OGRFeatureDefnH,arg2::OGRFieldDefnH)
    ccall((:OGR_FD_AddFieldDefn,libgdal),Void,(OGRFeatureDefnH,OGRFieldDefnH),arg1,arg2)
end


"""
    OGR_FD_DeleteFieldDefn(OGRFeatureDefnH hDefn,
                           int iField) -> OGRErr

Delete an existing field definition.

### Parameters
* **hDefn**: handle to the feature definition.
* **iField**: the index of the field defintion.

### Returns
OGRERR_NONE in case of success.
"""
function deletefielddefn(hDefn::OGRFeatureDefnH,iField::Integer)
    ccall((:OGR_FD_DeleteFieldDefn,libgdal),OGRErr,(OGRFeatureDefnH,Cint),hDefn,iField)
end


"""
    OGR_FD_ReorderFieldDefns(OGRFeatureDefnH hDefn,
                             int * panMap) -> OGRErr
"""
function reorderfielddefns(hDefn::OGRFeatureDefnH,panMap::Vector{Cint})
    ccall((:OGR_FD_ReorderFieldDefns,libgdal),OGRErr,(OGRFeatureDefnH,Ptr{Cint}),hDefn,panMap)
end


"""
    OGR_FD_GetGeomType(OGRFeatureDefnH) -> OGRwkbGeometryType

Fetch the geometry base type of the passed feature definition.

### Parameters
* **hDefn**: handle to the feature definition to get the geometry type from.

### Returns
the base type for all geometry related to this definition.
"""
function getgeomtype(arg1::OGRFeatureDefnH)
    ccall((:OGR_FD_GetGeomType,libgdal),OGRwkbGeometryType,(OGRFeatureDefnH,),arg1)
end


"""
    OGR_FD_SetGeomType(OGRFeatureDefnH,
                       OGRwkbGeometryType) -> void

Assign the base geometry type for the passed layer (the same as the feature definition).

### Parameters
* **hDefn**: handle to the layer or feature definition to set the geometry type to.
* **eType**: the new type to assign.
"""
function setgeomtype(arg1::OGRFeatureDefnH,arg2::OGRwkbGeometryType)
    ccall((:OGR_FD_SetGeomType,libgdal),Void,(OGRFeatureDefnH,OGRwkbGeometryType),arg1,arg2)
end


"""
    OGR_FD_IsGeometryIgnored(OGRFeatureDefnH) -> int

Determine whether the geometry can be omitted when fetching features.

### Parameters
* **hDefn**: handle to the feature definition on witch OGRFeature are based on.

### Returns
ignore state
"""
function isgeometryignored(arg1::OGRFeatureDefnH)
    ccall((:OGR_FD_IsGeometryIgnored,libgdal),Cint,(OGRFeatureDefnH,),arg1)
end


"""
    OGR_FD_SetGeometryIgnored(OGRFeatureDefnH,
                              int) -> void

Set whether the geometry can be omitted when fetching features.

### Parameters
* **hDefn**: handle to the feature definition on witch OGRFeature are based on.
* **bIgnore**: ignore state
"""
function setgeometryignored(arg1::OGRFeatureDefnH,arg2::Integer)
    ccall((:OGR_FD_SetGeometryIgnored,libgdal),Void,(OGRFeatureDefnH,Cint),arg1,arg2)
end


"""
    OGR_FD_IsStyleIgnored(OGRFeatureDefnH) -> int

Determine whether the style can be omitted when fetching features.

### Parameters
* **hDefn**: handle to the feature definition on which OGRFeature are based on.

### Returns
ignore state
"""
function isstyleignored(arg1::OGRFeatureDefnH)
    ccall((:OGR_FD_IsStyleIgnored,libgdal),Cint,(OGRFeatureDefnH,),arg1)
end


"""
    OGR_FD_SetStyleIgnored(OGRFeatureDefnH,
                           int) -> void

Set whether the style can be omitted when fetching features.

### Parameters
* **hDefn**: handle to the feature definition on witch OGRFeature are based on.
* **bIgnore**: ignore state
"""
function setstyleignored(arg1::OGRFeatureDefnH,arg2::Integer)
    ccall((:OGR_FD_SetStyleIgnored,libgdal),Void,(OGRFeatureDefnH,Cint),arg1,arg2)
end


"""
    OGR_FD_Reference(OGRFeatureDefnH) -> int

Increments the reference count by one.

### Parameters
* **hDefn**: handle to the feature definition on witch OGRFeature are based on.

### Returns
the updated reference count.
"""
function reference(arg1::OGRFeatureDefnH)
    ccall((:OGR_FD_Reference,libgdal),Cint,(OGRFeatureDefnH,),arg1)
end


"""
    OGR_FD_Dereference(OGRFeatureDefnH) -> int

Decrements the reference count by one.

### Parameters
* **hDefn**: handle to the feature definition on witch OGRFeature are based on.

### Returns
the updated reference count.
"""
function dereference(arg1::OGRFeatureDefnH)
    ccall((:OGR_FD_Dereference,libgdal),Cint,(OGRFeatureDefnH,),arg1)
end


"""
    OGR_FD_GetReferenceCount(OGRFeatureDefnH) -> int

Fetch current reference count.

### Parameters
* **hDefn**: handle to the feature definition on witch OGRFeature are based on.

### Returns
the current reference count.
"""
function getreferencecount(arg1::OGRFeatureDefnH)
    ccall((:OGR_FD_GetReferenceCount,libgdal),Cint,(OGRFeatureDefnH,),arg1)
end


"""
    OGR_FD_GetGeomFieldCount(OGRFeatureDefnH hFDefn) -> int

Fetch number of geometry fields on the passed feature definition.

### Parameters
* **hDefn**: handle to the feature definition to get the fields count from.

### Returns
count of geometry fields.
"""
function getgeomfieldcount(hFDefn::OGRFeatureDefnH)
    ccall((:OGR_FD_GetGeomFieldCount,libgdal),Cint,(OGRFeatureDefnH,),hFDefn)
end


"""
    OGR_FD_GetGeomFieldDefn(OGRFeatureDefnH hFDefn,
                            int i) -> OGRGeomFieldDefnH

Fetch geometry field definition of the passed feature definition.

### Parameters
* **hDefn**: handle to the feature definition to get the field definition from.
* **iGeomField**: the geometry field to fetch, between 0 and GetGeomFieldCount()-1.

### Returns
an handle to an internal field definition object or NULL if invalid index. This object should not be modified or freed by the application.
"""
function getgeomfielddefn(hFDefn::OGRFeatureDefnH,i::Integer)
    checknull(ccall((:OGR_FD_GetGeomFieldDefn,libgdal),OGRGeomFieldDefnH,(OGRFeatureDefnH,Cint),hFDefn,i))
end


"""
    OGR_FD_GetGeomFieldIndex(OGRFeatureDefnH hFDefn,
                             const char * pszName) -> int

Find geometry field by name.

### Parameters
* **hDefn**: handle to the feature definition to get field index from.
* **pszGeomFieldName**: the geometry field name to search for.

### Returns
the geometry field index, or -1 if no match found.
"""
function getgeomfieldindex(hFDefn::OGRFeatureDefnH,pszName::AbstractString)
    ccall((:OGR_FD_GetGeomFieldIndex,libgdal),Cint,(OGRFeatureDefnH,Ptr{UInt8}),hFDefn,pszName)
end


"""
    OGR_FD_AddGeomFieldDefn(OGRFeatureDefnH hFDefn,
                            OGRGeomFieldDefnH hGFldDefn) -> void

Add a new field definition to the passed feature definition.

### Parameters
* **hDefn**: handle to the feature definition to add the geometry field definition to.
* **hNewGeomField**: handle to the new field definition.
"""
function addgeomfielddefn(hFDefn::OGRFeatureDefnH,hGFldDefn::OGRGeomFieldDefnH)
    ccall((:OGR_FD_AddGeomFieldDefn,libgdal),Void,(OGRFeatureDefnH,OGRGeomFieldDefnH),hFDefn,hGFldDefn)
end


"""
    OGR_FD_DeleteGeomFieldDefn(OGRFeatureDefnH hFDefn,
                               int iGeomField) -> OGRErr

Delete an existing geometry field definition.

### Parameters
* **hDefn**: handle to the feature definition.
* **iGeomField**: the index of the geometry field defintion.

### Returns
OGRERR_NONE in case of success.
"""
function deletegeomfielddefn(hFDefn::OGRFeatureDefnH,iGeomField::Integer)
    ccall((:OGR_FD_DeleteGeomFieldDefn,libgdal),OGRErr,(OGRFeatureDefnH,Cint),hFDefn,iGeomField)
end


"""
    OGR_FD_IsSame(OGRFeatureDefnH hFDefn,
                  OGRFeatureDefnH hOtherFDefn) -> int

Test if the feature definition is identical to the other one.

### Parameters
* **hFDefn**: handle to the feature definition on witch OGRFeature are based on.
* **hOtherFDefn**: handle to the other feature definition to compare to.

### Returns
TRUE if the feature definition is identical to the other one.
"""
function issame(hFDefn::OGRFeatureDefnH,hOtherFDefn::OGRFeatureDefnH)
    ccall((:OGR_FD_IsSame,libgdal),Cint,(OGRFeatureDefnH,OGRFeatureDefnH),hFDefn,hOtherFDefn)
end


"""
    OGR_F_Create(OGRFeatureDefnH) -> OGRFeatureH

Feature factory.

### Parameters
* **hDefn**: handle to the feature class (layer) definition to which the feature will adhere.

### Returns
an handle to the new feature object with null fields and no geometry.
"""
function create(arg1::OGRFeatureDefnH)
    checknull(ccall((:OGR_F_Create,libgdal),OGRFeatureH,(OGRFeatureDefnH,),arg1))
end


"""
    OGR_F_Destroy(OGRFeatureH) -> void

Destroy feature.

### Parameters
* **hFeat**: handle to the feature to destroy.
"""
function destroy(arg1::OGRFeatureH)
    ccall((:OGR_F_Destroy,libgdal),Void,(OGRFeatureH,),arg1)
end


"""
    OGR_F_GetDefnRef(OGRFeatureH) -> OGRFeatureDefnH

Fetch feature definition.

### Parameters
* **hFeat**: handle to the feature to get the feature definition from.

### Returns
an handle to the feature definition object on which feature depends.
"""
function getdefnref(arg1::OGRFeatureH)
    checknull(ccall((:OGR_F_GetDefnRef,libgdal),OGRFeatureDefnH,(OGRFeatureH,),arg1))
end


"""
    OGR_F_SetGeometryDirectly(OGRFeatureH,
                              OGRGeometryH) -> OGRErr

Set feature geometry.

### Parameters
* **hFeat**: handle to the feature on which to apply the geometry.
* **hGeom**: handle to the new geometry to apply to feature.

### Returns
OGRERR_NONE if successful, or OGR_UNSUPPORTED_GEOMETRY_TYPE if the geometry type is illegal for the OGRFeatureDefn (checking not yet implemented).
"""
function setgeometrydirectly(arg1::OGRFeatureH,arg2::OGRGeometryH)
    ccall((:OGR_F_SetGeometryDirectly,libgdal),OGRErr,(OGRFeatureH,OGRGeometryH),arg1,arg2)
end


"""
    OGR_F_SetGeometry(OGRFeatureH,
                      OGRGeometryH) -> OGRErr

Set feature geometry.

### Parameters
* **hFeat**: handle to the feature on which new geometry is applied to.
* **hGeom**: handle to the new geometry to apply to feature.

### Returns
OGRERR_NONE if successful, or OGR_UNSUPPORTED_GEOMETRY_TYPE if the geometry type is illegal for the OGRFeatureDefn (checking not yet implemented).
"""
function setgeometry(arg1::OGRFeatureH,arg2::OGRGeometryH)
    ccall((:OGR_F_SetGeometry,libgdal),OGRErr,(OGRFeatureH,OGRGeometryH),arg1,arg2)
end


"""
    OGR_F_GetGeometryRef(OGRFeatureH) -> OGRGeometryH

Fetch an handle to feature geometry.

### Parameters
* **hFeat**: handle to the feature to get geometry from.

### Returns
an handle to internal feature geometry. This object should not be modified.
"""
function getgeometryref(arg1::OGRFeatureH)
    checknull(ccall((:OGR_F_GetGeometryRef,libgdal),OGRGeometryH,(OGRFeatureH,),arg1))
end


"""
    OGR_F_StealGeometry(OGRFeatureH) -> OGRGeometryH

Take away ownership of geometry.

### Returns
the pointer to the geometry.
"""
function stealgeometry(arg1::OGRFeatureH)
    checknull(ccall((:OGR_F_StealGeometry,libgdal),OGRGeometryH,(OGRFeatureH,),arg1))
end


"""
    OGR_F_Clone(OGRFeatureH) -> OGRFeatureH

Duplicate feature.

### Parameters
* **hFeat**: handle to the feature to clone.

### Returns
an handle to the new feature, exactly matching this feature.
"""
function clone(arg1::OGRFeatureH)
    checknull(ccall((:OGR_F_Clone,libgdal),OGRFeatureH,(OGRFeatureH,),arg1))
end


"""
    OGR_F_Equal(OGRFeatureH,
                OGRFeatureH) -> int

Test if two features are the same.

### Parameters
* **hFeat**: handle to one of the feature.
* **hOtherFeat**: handle to the other feature to test this one against.

### Returns
TRUE if they are equal, otherwise FALSE.
"""
function equal(arg1::OGRFeatureH,arg2::OGRFeatureH)
    ccall((:OGR_F_Equal,libgdal),Cint,(OGRFeatureH,OGRFeatureH),arg1,arg2)
end


"""
    OGR_F_GetFieldCount(OGRFeatureH) -> int

Fetch number of fields on this feature This will always be the same as the field count for the OGRFeatureDefn.

### Parameters
* **hFeat**: handle to the feature to get the fields count from.

### Returns
count of fields.
"""
function getfieldcount(arg1::OGRFeatureH)
    ccall((:OGR_F_GetFieldCount,libgdal),Cint,(OGRFeatureH,),arg1)
end


"""
    OGR_F_GetFieldDefnRef(OGRFeatureH,
                          int) -> OGRFieldDefnH

Fetch definition for this field.

### Parameters
* **hFeat**: handle to the feature on which the field is found.
* **i**: the field to fetch, from 0 to GetFieldCount()-1.

### Returns
an handle to the field definition (from the OGRFeatureDefn). This is an internal reference, and should not be deleted or modified.
"""
function getfielddefnref(arg1::OGRFeatureH,arg2::Integer)
    checknull(ccall((:OGR_F_GetFieldDefnRef,libgdal),OGRFieldDefnH,(OGRFeatureH,Cint),arg1,arg2))
end


"""
    OGR_F_GetFieldIndex(OGRFeatureH,
                        const char *) -> int

Fetch the field index given field name.

### Parameters
* **hFeat**: handle to the feature on which the field is found.
* **pszName**: the name of the field to search for.

### Returns
the field index, or -1 if no matching field is found.
"""
function getfieldindex(arg1::OGRFeatureH,arg2::AbstractString)
    ccall((:OGR_F_GetFieldIndex,libgdal),Cint,(OGRFeatureH,Ptr{UInt8}),arg1,arg2)
end


"""
    OGR_F_IsFieldSet(OGRFeatureH,
                     int) -> int

Test if a field has ever been assigned a value or not.

### Parameters
* **hFeat**: handle to the feature on which the field is.
* **iField**: the field to test.

### Returns
TRUE if the field has been set, otherwise false.
"""
function isfieldset(arg1::OGRFeatureH,arg2::Integer)
    ccall((:OGR_F_IsFieldSet,libgdal),Cint,(OGRFeatureH,Cint),arg1,arg2)
end


"""
    OGR_F_UnsetField(OGRFeatureH,
                     int) -> void

Clear a field, marking it as unset.

### Parameters
* **hFeat**: handle to the feature on which the field is.
* **iField**: the field to unset.
"""
function unsetfield(arg1::OGRFeatureH,arg2::Integer)
    ccall((:OGR_F_UnsetField,libgdal),Void,(OGRFeatureH,Cint),arg1,arg2)
end


"""
    OGR_F_GetRawFieldRef(OGRFeatureH,
                         int) -> OGRField *

Fetch an handle to the internal field value given the index.

### Parameters
* **hFeat**: handle to the feature on which field is found.
* **iField**: the field to fetch, from 0 to GetFieldCount()-1.

### Returns
the returned handle is to an internal data structure, and should not be freed, or modified.
"""
function getrawfieldref(arg1::OGRFeatureH,arg2::Integer)
    ccall((:OGR_F_GetRawFieldRef,libgdal),Ptr{OGRField},(OGRFeatureH,Cint),arg1,arg2)
end


"""
    OGR_F_GetFieldAsInteger(OGRFeatureH,
                            int) -> int

Fetch field value as integer.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to fetch, from 0 to GetFieldCount()-1.

### Returns
the field value.
"""
function getfieldasinteger(arg1::OGRFeatureH,arg2::Integer)
    ccall((:OGR_F_GetFieldAsInteger,libgdal),Cint,(OGRFeatureH,Cint),arg1,arg2)
end


"""
    OGR_F_GetFieldAsInteger64(OGRFeatureH,
                              int) -> GIntBig

Fetch field value as integer 64 bit.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to fetch, from 0 to GetFieldCount()-1.

### Returns
the field value.
"""
function getfieldasinteger64(arg1::OGRFeatureH,arg2::Integer)
    ccall((:OGR_F_GetFieldAsInteger64,libgdal),GIntBig,(OGRFeatureH,Cint),arg1,arg2)
end


"""
    OGR_F_GetFieldAsDouble(OGRFeatureH,
                           int) -> double

Fetch field value as a double.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to fetch, from 0 to GetFieldCount()-1.

### Returns
the field value.
"""
function getfieldasdouble(arg1::OGRFeatureH,arg2::Integer)
    ccall((:OGR_F_GetFieldAsDouble,libgdal),Cdouble,(OGRFeatureH,Cint),arg1,arg2)
end


"""
    OGR_F_GetFieldAsString(OGRFeatureH,
                           int) -> const char *

Fetch field value as a string.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to fetch, from 0 to GetFieldCount()-1.

### Returns
the field value. This string is internal, and should not be modified, or freed. Its lifetime may be very brief.
"""
function getfieldasstring(arg1::OGRFeatureH,arg2::Integer)
    bytestring(ccall((:OGR_F_GetFieldAsString,libgdal),Ptr{UInt8},(OGRFeatureH,Cint),arg1,arg2))
end


"""
    OGR_F_GetFieldAsIntegerList(OGRFeatureH,
                                int,
                                int *) -> const int *

Fetch field value as a list of integers.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to fetch, from 0 to GetFieldCount()-1.
* **pnCount**: an integer to put the list count (number of integers) into.

### Returns
the field value. This list is internal, and should not be modified, or freed. Its lifetime may be very brief. If *pnCount is zero on return the returned pointer may be NULL or non-NULL.
"""
function getfieldasintegerlist(arg1::OGRFeatureH,arg2::Integer,arg3::Vector{Cint})
    ccall((:OGR_F_GetFieldAsIntegerList,libgdal),Ptr{Cint},(OGRFeatureH,Cint,Ptr{Cint}),arg1,arg2,arg3)
end


"""
    OGR_F_GetFieldAsInteger64List(OGRFeatureH,
                                  int,
                                  int *) -> const GIntBig *

Fetch field value as a list of 64 bit integers.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to fetch, from 0 to GetFieldCount()-1.
* **pnCount**: an integer to put the list count (number of integers) into.

### Returns
the field value. This list is internal, and should not be modified, or freed. Its lifetime may be very brief. If *pnCount is zero on return the returned pointer may be NULL or non-NULL.
"""
function getfieldasinteger64list(arg1::OGRFeatureH,arg2::Integer,arg3::Vector{Cint})
    ccall((:OGR_F_GetFieldAsInteger64List,libgdal),Ptr{GIntBig},(OGRFeatureH,Cint,Ptr{Cint}),arg1,arg2,arg3)
end


"""
    OGR_F_GetFieldAsDoubleList(OGRFeatureH,
                               int,
                               int *) -> const double *

Fetch field value as a list of doubles.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to fetch, from 0 to GetFieldCount()-1.
* **pnCount**: an integer to put the list count (number of doubles) into.

### Returns
the field value. This list is internal, and should not be modified, or freed. Its lifetime may be very brief. If *pnCount is zero on return the returned pointer may be NULL or non-NULL.
"""
function getfieldasdoublelist(arg1::OGRFeatureH,arg2::Integer,arg3::Vector{Cint})
    ccall((:OGR_F_GetFieldAsDoubleList,libgdal),Ptr{Cdouble},(OGRFeatureH,Cint,Ptr{Cint}),arg1,arg2,arg3)
end


"""
    OGR_F_GetFieldAsStringList(OGRFeatureH,
                               int) -> char **

Fetch field value as a list of strings.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to fetch, from 0 to GetFieldCount()-1.

### Returns
the field value. This list is internal, and should not be modified, or freed. Its lifetime may be very brief.
"""
function getfieldasstringlist(arg1::OGRFeatureH,arg2::Integer)
    bytestring(unsafe_load(ccall((:OGR_F_GetFieldAsStringList,libgdal),Ptr{Ptr{UInt8}},(OGRFeatureH,Cint),arg1,arg2)))
end


"""
    OGR_F_GetFieldAsBinary(OGRFeatureH,
                           int,
                           int *) -> GByte *

Fetch field value as binary.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to fetch, from 0 to GetFieldCount()-1.
* **pnBytes**: location to place count of bytes returned.

### Returns
the field value. This list is internal, and should not be modified, or freed. Its lifetime may be very brief.
"""
function getfieldasbinary(arg1::OGRFeatureH,arg2::Integer,arg3::Vector{Cint})
    ccall((:OGR_F_GetFieldAsBinary,libgdal),Ptr{GByte},(OGRFeatureH,Cint,Ptr{Cint}),arg1,arg2,arg3)
end


"""
    OGR_F_GetFieldAsDateTime(OGRFeatureH,
                             int,
                             int *,
                             int *,
                             int *,
                             int *,
                             int *,
                             int *,
                             int *) -> int

Fetch field value as date and time.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to fetch, from 0 to GetFieldCount()-1.
* **pnYear**: (including century)
* **pnMonth**: (1-12)
* **pnDay**: (1-31)
* **pnHour**: (0-23)
* **pnMinute**: (0-59)
* **pnSecond**: (0-59)
* **pnTZFlag**: (0=unknown, 1=localtime, 100=GMT, see data model for details)

### Returns
TRUE on success or FALSE on failure.
"""
function getfieldasdatetime(arg1::OGRFeatureH,arg2::Integer,arg3::Vector{Cint},arg4::Vector{Cint},arg5::Vector{Cint},arg6::Vector{Cint},arg7::Vector{Cint},arg8::Vector{Cint},arg9::Vector{Cint})
    ccall((:OGR_F_GetFieldAsDateTime,libgdal),Cint,(OGRFeatureH,Cint,Ptr{Cint},Ptr{Cint},Ptr{Cint},Ptr{Cint},Ptr{Cint},Ptr{Cint},Ptr{Cint}),arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9)
end


"""
    OGR_F_GetFieldAsDateTimeEx(OGRFeatureH hFeat,
                               int iField,
                               int * pnYear,
                               int * pnMonth,
                               int * pnDay,
                               int * pnHour,
                               int * pnMinute,
                               float * pfSecond,
                               int * pnTZFlag) -> int

Fetch field value as date and time.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to fetch, from 0 to GetFieldCount()-1.
* **pnYear**: (including century)
* **pnMonth**: (1-12)
* **pnDay**: (1-31)
* **pnHour**: (0-23)
* **pnMinute**: (0-59)
* **pfSecond**: (0-59 with millisecond accuracy)
* **pnTZFlag**: (0=unknown, 1=localtime, 100=GMT, see data model for details)

### Returns
TRUE on success or FALSE on failure.
"""
function getfieldasdatetimeex(hFeat::OGRFeatureH,iField::Integer,pnYear::Vector{Cint},pnMonth::Vector{Cint},pnDay::Vector{Cint},pnHour::Vector{Cint},pnMinute::Vector{Cint},pfSecond::Ptr{Cfloat},pnTZFlag::Vector{Cint})
    ccall((:OGR_F_GetFieldAsDateTimeEx,libgdal),Cint,(OGRFeatureH,Cint,Ptr{Cint},Ptr{Cint},Ptr{Cint},Ptr{Cint},Ptr{Cint},Ptr{Cfloat},Ptr{Cint}),hFeat,iField,pnYear,pnMonth,pnDay,pnHour,pnMinute,pfSecond,pnTZFlag)
end


"""
    OGR_F_SetFieldInteger(OGRFeatureH,
                          int,
                          int) -> void

Set field to integer value.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to fetch, from 0 to GetFieldCount()-1.
* **nValue**: the value to assign.
"""
function setfieldinteger(arg1::OGRFeatureH,arg2::Integer,arg3::Integer)
    ccall((:OGR_F_SetFieldInteger,libgdal),Void,(OGRFeatureH,Cint,Cint),arg1,arg2,arg3)
end


"""
    OGR_F_SetFieldInteger64(OGRFeatureH,
                            int,
                            GIntBig) -> void

Set field to 64 bit integer value.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to fetch, from 0 to GetFieldCount()-1.
* **nValue**: the value to assign.
"""
function setfieldinteger64(arg1::OGRFeatureH,arg2::Integer,arg3::GIntBig)
    ccall((:OGR_F_SetFieldInteger64,libgdal),Void,(OGRFeatureH,Cint,GIntBig),arg1,arg2,arg3)
end


"""
    OGR_F_SetFieldDouble(OGRFeatureH,
                         int,
                         double) -> void

Set field to double value.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to fetch, from 0 to GetFieldCount()-1.
* **dfValue**: the value to assign.
"""
function setfielddouble(arg1::OGRFeatureH,arg2::Integer,arg3::Real)
    ccall((:OGR_F_SetFieldDouble,libgdal),Void,(OGRFeatureH,Cint,Cdouble),arg1,arg2,arg3)
end


"""
    OGR_F_SetFieldString(OGRFeatureH,
                         int,
                         const char *) -> void

Set field to string value.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to fetch, from 0 to GetFieldCount()-1.
* **pszValue**: the value to assign.
"""
function setfieldstring(arg1::OGRFeatureH,arg2::Integer,arg3::AbstractString)
    ccall((:OGR_F_SetFieldString,libgdal),Void,(OGRFeatureH,Cint,Ptr{UInt8}),arg1,arg2,arg3)
end


"""
    OGR_F_SetFieldIntegerList(OGRFeatureH,
                              int,
                              int,
                              int *) -> void

Set field to list of integers value.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to set, from 0 to GetFieldCount()-1.
* **nCount**: the number of values in the list being assigned.
* **panValues**: the values to assign.
"""
function setfieldintegerlist(arg1::OGRFeatureH,arg2::Integer,arg3::Integer,arg4::Vector{Cint})
    ccall((:OGR_F_SetFieldIntegerList,libgdal),Void,(OGRFeatureH,Cint,Cint,Ptr{Cint}),arg1,arg2,arg3,arg4)
end


"""
    OGR_F_SetFieldInteger64List(OGRFeatureH,
                                int,
                                int,
                                const GIntBig *) -> void

Set field to list of 64 bit integers value.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to set, from 0 to GetFieldCount()-1.
* **nCount**: the number of values in the list being assigned.
* **panValues**: the values to assign.
"""
function setfieldinteger64list(arg1::OGRFeatureH,arg2::Integer,arg3::Integer,arg4::Ptr{GIntBig})
    ccall((:OGR_F_SetFieldInteger64List,libgdal),Void,(OGRFeatureH,Cint,Cint,Ptr{GIntBig}),arg1,arg2,arg3,arg4)
end


"""
    OGR_F_SetFieldDoubleList(OGRFeatureH,
                             int,
                             int,
                             double *) -> void

Set field to list of doubles value.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to set, from 0 to GetFieldCount()-1.
* **nCount**: the number of values in the list being assigned.
* **padfValues**: the values to assign.
"""
function setfielddoublelist(arg1::OGRFeatureH,arg2::Integer,arg3::Integer,arg4::Vector{Float64})
    ccall((:OGR_F_SetFieldDoubleList,libgdal),Void,(OGRFeatureH,Cint,Cint,Ptr{Cdouble}),arg1,arg2,arg3,arg4)
end


"""
    OGR_F_SetFieldStringList(OGRFeatureH,
                             int,
                             char **) -> void

Set field to list of strings value.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to set, from 0 to GetFieldCount()-1.
* **papszValues**: the values to assign.
"""
function setfieldstringlist(arg1::OGRFeatureH,arg2::Integer,arg3::Vector{UTF8String})
    ccall((:OGR_F_SetFieldStringList,libgdal),Void,(OGRFeatureH,Cint,Ptr{Ptr{UInt8}}),arg1,arg2,arg3)
end


"""
    OGR_F_SetFieldRaw(OGRFeatureH,
                      int,
                      OGRField *) -> void

Set field.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to fetch, from 0 to GetFieldCount()-1.
* **psValue**: handle on the value to assign.
"""
function setfieldraw(arg1::OGRFeatureH,arg2::Integer,arg3::Ptr{OGRField})
    ccall((:OGR_F_SetFieldRaw,libgdal),Void,(OGRFeatureH,Cint,Ptr{OGRField}),arg1,arg2,arg3)
end


"""
    OGR_F_SetFieldBinary(OGRFeatureH,
                         int,
                         int,
                         GByte *) -> void

Set field to binary data.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to set, from 0 to GetFieldCount()-1.
* **nBytes**: the number of bytes in pabyData array.
* **pabyData**: the data to apply.
"""
function setfieldbinary(arg1::OGRFeatureH,arg2::Integer,arg3::Integer,arg4::Ptr{GByte})
    ccall((:OGR_F_SetFieldBinary,libgdal),Void,(OGRFeatureH,Cint,Cint,Ptr{GByte}),arg1,arg2,arg3,arg4)
end


"""
    OGR_F_SetFieldDateTime(OGRFeatureH,
                           int,
                           int,
                           int,
                           int,
                           int,
                           int,
                           int,
                           int) -> void

Set field to datetime.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to set, from 0 to GetFieldCount()-1.
* **nYear**: (including century)
* **nMonth**: (1-12)
* **nDay**: (1-31)
* **nHour**: (0-23)
* **nMinute**: (0-59)
* **nSecond**: (0-59)
* **nTZFlag**: (0=unknown, 1=localtime, 100=GMT, see data model for details)
"""
function setfielddatetime(arg1::OGRFeatureH,arg2::Integer,arg3::Integer,arg4::Integer,arg5::Integer,arg6::Integer,arg7::Integer,arg8::Integer,arg9::Integer)
    ccall((:OGR_F_SetFieldDateTime,libgdal),Void,(OGRFeatureH,Cint,Cint,Cint,Cint,Cint,Cint,Cint,Cint),arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9)
end


"""
    OGR_F_SetFieldDateTimeEx(OGRFeatureH,
                             int,
                             int,
                             int,
                             int,
                             int,
                             int,
                             float,
                             int) -> void

Set field to datetime.

### Parameters
* **hFeat**: handle to the feature that owned the field.
* **iField**: the field to set, from 0 to GetFieldCount()-1.
* **nYear**: (including century)
* **nMonth**: (1-12)
* **nDay**: (1-31)
* **nHour**: (0-23)
* **nMinute**: (0-59)
* **fSecond**: (0-59, with millisecond accuracy)
* **nTZFlag**: (0=unknown, 1=localtime, 100=GMT, see data model for details)
"""
function setfielddatetimeex(arg1::OGRFeatureH,arg2::Integer,arg3::Integer,arg4::Integer,arg5::Integer,arg6::Integer,arg7::Integer,arg8::Cfloat,arg9::Integer)
    ccall((:OGR_F_SetFieldDateTimeEx,libgdal),Void,(OGRFeatureH,Cint,Cint,Cint,Cint,Cint,Cint,Cfloat,Cint),arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9)
end


"""
    OGR_F_GetGeomFieldCount(OGRFeatureH hFeat) -> int

Fetch number of geometry fields on this feature This will always be the same as the geometry field count for the OGRFeatureDefn.

### Parameters
* **hFeat**: handle to the feature to get the geometry fields count from.

### Returns
count of geometry fields.
"""
function getgeomfieldcount(hFeat::OGRFeatureH)
    ccall((:OGR_F_GetGeomFieldCount,libgdal),Cint,(OGRFeatureH,),hFeat)
end


"""
    OGR_F_GetGeomFieldDefnRef(OGRFeatureH hFeat,
                              int iField) -> OGRGeomFieldDefnH

Fetch definition for this geometry field.

### Parameters
* **hFeat**: handle to the feature on which the field is found.
* **i**: the field to fetch, from 0 to GetGeomFieldCount()-1.

### Returns
an handle to the field definition (from the OGRFeatureDefn). This is an internal reference, and should not be deleted or modified.
"""
function getgeomfielddefnref(hFeat::OGRFeatureH,iField::Integer)
    checknull(ccall((:OGR_F_GetGeomFieldDefnRef,libgdal),OGRGeomFieldDefnH,(OGRFeatureH,Cint),hFeat,iField))
end


"""
    OGR_F_GetGeomFieldIndex(OGRFeatureH hFeat,
                            const char * pszName) -> int

Fetch the geometry field index given geometry field name.

### Parameters
* **hFeat**: handle to the feature on which the geometry field is found.
* **pszName**: the name of the geometry field to search for.

### Returns
the geometry field index, or -1 if no matching geometry field is found.
"""
function getgeomfieldindex(hFeat::OGRFeatureH,pszName::AbstractString)
    ccall((:OGR_F_GetGeomFieldIndex,libgdal),Cint,(OGRFeatureH,Ptr{UInt8}),hFeat,pszName)
end


"""
    OGR_F_GetGeomFieldRef(OGRFeatureH hFeat,
                          int iField) -> OGRGeometryH

Fetch an handle to feature geometry.

### Parameters
* **hFeat**: handle to the feature to get geometry from.
* **iField**: geometry field to get.

### Returns
an handle to internal feature geometry. This object should not be modified.
"""
function getgeomfieldref(hFeat::OGRFeatureH,iField::Integer)
    checknull(ccall((:OGR_F_GetGeomFieldRef,libgdal),OGRGeometryH,(OGRFeatureH,Cint),hFeat,iField))
end


"""
    OGR_F_SetGeomFieldDirectly(OGRFeatureH hFeat,
                               int iField,
                               OGRGeometryH hGeom) -> OGRErr

Set feature geometry of a specified geometry field.

### Parameters
* **hFeat**: handle to the feature on which to apply the geometry.
* **iField**: geometry field to set.
* **hGeom**: handle to the new geometry to apply to feature.

### Returns
OGRERR_NONE if successful, or OGRERR_FAILURE if the index is invalid, or OGR_UNSUPPORTED_GEOMETRY_TYPE if the geometry type is illegal for the OGRFeatureDefn (checking not yet implemented).
"""
function setgeomfielddirectly(hFeat::OGRFeatureH,iField::Integer,hGeom::OGRGeometryH)
    ccall((:OGR_F_SetGeomFieldDirectly,libgdal),OGRErr,(OGRFeatureH,Cint,OGRGeometryH),hFeat,iField,hGeom)
end


"""
    OGR_F_SetGeomField(OGRFeatureH hFeat,
                       int iField,
                       OGRGeometryH hGeom) -> OGRErr

Set feature geometry of a specified geometry field.

### Parameters
* **hFeat**: handle to the feature on which new geometry is applied to.
* **iField**: geometry field to set.
* **hGeom**: handle to the new geometry to apply to feature.

### Returns
OGRERR_NONE if successful, or OGR_UNSUPPORTED_GEOMETRY_TYPE if the geometry type is illegal for the OGRFeatureDefn (checking not yet implemented).
"""
function setgeomfield(hFeat::OGRFeatureH,iField::Integer,hGeom::OGRGeometryH)
    ccall((:OGR_F_SetGeomField,libgdal),OGRErr,(OGRFeatureH,Cint,OGRGeometryH),hFeat,iField,hGeom)
end


"""
    OGR_F_GetFID(OGRFeatureH) -> GIntBig

Get feature identifier.

### Parameters
* **hFeat**: handle to the feature from which to get the feature identifier.

### Returns
feature id or OGRNullFID if none has been assigned.
"""
function getfid(arg1::OGRFeatureH)
    ccall((:OGR_F_GetFID,libgdal),GIntBig,(OGRFeatureH,),arg1)
end


"""
    OGR_F_SetFID(OGRFeatureH,
                 GIntBig) -> OGRErr

Set the feature identifier.

### Parameters
* **hFeat**: handle to the feature to set the feature id to.
* **nFID**: the new feature identifier value to assign.

### Returns
On success OGRERR_NONE, or on failure some other value.
"""
function setfid(arg1::OGRFeatureH,arg2::GIntBig)
    ccall((:OGR_F_SetFID,libgdal),OGRErr,(OGRFeatureH,GIntBig),arg1,arg2)
end


"""
    OGR_F_DumpReadable(OGRFeatureH,
                       FILE *) -> void

Dump this feature in a human readable form.

### Parameters
* **hFeat**: handle to the feature to dump.
* **fpOut**: the stream to write to, such as strout.
"""
function dumpreadable(arg1::OGRFeatureH,arg2::Ptr{FILE})
    ccall((:OGR_F_DumpReadable,libgdal),Void,(OGRFeatureH,Ptr{FILE}),arg1,arg2)
end


"""
    OGR_F_SetFrom(OGRFeatureH,
                  OGRFeatureH,
                  int) -> OGRErr

Set one feature from another.

### Parameters
* **hFeat**: handle to the feature to set to.
* **hOtherFeat**: handle to the feature from which geometry, and field values will be copied.
* **bForgiving**: TRUE if the operation should continue despite lacking output fields matching some of the source fields.

### Returns
OGRERR_NONE if the operation succeeds, even if some values are not transferred, otherwise an error code.
"""
function setfrom(arg1::OGRFeatureH,arg2::OGRFeatureH,arg3::Integer)
    ccall((:OGR_F_SetFrom,libgdal),OGRErr,(OGRFeatureH,OGRFeatureH,Cint),arg1,arg2,arg3)
end


"""
    OGR_F_SetFromWithMap(OGRFeatureH,
                         OGRFeatureH,
                         int,
                         int *) -> OGRErr

Set one feature from another.

### Parameters
* **hFeat**: handle to the feature to set to.
* **hOtherFeat**: handle to the feature from which geometry, and field values will be copied.
* **panMap**: Array of the indices of the destination feature's fields stored at the corresponding index of the source feature's fields. A value of -1 should be used to ignore the source's field. The array should not be NULL and be as long as the number of fields in the source feature.
* **bForgiving**: TRUE if the operation should continue despite lacking output fields matching some of the source fields.

### Returns
OGRERR_NONE if the operation succeeds, even if some values are not transferred, otherwise an error code.
"""
function setfromwithmap(arg1::OGRFeatureH,arg2::OGRFeatureH,arg3::Integer,arg4::Vector{Cint})
    ccall((:OGR_F_SetFromWithMap,libgdal),OGRErr,(OGRFeatureH,OGRFeatureH,Cint,Ptr{Cint}),arg1,arg2,arg3,arg4)
end


"""
    OGR_F_GetStyleString(OGRFeatureH) -> const char *

Fetch style string for this feature.

### Parameters
* **hFeat**: handle to the feature to get the style from.

### Returns
a reference to a representation in string format, or NULL if there isn't one.
"""
function getstylestring(arg1::OGRFeatureH)
    bytestring(ccall((:OGR_F_GetStyleString,libgdal),Ptr{UInt8},(OGRFeatureH,),arg1))
end


"""
    OGR_F_SetStyleString(OGRFeatureH,
                         const char *) -> void

Set feature style string.

### Parameters
* **hFeat**: handle to the feature to set style to.
* **pszStyle**: the style string to apply to this feature, cannot be NULL.
"""
function setstylestring(arg1::OGRFeatureH,arg2::AbstractString)
    ccall((:OGR_F_SetStyleString,libgdal),Void,(OGRFeatureH,Ptr{UInt8}),arg1,arg2)
end


"""
    OGR_F_SetStyleStringDirectly(OGRFeatureH,
                                 char *) -> void

Set feature style string.

### Parameters
* **hFeat**: handle to the feature to set style to.
* **pszStyle**: the style string to apply to this feature, cannot be NULL.
"""
function setstylestringdirectly(arg1::OGRFeatureH,arg2::AbstractString)
    ccall((:OGR_F_SetStyleStringDirectly,libgdal),Void,(OGRFeatureH,Ptr{UInt8}),arg1,arg2)
end


"""
    OGR_F_GetStyleTable(OGRFeatureH) -> OGRStyleTableH
"""
function getstyletable(arg1::OGRFeatureH)
    checknull(ccall((:OGR_F_GetStyleTable,libgdal),OGRStyleTableH,(OGRFeatureH,),arg1))
end


"""
    OGR_F_SetStyleTableDirectly(OGRFeatureH,
                                OGRStyleTableH) -> void
"""
function setstyletabledirectly(arg1::OGRFeatureH,arg2::OGRStyleTableH)
    ccall((:OGR_F_SetStyleTableDirectly,libgdal),Void,(OGRFeatureH,OGRStyleTableH),arg1,arg2)
end


"""
    OGR_F_SetStyleTable(OGRFeatureH,
                        OGRStyleTableH) -> void
"""
function setstyletable(arg1::OGRFeatureH,arg2::OGRStyleTableH)
    ccall((:OGR_F_SetStyleTable,libgdal),Void,(OGRFeatureH,OGRStyleTableH),arg1,arg2)
end


"""
    OGR_F_FillUnsetWithDefault(OGRFeatureH hFeat,
                               int bNotNullableOnly,
                               char ** papszOptions) -> void

Fill unset fields with default values that might be defined.

### Parameters
* **hFeat**: handle to the feature.
* **bNotNullableOnly**: if we should fill only unset fields with a not-null constraint.
* **papszOptions**: unused currently. Must be set to NULL.
"""
function fillunsetwithdefault(hFeat::OGRFeatureH,bNotNullableOnly::Integer,papszOptions::Vector{UTF8String})
    ccall((:OGR_F_FillUnsetWithDefault,libgdal),Void,(OGRFeatureH,Cint,Ptr{Ptr{UInt8}}),hFeat,bNotNullableOnly,papszOptions)
end


"""
    OGR_F_Validate(OGRFeatureH,
                   int nValidateFlags,
                   int bEmitError) -> int

Validate that a feature meets constraints of its schema.

### Parameters
* **hFeat**: handle to the feature to validate.
* **nValidateFlags**: OGR_F_VAL_ALL or combination of OGR_F_VAL_NULL, OGR_F_VAL_GEOM_TYPE, OGR_F_VAL_WIDTH and OGR_F_VAL_ALLOW_NULL_WHEN_DEFAULT with '|' operator
* **bEmitError**: TRUE if a CPLError() must be emitted when a check fails

### Returns
TRUE if all enabled validation tests pass.
"""
function validate(arg1::OGRFeatureH,nValidateFlags::Integer,bEmitError::Integer)
    ccall((:OGR_F_Validate,libgdal),Cint,(OGRFeatureH,Cint,Cint),arg1,nValidateFlags,bEmitError)
end


"""
    OGR_L_GetName(OGRLayerH) -> const char *

Return the layer name.

### Parameters
* **hLayer**: handle to the layer.

### Returns
the layer name (must not been freed)
"""
function getname(arg1::OGRLayerH)
    bytestring(ccall((:OGR_L_GetName,libgdal),Ptr{UInt8},(OGRLayerH,),arg1))
end


"""
    OGR_L_GetGeomType(OGRLayerH) -> OGRwkbGeometryType

Return the layer geometry type.

### Parameters
* **hLayer**: handle to the layer.

### Returns
the geometry type
"""
function getgeomtype(arg1::OGRLayerH)
    ccall((:OGR_L_GetGeomType,libgdal),OGRwkbGeometryType,(OGRLayerH,),arg1)
end


"""
    OGR_L_GetSpatialFilter(OGRLayerH) -> OGRGeometryH

This function returns the current spatial filter for this layer.

### Parameters
* **hLayer**: handle to the layer to get the spatial filter from.

### Returns
an handle to the spatial filter geometry.
"""
function getspatialfilter(arg1::OGRLayerH)
    checknull(ccall((:OGR_L_GetSpatialFilter,libgdal),OGRGeometryH,(OGRLayerH,),arg1))
end


"""
    OGR_L_SetSpatialFilter(OGRLayerH,
                           OGRGeometryH) -> void

Set a new spatial filter.

### Parameters
* **hLayer**: handle to the layer on which to set the spatial filter.
* **hGeom**: handle to the geometry to use as a filtering region. NULL may be passed indicating that the current spatial filter should be cleared, but no new one instituted.
"""
function setspatialfilter(arg1::OGRLayerH,arg2::OGRGeometryH)
    ccall((:OGR_L_SetSpatialFilter,libgdal),Void,(OGRLayerH,OGRGeometryH),arg1,arg2)
end


"""
    OGR_L_SetSpatialFilterRect(OGRLayerH,
                               double,
                               double,
                               double,
                               double) -> void

Set a new rectangular spatial filter.

### Parameters
* **hLayer**: handle to the layer on which to set the spatial filter.
* **dfMinX**: the minimum X coordinate for the rectangular region.
* **dfMinY**: the minimum Y coordinate for the rectangular region.
* **dfMaxX**: the maximum X coordinate for the rectangular region.
* **dfMaxY**: the maximum Y coordinate for the rectangular region.
"""
function setspatialfilterrect(arg1::OGRLayerH,arg2::Real,arg3::Real,arg4::Real,arg5::Real)
    ccall((:OGR_L_SetSpatialFilterRect,libgdal),Void,(OGRLayerH,Cdouble,Cdouble,Cdouble,Cdouble),arg1,arg2,arg3,arg4,arg5)
end


"""
    OGR_L_SetSpatialFilterEx(OGRLayerH,
                             int iGeomField,
                             OGRGeometryH hGeom) -> void

Set a new spatial filter.

### Parameters
* **hLayer**: handle to the layer on which to set the spatial filter.
* **iGeomField**: index of the geometry field on which the spatial filter operates.
* **hGeom**: handle to the geometry to use as a filtering region. NULL may be passed indicating that the current spatial filter should be cleared, but no new one instituted.
"""
function setspatialfilterex(arg1::OGRLayerH,iGeomField::Integer,hGeom::OGRGeometryH)
    ccall((:OGR_L_SetSpatialFilterEx,libgdal),Void,(OGRLayerH,Cint,OGRGeometryH),arg1,iGeomField,hGeom)
end


"""
    OGR_L_SetSpatialFilterRectEx(OGRLayerH,
                                 int iGeomField,
                                 double dfMinX,
                                 double dfMinY,
                                 double dfMaxX,
                                 double dfMaxY) -> void

Set a new rectangular spatial filter.

### Parameters
* **hLayer**: handle to the layer on which to set the spatial filter.
* **iGeomField**: index of the geometry field on which the spatial filter operates.
* **dfMinX**: the minimum X coordinate for the rectangular region.
* **dfMinY**: the minimum Y coordinate for the rectangular region.
* **dfMaxX**: the maximum X coordinate for the rectangular region.
* **dfMaxY**: the maximum Y coordinate for the rectangular region.
"""
function setspatialfilterrectex(arg1::OGRLayerH,iGeomField::Integer,dfMinX::Real,dfMinY::Real,dfMaxX::Real,dfMaxY::Real)
    ccall((:OGR_L_SetSpatialFilterRectEx,libgdal),Void,(OGRLayerH,Cint,Cdouble,Cdouble,Cdouble,Cdouble),arg1,iGeomField,dfMinX,dfMinY,dfMaxX,dfMaxY)
end


"""
    OGR_L_SetAttributeFilter(OGRLayerH,
                             const char *) -> OGRErr

Set a new attribute query.

### Parameters
* **hLayer**: handle to the layer on which attribute query will be executed.
* **pszQuery**: query in restricted SQL WHERE format, or NULL to clear the current query.

### Returns
OGRERR_NONE if successfully installed, or an error code if the query expression is in error, or some other failure occurs.
"""
function setattributefilter(arg1::OGRLayerH,arg2::AbstractString)
    ccall((:OGR_L_SetAttributeFilter,libgdal),OGRErr,(OGRLayerH,Ptr{UInt8}),arg1,arg2)
end


"""
    OGR_L_ResetReading(OGRLayerH) -> void

Reset feature reading to start on the first feature.

### Parameters
* **hLayer**: handle to the layer on which features are read.
"""
function resetreading(arg1::OGRLayerH)
    ccall((:OGR_L_ResetReading,libgdal),Void,(OGRLayerH,),arg1)
end


"""
    OGR_L_GetNextFeature(OGRLayerH) -> OGRFeatureH

Fetch the next available feature from this layer.

### Parameters
* **hLayer**: handle to the layer from which feature are read.

### Returns
an handle to a feature, or NULL if no more features are available.
"""
function getnextfeature(arg1::OGRLayerH)
    checknull(ccall((:OGR_L_GetNextFeature,libgdal),OGRFeatureH,(OGRLayerH,),arg1))
end


"""
    OGR_L_SetNextByIndex(OGRLayerH,
                         GIntBig) -> OGRErr

Move read cursor to the nIndex'th feature in the current resultset.

### Parameters
* **hLayer**: handle to the layer
* **nIndex**: the index indicating how many steps into the result set to seek.

### Returns
OGRERR_NONE on success or an error code.
"""
function setnextbyindex(arg1::OGRLayerH,arg2::GIntBig)
    ccall((:OGR_L_SetNextByIndex,libgdal),OGRErr,(OGRLayerH,GIntBig),arg1,arg2)
end


"""
    OGR_L_GetFeature(OGRLayerH,
                     GIntBig) -> OGRFeatureH

Fetch a feature by its identifier.

### Parameters
* **hLayer**: handle to the layer that owned the feature.
* **nFeatureId**: the feature id of the feature to read.

### Returns
an handle to a feature now owned by the caller, or NULL on failure.
"""
function getfeature(arg1::OGRLayerH,arg2::GIntBig)
    checknull(ccall((:OGR_L_GetFeature,libgdal),OGRFeatureH,(OGRLayerH,GIntBig),arg1,arg2))
end


"""
    OGR_L_SetFeature(OGRLayerH,
                     OGRFeatureH) -> OGRErr

Rewrite an existing feature.

### Parameters
* **hLayer**: handle to the layer to write the feature.
* **hFeat**: the feature to write.

### Returns
OGRERR_NONE if the operation works, otherwise an appropriate error code (e.g OGRERR_NON_EXISTING_FEATURE if the feature does not exist).
"""
function setfeature(arg1::OGRLayerH,arg2::OGRFeatureH)
    ccall((:OGR_L_SetFeature,libgdal),OGRErr,(OGRLayerH,OGRFeatureH),arg1,arg2)
end


"""
    OGR_L_CreateFeature(OGRLayerH,
                        OGRFeatureH) -> OGRErr

Create and write a new feature within a layer.

### Parameters
* **hLayer**: handle to the layer to write the feature to.
* **hFeat**: the handle of the feature to write to disk.

### Returns
OGRERR_NONE on success.
"""
function createfeature(arg1::OGRLayerH,arg2::OGRFeatureH)
    ccall((:OGR_L_CreateFeature,libgdal),OGRErr,(OGRLayerH,OGRFeatureH),arg1,arg2)
end


"""
    OGR_L_DeleteFeature(OGRLayerH,
                        GIntBig) -> OGRErr

Delete feature from layer.

### Parameters
* **hLayer**: handle to the layer
* **nFID**: the feature id to be deleted from the layer

### Returns
OGRERR_NONE if the operation works, otherwise an appropriate error code (e.g OGRERR_NON_EXISTING_FEATURE if the feature does not exist).
"""
function deletefeature(arg1::OGRLayerH,arg2::GIntBig)
    ccall((:OGR_L_DeleteFeature,libgdal),OGRErr,(OGRLayerH,GIntBig),arg1,arg2)
end


"""
    OGR_L_GetLayerDefn(OGRLayerH) -> OGRFeatureDefnH

Fetch the schema information for this layer.

### Parameters
* **hLayer**: handle to the layer to get the schema information.

### Returns
an handle to the feature definition.
"""
function getlayerdefn(arg1::OGRLayerH)
    checknull(ccall((:OGR_L_GetLayerDefn,libgdal),OGRFeatureDefnH,(OGRLayerH,),arg1))
end


"""
    OGR_L_GetSpatialRef(OGRLayerH) -> OGRSpatialReferenceH

Fetch the spatial reference system for this layer.

### Parameters
* **hLayer**: handle to the layer to get the spatial reference from.

### Returns
spatial reference, or NULL if there isn't one.
"""
function getspatialref(arg1::OGRLayerH)
    checknull(ccall((:OGR_L_GetSpatialRef,libgdal),OGRSpatialReferenceH,(OGRLayerH,),arg1))
end


"""
    OGR_L_FindFieldIndex(OGRLayerH,
                         const char *,
                         int bExactMatch) -> int

Find the index of field in a layer.

### Returns
field index, or -1 if the field doesn't exist
"""
function findfieldindex(arg1::OGRLayerH,arg2::AbstractString,bExactMatch::Integer)
    ccall((:OGR_L_FindFieldIndex,libgdal),Cint,(OGRLayerH,Ptr{UInt8},Cint),arg1,arg2,bExactMatch)
end


"""
    OGR_L_GetFeatureCount(OGRLayerH,
                          int) -> GIntBig

Fetch the feature count in this layer.

### Parameters
* **hLayer**: handle to the layer that owned the features.
* **bForce**: Flag indicating whether the count should be computed even if it is expensive.

### Returns
feature count, -1 if count not known.
"""
function getfeaturecount(arg1::OGRLayerH,arg2::Integer)
    ccall((:OGR_L_GetFeatureCount,libgdal),GIntBig,(OGRLayerH,Cint),arg1,arg2)
end


"""
    OGR_L_GetExtent(OGRLayerH,
                    OGREnvelope *,
                    int) -> OGRErr

Fetch the extent of this layer.

### Parameters
* **hLayer**: handle to the layer from which to get extent.
* **psExtent**: the structure in which the extent value will be returned.
* **bForce**: Flag indicating whether the extent should be computed even if it is expensive.

### Returns
OGRERR_NONE on success, OGRERR_FAILURE if extent not known.
"""
function getextent(arg1::OGRLayerH,arg2::Ptr{OGREnvelope},arg3::Integer)
    ccall((:OGR_L_GetExtent,libgdal),OGRErr,(OGRLayerH,Ptr{OGREnvelope},Cint),arg1,arg2,arg3)
end


"""
    OGR_L_GetExtentEx(OGRLayerH,
                      int iGeomField,
                      OGREnvelope * psExtent,
                      int bForce) -> OGRErr

Fetch the extent of this layer, on the specified geometry field.

### Parameters
* **hLayer**: handle to the layer from which to get extent.
* **iGeomField**: the index of the geometry field on which to compute the extent.
* **psExtent**: the structure in which the extent value will be returned.
* **bForce**: Flag indicating whether the extent should be computed even if it is expensive.

### Returns
OGRERR_NONE on success, OGRERR_FAILURE if extent not known.
"""
function getextentex(arg1::OGRLayerH,iGeomField::Integer,psExtent::Ptr{OGREnvelope},bForce::Integer)
    ccall((:OGR_L_GetExtentEx,libgdal),OGRErr,(OGRLayerH,Cint,Ptr{OGREnvelope},Cint),arg1,iGeomField,psExtent,bForce)
end


"""
    OGR_L_TestCapability(OGRLayerH,
                         const char *) -> int

Test if this layer supported the named capability.

### Parameters
* **hLayer**: handle to the layer to get the capability from.
* **pszCap**: the name of the capability to test.

### Returns
TRUE if the layer has the requested capability, or FALSE otherwise. OGRLayers will return FALSE for any unrecognised capabilities.
"""
function testcapability(arg1::OGRLayerH,arg2::AbstractString)
    ccall((:OGR_L_TestCapability,libgdal),Cint,(OGRLayerH,Ptr{UInt8}),arg1,arg2)
end


"""
    OGR_L_CreateField(OGRLayerH,
                      OGRFieldDefnH,
                      int) -> OGRErr

Create a new field on a layer.

### Parameters
* **hLayer**: handle to the layer to write the field definition.
* **hField**: handle of the field definition to write to disk.
* **bApproxOK**: If TRUE, the field may be created in a slightly different form depending on the limitations of the format driver.

### Returns
OGRERR_NONE on success.
"""
function createfield(arg1::OGRLayerH,arg2::OGRFieldDefnH,arg3::Integer)
    ccall((:OGR_L_CreateField,libgdal),OGRErr,(OGRLayerH,OGRFieldDefnH,Cint),arg1,arg2,arg3)
end


"""
    OGR_L_CreateGeomField(OGRLayerH hLayer,
                          OGRGeomFieldDefnH hFieldDefn,
                          int bForce) -> OGRErr

Create a new geometry field on a layer.

### Parameters
* **hLayer**: handle to the layer to write the field definition.
* **hField**: handle of the geometry field definition to write to disk.
* **bApproxOK**: If TRUE, the field may be created in a slightly different form depending on the limitations of the format driver.

### Returns
OGRERR_NONE on success.
"""
function creategeomfield(hLayer::OGRLayerH,hFieldDefn::OGRGeomFieldDefnH,bForce::Integer)
    ccall((:OGR_L_CreateGeomField,libgdal),OGRErr,(OGRLayerH,OGRGeomFieldDefnH,Cint),hLayer,hFieldDefn,bForce)
end


"""
    OGR_L_DeleteField(OGRLayerH,
                      int iField) -> OGRErr

Create a new field on a layer.

### Parameters
* **hLayer**: handle to the layer.
* **iField**: index of the field to delete.

### Returns
OGRERR_NONE on success.
"""
function deletefield(arg1::OGRLayerH,iField::Integer)
    ccall((:OGR_L_DeleteField,libgdal),OGRErr,(OGRLayerH,Cint),arg1,iField)
end


"""
    OGR_L_ReorderFields(OGRLayerH,
                        int * panMap) -> OGRErr

Reorder all the fields of a layer.

### Parameters
* **hLayer**: handle to the layer.
* **panMap**: an array of GetLayerDefn()->OGRFeatureDefn::GetFieldCount() elements which is a permutation of [0, GetLayerDefn()->OGRFeatureDefn::GetFieldCount()-1].

### Returns
OGRERR_NONE on success.
"""
function reorderfields(arg1::OGRLayerH,panMap::Vector{Cint})
    ccall((:OGR_L_ReorderFields,libgdal),OGRErr,(OGRLayerH,Ptr{Cint}),arg1,panMap)
end


"""
    OGR_L_ReorderField(OGRLayerH,
                       int iOldFieldPos,
                       int iNewFieldPos) -> OGRErr

Reorder an existing field on a layer.

### Parameters
* **hLayer**: handle to the layer.
* **iOldFieldPos**: previous position of the field to move. Must be in the range [0,GetFieldCount()-1].
* **iNewFieldPos**: new position of the field to move. Must be in the range [0,GetFieldCount()-1].

### Returns
OGRERR_NONE on success.
"""
function reorderfield(arg1::OGRLayerH,iOldFieldPos::Integer,iNewFieldPos::Integer)
    ccall((:OGR_L_ReorderField,libgdal),OGRErr,(OGRLayerH,Cint,Cint),arg1,iOldFieldPos,iNewFieldPos)
end


"""
    OGR_L_AlterFieldDefn(OGRLayerH,
                         int iField,
                         OGRFieldDefnH hNewFieldDefn,
                         int nFlags) -> OGRErr

Alter the definition of an existing field on a layer.

### Parameters
* **hLayer**: handle to the layer.
* **iField**: index of the field whose definition must be altered.
* **hNewFieldDefn**: new field definition
* **nFlags**: combination of ALTER_NAME_FLAG, ALTER_TYPE_FLAG, ALTER_WIDTH_PRECISION_FLAG, ALTER_NULLABLE_FLAG and ALTER_DEFAULT_FLAG to indicate which of the name and/or type and/or width and precision fields and/or nullability from the new field definition must be taken into account.

### Returns
OGRERR_NONE on success.
"""
function alterfielddefn(arg1::OGRLayerH,iField::Integer,hNewFieldDefn::OGRFieldDefnH,nFlags::Integer)
    ccall((:OGR_L_AlterFieldDefn,libgdal),OGRErr,(OGRLayerH,Cint,OGRFieldDefnH,Cint),arg1,iField,hNewFieldDefn,nFlags)
end


"""
    OGR_L_StartTransaction(OGRLayerH) -> OGRErr

For datasources which support transactions, StartTransaction creates a transaction.

### Parameters
* **hLayer**: handle to the layer

### Returns
OGRERR_NONE on success.
"""
function starttransaction(arg1::OGRLayerH)
    ccall((:OGR_L_StartTransaction,libgdal),OGRErr,(OGRLayerH,),arg1)
end


"""
    OGR_L_CommitTransaction(OGRLayerH) -> OGRErr

For datasources which support transactions, CommitTransaction commits a transaction.

### Parameters
* **hLayer**: handle to the layer

### Returns
OGRERR_NONE on success.
"""
function committransaction(arg1::OGRLayerH)
    ccall((:OGR_L_CommitTransaction,libgdal),OGRErr,(OGRLayerH,),arg1)
end


"""
    OGR_L_RollbackTransaction(OGRLayerH) -> OGRErr

For datasources which support transactions, RollbackTransaction will roll back a datasource to its state before the start of the current transaction.

### Parameters
* **hLayer**: handle to the layer

### Returns
OGRERR_NONE on success.
"""
function rollbacktransaction(arg1::OGRLayerH)
    ccall((:OGR_L_RollbackTransaction,libgdal),OGRErr,(OGRLayerH,),arg1)
end


"""
    OGR_L_Reference(OGRLayerH) -> int
"""
function reference(arg1::OGRLayerH)
    ccall((:OGR_L_Reference,libgdal),Cint,(OGRLayerH,),arg1)
end


"""
    OGR_L_Dereference(OGRLayerH) -> int
"""
function dereference(arg1::OGRLayerH)
    ccall((:OGR_L_Dereference,libgdal),Cint,(OGRLayerH,),arg1)
end


"""
    OGR_L_GetRefCount(OGRLayerH) -> int
"""
function getrefcount(arg1::OGRLayerH)
    ccall((:OGR_L_GetRefCount,libgdal),Cint,(OGRLayerH,),arg1)
end


"""
    OGR_L_SyncToDisk(OGRLayerH) -> OGRErr

Flush pending changes to disk.

### Parameters
* **hLayer**: handle to the layer

### Returns
OGRERR_NONE if no error occurs (even if nothing is done) or an error code.
"""
function synctodisk(arg1::OGRLayerH)
    ccall((:OGR_L_SyncToDisk,libgdal),OGRErr,(OGRLayerH,),arg1)
end


"""
    OGR_L_GetFeaturesRead(OGRLayerH) -> GIntBig
"""
function getfeaturesread(arg1::OGRLayerH)
    ccall((:OGR_L_GetFeaturesRead,libgdal),GIntBig,(OGRLayerH,),arg1)
end


"""
    OGR_L_GetFIDColumn(OGRLayerH) -> const char *

This method returns the name of the underlying database column being used as the FID column, or "" if not supported.

### Parameters
* **hLayer**: handle to the layer

### Returns
fid column name.
"""
function getfidcolumn(arg1::OGRLayerH)
    bytestring(ccall((:OGR_L_GetFIDColumn,libgdal),Ptr{UInt8},(OGRLayerH,),arg1))
end


"""
    OGR_L_GetGeometryColumn(OGRLayerH) -> const char *

This method returns the name of the underlying database column being used as the geometry column, or "" if not supported.

### Parameters
* **hLayer**: handle to the layer

### Returns
geometry column name.
"""
function getgeometrycolumn(arg1::OGRLayerH)
    bytestring(ccall((:OGR_L_GetGeometryColumn,libgdal),Ptr{UInt8},(OGRLayerH,),arg1))
end


"""
    OGR_L_GetStyleTable(OGRLayerH) -> OGRStyleTableH
"""
function getstyletable(arg1::OGRLayerH)
    checknull(ccall((:OGR_L_GetStyleTable,libgdal),OGRStyleTableH,(OGRLayerH,),arg1))
end


"""
    OGR_L_SetStyleTableDirectly(OGRLayerH,
                                OGRStyleTableH) -> void
"""
function setstyletabledirectly(arg1::OGRLayerH,arg2::OGRStyleTableH)
    ccall((:OGR_L_SetStyleTableDirectly,libgdal),Void,(OGRLayerH,OGRStyleTableH),arg1,arg2)
end


"""
    OGR_L_SetStyleTable(OGRLayerH,
                        OGRStyleTableH) -> void
"""
function setstyletable(arg1::OGRLayerH,arg2::OGRStyleTableH)
    ccall((:OGR_L_SetStyleTable,libgdal),Void,(OGRLayerH,OGRStyleTableH),arg1,arg2)
end


"""
    OGR_L_SetIgnoredFields(OGRLayerH,
                           const char **) -> OGRErr

Set which fields can be omitted when retrieving features from the layer.

### Parameters
* **papszFields**: an array of field names terminated by NULL item. If NULL is passed, the ignored list is cleared.

### Returns
OGRERR_NONE if all field names have been resolved (even if the driver does not support this method)
"""
function setignoredfields(arg1::OGRLayerH,arg2::Vector{UTF8String})
    ccall((:OGR_L_SetIgnoredFields,libgdal),OGRErr,(OGRLayerH,Ptr{Ptr{UInt8}}),arg1,arg2)
end


"""
    OGR_L_Intersection(OGRLayerH,
                       OGRLayerH,
                       OGRLayerH,
                       char **,
                       GDALProgressFunc,
                       void *) -> OGRErr

Intersection of two layers.

### Parameters
* **pLayerInput**: the input layer. Should not be NULL.
* **pLayerMethod**: the method layer. Should not be NULL.
* **pLayerResult**: the layer where the features resulting from the operation are inserted. Should not be NULL. See above the note about the schema.
* **papszOptions**: NULL terminated list of options (may be NULL).
* **pfnProgress**: a GDALProgressFunc() compatible callback function for reporting progress or NULL.
* **pProgressArg**: argument to be passed to pfnProgress. May be NULL.

### Returns
an error code if there was an error or the execution was interrupted, OGRERR_NONE otherwise.
"""
function intersection(arg1::OGRLayerH,arg2::OGRLayerH,arg3::OGRLayerH,arg4::Vector{UTF8String},arg5::GDALProgressFunc,arg6::Ptr{Void})
    ccall((:OGR_L_Intersection,libgdal),OGRErr,(OGRLayerH,OGRLayerH,OGRLayerH,Ptr{Ptr{UInt8}},GDALProgressFunc,Ptr{Void}),arg1,arg2,arg3,arg4,arg5,arg6)
end


"""
    OGR_L_Union(OGRLayerH,
                OGRLayerH,
                OGRLayerH,
                char **,
                GDALProgressFunc,
                void *) -> OGRErr

Union of two layers.

### Parameters
* **pLayerInput**: the input layer. Should not be NULL.
* **pLayerMethod**: the method layer. Should not be NULL.
* **pLayerResult**: the layer where the features resulting from the operation are inserted. Should not be NULL. See above the note about the schema.
* **papszOptions**: NULL terminated list of options (may be NULL).
* **pfnProgress**: a GDALProgressFunc() compatible callback function for reporting progress or NULL.
* **pProgressArg**: argument to be passed to pfnProgress. May be NULL.

### Returns
an error code if there was an error or the execution was interrupted, OGRERR_NONE otherwise.
"""
function union(arg1::OGRLayerH,arg2::OGRLayerH,arg3::OGRLayerH,arg4::Vector{UTF8String},arg5::GDALProgressFunc,arg6::Ptr{Void})
    ccall((:OGR_L_Union,libgdal),OGRErr,(OGRLayerH,OGRLayerH,OGRLayerH,Ptr{Ptr{UInt8}},GDALProgressFunc,Ptr{Void}),arg1,arg2,arg3,arg4,arg5,arg6)
end


"""
    OGR_L_SymDifference(OGRLayerH,
                        OGRLayerH,
                        OGRLayerH,
                        char **,
                        GDALProgressFunc,
                        void *) -> OGRErr

Symmetrical difference of two layers.

### Parameters
* **pLayerInput**: the input layer. Should not be NULL.
* **pLayerMethod**: the method layer. Should not be NULL.
* **pLayerResult**: the layer where the features resulting from the operation are inserted. Should not be NULL. See above the note about the schema.
* **papszOptions**: NULL terminated list of options (may be NULL).
* **pfnProgress**: a GDALProgressFunc() compatible callback function for reporting progress or NULL.
* **pProgressArg**: argument to be passed to pfnProgress. May be NULL.

### Returns
an error code if there was an error or the execution was interrupted, OGRERR_NONE otherwise.
"""
function symdifference(arg1::OGRLayerH,arg2::OGRLayerH,arg3::OGRLayerH,arg4::Vector{UTF8String},arg5::GDALProgressFunc,arg6::Ptr{Void})
    ccall((:OGR_L_SymDifference,libgdal),OGRErr,(OGRLayerH,OGRLayerH,OGRLayerH,Ptr{Ptr{UInt8}},GDALProgressFunc,Ptr{Void}),arg1,arg2,arg3,arg4,arg5,arg6)
end


"""
    OGR_L_Identity(OGRLayerH,
                   OGRLayerH,
                   OGRLayerH,
                   char **,
                   GDALProgressFunc,
                   void *) -> OGRErr

Identify the features of this layer with the ones from the identity layer.

### Parameters
* **pLayerInput**: the input layer. Should not be NULL.
* **pLayerMethod**: the method layer. Should not be NULL.
* **pLayerResult**: the layer where the features resulting from the operation are inserted. Should not be NULL. See above the note about the schema.
* **papszOptions**: NULL terminated list of options (may be NULL).
* **pfnProgress**: a GDALProgressFunc() compatible callback function for reporting progress or NULL.
* **pProgressArg**: argument to be passed to pfnProgress. May be NULL.

### Returns
an error code if there was an error or the execution was interrupted, OGRERR_NONE otherwise.
"""
function identity(arg1::OGRLayerH,arg2::OGRLayerH,arg3::OGRLayerH,arg4::Vector{UTF8String},arg5::GDALProgressFunc,arg6::Ptr{Void})
    ccall((:OGR_L_Identity,libgdal),OGRErr,(OGRLayerH,OGRLayerH,OGRLayerH,Ptr{Ptr{UInt8}},GDALProgressFunc,Ptr{Void}),arg1,arg2,arg3,arg4,arg5,arg6)
end


"""
    OGR_L_Update(OGRLayerH,
                 OGRLayerH,
                 OGRLayerH,
                 char **,
                 GDALProgressFunc,
                 void *) -> OGRErr

Update this layer with features from the update layer.

### Parameters
* **pLayerInput**: the input layer. Should not be NULL.
* **pLayerMethod**: the method layer. Should not be NULL.
* **pLayerResult**: the layer where the features resulting from the operation are inserted. Should not be NULL. See above the note about the schema.
* **papszOptions**: NULL terminated list of options (may be NULL).
* **pfnProgress**: a GDALProgressFunc() compatible callback function for reporting progress or NULL.
* **pProgressArg**: argument to be passed to pfnProgress. May be NULL.

### Returns
an error code if there was an error or the execution was interrupted, OGRERR_NONE otherwise.
"""
function update(arg1::OGRLayerH,arg2::OGRLayerH,arg3::OGRLayerH,arg4::Vector{UTF8String},arg5::GDALProgressFunc,arg6::Ptr{Void})
    ccall((:OGR_L_Update,libgdal),OGRErr,(OGRLayerH,OGRLayerH,OGRLayerH,Ptr{Ptr{UInt8}},GDALProgressFunc,Ptr{Void}),arg1,arg2,arg3,arg4,arg5,arg6)
end


"""
    OGR_L_Clip(OGRLayerH,
               OGRLayerH,
               OGRLayerH,
               char **,
               GDALProgressFunc,
               void *) -> OGRErr

Clip off areas that are not covered by the method layer.

### Parameters
* **pLayerInput**: the input layer. Should not be NULL.
* **pLayerMethod**: the method layer. Should not be NULL.
* **pLayerResult**: the layer where the features resulting from the operation are inserted. Should not be NULL. See above the note about the schema.
* **papszOptions**: NULL terminated list of options (may be NULL).
* **pfnProgress**: a GDALProgressFunc() compatible callback function for reporting progress or NULL.
* **pProgressArg**: argument to be passed to pfnProgress. May be NULL.

### Returns
an error code if there was an error or the execution was interrupted, OGRERR_NONE otherwise.
"""
function clip(arg1::OGRLayerH,arg2::OGRLayerH,arg3::OGRLayerH,arg4::Vector{UTF8String},arg5::GDALProgressFunc,arg6::Ptr{Void})
    ccall((:OGR_L_Clip,libgdal),OGRErr,(OGRLayerH,OGRLayerH,OGRLayerH,Ptr{Ptr{UInt8}},GDALProgressFunc,Ptr{Void}),arg1,arg2,arg3,arg4,arg5,arg6)
end


"""
    OGR_L_Erase(OGRLayerH,
                OGRLayerH,
                OGRLayerH,
                char **,
                GDALProgressFunc,
                void *) -> OGRErr

Remove areas that are covered by the method layer.

### Parameters
* **pLayerInput**: the input layer. Should not be NULL.
* **pLayerMethod**: the method layer. Should not be NULL.
* **pLayerResult**: the layer where the features resulting from the operation are inserted. Should not be NULL. See above the note about the schema.
* **papszOptions**: NULL terminated list of options (may be NULL).
* **pfnProgress**: a GDALProgressFunc() compatible callback function for reporting progress or NULL.
* **pProgressArg**: argument to be passed to pfnProgress. May be NULL.

### Returns
an error code if there was an error or the execution was interrupted, OGRERR_NONE otherwise.
"""
function erase(arg1::OGRLayerH,arg2::OGRLayerH,arg3::OGRLayerH,arg4::Vector{UTF8String},arg5::GDALProgressFunc,arg6::Ptr{Void})
    ccall((:OGR_L_Erase,libgdal),OGRErr,(OGRLayerH,OGRLayerH,OGRLayerH,Ptr{Ptr{UInt8}},GDALProgressFunc,Ptr{Void}),arg1,arg2,arg3,arg4,arg5,arg6)
end


"""
    OGR_DS_Destroy(OGRDataSourceH) -> void

Closes opened datasource and releases allocated resources.

### Parameters
* **hDataSource**: handle to allocated datasource object.
"""
function destroy(arg1::OGRDataSourceH)
    ccall((:OGR_DS_Destroy,libgdal),Void,(OGRDataSourceH,),arg1)
end


"""
    OGR_DS_GetName(OGRDataSourceH) -> const char *

Returns the name of the data source.

### Parameters
* **hDS**: handle to the data source to get the name from.

### Returns
pointer to an internal name string which should not be modified or freed by the caller.
"""
function getname(arg1::OGRDataSourceH)
    bytestring(ccall((:OGR_DS_GetName,libgdal),Ptr{UInt8},(OGRDataSourceH,),arg1))
end


"""
    OGR_DS_GetLayerCount(OGRDataSourceH) -> int

Get the number of layers in this data source.

### Parameters
* **hDS**: handle to the data source from which to get the number of layers.

### Returns
layer count.
"""
function getlayercount(arg1::OGRDataSourceH)
    ccall((:OGR_DS_GetLayerCount,libgdal),Cint,(OGRDataSourceH,),arg1)
end


"""
    OGR_DS_GetLayer(OGRDataSourceH,
                    int) -> OGRLayerH

Fetch a layer by index.

### Parameters
* **hDS**: handle to the data source from which to get the layer.
* **iLayer**: a layer number between 0 and OGR_DS_GetLayerCount()-1.

### Returns
an handle to the layer, or NULL if iLayer is out of range or an error occurs.
"""
function getlayer(arg1::OGRDataSourceH,arg2::Integer)
    checknull(ccall((:OGR_DS_GetLayer,libgdal),OGRLayerH,(OGRDataSourceH,Cint),arg1,arg2))
end


"""
    OGR_DS_GetLayerByName(OGRDataSourceH,
                          const char *) -> OGRLayerH

Fetch a layer by name.

### Parameters
* **hDS**: handle to the data source from which to get the layer.
* **pszLayerName**: Layer the layer name of the layer to fetch.

### Returns
an handle to the layer, or NULL if the layer is not found or an error occurs.
"""
function getlayerbyname(arg1::OGRDataSourceH,arg2::AbstractString)
    checknull(ccall((:OGR_DS_GetLayerByName,libgdal),OGRLayerH,(OGRDataSourceH,Ptr{UInt8}),arg1,arg2))
end


"""
    OGR_DS_DeleteLayer(OGRDataSourceH,
                       int) -> OGRErr

Delete the indicated layer from the datasource.

### Parameters
* **hDS**: handle to the datasource
* **iLayer**: the index of the layer to delete.

### Returns
OGRERR_NONE on success, or OGRERR_UNSUPPORTED_OPERATION if deleting layers is not supported for this datasource.
"""
function deletelayer(arg1::OGRDataSourceH,arg2::Integer)
    ccall((:OGR_DS_DeleteLayer,libgdal),OGRErr,(OGRDataSourceH,Cint),arg1,arg2)
end


"""
    OGR_DS_GetDriver(OGRDataSourceH) -> OGRSFDriverH

Returns the driver that the dataset was opened with.

### Parameters
* **hDS**: handle to the datasource

### Returns
NULL if driver info is not available, or pointer to a driver owned by the OGRSFDriverManager.
"""
function getdriver(arg1::OGRDataSourceH)
    checknull(ccall((:OGR_DS_GetDriver,libgdal),OGRSFDriverH,(OGRDataSourceH,),arg1))
end


"""
    OGR_DS_CreateLayer(OGRDataSourceH,
                       const char *,
                       OGRSpatialReferenceH,
                       OGRwkbGeometryType,
                       char **) -> OGRLayerH

This function attempts to create a new layer on the data source with the indicated name, coordinate system, geometry type.

### Parameters
* **hDS**: The dataset handle.
* **pszName**: the name for the new layer. This should ideally not match any existing layer on the datasource.
* **hSpatialRef**: handle to the coordinate system to use for the new layer, or NULL if no coordinate system is available.
* **eType**: the geometry type for the layer. Use wkbUnknown if there are no constraints on the types geometry to be written.
* **papszOptions**: a StringList of name=value options. Options are driver specific, and driver information can be found at the following url: http://www.gdal.org/ogr/ogr_formats.html

### Returns
NULL is returned on failure, or a new OGRLayer handle on success.
"""
function createlayer(arg1::OGRDataSourceH,arg2::AbstractString,arg3::OGRSpatialReferenceH,arg4::OGRwkbGeometryType,arg5::Vector{UTF8String})
    checknull(ccall((:OGR_DS_CreateLayer,libgdal),OGRLayerH,(OGRDataSourceH,Ptr{UInt8},OGRSpatialReferenceH,OGRwkbGeometryType,Ptr{Ptr{UInt8}}),arg1,arg2,arg3,arg4,arg5))
end


"""
    OGR_DS_CopyLayer(OGRDataSourceH,
                     OGRLayerH,
                     const char *,
                     char **) -> OGRLayerH

Duplicate an existing layer.

### Parameters
* **hDS**: handle to the data source where to create the new layer
* **hSrcLayer**: handle to the source layer.
* **pszNewName**: the name of the layer to create.
* **papszOptions**: a StringList of name=value options. Options are driver specific.

### Returns
an handle to the layer, or NULL if an error occurs.
"""
function copylayer(arg1::OGRDataSourceH,arg2::OGRLayerH,arg3::AbstractString,arg4::Vector{UTF8String})
    checknull(ccall((:OGR_DS_CopyLayer,libgdal),OGRLayerH,(OGRDataSourceH,OGRLayerH,Ptr{UInt8},Ptr{Ptr{UInt8}}),arg1,arg2,arg3,arg4))
end


"""
    OGR_DS_TestCapability(OGRDataSourceH,
                          const char *) -> int

Test if capability is available.

### Parameters
* **hDS**: handle to the data source against which to test the capability.
* **pszCapability**: the capability to test.

### Returns
TRUE if capability available otherwise FALSE.
"""
function testcapability(arg1::OGRDataSourceH,arg2::AbstractString)
    ccall((:OGR_DS_TestCapability,libgdal),Cint,(OGRDataSourceH,Ptr{UInt8}),arg1,arg2)
end


"""
    OGR_DS_ExecuteSQL(OGRDataSourceH,
                      const char *,
                      OGRGeometryH,
                      const char *) -> OGRLayerH

Execute an SQL statement against the data store.

### Parameters
* **hDS**: handle to the data source on which the SQL query is executed.
* **pszSQLCommand**: the SQL statement to execute.
* **hSpatialFilter**: handle to a geometry which represents a spatial filter. Can be NULL.
* **pszDialect**: allows control of the statement dialect. If set to NULL, the OGR SQL engine will be used, except for RDBMS drivers that will use their dedicated SQL engine, unless OGRSQL is explicitly passed as the dialect. Starting with OGR 1.10, the SQLITE dialect can also be used.

### Returns
an handle to a OGRLayer containing the results of the query. Deallocate with OGR_DS_ReleaseResultSet().
"""
function executesql(arg1::OGRDataSourceH,arg2::AbstractString,arg3::OGRGeometryH,arg4::AbstractString)
    checknull(ccall((:OGR_DS_ExecuteSQL,libgdal),OGRLayerH,(OGRDataSourceH,Ptr{UInt8},OGRGeometryH,Ptr{UInt8}),arg1,arg2,arg3,arg4))
end


"""
    OGR_DS_ReleaseResultSet(OGRDataSourceH,
                            OGRLayerH) -> void

Release results of OGR_DS_ExecuteSQL().

### Parameters
* **hDS**: an handle to the data source on which was executed an SQL query.
* **hLayer**: handle to the result of a previous OGR_DS_ExecuteSQL() call.
"""
function releaseresultset(arg1::OGRDataSourceH,arg2::OGRLayerH)
    ccall((:OGR_DS_ReleaseResultSet,libgdal),Void,(OGRDataSourceH,OGRLayerH),arg1,arg2)
end


"""
    OGR_DS_Reference(OGRDataSourceH) -> int
"""
function reference(arg1::OGRDataSourceH)
    ccall((:OGR_DS_Reference,libgdal),Cint,(OGRDataSourceH,),arg1)
end


"""
    OGR_DS_Dereference(OGRDataSourceH) -> int
"""
function dereference(arg1::OGRDataSourceH)
    ccall((:OGR_DS_Dereference,libgdal),Cint,(OGRDataSourceH,),arg1)
end


"""
    OGR_DS_GetRefCount(OGRDataSourceH) -> int
"""
function getrefcount(arg1::OGRDataSourceH)
    ccall((:OGR_DS_GetRefCount,libgdal),Cint,(OGRDataSourceH,),arg1)
end


"""
    OGR_DS_GetSummaryRefCount(OGRDataSourceH) -> int
"""
function getsummaryrefcount(arg1::OGRDataSourceH)
    ccall((:OGR_DS_GetSummaryRefCount,libgdal),Cint,(OGRDataSourceH,),arg1)
end


"""
    OGR_DS_SyncToDisk(OGRDataSourceH) -> OGRErr
"""
function synctodisk(arg1::OGRDataSourceH)
    ccall((:OGR_DS_SyncToDisk,libgdal),OGRErr,(OGRDataSourceH,),arg1)
end


"""
    OGR_DS_GetStyleTable(OGRDataSourceH) -> OGRStyleTableH
"""
function getstyletable(arg1::OGRDataSourceH)
    checknull(ccall((:OGR_DS_GetStyleTable,libgdal),OGRStyleTableH,(OGRDataSourceH,),arg1))
end


"""
    OGR_DS_SetStyleTableDirectly(OGRDataSourceH,
                                 OGRStyleTableH) -> void
"""
function setstyletabledirectly(arg1::OGRDataSourceH,arg2::OGRStyleTableH)
    ccall((:OGR_DS_SetStyleTableDirectly,libgdal),Void,(OGRDataSourceH,OGRStyleTableH),arg1,arg2)
end


"""
    OGR_DS_SetStyleTable(OGRDataSourceH,
                         OGRStyleTableH) -> void
"""
function setstyletable(arg1::OGRDataSourceH,arg2::OGRStyleTableH)
    ccall((:OGR_DS_SetStyleTable,libgdal),Void,(OGRDataSourceH,OGRStyleTableH),arg1,arg2)
end


"""
    OGR_Dr_GetName(OGRSFDriverH) -> const char *

Fetch name of driver (file format).

### Parameters
* **hDriver**: handle to the the driver to get the name from.

### Returns
driver name. This is an internal string and should not be modified or freed.
"""
function getname(arg1::OGRSFDriverH)
    bytestring(ccall((:OGR_Dr_GetName,libgdal),Ptr{UInt8},(OGRSFDriverH,),arg1))
end


"""
    OGR_Dr_Open(OGRSFDriverH,
                const char *,
                int) -> OGRDataSourceH

Attempt to open file with this driver.

### Parameters
* **hDriver**: handle to the driver that is used to open file.
* **pszName**: the name of the file, or data source to try and open.
* **bUpdate**: TRUE if update access is required, otherwise FALSE (the default).

### Returns
NULL on error or if the pass name is not supported by this driver, otherwise an handle to a GDALDataset. This GDALDataset should be closed by deleting the object when it is no longer needed.
"""
function open(arg1::OGRSFDriverH,arg2::AbstractString,arg3::Integer)
    checknull(ccall((:OGR_Dr_Open,libgdal),OGRDataSourceH,(OGRSFDriverH,Ptr{UInt8},Cint),arg1,arg2,arg3))
end


"""
    OGR_Dr_TestCapability(OGRSFDriverH,
                          const char *) -> int

Test if capability is available.

### Parameters
* **hDriver**: handle to the driver to test the capability against.
* **pszCap**: the capability to test.

### Returns
TRUE if capability available otherwise FALSE.
"""
function testcapability(arg1::OGRSFDriverH,arg2::AbstractString)
    ccall((:OGR_Dr_TestCapability,libgdal),Cint,(OGRSFDriverH,Ptr{UInt8}),arg1,arg2)
end


"""
    OGR_Dr_CreateDataSource(OGRSFDriverH,
                            const char *,
                            char **) -> OGRDataSourceH

This function attempts to create a new data source based on the passed driver.

### Parameters
* **hDriver**: handle to the driver on which data source creation is based.
* **pszName**: the name for the new data source. UTF-8 encoded.
* **papszOptions**: a StringList of name=value options. Options are driver specific, and driver information can be found at the following url: http://www.gdal.org/ogr/ogr_formats.html

### Returns
NULL is returned on failure, or a new OGRDataSource handle on success.
"""
function createdatasource(arg1::OGRSFDriverH,arg2::AbstractString,arg3::Vector{UTF8String})
    checknull(ccall((:OGR_Dr_CreateDataSource,libgdal),OGRDataSourceH,(OGRSFDriverH,Ptr{UInt8},Ptr{Ptr{UInt8}}),arg1,arg2,arg3))
end


"""
    OGR_Dr_CopyDataSource(OGRSFDriverH,
                          OGRDataSourceH,
                          const char *,
                          char **) -> OGRDataSourceH

This function creates a new datasource by copying all the layers from the source datasource.

### Parameters
* **hDriver**: handle to the driver on which data source creation is based.
* **hSrcDS**: source datasource
* **pszNewName**: the name for the new data source.
* **papszOptions**: a StringList of name=value options. Options are driver specific, and driver information can be found at the following url: http://www.gdal.org/ogr/ogr_formats.html

### Returns
NULL is returned on failure, or a new OGRDataSource handle on success.
"""
function copydatasource(arg1::OGRSFDriverH,arg2::OGRDataSourceH,arg3::AbstractString,arg4::Vector{UTF8String})
    checknull(ccall((:OGR_Dr_CopyDataSource,libgdal),OGRDataSourceH,(OGRSFDriverH,OGRDataSourceH,Ptr{UInt8},Ptr{Ptr{UInt8}}),arg1,arg2,arg3,arg4))
end


"""
    OGR_Dr_DeleteDataSource(OGRSFDriverH,
                            const char *) -> OGRErr

Delete a datasource.

### Parameters
* **hDriver**: handle to the driver on which data source deletion is based.
* **pszDataSource**: the name of the datasource to delete.

### Returns
OGRERR_NONE on success, and OGRERR_UNSUPPORTED_OPERATION if this is not supported by this driver.
"""
function deletedatasource(arg1::OGRSFDriverH,arg2::AbstractString)
    ccall((:OGR_Dr_DeleteDataSource,libgdal),OGRErr,(OGRSFDriverH,Ptr{UInt8}),arg1,arg2)
end


"""
    OGROpen(const char *,
            int,
            OGRSFDriverH *) -> OGRDataSourceH

Open a file / data source with one of the registered drivers.

### Parameters
* **pszName**: the name of the file, or data source to open.
* **bUpdate**: FALSE for read-only access (the default) or TRUE for read-write access.
* **pahDriverList**: if non-NULL, this argument will be updated with a pointer to the driver which was used to open the data source.

### Returns
NULL on error or if the pass name is not supported by this driver, otherwise an handle to a GDALDataset. This GDALDataset should be closed by deleting the object when it is no longer needed.
"""
function open(arg1::AbstractString,arg2::Integer,arg3::Ptr{OGRSFDriverH})
    checknull(ccall((:OGROpen,libgdal),OGRDataSourceH,(Ptr{UInt8},Cint,Ptr{OGRSFDriverH}),arg1,arg2,arg3))
end


"""
    OGROpenShared(const char *,
                  int,
                  OGRSFDriverH *) -> OGRDataSourceH
"""
function openshared(arg1::AbstractString,arg2::Integer,arg3::Ptr{OGRSFDriverH})
    checknull(ccall((:OGROpenShared,libgdal),OGRDataSourceH,(Ptr{UInt8},Cint,Ptr{OGRSFDriverH}),arg1,arg2,arg3))
end


"""
    OGRReleaseDataSource(OGRDataSourceH) -> OGRErr

Drop a reference to this datasource, and if the reference count drops to zero close (destroy) the datasource.

### Parameters
* **hDS**: handle to the data source to release

### Returns
OGRERR_NONE on success or an error code.
"""
function releasedatasource(arg1::OGRDataSourceH)
    ccall((:OGRReleaseDataSource,libgdal),OGRErr,(OGRDataSourceH,),arg1)
end


"""
    OGRRegisterDriver(OGRSFDriverH) -> void
"""
function registerdriver(arg1::OGRSFDriverH)
    ccall((:OGRRegisterDriver,libgdal),Void,(OGRSFDriverH,),arg1)
end


"""
    OGRDeregisterDriver(OGRSFDriverH) -> void
"""
function deregisterdriver(arg1::OGRSFDriverH)
    ccall((:OGRDeregisterDriver,libgdal),Void,(OGRSFDriverH,),arg1)
end


"""
    OGRGetDriverCount(void) -> int

Fetch the number of registered drivers.

### Returns
the drivers count.
"""
function getdrivercount()
    ccall((:OGRGetDriverCount,libgdal),Cint,())
end


"""
    OGRGetDriver(int) -> OGRSFDriverH

Fetch the indicated driver.

### Parameters
* **iDriver**: the driver index, from 0 to GetDriverCount()-1.

### Returns
handle to the driver, or NULL if iDriver is out of range.
"""
function getdriver(arg1::Integer)
    checknull(ccall((:OGRGetDriver,libgdal),OGRSFDriverH,(Cint,),arg1))
end


"""
    OGRGetDriverByName(const char *) -> OGRSFDriverH

Fetch the indicated driver.

### Parameters
* **pszName**: the driver name

### Returns
the driver, or NULL if no driver with that name is found
"""
function getdriverbyname(arg1::AbstractString)
    checknull(ccall((:OGRGetDriverByName,libgdal),OGRSFDriverH,(Ptr{UInt8},),arg1))
end


"""
    OGRGetOpenDSCount(void) -> int
"""
function getopendscount()
    ccall((:OGRGetOpenDSCount,libgdal),Cint,())
end


"""
    OGRGetOpenDS(int iDS) -> OGRDataSourceH
"""
function getopends(iDS::Integer)
    checknull(ccall((:OGRGetOpenDS,libgdal),OGRDataSourceH,(Cint,),iDS))
end


"""
    OGRRegisterAll(void) -> void

Register all drivers.
"""
function registerall()
    ccall((:OGRRegisterAll,libgdal),Void,())
end


"""
    OGRCleanupAll(void) -> void

Cleanup all OGR related resources.
"""
function cleanupall()
    ccall((:OGRCleanupAll,libgdal),Void,())
end


"""
    OGR_SM_Create(OGRStyleTableH hStyleTable) -> OGRStyleMgrH

OGRStyleMgr factory.

### Parameters
* **hStyleTable**: pointer to OGRStyleTable or NULL if not working with a style table.

### Returns
an handle to the new style manager object.
"""
function create(hStyleTable::OGRStyleTableH)
    checknull(ccall((:OGR_SM_Create,libgdal),OGRStyleMgrH,(OGRStyleTableH,),hStyleTable))
end


"""
    OGR_SM_Destroy(OGRStyleMgrH hSM) -> void

Destroy Style Manager.

### Parameters
* **hSM**: handle to the style manager to destroy.
"""
function destroy(hSM::OGRStyleMgrH)
    ccall((:OGR_SM_Destroy,libgdal),Void,(OGRStyleMgrH,),hSM)
end


"""
    OGR_SM_InitFromFeature(OGRStyleMgrH hSM,
                           OGRFeatureH hFeat) -> const char *

Initialize style manager from the style string of a feature.

### Parameters
* **hSM**: handle to the style manager.
* **hFeat**: handle to the new feature from which to read the style.

### Returns
a reference to the style string read from the feature, or NULL in case of error.
"""
function initfromfeature(hSM::OGRStyleMgrH,hFeat::OGRFeatureH)
    bytestring(ccall((:OGR_SM_InitFromFeature,libgdal),Ptr{UInt8},(OGRStyleMgrH,OGRFeatureH),hSM,hFeat))
end


"""
    OGR_SM_InitStyleString(OGRStyleMgrH hSM,
                           const char * pszStyleString) -> int

Initialize style manager from the style string.

### Parameters
* **hSM**: handle to the style manager.
* **pszStyleString**: the style string to use (can be NULL).

### Returns
TRUE on success, FALSE on errors.
"""
function initstylestring(hSM::OGRStyleMgrH,pszStyleString::AbstractString)
    ccall((:OGR_SM_InitStyleString,libgdal),Cint,(OGRStyleMgrH,Ptr{UInt8}),hSM,pszStyleString)
end


"""
    OGR_SM_GetPartCount(OGRStyleMgrH hSM,
                        const char * pszStyleString) -> int

Get the number of parts in a style.

### Parameters
* **hSM**: handle to the style manager.
* **pszStyleString**: (optional) the style string on which to operate. If NULL then the current style string stored in the style manager is used.

### Returns
the number of parts (style tools) in the style.
"""
function getpartcount(hSM::OGRStyleMgrH,pszStyleString::AbstractString)
    ccall((:OGR_SM_GetPartCount,libgdal),Cint,(OGRStyleMgrH,Ptr{UInt8}),hSM,pszStyleString)
end


"""
    OGR_SM_GetPart(OGRStyleMgrH hSM,
                   int nPartId,
                   const char * pszStyleString) -> OGRStyleToolH

Fetch a part (style tool) from the current style.

### Parameters
* **hSM**: handle to the style manager.
* **nPartId**: the part number (0-based index).
* **pszStyleString**: (optional) the style string on which to operate. If NULL then the current style string stored in the style manager is used.

### Returns
OGRStyleToolH of the requested part (style tools) or NULL on error.
"""
function getpart(hSM::OGRStyleMgrH,nPartId::Integer,pszStyleString::AbstractString)
    checknull(ccall((:OGR_SM_GetPart,libgdal),OGRStyleToolH,(OGRStyleMgrH,Cint,Ptr{UInt8}),hSM,nPartId,pszStyleString))
end


"""
    OGR_SM_AddPart(OGRStyleMgrH hSM,
                   OGRStyleToolH hST) -> int

Add a part (style tool) to the current style.

### Parameters
* **hSM**: handle to the style manager.
* **hST**: the style tool defining the part to add.

### Returns
TRUE on success, FALSE on errors.
"""
function addpart(hSM::OGRStyleMgrH,hST::OGRStyleToolH)
    ccall((:OGR_SM_AddPart,libgdal),Cint,(OGRStyleMgrH,OGRStyleToolH),hSM,hST)
end


"""
    OGR_SM_AddStyle(OGRStyleMgrH hSM,
                    const char * pszStyleName,
                    const char * pszStyleString) -> int

Add a style to the current style table.

### Parameters
* **hSM**: handle to the style manager.
* **pszStyleName**: the name of the style to add.
* **pszStyleString**: the style string to use, or NULL to use the style stored in the manager.

### Returns
TRUE on success, FALSE on errors.
"""
function addstyle(hSM::OGRStyleMgrH,pszStyleName::AbstractString,pszStyleString::AbstractString)
    ccall((:OGR_SM_AddStyle,libgdal),Cint,(OGRStyleMgrH,Ptr{UInt8},Ptr{UInt8}),hSM,pszStyleName,pszStyleString)
end


"""
    OGR_ST_Create(OGRSTClassId eClassId) -> OGRStyleToolH

OGRStyleTool factory.

### Parameters
* **eClassId**: subclass of style tool to create. One of OGRSTCPen (1), OGRSTCBrush (2), OGRSTCSymbol (3) or OGRSTCLabel (4).

### Returns
an handle to the new style tool object or NULL if the creation failed.
"""
function create(eClassId::OGRSTClassId)
    checknull(ccall((:OGR_ST_Create,libgdal),OGRStyleToolH,(OGRSTClassId,),eClassId))
end


"""
    OGR_ST_Destroy(OGRStyleToolH hST) -> void

Destroy Style Tool.

### Parameters
* **hST**: handle to the style tool to destroy.
"""
function destroy(hST::OGRStyleToolH)
    ccall((:OGR_ST_Destroy,libgdal),Void,(OGRStyleToolH,),hST)
end


"""
    OGR_ST_GetType(OGRStyleToolH hST) -> OGRSTClassId

Determine type of Style Tool.

### Parameters
* **hST**: handle to the style tool.

### Returns
the style tool type, one of OGRSTCPen (1), OGRSTCBrush (2), OGRSTCSymbol (3) or OGRSTCLabel (4). Returns OGRSTCNone (0) if the OGRStyleToolH is invalid.
"""
function gettype(hST::OGRStyleToolH)
    ccall((:OGR_ST_GetType,libgdal),OGRSTClassId,(OGRStyleToolH,),hST)
end


"""
    OGR_ST_GetUnit(OGRStyleToolH hST) -> OGRSTUnitId

Get Style Tool units.

### Parameters
* **hST**: handle to the style tool.

### Returns
the style tool units.
"""
function getunit(hST::OGRStyleToolH)
    ccall((:OGR_ST_GetUnit,libgdal),OGRSTUnitId,(OGRStyleToolH,),hST)
end


"""
    OGR_ST_SetUnit(OGRStyleToolH hST,
                   OGRSTUnitId eUnit,
                   double dfGroundPaperScale) -> void

Set Style Tool units.

### Parameters
* **hST**: handle to the style tool.
* **eUnit**: the new unit.
* **dfGroundPaperScale**: ground to paper scale factor.
"""
function setunit(hST::OGRStyleToolH,eUnit::OGRSTUnitId,dfGroundPaperScale::Real)
    ccall((:OGR_ST_SetUnit,libgdal),Void,(OGRStyleToolH,OGRSTUnitId,Cdouble),hST,eUnit,dfGroundPaperScale)
end


"""
    OGR_ST_GetParamStr(OGRStyleToolH hST,
                       int eParam,
                       int * bValueIsNull) -> const char *

Get Style Tool parameter value as string.

### Parameters
* **hST**: handle to the style tool.
* **eParam**: the parameter id from the enumeration corresponding to the type of this style tool (one of the OGRSTPenParam, OGRSTBrushParam, OGRSTSymbolParam or OGRSTLabelParam enumerations)
* **bValueIsNull**: pointer to an integer that will be set to TRUE or FALSE to indicate whether the parameter value is NULL.

### Returns
the parameter value as string and sets bValueIsNull.
"""
function getparamstr(hST::OGRStyleToolH,eParam::Integer,bValueIsNull::Vector{Cint})
    bytestring(ccall((:OGR_ST_GetParamStr,libgdal),Ptr{UInt8},(OGRStyleToolH,Cint,Ptr{Cint}),hST,eParam,bValueIsNull))
end


"""
    OGR_ST_GetParamNum(OGRStyleToolH hST,
                       int eParam,
                       int * bValueIsNull) -> int

Get Style Tool parameter value as an integer.

### Parameters
* **hST**: handle to the style tool.
* **eParam**: the parameter id from the enumeration corresponding to the type of this style tool (one of the OGRSTPenParam, OGRSTBrushParam, OGRSTSymbolParam or OGRSTLabelParam enumerations)
* **bValueIsNull**: pointer to an integer that will be set to TRUE or FALSE to indicate whether the parameter value is NULL.

### Returns
the parameter value as integer and sets bValueIsNull.
"""
function getparamnum(hST::OGRStyleToolH,eParam::Integer,bValueIsNull::Vector{Cint})
    ccall((:OGR_ST_GetParamNum,libgdal),Cint,(OGRStyleToolH,Cint,Ptr{Cint}),hST,eParam,bValueIsNull)
end


"""
    OGR_ST_GetParamDbl(OGRStyleToolH hST,
                       int eParam,
                       int * bValueIsNull) -> double

Get Style Tool parameter value as a double.

### Parameters
* **hST**: handle to the style tool.
* **eParam**: the parameter id from the enumeration corresponding to the type of this style tool (one of the OGRSTPenParam, OGRSTBrushParam, OGRSTSymbolParam or OGRSTLabelParam enumerations)
* **bValueIsNull**: pointer to an integer that will be set to TRUE or FALSE to indicate whether the parameter value is NULL.

### Returns
the parameter value as double and sets bValueIsNull.
"""
function getparamdbl(hST::OGRStyleToolH,eParam::Integer,bValueIsNull::Vector{Cint})
    ccall((:OGR_ST_GetParamDbl,libgdal),Cdouble,(OGRStyleToolH,Cint,Ptr{Cint}),hST,eParam,bValueIsNull)
end


"""
    OGR_ST_SetParamStr(OGRStyleToolH hST,
                       int eParam,
                       const char * pszValue) -> void

Set Style Tool parameter value from a string.

### Parameters
* **hST**: handle to the style tool.
* **eParam**: the parameter id from the enumeration corresponding to the type of this style tool (one of the OGRSTPenParam, OGRSTBrushParam, OGRSTSymbolParam or OGRSTLabelParam enumerations)
* **pszValue**: the new parameter value
"""
function setparamstr(hST::OGRStyleToolH,eParam::Integer,pszValue::AbstractString)
    ccall((:OGR_ST_SetParamStr,libgdal),Void,(OGRStyleToolH,Cint,Ptr{UInt8}),hST,eParam,pszValue)
end


"""
    OGR_ST_SetParamNum(OGRStyleToolH hST,
                       int eParam,
                       int nValue) -> void

Set Style Tool parameter value from an integer.

### Parameters
* **hST**: handle to the style tool.
* **eParam**: the parameter id from the enumeration corresponding to the type of this style tool (one of the OGRSTPenParam, OGRSTBrushParam, OGRSTSymbolParam or OGRSTLabelParam enumerations)
* **nValue**: the new parameter value
"""
function setparamnum(hST::OGRStyleToolH,eParam::Integer,nValue::Integer)
    ccall((:OGR_ST_SetParamNum,libgdal),Void,(OGRStyleToolH,Cint,Cint),hST,eParam,nValue)
end


"""
    OGR_ST_SetParamDbl(OGRStyleToolH hST,
                       int eParam,
                       double dfValue) -> void

Set Style Tool parameter value from a double.

### Parameters
* **hST**: handle to the style tool.
* **eParam**: the parameter id from the enumeration corresponding to the type of this style tool (one of the OGRSTPenParam, OGRSTBrushParam, OGRSTSymbolParam or OGRSTLabelParam enumerations)
* **dfValue**: the new parameter value
"""
function setparamdbl(hST::OGRStyleToolH,eParam::Integer,dfValue::Real)
    ccall((:OGR_ST_SetParamDbl,libgdal),Void,(OGRStyleToolH,Cint,Cdouble),hST,eParam,dfValue)
end


"""
    OGR_ST_GetStyleString(OGRStyleToolH hST) -> const char *

Get the style string for this Style Tool.

### Parameters
* **hST**: handle to the style tool.

### Returns
the style string for this style tool or "" if the hST is invalid.
"""
function getstylestring(hST::OGRStyleToolH)
    bytestring(ccall((:OGR_ST_GetStyleString,libgdal),Ptr{UInt8},(OGRStyleToolH,),hST))
end


"""
    OGR_ST_GetRGBFromString(OGRStyleToolH hST,
                            const char * pszColor,
                            int * pnRed,
                            int * pnGreen,
                            int * pnBlue,
                            int * pnAlpha) -> int

Return the r,g,b,a components of a color encoded in #RRGGBB[AA] format.

### Parameters
* **hST**: handle to the style tool.
* **pszColor**: the color to parse
* **pnRed**: pointer to an int in which the red value will be returned
* **pnGreen**: pointer to an int in which the green value will be returned
* **pnBlue**: pointer to an int in which the blue value will be returned
* **pnAlpha**: pointer to an int in which the (optional) alpha value will be returned

### Returns
TRUE if the color could be succesfully parsed, or FALSE in case of errors.
"""
function getrgbfromstring(hST::OGRStyleToolH,pszColor::AbstractString,pnRed::Vector{Cint},pnGreen::Vector{Cint},pnBlue::Vector{Cint},pnAlpha::Vector{Cint})
    ccall((:OGR_ST_GetRGBFromString,libgdal),Cint,(OGRStyleToolH,Ptr{UInt8},Ptr{Cint},Ptr{Cint},Ptr{Cint},Ptr{Cint}),hST,pszColor,pnRed,pnGreen,pnBlue,pnAlpha)
end


"""
    OGR_STBL_Create(void) -> OGRStyleTableH

OGRStyleTable factory.

### Returns
an handle to the new style table object.
"""
function create()
    checknull(ccall((:OGR_STBL_Create,libgdal),OGRStyleTableH,()))
end


"""
    OGR_STBL_Destroy(OGRStyleTableH hSTBL) -> void

Destroy Style Table.

### Parameters
* **hSTBL**: handle to the style table to destroy.
"""
function destroy(hSTBL::OGRStyleTableH)
    ccall((:OGR_STBL_Destroy,libgdal),Void,(OGRStyleTableH,),hSTBL)
end


"""
    OGR_STBL_AddStyle(OGRStyleTableH hStyleTable,
                      const char * pszName,
                      const char * pszStyleString) -> int

Add a new style in the table.

### Parameters
* **hStyleTable**: handle to the style table.
* **pszName**: the name the style to add.
* **pszStyleString**: the style string to add.

### Returns
TRUE on success, FALSE on error
"""
function addstyle(hStyleTable::OGRStyleTableH,pszName::AbstractString,pszStyleString::AbstractString)
    ccall((:OGR_STBL_AddStyle,libgdal),Cint,(OGRStyleTableH,Ptr{UInt8},Ptr{UInt8}),hStyleTable,pszName,pszStyleString)
end


"""
    OGR_STBL_SaveStyleTable(OGRStyleTableH hStyleTable,
                            const char * pszFilename) -> int

Save a style table to a file.

### Parameters
* **hStyleTable**: handle to the style table.
* **pszFilename**: the name of the file to save to.

### Returns
TRUE on success, FALSE on error
"""
function savestyletable(hStyleTable::OGRStyleTableH,pszFilename::AbstractString)
    ccall((:OGR_STBL_SaveStyleTable,libgdal),Cint,(OGRStyleTableH,Ptr{UInt8}),hStyleTable,pszFilename)
end


"""
    OGR_STBL_LoadStyleTable(OGRStyleTableH hStyleTable,
                            const char * pszFilename) -> int

Load a style table from a file.

### Parameters
* **hStyleTable**: handle to the style table.
* **pszFilename**: the name of the file to load from.

### Returns
TRUE on success, FALSE on error
"""
function loadstyletable(hStyleTable::OGRStyleTableH,pszFilename::AbstractString)
    ccall((:OGR_STBL_LoadStyleTable,libgdal),Cint,(OGRStyleTableH,Ptr{UInt8}),hStyleTable,pszFilename)
end


"""
    OGR_STBL_Find(OGRStyleTableH hStyleTable,
                  const char * pszName) -> const char *

Get a style string by name.

### Parameters
* **hStyleTable**: handle to the style table.
* **pszName**: the name of the style string to find.

### Returns
the style string matching the name or NULL if not found or error.
"""
function find(hStyleTable::OGRStyleTableH,pszName::AbstractString)
    bytestring(ccall((:OGR_STBL_Find,libgdal),Ptr{UInt8},(OGRStyleTableH,Ptr{UInt8}),hStyleTable,pszName))
end


"""
    OGR_STBL_ResetStyleStringReading(OGRStyleTableH hStyleTable) -> void

Reset the next style pointer to 0.

### Parameters
* **hStyleTable**: handle to the style table.
"""
function resetstylestringreading(hStyleTable::OGRStyleTableH)
    ccall((:OGR_STBL_ResetStyleStringReading,libgdal),Void,(OGRStyleTableH,),hStyleTable)
end


"""
    OGR_STBL_GetNextStyle(OGRStyleTableH hStyleTable) -> const char *

Get the next style string from the table.

### Parameters
* **hStyleTable**: handle to the style table.

### Returns
the next style string or NULL on error.
"""
function getnextstyle(hStyleTable::OGRStyleTableH)
    bytestring(ccall((:OGR_STBL_GetNextStyle,libgdal),Ptr{UInt8},(OGRStyleTableH,),hStyleTable))
end


"""
    OGR_STBL_GetLastStyleName(OGRStyleTableH hStyleTable) -> const char *

Get the style name of the last style string fetched with OGR_STBL_GetNextStyle.

### Parameters
* **hStyleTable**: handle to the style table.

### Returns
the Name of the last style string or NULL on error.
"""
function getlaststylename(hStyleTable::OGRStyleTableH)
    bytestring(ccall((:OGR_STBL_GetLastStyleName,libgdal),Ptr{UInt8},(OGRStyleTableH,),hStyleTable))
end
