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

DeclareRepresentation( "IsSemisimpleCategoryMorphismRep",
                       IsSemisimpleCategoryMorphism and IsAttributeStoringRep,
                       [ ] );

BindGlobal( "TheFamilyOfSemisimpleCategoryMorphisms",
        NewFamily( "TheFamilyOfSemisimpleCategoryMorphisms" ) );

BindGlobal( "TheTypeOfSemisimpleCategoryMorphisms",
        NewType( TheFamilyOfSemisimpleCategoryMorphisms,
                IsSemisimpleCategoryMorphismRep ) );

####################################
##
## Constructors
##
####################################

##
InstallMethod( SemisimpleCategoryMorphism,
               [ IsSemisimpleCategoryObject, IsList, IsSemisimpleCategoryObject ],
               
  function( source, morphism_list, range )
    local category, semisimple_category_morphism, sort_function, field;
    
    category := CapCategory( source );
    
    morphism_list := Filtered( morphism_list,
                       alpha -> NrRows( UnderlyingMatrix( alpha[1] ) ) <> 0 or NrColumns( UnderlyingMatrix( alpha[1] ) ) <> 0 );
    
    sort_function := function( a, b ) return a[2] <= b[2]; end;
    
    Sort( morphism_list, sort_function );
    
    field := UnderlyingFieldForHomalg( source );
    
    semisimple_category_morphism := rec( );
    
    ObjectifyWithAttributes( semisimple_category_morphism, TheTypeOfSemisimpleCategoryMorphisms,
                             Source, source,
                             Range, range,
                             SemisimpleCategoryMorphismList, morphism_list,
                             UnderlyingFieldForHomalg, field
    );

    Add( category, semisimple_category_morphism );
    
    return semisimple_category_morphism;
    
end );

##
InstallMethod( SemisimpleCategoryMorphismSparse,
               [ IsSemisimpleCategoryObject, IsList, IsSemisimpleCategoryObject ],
               
  function( source, morphism_list, range )
    local support, field, chi, pos, source_vector_space, range_vector_space;
    
    morphism_list := Filtered( morphism_list,
                       alpha -> NrRows( UnderlyingMatrix( alpha[1] ) ) <> 0 or NrColumns( UnderlyingMatrix( alpha[1] ) ) <> 0 );
    
    support := Set( Concatenation( Support( source ), Support( range ) ) );
    
    field := UnderlyingFieldForHomalg( source );
    
    for chi in support do
      
      pos := PositionProperty( morphism_list, entry -> chi = entry[2] );
      
      if pos = fail then
          
          source_vector_space := VectorSpaceObject( Multiplicity( source, chi ), field );
          
          range_vector_space := VectorSpaceObject( Multiplicity( range, chi ), field );
          
          Add( morphism_list, [ ZeroMorphism( source_vector_space, range_vector_space ), chi ] );
          
      fi;
      
    od;
    
    return SemisimpleCategoryMorphism( source, morphism_list, range );
    
end );


##
InstallMethod( ComponentInclusionMorphism,
               [ IsSemisimpleCategoryObject, IsObject ],
               
  function( object, chi )
    local category, support, l, summands;
    
    category := CapCategory( object );
    
    support := Support( object );
    
    l := PositionProperty( support, psi -> psi = chi );
    
    if l = fail then
        
        return UniversalMorphismFromZeroObject( object );
        
    fi;
    
    summands := List( support, psi -> SemisimpleCategoryObject( [ [ Multiplicity( object, psi ), psi ] ], category ) );
    
    return InjectionOfCofactorOfDirectSum( summands, l );
    
end );

##
InstallMethod( ComponentProjectionMorphism,
               [ IsSemisimpleCategoryObject, IsObject ],
               
  function( object, chi )
    local category, support, l, summands;
    
    category := CapCategory( object );
    
    support := Support( object );
    
    l := PositionProperty( support, psi -> psi = chi );
    
    if l = fail then
        
        return UniversalMorphismIntoZeroObject( object );
        
    fi;
    
    summands := List( support, psi -> SemisimpleCategoryObject( [ [ Multiplicity( object, psi ), psi ] ], category ) );
    
    return ProjectionInFactorOfDirectSum( summands, l );
    
end );



####################################
##
## Attributes
##
####################################

##
InstallMethod( Support,
               [ IsSemisimpleCategoryMorphism ],
               
  function( morphism )
    
    return List( SemisimpleCategoryMorphismList( morphism ), elem -> elem[2] );
    
end );

####################################
##
## Operations
##
####################################

##
InstallMethod( Component,
               [ IsSemisimpleCategoryMorphism, IsObject ],
               
  function( morphism, irr )
    local coeff;
    
    coeff := First( SemisimpleCategoryMorphismList( morphism ), elem -> elem[2] = irr );
    
    if coeff = fail then
        
        return IdentityMorphism( ZeroObject( UnderlyingCategoryForSemisimpleCategory( CapCategory( morphism ) ) ) );
        
    else
        
        return coeff[1];
        
    fi;
    
end );

####################################
##
## View
##
####################################

##
InstallMethod( Display,
               [ IsSemisimpleCategoryMorphism ],
               
  function( morphism )
    local morphism_list, elem;
    
    morphism_list := SemisimpleCategoryMorphismList( morphism );
    
    for elem in morphism_list do
        
        Print( Concatenation( "Component: (χ_", String( elem[2] ), ")\n" ) );
        
        Print( "\n" );
        
        Display( elem[1] );
        
        Print( "\n------------------------\n" );
        
    od;
    
end );

