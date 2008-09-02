<!--
 | (C) Copyright IBM Corporation 2005 - 2006. All Rights Reserved.
 *-->

<!-- ============ Hooks for domain extension ============ -->
<!ENTITY % java2Class                    "java2Class">
<!ENTITY % java2ClassDetail              "java2ClassDetail">
<!ENTITY % java2ClassDef                 "java2ClassDef">
<!ENTITY % java2FinalClass               "java2FinalClass">
<!ENTITY % java2AbstractClass            "java2AbstractClass">
<!ENTITY % java2StaticClass              "java2StaticClass">
<!ENTITY % java2ClassAccess              "java2ClassAccess">
<!ENTITY % java2BaseClass                "java2BaseClass">
<!ENTITY % java2ImplementedInterface     "java2ImplementedInterface">


<!-- ============ Hooks for shell DTD ============ -->
<!ENTITY % java2Class-types-default
    "java2Class | java2Interface | java2Method | java2Field">
<!ENTITY % java2Class-info-types  "%java2Class-types-default;">

<!ENTITY included-domains "">


<!-- ============ Topic specializations ============ -->
<!ELEMENT java2Class   ((%apiName;), (%shortdesc;), (%prolog;)?, (%java2ClassDetail;), (%related-links;)?, (%java2Class-info-types;)*)>
<!ATTLIST java2Class       id ID #REQUIRED
                          conref CDATA #IMPLIED
                          outputclass CDATA #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          %arch-atts;
                          domains CDATA "&included-domains;"
>

<!ELEMENT java2ClassDetail  ((%java2ClassDef;)?, (%apiDesc;)?, (%example;|%section;|%apiImpl;)*)>
<!ATTLIST java2ClassDetail  %id-atts;
                          translate (yes|no) #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          outputclass CDATA #IMPLIED>

<!ELEMENT java2ClassDef   ((%java2FinalClass;)?, (%java2AbstractClass;)?, (%java2StaticClass;)?, (%java2ClassAccess;)?, (%java2BaseClass;)?, (%java2ImplementedInterface;)*) >
<!ATTLIST java2ClassDef    spectitle CDATA #IMPLIED
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2FinalClass  EMPTY>
<!ATTLIST java2FinalClass  name CDATA #FIXED "final"
                          value CDATA #FIXED "final"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>
<!ELEMENT java2AbstractClass  EMPTY>
<!ATTLIST java2AbstractClass  name CDATA #FIXED "abstract"
                          value CDATA #FIXED "abstract"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>
<!ELEMENT java2StaticClass  EMPTY>
<!ATTLIST java2StaticClass  name CDATA #FIXED "static"
                          value CDATA #FIXED "static"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>
<!ELEMENT java2ClassAccess  EMPTY>
<!ATTLIST java2ClassAccess  name CDATA #FIXED "access"
                          value (public) #FIXED "public"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2BaseClass  (#PCDATA)*>
<!ATTLIST java2BaseClass   href CDATA #IMPLIED
                          keyref CDATA #IMPLIED
                          type   CDATA  #IMPLIED
                          %univ-atts;
                          format        CDATA   #IMPLIED
                          scope (local | peer | external) #IMPLIED
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2ImplementedInterface  (#PCDATA)*>
<!ATTLIST java2ImplementedInterface  href CDATA #IMPLIED
                          keyref CDATA #IMPLIED
                          type   CDATA  #IMPLIED
                          %univ-atts;
                          format        CDATA   #IMPLIED
                          scope (local | peer | external) #IMPLIED
                          outputclass CDATA #IMPLIED
>


<!-- ============ Class attributes for type ancestry ============ -->
<!ATTLIST java2Class   %global-atts;
    class  CDATA "- topic/topic reference/reference apiRef/apiRef apiClassifier/apiClassifier javaClass/javaClass java2Class/java2Class">
<!ATTLIST java2ClassDetail   %global-atts;
    class  CDATA "- topic/body reference/refbody apiRef/apiDetail apiClassifier/apiClassifierDetail javaClass/javaClassDetail java2Class/java2ClassDetail">
<!ATTLIST java2ClassDef   %global-atts;
    class  CDATA "- topic/section reference/section apiRef/apiDef apiClassifier/apiClassifierDef javaClass/javaClassDef java2Class/java2ClassDef">
<!ATTLIST java2FinalClass   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiClassifier/apiQualifier javaClass/javaFinalClass java2Class/java2FinalClass">
<!ATTLIST java2AbstractClass   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiClassifier/apiQualifier javaClass/javaAbstractClass java2Class/java2AbstractClass">
<!ATTLIST java2StaticClass   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiClassifier/apiQualifier javaClass/javaStaticClass java2Class/java2StaticClass">
<!ATTLIST java2ClassAccess   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiClassifier/apiQualifier javaClass/javaClassAccess java2Class/java2ClassAccess">
<!ATTLIST java2BaseClass   %global-atts;
    class  CDATA "- topic/xref reference/xref apiRef/apiRelation apiClassifier/apiBaseClassifier javaClass/javaBaseClass java2Class/java2BaseClass">
<!ATTLIST javaImplementedInterface   %global-atts;
    class  CDATA "- topic/xref reference/xref apiRef/apiRelation apiClassifier/apiBaseClassifier javaClass/javaImplementedInterface java2Class/java2ImplementedInterface">
