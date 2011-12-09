<!--
 | (C) Copyright IBM Corporation 2005 - 2006. All Rights Reserved.
 *-->

<!ENTITY % java2APIMap             "java2APIMap">
<!ENTITY % java2PackageRef         "java2PackageRef">
<!ENTITY % java2InterfaceRef       "java2InterfaceRef">
<!ENTITY % java2ClassRef           "java2ClassRef">
<!ENTITY % java2ExceptionClassRef  "java2ExceptionClassRef">
<!ENTITY % java2ErrorClassRef      "java2ErrorClassRef">

<!ELEMENT java2APIMap      ((%topicmeta;)?, (%java2PackageRef;)*, (%reltable;)*)>
<!ATTLIST java2APIMap      title     CDATA #IMPLIED
                          id        ID    #IMPLIED
                          anchorref CDATA #IMPLIED
                          %topicref-atts;
                          %select-atts;
             translate  (yes | no)                        #IMPLIED
             xml:lang   NMTOKEN                           #IMPLIED
             %arch-atts;
                          domains    CDATA "&included-domains;"
>

<!ELEMENT java2PackageRef ((%topicmeta;)?, (%topicref;)*, (%java2PackageRef;)*, (%java2InterfaceRef;)*, (%java2ClassRef;)*, (%java2ExceptionClassRef;)*, (%java2ErrorClassRef;)*)>
<!ATTLIST java2PackageRef
  navtitle     CDATA     #IMPLIED
  id           ID        #IMPLIED
  href         CDATA     #IMPLIED
  keyref       CDATA     #IMPLIED
  query        CDATA     #IMPLIED
  conref       CDATA     #IMPLIED
  copy-to      CDATA     #IMPLIED
  collection-type    (choice|unordered|sequence|family) #IMPLIED
  type         CDATA     "java2Package"
  scope       (local | peer | external) #IMPLIED
  locktitle   (yes|no)   #IMPLIED
  format       CDATA     #IMPLIED
  linking     (targetonly|sourceonly|normal|none) #IMPLIED
  toc         (yes|no)   #IMPLIED
  print       (yes|no)   #IMPLIED
  search      (yes|no)   #IMPLIED
  chunk        CDATA     #IMPLIED
  %select-atts;
>

<!ELEMENT java2InterfaceRef ((%topicmeta;)?, (%topicref;)*)>
<!ATTLIST java2InterfaceRef
  navtitle     CDATA     #IMPLIED
  id           ID        #IMPLIED
  href         CDATA     #IMPLIED
  keyref       CDATA     #IMPLIED
  query        CDATA     #IMPLIED
  conref       CDATA     #IMPLIED
  copy-to      CDATA     #IMPLIED
  collection-type    (choice|unordered|sequence|family) #IMPLIED
  type         CDATA     "javaInterface"
  scope       (local | peer | external) #IMPLIED
  locktitle   (yes|no)   #IMPLIED
  format       CDATA     #IMPLIED
  linking     (targetonly|sourceonly|normal|none) #IMPLIED
  toc         (yes|no)   #IMPLIED
  print       (yes|no)   #IMPLIED
  search      (yes|no)   #IMPLIED
  chunk        CDATA     #IMPLIED
  %select-atts;
>
<!ELEMENT java2ClassRef ((%topicmeta;)?, (%topicref;)*)>
<!ATTLIST java2ClassRef
  navtitle     CDATA     #IMPLIED
  id           ID        #IMPLIED
  href         CDATA     #IMPLIED
  keyref       CDATA     #IMPLIED
  query        CDATA     #IMPLIED
  conref       CDATA     #IMPLIED
  copy-to      CDATA     #IMPLIED
  collection-type    (choice|unordered|sequence|family) #IMPLIED
  type         CDATA     "java2Class"
  scope       (local | peer | external) #IMPLIED
  locktitle   (yes|no)   #IMPLIED
  format       CDATA     #IMPLIED
  linking     (targetonly|sourceonly|normal|none) #IMPLIED
  toc         (yes|no)   #IMPLIED
  print       (yes|no)   #IMPLIED
  search      (yes|no)   #IMPLIED
  chunk        CDATA     #IMPLIED
  %select-atts;
>
<!ELEMENT java2ExceptionClassRef ((%topicmeta;)?, (%topicref;)*)>
<!ATTLIST java2ExceptionClassRef
  navtitle     CDATA     #IMPLIED
  id           ID        #IMPLIED
  href         CDATA     #IMPLIED
  keyref       CDATA     #IMPLIED
  query        CDATA     #IMPLIED
  conref       CDATA     #IMPLIED
  copy-to      CDATA     #IMPLIED
  collection-type    (choice|unordered|sequence|family) #IMPLIED
  type         CDATA     "java2Class"
  scope       (local | peer | external) #IMPLIED
  locktitle   (yes|no)   #IMPLIED
  format       CDATA     #IMPLIED
  linking     (targetonly|sourceonly|normal|none) #IMPLIED
  toc         (yes|no)   #IMPLIED
  print       (yes|no)   #IMPLIED
  search      (yes|no)   #IMPLIED
  chunk        CDATA     #IMPLIED
  %select-atts;
>
<!ELEMENT java2ErrorClassRef ((%topicmeta;)?, (%topicref;)*)>
<!ATTLIST java2ErrorClassRef
  navtitle     CDATA     #IMPLIED
  id           ID        #IMPLIED
  href         CDATA     #IMPLIED
  keyref       CDATA     #IMPLIED
  query        CDATA     #IMPLIED
  conref       CDATA     #IMPLIED
  copy-to      CDATA     #IMPLIED
  collection-type    (choice|unordered|sequence|family) #IMPLIED
  type         CDATA     "java2Class"
  scope       (local | peer | external) #IMPLIED
  locktitle   (yes|no)   #IMPLIED
  format       CDATA     #IMPLIED
  linking     (targetonly|sourceonly|normal|none) #IMPLIED
  toc         (yes|no)   #IMPLIED
  print       (yes|no)   #IMPLIED
  search      (yes|no)   #IMPLIED
  chunk        CDATA     #IMPLIED
  %select-atts;
>

<!ATTLIST java2APIMap %global-atts;
    class CDATA "- map/map apiMap/apiMap javaAPIMap/javaAPIMap java2APIMap/java2APIMap">
<!ATTLIST java2PackageRef %global-atts;
    class CDATA "- map/topicref apiMap/apiItemRef javaAPIMap/javaPackageRef java2APIMap/java2PackageRef">
<!ATTLIST java2InterfaceRef %global-atts;
    class CDATA "- map/topicref apiMap/apiItemRef javaAPIMap/javaInterfaceRef java2APIMap/java2InterfaceRef">
<!ATTLIST java2ClassRef %global-atts;
    class CDATA "- map/topicref apiMap/apiItemRef javaAPIMap/javaClassRef java2APIMap/java2ClassRef">
<!ATTLIST java2ExceptionClassRef %global-atts;
    class CDATA "- map/topicref apiMap/apiItemRef javaAPIMap/javaExceptionClassRef java2APIMap/java2ExceptionClassRef">
<!ATTLIST java2ErrorClassRef %global-atts;
    class CDATA "- map/topicref apiMap/apiItemRef javaAPIMap/javaErrorClassRef java2APIMap/java2ErrorClassRef">
