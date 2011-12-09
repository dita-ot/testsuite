<!--
 | (C) Copyright IBM Corporation 2005 - 2006. All Rights Reserved.
 *-->

<!ENTITY % java2class      "java2class">
<!ENTITY % java2field      "java2field">


<!ELEMENT java2class      (#PCDATA)>
<!ATTLIST java2class       href CDATA #IMPLIED
                      keyref CDATA #IMPLIED
                      type   CDATA  #IMPLIED
                      %univ-atts;
                      format        CDATA   #IMPLIED
                      scope (local | peer | external) #IMPLIED
                      outputclass CDATA #IMPLIED
>

<!ELEMENT java2field      (#PCDATA)>
<!ATTLIST java2field       href CDATA #IMPLIED
                      keyref CDATA #IMPLIED
                      type   CDATA  #IMPLIED
                      %univ-atts;
                      format        CDATA   #IMPLIED
                      scope (local | peer | external) #IMPLIED
                      outputclass CDATA #IMPLIED
>

<!ATTLIST java2class   %global-atts;
    class  CDATA "+ topic/xref pr-d/xref api-d/apiclassifier javaapi-d/javaclass java2api-d/java2class">
<!ATTLIST java2field   %global-atts;
    class  CDATA "+ topic/xref pr-d/xref api-d/apivalue javaapi-d/javafield java2api-d/java2field">
