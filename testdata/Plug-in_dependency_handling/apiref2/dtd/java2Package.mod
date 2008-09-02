<!--
 | (C) Copyright IBM Corporation 2005 - 2006. All Rights Reserved.
 *-->

<!-- ============ Hooks for domain extension ============ -->
<!ENTITY % java2Package           "java2Package">
<!ENTITY % java2PackageDetail     "java2PackageDetail">


<!-- ============ Hooks for shell DTD ============ -->
<!ENTITY % java2Package-types-default  "no-topic-nesting">
<!ENTITY % java2Package-info-types     "%java2Package-types-default;">

<!ENTITY included-domains "">


<!-- ============ Topic specializations ============ -->
<!ELEMENT java2Package     ((%apiSyntax;)?, (%apiName;), (%shortdesc;), (%prolog;)?, (%java2PackageDetail;), (%related-links;)?, (%java2Package-info-types;)*)>
<!ATTLIST java2Package     id ID #REQUIRED
                          conref CDATA #IMPLIED
                          outputclass CDATA #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          %arch-atts;
                          domains CDATA "&included-domains;"
>

<!ELEMENT java2PackageDetail      ((%apiDesc;)?, (%example;|%section;|%apiImpl;)*)>
<!ATTLIST java2PackageDetail  %id-atts;
                          translate (yes|no) #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          outputclass CDATA #IMPLIED>


<!-- ============ Class attributes for type ancestry ============ -->
<!ATTLIST java2Package   %global-atts;
    class  CDATA "- topic/topic reference/reference apiRef/apiRef apiPackage/apiPackage javaPackage/javaPackage apiPackage2/java2Package">
<!ATTLIST java2PackageDetail   %global-atts;
    class  CDATA "- topic/body reference/refbody apiRef/apiDetail apiPackage/apiDetail javaPackage/javaPackageDetail apiPackage2/java2PackageDetail">
