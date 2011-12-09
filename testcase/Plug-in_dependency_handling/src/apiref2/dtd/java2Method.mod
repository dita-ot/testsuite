<!--
 | (C) Copyright IBM Corporation 2005 - 2006. All Rights Reserved.
 *-->

<!-- ============ Hooks for domain extension ============ -->
<!ENTITY % java2Method              "java2Method">
<!ENTITY % java2MethodDetail        "java2MethodDetail">
<!ENTITY % java2MethodDef           "java2MethodDef">
<!ENTITY % java2FinalMethod         "java2FinalMethod">
<!ENTITY % java2AbstractMethod      "java2AbstractMethod">
<!ENTITY % java2StaticMethod        "java2StaticMethod">
<!ENTITY % java2NativeMethod        "java2NativeMethod">
<!ENTITY % java2SynchronizedMethod  "java2SynchronizedMethod">
<!ENTITY % java2MethodAccess        "java2MethodAccess">
<!ENTITY % java2MethodClass         "java2MethodClass">
<!ENTITY % java2MethodInterface     "java2MethodInterface">
<!ENTITY % java2MethodPrimitive     "java2MethodPrimitive">
<!ENTITY % java2MethodArray         "java2MethodArray">
<!ENTITY % java2Return              "java2Return">
<!ENTITY % java2Void                "java2Void">
<!ENTITY % java2ConstructorDef      "java2ConstructorDef">
<!ENTITY % java2Param               "java2Param">
<!ENTITY % java2Exception           "java2Exception">


<!-- ============ Hooks for shell DTD ============ -->
<!ENTITY % java2Method-types-default  "no-topic-nesting">
<!ENTITY % java2Method-info-types     "%java2Method-types-default;">

<!ENTITY included-domains "">


<!-- ============ Topic specializations ============ -->
<!ELEMENT java2Method   ( (%apiName;), (%shortdesc;), (%prolog;)?, (%java2MethodDetail;), (%related-links;)?, (%java2Method-info-types;)* )>
<!ATTLIST java2Method      id ID #REQUIRED
                          conref CDATA #IMPLIED
                          outputclass CDATA #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          %arch-atts;
                          domains CDATA "&included-domains;"
>

<!ELEMENT java2MethodDetail  ((%java2MethodDef;|%java2ConstructorDef;), (%apiDesc;)?, (%example;|%section;|%apiImpl;)*)>
<!ATTLIST java2MethodDetail  %id-atts;
                          translate (yes|no) #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          outputclass CDATA #IMPLIED>

<!ELEMENT java2MethodDef   ((%java2FinalMethod;)?, (%java2AbstractMethod;)?, (%java2StaticMethod;)?, (%java2NativeMethod;)?, (%java2SynchronizedMethod;)?, (%java2MethodAccess;)?, (%java2Return;|%java2Void;), (%java2Param;)*, (%java2Exception;)*) >
<!ATTLIST java2MethodDef    spectitle CDATA #IMPLIED
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2ConstructorDef   ((%java2MethodAccess;)?, (%java2Param;)*, (%java2Exception;)*) >
<!ATTLIST java2ConstructorDef  spectitle CDATA #IMPLIED
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2Return     ((%java2MethodClass;|%java2MethodInterface;|%java2MethodPrimitive;), (%java2MethodArray;)*, (%apiDefNote;)?) >
<!ATTLIST java2Return      keyref CDATA #IMPLIED
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2Param      ((%java2MethodClass;|%java2MethodInterface;|%java2MethodPrimitive;),  (%java2MethodArray;)*, (%apiItemName;), (%apiDefNote;)?) >
<!ATTLIST java2Param       keyref CDATA #IMPLIED
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2Exception  ((%java2MethodClass;), (%apiDefNote;)?) >
<!ATTLIST java2Exception   keyref CDATA #IMPLIED
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2FinalMethod  EMPTY>
<!ATTLIST java2FinalMethod  name CDATA #FIXED "final"
                          value CDATA #FIXED "final"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>
<!ELEMENT java2AbstractMethod  EMPTY>
<!ATTLIST java2AbstractMethod  name CDATA #FIXED "abstract"
                          value CDATA #FIXED "abstract"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>
<!ELEMENT java2StaticMethod  EMPTY>
<!ATTLIST java2StaticMethod  name CDATA #FIXED "static"
                          value CDATA #FIXED "static"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>
<!ELEMENT java2NativeMethod  EMPTY>
<!ATTLIST java2NativeMethod  name CDATA #FIXED "native"
                          value CDATA #FIXED "native"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>
<!ELEMENT java2SynchronizedMethod  EMPTY>
<!ATTLIST java2SynchronizedMethod  name CDATA #FIXED "synchronized"
                          value CDATA #FIXED "synchronized"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>
<!ELEMENT java2MethodAccess  EMPTY>
<!ATTLIST java2MethodAccess  name CDATA #FIXED "access"
                          value (public | protected | private) #REQUIRED
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2MethodClass  (#PCDATA)*>
<!ATTLIST java2MethodClass  href CDATA #IMPLIED
                          keyref CDATA #IMPLIED
                          type   CDATA  #IMPLIED
                          %univ-atts;
                          format        CDATA   #IMPLIED
                          scope (local | peer | external) #IMPLIED
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2MethodInterface  (#PCDATA)*>
<!ATTLIST java2MethodInterface  href CDATA #IMPLIED
                          keyref CDATA #IMPLIED
                          type   CDATA  #IMPLIED
                          %univ-atts;
                          format        CDATA   #IMPLIED
                          scope (local | peer | external) #IMPLIED
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2MethodPrimitive  EMPTY>
<!ATTLIST java2MethodPrimitive  name CDATA #FIXED "type"
                          value ( boolean | byte | char | double | float | int | long | short ) #REQUIRED
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2MethodArray  EMPTY>
<!ATTLIST java2MethodArray  name CDATA "arraysize"
                          value CDATA ""
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2Void  EMPTY>
<!ATTLIST java2Void  name CDATA #FIXED "void"
                          value CDATA #FIXED "void"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>


<!-- ============ Class attributes for type ancestry ============ -->
<!ATTLIST java2Method   %global-atts;
    class  CDATA "- topic/topic reference/reference apiRef/apiRef apiOperation/apiOperation javaMethod/javaMethod java2Method/java2Method">
<!ATTLIST java2MethodDetail   %global-atts;
    class  CDATA "- topic/body reference/refbody apiRef/apiDetail apiOperation/apiOperationDetail javaMethod/javaMethodDetail java2Method/java2MethodDetail">
<!ATTLIST java2MethodDef   %global-atts;
    class  CDATA "- topic/section reference/section apiRef/apiDef apiOperation/apiOperationDef javaMethod/javaMethodDef java2Method/java2MethodDef">
<!ATTLIST java2FinalMethod   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier javaMethod/javaFinalMethod java2Method/java2FinalMethod">
<!ATTLIST java2AbstractMethod   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier javaMethod/javaAbstractMethod java2Method/java2AbstractMethod">
<!ATTLIST java2StaticMethod   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier javaMethod/javaStaticMethod java2Method/java2StaticMethod">
<!ATTLIST java2NativeMethod   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier javaMethod/javaNativeMethod java2Method/java2NativeMethod">
<!ATTLIST java2SynchronizedMethod   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier javaMethod/javaSynchronizedMethod java2Method/java2SynchronizedMethod">
<!ATTLIST java2MethodAccess   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier javaMethod/javaMethodAccess java2Method/java2MethodAccess">
<!ATTLIST java2Return   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiOperation/apiReturn javaMethod/javaReturn java2Method/java2Return">
<!ATTLIST java2Param   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiOperation/apiParam javaMethod/javaParam java2Method/java2Param">
<!ATTLIST java2Exception   %global-atts;
    class  CDATA "- topic/ph reference/ph apiRef/apiDefItem apiOperation/apiEvent javaMethod/javaException java2Method/java2Exception">
<!ATTLIST java2MethodClass   %global-atts;
    class  CDATA "- topic/xref reference/xref apiRef/apiRelation apiOperation/apiOperationClassifier javaMethod/javaMethodClass java2Method/java2MethodClass">
<!ATTLIST java2MethodInterface   %global-atts;
    class  CDATA "- topic/xref reference/xref apiRef/apiRelation apiOperation/apiOperationClassifier javaMethod/javaMethodInterface java2Method/java2MethodInterface">
<!ATTLIST java2MethodPrimitive   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiType apiOperation/apiType javaMethod/javaMethodPrimitive java2Method/java2MethodPrimitive">
<!ATTLIST java2MethodArray   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiArray apiOperation/apiArray javaMethod/javaMethodArray java2Method/java2MethodArray">
<!ATTLIST java2Void   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiOperation/apiQualifier javaMethod/javaVoid java2Method/java2Void ">
<!ATTLIST java2ConstructorDef   %global-atts;
    class  CDATA "- topic/section reference/section apiRef/apiDef apiOperation/apiConstructorDef javaMethod/javaConstructorDef java2Method/java2ConstructorDef">
