############################################################################
##
##                                ActionsForCAP package
##
##  Copyright 2016, Sebastian Gutsche, University of Siegen
##                  Sebastian Posur,   University of Siegen
##
##
#############################################################################

####################################
##
## GAP Category
##
####################################

DeclareRepresentation( "IsSemisimpleCategoryObjectRep",
                       IsSemisimpleCategoryObject and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfSemisimpleCategoryObjects",
        NewFamily( "TheFamilyOfSemisimpleCategoryObjects" ) );

BindGlobal( "TheTypeOfSemisimpleCategoryObjects",
        NewType( TheFamilyOfSemisimpleCategoryObjects,
                IsSemisimpleCategoryObjectRep ) );

####################################
##
## Constructors
##
####################################

##
InstallMethod( SemisimpleCategoryObject,
               [ IsList, IsCapCategory ],
               
  function( semisimple_object_list, category )
    local semisimple_category_object, normalized_semisimple_object_list;
    
    semisimple_category_object := rec( );
    
    normalized_semisimple_object_list := NormalizeSemisimpleCategoryObjectList( semisimple_object_list, category );
    
    ObjectifyWithAttributes( semisimple_category_object, TheTypeOfSemisimpleCategoryObjects,
                             SemisimpleCategoryObjectList, normalized_semisimple_object_list
    );

    Add( category, semisimple_category_object );
    
    return semisimple_category_object;
    
end );

##
InstallMethod( NormalizeSemisimpleCategoryObjectList,
               [ IsList, IsCapCategory ],
               
  function( semisimple_object_list, category )
    local sort_function, result_list, multiplicity, j, irreducible_object, size, i;
    
    semisimple_object_list := Filtered( semisimple_object_list, entry -> entry[1] > 0 );
    
    sort_function := function( a, b ) return a[2] <= b[2]; end;
    
    Sort( semisimple_object_list, sort_function );
    
    size := Size( semisimple_object_list );
    
    result_list := [ ];
    
    i := 1;
    
    while ( i <= size ) do
        
        irreducible_object := semisimple_object_list[i][2];
        
        multiplicity := semisimple_object_list[i][1];
        
        j := i + 1;
        
        while ( j <= size ) and ( semisimple_object_list[j][2] = irreducible_object ) do
            
            multiplicity := multiplicity + semisimple_object_list[j][1];
            
            j := j + 1;
            
        od;
        
        Add( result_list, [ multiplicity, irreducible_object ] );
        
        i := j;
        
    od;
    
    return result_list;
    
end );

####################################
##
## Attributes
##
####################################

##
InstallMethod( Support,
               [ IsSemisimpleCategoryObject ],
               
  function( object )
    
    return List( SemisimpleCategoryObjectList( object ), elem -> elem[2] );
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( Display,
               [ IsSemisimpleCategoryObject ],
               
  function( object )
    local object_list, string, i, size;
    
    object_list := SemisimpleCategoryObjectList( object );
    
    size := Size( object_list );
    
    if size = 0 then
        
        Print( "0\n" );
        
        return;
        
    fi;
    
    string := Concatenation( String( object_list[1][1] ), "*(χ_", String( object_list[1][2] ), ")" );
    
    for i in [ 2 .. size ] do
        
        Append( string, Concatenation( " + ", String( object_list[i][1] ), "*(χ_", String( object_list[i][2] ), ")" ) );
        
    od;
    
    Print( Concatenation( string, "\n" ) );
    
end );