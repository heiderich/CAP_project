#############################################################################
##
##                                               CAP package
##
##  Copyright 2014, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#############################################################################

DeclareRepresentation( "IsSerreQuotientCategoryByCospansObjectRep",
                       IsCapCategoryObjectRep and IsSerreQuotientCategoryByCospansObject,
                       [ ] );

BindGlobal( "TheTypeOfSerreQuotientCategoryByCospansObject",
        NewType( TheFamilyOfCapCategoryObjects,
                IsSerreQuotientCategoryByCospansObjectRep ) );

DeclareRepresentation( "IsSerreQuotientCategoryByCospansMorphismRep",
                       IsCapCategoryMorphismRep and IsSerreQuotientCategoryByCospansMorphism,
                       [ ] );

BindGlobal( "TheTypeOfSerreQuotientCategoryByCospansMorphism",
        NewType( TheFamilyOfCapCategoryMorphisms,
                 IsSerreQuotientCategoryByCospansMorphismRep ) );

#############################################
##
## Installation method
##
#############################################

BindGlobal( "CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SERRE_QUOTIENT_BY_COSPANS",
  
  function( category )
    local membership_function;
    
    membership_function := SubcategoryMembershipTestFunctionForSerreQuotient( category );
    
    ## Equalities
    
    AddIsCongruentForMorphisms( category,
      
      function( morphism1, morphism2 )
        local underlying_general, new_morphism_aid, new_general, sum_general,
              sum_associated, sum_image;
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism2 );
        
        new_morphism_aid := AdditiveInverse( Arrow( underlying_general ) );
        
        new_general := GeneralizedMorphismByCospan( SourceAid( underlying_general ), new_morphism_aid, RangeAid( underlying_general ) );
        
        sum_general := AdditionForMorphisms( UnderlyingGeneralizedMorphism( morphism1 ), new_general );
        
        sum_associated := AssociatedMorphism( sum_general );
        
        sum_image := ImageObject( sum_associated );
        
        return membership_function( sum_image );
        
    end );
    
    AddIsEqualForObjects( category,
      
      function( obj1, obj2 )
        
        return IsEqualForObjects( UnderlyingHonestObject( obj1 ), UnderlyingHonestObject( obj2 ) );
        
    end );
    
    ## Is Zero
    
    AddIsZeroForObjects( category,
      
      function( obj )
        
        return membership_function( UnderlyingHonestObject( obj ) );
        
    end );
    
    ## PreCompose
    
    AddPreCompose( category,
      
      function( morphism1, morphism2 )
        local composition;
        
        composition := PreCompose( UnderlyingGeneralizedMorphism( morphism1 ),
                                   UnderlyingGeneralizedMorphism( morphism2 ) );
        
        return SerreQuotientCategoryByCospansMorphism( category, composition );
        
    end );
    
    ## IdentityMorphism
    
    AddIdentityMorphism( category,
      
      function( object )
        
        return AsSerreQuotientCategoryByCospansMorphism( category, IdentityMorphism( UnderlyingHonestObject( object ) ) );
        
    end );
    
    ## Addition for morphisms
    
    AddAdditionForMorphisms( category,
      
      function( morphism1, morphism2 )
        local sum;
        
        sum := AdditionForMorphisms( UnderlyingGeneralizedMorphism( morphism1 ),
                                     UnderlyingGeneralizedMorphism( morphism2 ) );
        
        return SerreQuotientCategoryByCospansMorphism( category, sum );
        
    end );
    
    ## IsZeroForMorphisms
    ## Can be derived, but there might be a faster solution
#     AddIsZeroForMorphisms( category,
#       
#       function( morphism )
#         local associated, image;
#         
#         associated := AssociatedMorphism( UnderlyingGeneralizedMorphism( morphism ) );
#         
#         image := ImageObject( associated );
#         
#         return membership_function( image );
#         
#     end );
    
    ## Additive inverse for morphisms (works without normalization)
    
    AddAdditiveInverseForMorphisms( category,
      
      function( morphism )
        local new_general;
        
        new_general := AdditiveInverseForMorphisms( UnderlyingGeneralizedMorphism( morphism ) );
        
        return SerreQuotientCategoryByCospansMorphism( category, new_general );
        
    end );
    
    ## Zero morphism
    
    AddZeroMorphism( category,
      
      function( source, range )
        local new_general;
        
        new_general := ZeroMorphism( UnderlyingGeneralizedObject( source ), UnderlyingGeneralizedObject( range ) );
        
        return SerreQuotientCategoryByCospansMorphism( category, new_general );
        
    end );
    
    ## Zero object
    
    AddZeroObject( category,
      
      function( )
        local generalized_zero;
        
        generalized_zero := ZeroObject( UnderlyingHonestCategory( category ) );
        
        return AsSerreQuotientByThreeArrowsObject( category, UnderlyingHonestObject( generalized_zero ) );
        
    end );
    
    ## direct sum
    
    AddDirectSum( category,
      
      function( obj_list )
        local honest_list, honest_sum;
        
        honest_list := List( obj_list, UnderlyingHonestObject );
        
        honest_sum := CallFuncList( DirectSum, honest_list );
        
        return AsSerreQuotientByCospansObject( category, honest_sum );
        
    end );
    
    AddProjectionInFactorOfDirectSumWithGivenDirectSum( category,
      
      function( product_object, component_number, direct_sum_object )
        local underlying_objects, underlying_direct_sum, honest_projection;
        
        underlying_objects := List( product_object, UnderlyingHonestObject );
        
        underlying_direct_sum := UnderlyingHonestObject( direct_sum_object );
        
        honest_projection := ProjectionInFactorOfDirectSumWithGivenDirectSum( underlying_objects, component_number, underlying_direct_sum );
        
        return AsSerreQuotientCategoryByCospansMorphism( category, honest_projection );
        
    end );
    
    AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( category,
      
      function( object_product_list, injection_number, direct_sum_object )
        local underlying_objects, underlying_direct_sum, honest_injection;
        
        underlying_objects := List( object_product_list, UnderlyingHonestObject );
        
        underlying_direct_sum := UnderlyingHonestObject( direct_sum_object );
        
        honest_injection := AddInjectionOfCofactorOfDirectSumWithGivenDirectSum( underlying_objects, injection_number, underlying_direct_sum );
        
        return AsSerreQuotientCategoryByCospansMorphism( category, honest_injection );
        
    end );
    
    AddUniversalMorphismIntoDirectSum( category,
      
      function( diagram, morphism_list )
        local generalized_list, arrow_list, reversedarrow_list, new_arrow, new_reversed_arrow, object_list;
        
        generalized_list := List( morphism_list, UnderlyingGeneralizedMorphism );
        
        arrow_list := List( generalized_list, Arrow );
        
        reversedarrow_list := List( generalized_list, ReversedArrow );
        
        object_list := List( diagram, UnderlyingHonestObject );
        
        new_arrow := UniversalMorphismIntoDirectSum( object_list, arrow_list );
        
        new_reversed_arrow := DirectSumFunctorial( reversedarrow_list );
        
        return SerreQuotientCategoryByCospansMorphism( category, new_arrow, new_reversed_arrow );
        
    end );
    
    ## Needs work
    AddUniversalMorphismFromDirectSum( category,
      
      function( diagram, morphism_list )
        local generalized_list, arrow_list, reversedarrow_list, new_arrow, new_reversed_arrow, object_list;
        
        generalized_list := List( morphism_list, UnderlyingGeneralizedMorphism );
        
        arrow_list := List( generalized_list, Arrow );
        
        reversedarrow_list := List( generalized_list, ReversedArrow );
        
        object_list := List( diagram, UnderlyingHonestObject );
        
        new_arrow := DirectSumFunctorial( arrow_list );
        
        new_reversed_arrow := UniversalMorphismFromDirectSum( object_list, reversedarrow_list );
        
        return SerreQuotientCategoryByCospansMorphism( category, new_arrow, new_reversed_arrow );
        
    end );
    
    ## Kernel
    
    AddKernelEmbedding( category,
      
      function( morphism )
        local underlying_general, kernel_mor;
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism );
        
        kernel_mor := KernelEmbedding( Arrow( underlying_general ) );
        
        return AsSerreQuotientCategoryByCospansMorphism( category, kernel_mor );
        
    end );
    
    AddLiftAlongMonomorphism( category,
      
      function( monomorphism, test_morphism )
        local inverse_of_mono, composition;
        
        inverse_of_mono := PseudoInverse( UnderlyingGeneralizedMorphism( monomorphism ) );
        
        composition := PreCompose( UnderlyingGeneralizedMorphism( test_morphism ), inverse_of_mono );
        
        return SerreQuotientCategoryByCospansMorphism( category, composition );
        
    end );
    
    ## Cokernel
    
    AddCokernelProjection( category,
      
      function( morphism )
        local underlying_general, cokernel_mor, inverse_of_reversed;
        
        underlying_general := UnderlyingGeneralizedMorphism( morphism );
        
        cokernel_mor := CokernelProjection( Arrow( underlying_general ) );
        
        inverse_of_reversed := GeneralizedInverseByCospan( ReversedArrow( underlying_general ) );
        
        cokernel_mor := GeneralizedMorphismByCospan( cokernel_mor );
        
        return AsSerreQuotientCategoryByCospansMorphism( category, PreCompose( inverse_of_reversed, cokernel_mor ) );
        
    end );
    
    AddColiftAlongEpimorphism( category,
      
      function( epimorphism, test_morphism )
        local inverse_of_epi, composition;
        
        inverse_of_epi := PseudoInverse( UnderlyingGeneralizedMorphism( epimorphism ) );
        
        composition := PreCompose( inverse_of_epi, UnderlyingGeneralizedMorphism( test_morphism ) );
        
        return SerreQuotientCategoryByCospansMorphism( category, composition );
        
    end );
    
end );

#############################################
##
## Constructor
##
#############################################

InstallMethod( SerreQuotientCategoryByCospans,
               [ IsCapCategory, IsFunction ],
               
  function( category, test_function )
    local name;
    
    name := NameFunction( test_function );
    
    return SerreQuotientCategoryByCospans( category, test_function, Concatenation( "test function with name: ", name ) );
    
end );

InstallMethodWithCacheFromObject( SerreQuotientCategoryByCospans,
                                  [ IsCapCategory, IsFunction, IsString ],
                                  
  function( category, test_function, function_name )
    local serre_category, gen_category, name, preconditions, category_weight_list, i;
    
    if not HasIsFinalized( category ) or not IsFinalized( category ) then
        
        Error( "category must be finalized" );
        return;
        
    fi;
    
    preconditions := [ "IsEqualForObjects",
                       "ImageObject",
                       "AdditiveInverseForMorphisms",
                       "IdentityMorphism",
                       "ZeroMorphism",
                       "DirectSum",
                       "ProjectionInFactorOfDirectSumWithGivenDirectSum",
                       "InjectionOfCofactorOfDirectSumWithGivenDirectSum",
                       "UniversalMorphismFromDirectSum",
                       "UniversalMorphismIntoDirectSum",
                       "DirectSumFunctorial",
                       "KernelEmbedding",
                       "CokernelProjection" ];
    
    category_weight_list := category!.derivations_weight_list;
    
    for i in preconditions do
        
        if CurrentOperationWeight( category_weight_list, i ) = infinity then
            
            Error( Concatenation( "category must be able to compute ", i ) );
            return;
            
        fi;
        
    od;
    
    name := Name( category );
    
    name := Concatenation( "The Serre quotient category of ", name, " by ", function_name );
    
    serre_category := CreateCapCategory( name );
    
    SetFilterObj( serre_category, WasCreatedAsSerreQuotientCategoryByCospans );
    
    SetUnderlyingHonestCategory( serre_category, category );
    
    SetUnderlyingGeneralizedMorphismCategory( serre_category, GeneralizedMorphismCategoryByCospans( category ) );
    
    SetSubcategoryMembershipTestFunctionForSerreQuotient( serre_category, test_function );
    
    SetIsAbelianCategory( serre_category, true );
    
    CAP_INTERNAL_INSTALL_OPERATIONS_FOR_SERRE_QUOTIENT_BY_COSPANS( serre_category );
    
    Finalize( serre_category );
    
    return serre_category;
    
end );

InstallMethodWithCacheFromObject( AsSerreQuotientByCospansObject,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsCapCategoryObject ],
                                  
  function( serre_category, object )
    local honest_category, serre_object;
    
    honest_category := UnderlyingHonestCategory( serre_category );
    
    if not IsIdenticalObj( honest_category, CapCategory( object ) ) then
        
        Error( "object does not belong to underlying honest category of serre quotient" );
        
    fi;
    
    serre_object := rec( );
    
    ObjectifyWithAttributes( serre_object, TheTypeOfSerreQuotientCategoryByCospansObject );
    
    SetUnderlyingHonestObject( serre_object, object );
    
    SetUnderlyingGeneralizedObject( serre_object, GeneralizedMorphismByCospansObject( object ) );
    
    AddToToDoList( ToDoListEntryForEqualAttributes( serre_object, "IsWellDefined", object, "IsWellDefined" ) );
    
    AddObject( serre_category, serre_object );
    
    return serre_object;
    
end );

InstallMethodWithCacheFromObject( SerreQuotientCategoryByCospansMorphism,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsGeneralizedMorphismByCospan ],
                                  
  function( serre_category, gen_morphism )
    local honest_category, serre_morphism;
    
    if not IsIdenticalObj( UnderlyingGeneralizedMorphismCategory( serre_category ), CapCategory( gen_morphism ) ) then
        
        Error( "generalized morphism has wrong category" );
        
    fi;
    
    serre_morphism := rec( );
    
    ObjectifyWithAttributes( serre_morphism, TheTypeOfSerreQuotientCategoryByCospansMorphism,
                             Source, AsSerreQuotientByCospansObject( serre_category, UnderlyingHonestObject( Source( gen_morphism ) ) ),
                             Range, AsSerreQuotientByCospansObject( serre_category, UnderlyingHonestObject( Range( gen_morphism ) ) ) );
    
    SetUnderlyingGeneralizedMorphism( serre_morphism, gen_morphism );
    
    AddMorphism( serre_category, serre_morphism );
    
    return serre_morphism;
    
end );

InstallMethod( SerreQuotientCategoryByCospansMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( serre_category, source_aid, associated, range_aid )
    
    return SerreQuotientCategoryByCospansMorphism( serre_category, GeneralizedMorphismByCospan( source_aid, associated, range_aid ) );
    
end );

InstallMethod( SerreQuotientCategoryByCospansMorphismWithSourceAid,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( serre_category, source_aid, associated )
    
    return SerreQuotientCategoryByCospansMorphism( serre_category, GeneralizedMorphismByCospanWithSourceAid( source_aid, associated ) );
    
end );

InstallMethod( SerreQuotientCategoryByCospansMorphism,
               [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsCapCategoryMorphism, IsCapCategoryMorphism ],
                                  
  function( serre_category, reversed_arrow, arrow )
    
    return SerreQuotientCategoryByCospansMorphism( serre_category, GeneralizedMorphismByCospan( reversed_arrow, arrow ) );
    
end );

InstallMethodWithCacheFromObject( AsSerreQuotientCategoryByCospansMorphism,
                                  [ IsCapCategory and WasCreatedAsSerreQuotientCategoryByCospans, IsCapCategoryMorphism ],
                                  
  function( serre_category, associated )
    
    return SerreQuotientCategoryByCospansMorphism( serre_category, AsGeneralizedMorphismByCospan( associated ) );
    
end );
