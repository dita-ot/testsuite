<!--
 | (C) Copyright IBM Corporation 2005 - 2006. All Rights Reserved.
 *-->

<!-- ============ Hooks for domain extension ============ -->
<!ENTITY % java2Field              "java2Field">
<!ENTITY % java2FieldDetail        "java2FieldDetail">
<!ENTITY % java2FieldDef           "java2FieldDef">
<!ENTITY % java2FinalField         "java2FinalField">
<!ENTITY % java2StaticField        "java2StaticField">
<!ENTITY % java2TransientField     "java2TransientField">
<!ENTITY % java2VolatileField      "java2VolatileField">
<!ENTITY % java2FieldAccess        "java2FieldAccess">
<!ENTITY % java2FieldClass         "java2FieldClass">
<!ENTITY % java2FieldInterface     "java2FieldInterface">
<!ENTITY % java2FieldPrimitive     "java2FieldPrimitive">
<!ENTITY % java2FieldArray         "java2FieldArray">


<!-- ============ Hooks for shell DTD ============ -->
<!ENTITY % java2Field-types-default  "no-topic-nesting">
<!ENTITY % java2Field-info-types     "%java2Field-types-default;">

<!ENTITY included-domains "">


<!-- ============ Topic specializations ============ -->
<!ELEMENT java2Field       ( (%apiName;), (%shortdesc;), (%prolog;)?, (%java2FieldDetail;), (%related-links;)?, ( %java2Field-info-types;)* )>
<!ATTLIST java2Field    id ID #REQUIRED
                          conref CDATA #IMPLIED
                          outputclass CDATA #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          %arch-atts;
                          domains CDATA "&included-domains;"
>

<!ELEMENT java2FieldDetail  ((%java2FieldDef;), (%apiDesc;)?, (%example;|%section;|%apiImpl;)*)>
<!ATTLIST java2FieldDetail  %id-atts;
                          translate (yes|no) #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          outputclass CDATA #IMPLIED>

<!ELEMENT java2FieldDef   ( (%java2FinalField;)?, (%java2StaticField;)?, (%java2TransientField;)?, (%java2VolatileField;)?, (%java2FieldAccess;)?, (%java2FieldClass; | %java2FieldInterface; | %java2FieldPrimitive; ), (%java2FieldArray;)*, (%apiData;)? ) >
<!ATTLIST java2FieldDef    spectitle CDATA #IMPLIED
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2FinalField  EMPTY>
<!ATTLIST java2FinalField  name CDATA #FIXED "final"
                          value CDATA #FIXED "final"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>
<!ELEMENT java2StaticField  EMPTY>
<!ATTLIST java2StaticField  name CDATA #FIXED "static"
                          value CDATA #FIXED "static"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>
<!ELEMENT java2TransientField  EMPTY>
<!ATTLIST java2TransientField  name CDATA #FIXED "transient"
                          value CDATA #FIXED "transient"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>
<!ELEMENT java2VolatileField  EMPTY>
<!ATTLIST java2VolatileField  name CDATA #FIXED "volatile"
                          value CDATA #FIXED "volatile"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>
<!ELEMENT java2FieldAccess  EMPTY>
<!ATTLIST java2FieldAccess  name CDATA #FIXED "access"
                          value (public | protected | private) #REQUIRED
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2FieldClass  (#PCDATA)*>
<!ATTLIST java2FieldClass  href CDATA #IMPLIED
                          keyref CDATA #IMPLIED
                          type   CDATA  #IMPLIED
                          %univ-atts;
                          format        CDATA   #IMPLIED
                          scope (local | peer | external) #IMPLIED
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2FieldInterface  (#PCDATA)*>
<!ATTLIST java2FieldInterface  href CDATA #IMPLIED
                          keyref CDATA #IMPLIED
                          type   CDATA  #IMPLIED
                          %univ-atts;
                          format        CDATA   #IMPLIED
                          scope (local | peer | external) #IMPLIED
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2FieldPrimitive  EMPTY>
<!ATTLIST java2FieldPrimitive  name CDATA #FIXED "type"
                          value ( boolean | byte | char | double | float | int | long | short ) #REQUIRED
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2FieldArray  EMPTY>
<!ATTLIST java2FieldArray  name CDATA "arraysize"
                          value CDATA ""
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>


<!-- ============ Class attributes for type ancestry ============ -->
<!ATTLIST java2Field   %global-atts;
    class  CDATA "- topic/topic reference/reference apiRef/apiRef apiValue/apiValue javaField/javaField java2Field/javaField">
<!ATTLIST java2FieldDetail   %global-atts;
    class  CDATA "- topic/body reference/refbody apiRef/apiDetail apiValue/apiValueDetail javaField/javaFieldDetail java2Field/java2FieldDetail">
<!ATTLIST java2FieldDef   %global-atts;
    class  CDATA "- topic/section reference/section apiRef/apiDef apiValue/apiValueDef javaField/javaFieldDef java2Field/java2FieldDef">
<!ATTLIST java2FinalField   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiValue/apiQualifier javaField/javaFinalField java2Field/java2FinalField">
<!ATTLIST java2StaticField   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiValue/apiQualifier javaField/javaStaticField java2Field/java2StaticField">
<!ATTLIST java2TransientField   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiValue/apiQualifier javaField/javaTransientField java2Field/java2TransientField ">
<!ATTLIST java2VolatileField   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiValue/apiQualifier javaField/javaVolatileField java2Field/java2VolatileField">
<!ATTLIST java2FieldAccess   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiValue/apiQualifier javaField/javaFieldAccess java2Field/java2FieldAccess">
<!ATTLIST java2FieldClass   %global-atts;
    class  CDATA "- topic/xref reference/xref apiRef/apiRelation apiValue/apiValueClassifier javaField/javaFieldClass java2Field/java2FieldClass">
<!ATTLIST java2FieldInterface   %global-atts;
    class  CDATA "- topic/xref reference/xref apiRef/apiRelation apiValue/apiValueClassifier javaField/javaFieldInterface java2Field/java2FieldInterface">
<!ATTLIST java2FieldPrimitive   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiType apiValue/apiType javaField/javaFieldPrimitive  java2Field/java2FieldPrimitive">
<!ATTLIST java2FieldArray   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiArray javaField/javaFieldArray java2Field/java2FieldArray">
