#
# M2: Intrinsic modules with relations and generators for the CAP based homalg
#
# Implementations

InstallGlobalFunction( INSTALL_TODO_LISTS_FOR_HOMALG_MORPHISMS,
  function( input, output )
    local conds;
    
    input := Flat( input );
    
    input := Filtered( input, IsCapCategoryMorphism );
    
    if input = [ ] then
        SetIsMorphism( output, true );
    fi;
    
    conds := List( input, a -> [ a, "IsMorphism", true ] );
    
    AddToToDoList( ToDoListEntry( conds,
            [ [ "if IsMorphism = true for all morphisms in input then SetIsMorphism( output, true )",
                [ output, "IsMorphism", true ],
                ],
             ]
            ) );
    
    AddToToDoList( ToDoListEntry( [ [ output, "CokernelProjection" ] ],
            [ [ "in the category of finite presentations the CokernelProjection( phi ) is always well-defined regardless of the consistency of phi",
                function( )
                  SetIsMorphism( CokernelProjection( output ), true );
                end
                  ] ]
                  ) );
    
end );

##
InstallMethod( CategoryOfHomalgLeftModules,
        "for a homalg ring",
        [ IsHomalgRing ],

  function( R )
    local A, SM, etaSM, LG, etaLG, Id, type_obj, type_mor, type_end, IdSM, IdLG;
    
    A := LeftPresentations( R : FinalizeCategory := false );
    
    AddImageEmbedding( A, ImageEmbeddingForLeftModules );
    
    Finalize( A );
    
    SM := FunctorStandardModuleLeft( R );
    
    etaSM := NaturalIsomorphismFromIdentityToStandardModuleLeft( R );
    
    LG := FunctorLessGeneratorsLeft( R );
    
    etaLG := NaturalIsomorphismFromIdentityToLessGeneratorsLeft( R );
    
    ## CategoryWithAmbientObject
    
    A := CategoryWithAmbientObject( A );
    
    Id := IdentityFunctor( A );
    
    SM := WithAmbientObject( SM, A );
    
    etaSM := WithAmbientObject( etaSM, Id, SM );
    
    LG := WithAmbientObject( LG, A );
    
    etaLG := WithAmbientObject( etaLG, Id, LG );
    
    type_obj :=
      NewType( TheFamilyOfIntrinsicObjects,
              IsCapCategoryIntrinsicObjectRep and
              IsFinitelyPresentedModuleRep and
              IsHomalgLeftObjectOrMorphismOfLeftObjects
              );
    
    type_mor :=
      NewType( TheFamilyOfIntrinsicMorphisms,
              IsCapCategoryIntrinsicMorphismRep and
              IsMapOfFinitelyGeneratedModulesRep and
              IsHomalgLeftObjectOrMorphismOfLeftObjects
              );
    
    type_end :=
      NewType( TheFamilyOfIntrinsicMorphisms,
              IsCapCategoryIntrinsicMorphismRep and
              IsHomalgSelfMap and
              IsMapOfFinitelyGeneratedModulesRep and
              IsHomalgLeftObjectOrMorphismOfLeftObjects
              );
    
    ## IntrinsicCategory
    
    A := IntrinsicCategory( A, type_obj, type_mor, type_end, INSTALL_TODO_LISTS_FOR_HOMALG_MORPHISMS );
    
    ## TODO: legacy
    SetFilterObj( A, IsHomalgCategory );
    A!.containers := rec( );
    
    Id := IdentityFunctor( A );
    
    SM := Intrinsify( SM, A );
    
    etaSM := Intrinsify( etaSM, Id, SM );
    
    LG := Intrinsify( LG, A );
    
    etaLG := Intrinsify( etaLG, Id, LG );
    
    ## TurnAutoequivalenceIntoIdentityFunctor
    
    IdSM := TurnAutoequivalenceIntoIdentityFunctor( etaSM );
    
    A!.IdSM := IdSM;
    
    IdLG := TurnAutoequivalenceIntoIdentityFunctor( etaLG );
    
    A!.IdLG := IdLG;
    
    return A;
    
end );

##
InstallMethod( CategoryOfHomalgRightModules,
        "for homalg ring",
        [ IsHomalgRing ],

  function( R )
    local A, SM, etaSM, LG, etaLG, Id, type_obj, type_mor, type_end, IdSM, IdLG;
    
    A := RightPresentations( R : FinalizeCategory := false );
    
    AddImageEmbedding( A, ImageEmbeddingForRightModules );
    
    Finalize( A );
    
    SM := FunctorStandardModuleRight( R );
    
    etaSM := NaturalIsomorphismFromIdentityToStandardModuleRight( R );
    
    LG := FunctorLessGeneratorsRight( R );
    
    etaLG := NaturalIsomorphismFromIdentityToLessGeneratorsRight( R );
    
    ## CategoryWithAmbientObject
    
    A := CategoryWithAmbientObject( A );
    
    Id := IdentityFunctor( A );
    
    SM := WithAmbientObject( SM, A );
    
    etaSM := WithAmbientObject( etaSM, Id, SM );
    
    LG := WithAmbientObject( LG, A );
    
    etaLG := WithAmbientObject( etaLG, Id, LG );
    
    type_obj :=
      NewType( TheFamilyOfIntrinsicObjects,
              IsCapCategoryIntrinsicObjectRep and
              IsFinitelyPresentedModuleRep and
              IsHomalgRightObjectOrMorphismOfRightObjects
              );
    
    type_mor :=
      NewType( TheFamilyOfIntrinsicMorphisms,
              IsCapCategoryIntrinsicMorphismRep and
              IsMapOfFinitelyGeneratedModulesRep and
              IsHomalgRightObjectOrMorphismOfRightObjects
              );
    
    type_end :=
      NewType( TheFamilyOfIntrinsicMorphisms,
              IsCapCategoryIntrinsicMorphismRep and
              IsHomalgSelfMap and
              IsMapOfFinitelyGeneratedModulesRep and
              IsHomalgRightObjectOrMorphismOfRightObjects
              );
    
    ## IntrinsicCategory
    
    A := IntrinsicCategory( A, type_obj, type_mor, type_end, INSTALL_TODO_LISTS_FOR_HOMALG_MORPHISMS );
    
    ## TODO: legacy
    SetFilterObj( A, IsHomalgCategory );
    A!.containers := rec( );
    
    Id := IdentityFunctor( A );
    
    SM := Intrinsify( SM, A );
    
    etaSM := Intrinsify( etaSM, Id, SM );
    
    LG := Intrinsify( LG, A );
    
    etaLG := Intrinsify( etaLG, Id, LG );
    
    ## TurnAutoequivalenceIntoIdentityFunctor
    
    IdSM := TurnAutoequivalenceIntoIdentityFunctor( etaSM );
    
    A!.IdSM := IdSM;
    
    IdLG := TurnAutoequivalenceIntoIdentityFunctor( etaLG );
    
    A!.IdLG := IdLG;
    
    return A;
    
end );
