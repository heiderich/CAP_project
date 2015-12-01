#############################################################################
##
##                                               CAP package
##
##  Copyright 2015, Sebastian Gutsche, TU Kaiserslautern
##                  Sebastian Posur,   RWTH Aachen
##
#! @Chapter Serre Quotients
##
#############################################################################

#! Serre quotiens are implemented using generalized morphisms. A Serre quotient category
#! is the quotient of an abelian category A by a thick subcategory C. The objects of the quotient
#! are the objects from A, the morphisms are a limit construction. In the implementation
#! those morphisms are modeled by generalized morphisms, and therefore there are,
#! like in the generalized morphism case, three types of Serre quotients.

#! @Section General operations

#! As in the generalized morphism case, the generic constructors depend on the
#! generalized morphism standard. Please note that for implementations the specialized
#! constructors should be used.

#! @Description
#!  The category of objects in the category of Serre quotients.
#!  For actual objects this needs to be specialized.
DeclareCategory( "IsSerreQuotientCategoryObject",
                 IsCapCategoryObject );

#! @Description
#!  The category of morphisms in the category of Serre quotients.
#!  For actual morphisms this needs to be specialized.
DeclareCategory( "IsSerreQuotientCategoryMorphism",
                 IsCapCategoryMorphism );

#! @BeginGroup
#! @Description
#!  Creates a Serre quotient category <A>S</A> with name <A>name</A> out of an Abelian category <A>A</A>.
#!  If <A>name</A> is not given, a generic name is constructed out of the name of <A>A</A>.
#!  The argument <A>func</A> must be a unary function on the objects of <A>A</A> deciding the membership in
#!  the thick subcategory C mentioned above.
#! @Arguments A,func[,name]
#! @Returns a CAP category
DeclareOperation( "SerreQuotientCategory",
                  [ IsCapCategory, IsFunction, IsString ] );

DeclareOperation( "SerreQuotientCategory",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "\/",
                  [ IsCapCategory, IsFunction ] );
#! @EndGroup

#! @Description
#!  Given a Serre quotient category <A>A/C</A> and an object <A>M</A> in <A>A</A>,
#!  this constructor returns the corresponding object in the Serre quotient category.
#! @Arguments A/C, M
#! @Returns an object
DeclareOperation( "AsSerreQuotientCategoryObject",
                  [ IsCapCategory, IsCapCategoryObject ] );

#! @Description
#!  Given a Serre quotient category <A>A/C</A> and a generalized morphism <A>phi</A> in
#!  the generalized morphism category <A>A/C</A> is modeled upon,
#!  this constructor returns the corresponding morphism in the Serre quotient category.
#! @Arguments A/C, phi
#! @Returns a morphism
DeclareOperation( "SerreQuotientCategoryMorphism",
                  [ IsCapCategory, IsGeneralizedMorphism ] );

DeclareOperation( "SerreQuotientCategoryMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SerreQuotientCategoryMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SerreQuotientCategoryMorphismWithSourceAid",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SerreQuotientCategoryMorphismWithRangeAid",
                  [ IsCapCategory, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#!  Given a Serre quotient category <A>A/C</A> and an object <A>M</A> in <A>A</A>,
#!  this constructor returns the corresponding object in the Serre quotient category.
#! @Arguments A/C, M
#! @Returns an object
DeclareOperation( "AsSerreQuotientCategoryMorphism",
                  [ IsCapCategory, IsCapCategoryMorphism ] );

#! @Description
#!  When a Serre quotient category is created, a membership function for
#!  the subcategory is given. This attribute stores and returns this function
#! @Arguments C
#! @Returns a function
DeclareAttribute( "SubcategoryMembershipTestFunctionForSerreQuotient",
                  IsCapCategory );

#! @Description
#!  For a Serre quotient category <A>A/C</A> this attribute returns the category <A>A</A>.
#! @Arguments A/C
#! @Returns a category
DeclareAttribute( "UnderlyingHonestCategory",
                  IsCapCategory );

#! @Description
#!  For a Serre quotient category <A>A/C</A> this attribute returns generalized morphism category the quotient is modelled upon.
#! @Arguments A/C
#! @Returns a category
DeclareAttribute( "UnderlyingGeneralizedMorphismCategory",
                  IsCapCategory );

#! @Description
#!  For an object <A>M</A> in the Serre quotient category A/C this attribute returns the
#!  corresponding object in the generalized morphism category the quotient is modelled upon.
#! @Arguments M
#! @Returns an object
DeclareAttribute( "UnderlyingGeneralizedObject",
                  IsSerreQuotientCategoryObject );

#! @Description
#!  For an object <A>M</A> in the Serre quotient category A/C this attribute returns the
#!  corresponding object in <A>A</A>.
#! @Arguments M
#! @Returns an object
DeclareAttribute( "UnderlyingHonestObject",
                  IsSerreQuotientCategoryObject );

#! @Description
#!  For a morphism <A>phi</A> in the Serre quotient category A/C this attribute returns the
#!  corresponding generalized morphism in the generalized morphism category the quotient is modelled upon.
#! @Arguments phi
#! @Returns a morphism
DeclareAttribute( "UnderlyingGeneralizedMorphism",
                  IsSerreQuotientCategoryMorphism );

#! @Description
#!  Given a Serre quotient category <A>A/C</A>, this operation returns the canonical projection functor
#!  $ A \rightarrow A/C $.
#! @Arguments A/C
#! @Returns a functor
DeclareAttribute( "CanonicalProjection",
                  IsCapCategory );