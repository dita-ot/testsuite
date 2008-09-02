<!--
 | (C) Copyright IBM Corporation 2005 - 2006. All Rights Reserved.
 *-->

<!-- ============ Hooks for domain extension ============ -->
<!ENTITY % java2Interface         "java2Interface">
<!ENTITY % java2InterfaceDetail   "java2InterfaceDetail">
<!ENTITY % java2InterfaceDef      "java2InterfaceDef">
<!ENTITY % java2InterfaceAccess   "java2InterfaceAccess">
<!ENTITY % java2BaseInterface     "java2BaseInterface">


<!-- ============ Hooks for shell DTD ============ -->
<!ENTITY % java2Interface-types-default  "java2Method | java2Field">
<!ENTITY % java2Interface-info-types     "%java2Interface-types-default;">

<!ENTITY included-domains "">


<!-- ============ Topic specializations ============ -->
<!ELEMENT java2Interface   ( (%apiName;), (%shortdesc;), (%prolog;)?, (%java2InterfaceDetail;), (%related-links;)?, (%java2Interface-info-types;)* )>
<!ATTLIST java2Interface   id ID #REQUIRED
                          conref CDATA #IMPLIED
                          outputclass CDATA #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          %arch-atts;
                          domains CDATA "&included-domains;"
>

<!ELEMENT java2InterfaceDetail  ((%java2InterfaceDef;)?, (%apiDesc;)?, (%example;|%section;|%apiImpl;)*)>
<!ATTLIST java2InterfaceDetail  %id-atts;
                          translate (yes|no) #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          outputclass CDATA #IMPLIED>

<!-- MULTIPLE BASE INTERFACES? ADDED FOR NOW -->
<!ELEMENT java2InterfaceDef   ((%java2InterfaceAccess;)?, (%java2BaseInterface;)*) >
<!ATTLIST java2InterfaceDef  spectitle CDATA #IMPLIED
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2InterfaceAccess  EMPTY>
<!ATTLIST java2InterfaceAccess  name CDATA #FIXED "access"
                          value (public) #FIXED "public"
                          %univ-atts;
                          outputclass CDATA #IMPLIED
>

<!ELEMENT java2BaseInterface  (#PCDATA)*>
<!ATTLIST java2BaseInterface  href CDATA #IMPLIED
                          keyref CDATA #IMPLIED
                          type   CDATA  #IMPLIED
                          %univ-atts;
                          format        CDATA   #IMPLIED
                          scope (local | peer | external) #IMPLIED
                          outputclass CDATA #IMPLIED
>


<!-- ============ Class attributes for type ancestry ============ -->
<!ATTLIST java2Interface   %global-atts;
    class  CDATA "- topic/topic reference/reference apiRef/apiRef apiClassifier/apiClassifier javaInterface/javaInterface java2Interface/java2Interface">
<!ATTLIST java2InterfaceDetail   %global-atts;
    class  CDATA "- topic/body reference/refbody apiRef/apiDetail apiClassifier/apiClassifierDetail javaInterface/javaInterfaceDetail java2Interface/java2InterfaceDetail">
<!ATTLIST java2InterfaceDef   %global-atts;
    class  CDATA "- topic/section reference/section apiRef/apiDef apiClassifier/apiClassifierDef javaInterface/javaInterfaceDef java2Interface/java2InterfaceDef">
<!ATTLIST java2InterfaceAccess   %global-atts;
    class  CDATA "- topic/state reference/state apiRef/apiQualifier apiClassifier/apiQualifier javaInterface/javaInterfaceAccess java2Interface/java2InterfaceAccess">
<!ATTLIST java2BaseInterface   %global-atts;
    class  CDATA "- topic/xref reference/xref apiRef/apiRelation apiClassifier/apiBaseClassifier javaInterface/javaBaseInterface java2Interface/java2BaseInterface">
