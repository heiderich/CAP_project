#############################################################################
##
##                                               CategoriesForHomalg package
##
##  Copyright 2013, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @AutoDoc
#! @Chapter Category morphism
##
#############################################################################

###################################
##
#! @Section Categories
##
###################################

DeclareCategory( "IsHomalgCategoryMorphism",
                 IsHomalgCategoryCell );

###################################
##
#! @Section Functions for all objects
##
###################################

#! @Group Category getter
DeclareAttribute( "HomalgCategory",
                  IsHomalgCategoryMorphism );

DeclareAttribute( "Source",
                  IsHomalgCategoryMorphism );

DeclareAttribute( "Range",
                  IsHomalgCategoryMorphism );

# this attribute is also an implied operation
DeclareProperty( "CanComputeInverse",
                 IsHomalgCategoryMorphism );

DeclareAttribute( "Inverse",
                  IsHomalgCategoryMorphism );

###################################
##
#! @Section Technical stuff
##
###################################

DeclareGlobalFunction( "CATEGORIES_FOR_HOMALG_CREATE_MORPHISM_PRINT" );

DeclareGlobalFunction( "INSTALL_TODO_LIST_ENTRIES_FOR_MORPHISM" );

DeclareProperty( "CanComputeIdentityMorphism",
                 IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeZeroObject",
                 IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeMorphismFromZeroObject",
                 IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeMorphismIntoZeroObject",
                 IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeZeroMorphism",
                 IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeDirectSum",
                 IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeProjectionInFirstFactor",
                 IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeProjectionInSecondFactor",
                 IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeInjectionFromFirstSummand",
                 IsHomalgCategoryMorphism );

DeclareProperty( "CanComputeInjectionFromSecondSummand",
                 IsHomalgCategoryMorphism );

###################################
##
## Properties
##
###################################

DeclareProperty( "IsMonomorphism",
                 IsHomalgCategoryMorphism );

DeclareProperty( "IsEpimorphism",
                 IsHomalgCategoryMorphism );

DeclareProperty( "IsIsomorphism",
                 IsHomalgCategoryMorphism );

DeclareProperty( "IsEndomorphism",
                 IsHomalgCategoryMorphism );

DeclareProperty( "IsAutomorphism",
                 IsHomalgCategoryMorphism );

DeclareProperty( "IsSplitMonomorphism",
                 IsHomalgCategoryMorphism );

DeclareProperty( "IsSplitEpimorphism",
                 IsHomalgCategoryMorphism );

## TODO: IsIdentity
DeclareProperty( "IsOne",
                 IsHomalgCategoryMorphism );

DeclareProperty( "IsIdempotent",
                 IsHomalgCategoryMorphism );

###################################
##
#! @Section Morphism add functions
##
###################################

DeclareOperation( "Add",
                  [ IsHomalgCategory, IsHomalgCategoryMorphism ] );

###################################
##
#! @Section Morphism functions
##
###################################

DeclareProperty( "CanComputePreCompose",
                 IsHomalgCategoryMorphism );

DeclareOperation( "PreCompose",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

###################################
##
#! Monomorphism as kernel lift
##
###################################

DeclareProperty( "CanComputeMonoAsKernelLift",
                 IsHomalgCategoryMorphism );

DeclareOperation( "MonoAsKernelLift",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );

####################################
##
## Epismorphism as cokernel lift
##
####################################

DeclareProperty( "CanComputeEpiAsCokernelColift",
                 IsHomalgCategoryMorphism );

DeclareOperation( "EpiAsCokernelColift",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );


###################################
##
#! @Section Implied operations
##
###################################

DeclareProperty( "CanComputePostCompose",
                 IsHomalgCategoryMorphism );

DeclareOperation( "PostCompose",
                  [ IsHomalgCategoryMorphism, IsHomalgCategoryMorphism ] );
