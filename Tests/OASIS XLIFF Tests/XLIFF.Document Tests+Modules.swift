extension `XLIFF.Document Tests` {

    static let modulesInvalid: [Fixture] = [
        Fixture(
            "modules/invalid/Bad-ctr-property-not-legit-category.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="crt01">
                  <unit id="1">
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="note" currentVersion="r1" ref="n1">
                           <ctr:revision author="Bob"
            datetime="2013-07-16T10:30:00+8:00" version="r1">
                              <ctr:item property="content">The translation should be formal</ctr:item>
                              <ctr:item property="category">instruction</ctr:item>
                           </ctr:revision>
                           <ctr:revision author="Bob"
            datetime="2013-05-16T10:30:00+8:00" version="r2">
                              <ctr:item property="content">The translation should be informal</ctr:item>
                              <ctr:item property="category">comment</ctr:item>
                              <ctr:item property="category">tangerine</ctr:item><!--
            5.6.5.6 property
            MUST be either content to signify the content of an element, or the name of the attribute relating to the revision data.
            --><!-- violation not a legit category -->
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>
            \#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <notes>
                        <note category="instruction" id="n1">The translation should be formal</note>
                        <note category="comment" id="n2">Please Review my translation</note>
                     </notes>
                     <segment>
                        <source>Hello World</source>
                        <target>Guten Tag Welt</target>
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-ctr_appliesTo-not-using-ref-to-resolvableID.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="crt01">
                  <unit id="good-bad">
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="source" ref="nn1"><!-- good, resolves to an ID -->
                           <ctr:revision>
                              <ctr:item property="content">old note</ctr:item>
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="note" ref="no-match"><!-- bad, does not resolve to an ID
                        5.6.5.5 ref he value of the ref attribute MUST be the value of the id attribute of a single instance of an element that is a multiple instance within the enclosing element.
                        -->
                           <ctr:revision>
                              <ctr:item property="content">old note</ctr:item>
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="note">
                           <!-- violation of 5.6.4.3 revisions - When the appliesTo attribute refers to an element that\#u{20}
                              is a multiple instance within the enclosing element, the ref attribute MUST be\#u{20}
                              used to reference an individual instance if and only if the referenced instance\#u{20}
                              has an id.
                              -->
                           <ctr:revision>
                              <ctr:item property="content">old note</ctr:item>
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>
                     <notes>
                        <note id="nn1"></note>
                        <note id="nn2"></note>
                     </notes>
                     <segment>
                        <source>Yes</source>
                        <target>Ja</target>
                     </segment>
                     <segment>
                        <source>No</source>
                        <target>Nein</target>
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-ctr_property-not-content-or-valid-attribute-ref.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="crt01">
                  <unit id="property-attribute-testing">
                     <!--\#u{20}
                        5.6.5.6 property "The value MUST be either content to signify the content of an element,\#u{20}
                        or the name of the attribute relating to the revision data."
                     -->
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="note" ref="nn11">
                           <ctr:revision>
                              <ctr:item property="content">old note</ctr:item><!-- good, I'll just assume the content of\#u{20}
                                                                                   the previous note[@id='nn1'] was "old note" -->
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="note" ref="nn22">
                           <ctr:revision>
                              <ctr:item property="priority">old note</ctr:item><!--
            5.6.5.6 property
            MUST be either content to signify the content of an element, or the name of the attribute relating to the revision data.
            --><!-- bad, had it said id or category,\#u{20}
                                                                                    it would have met the requirement,\#u{20}
                                                                                    but since note[@id='nn1'] does not have
                                                                                    @priority it is a violation of\#u{20}
                                                                                    "or the name of the attribute relating to the revision data" -->
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <notes>
                        <note category="riddles" id="nn11"></note>
                        <note id="nn22"></note>
                     </notes>
                     <segment>
                        <source>Yes</source>
                        <target>Ja</target>
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-ctr_ref-not-pointed-to-resolvableID.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="crt01">
                  <unit id="good-bad">
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="source" ref="nn1"><!-- change back to note --><!-- good, resolves to an ID -->
                           <ctr:revision>
                              <ctr:item property="content">old note</ctr:item>
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="note" ref="no-match"><!-- bad, does not resolve to an ID
                        5.6.5.5 ref he value of the ref attribute MUST be the value of the id attribute of a single instance of an element that is a multiple instance within the enclosing element.
                        -->
                           <ctr:revision>
                              <ctr:item property="content">old note</ctr:item>
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="note">
                           <!-- violation of 5.6.4.3 revisions - When the appliesTo attribute refers to an element that\#u{20}
                              is a multiple instance within the enclosing element, the ref attribute MUST be\#u{20}
                              used to reference an individual instance if and only if the referenced instance\#u{20}
                              has an id.
                              -->
                           <ctr:revision>
                              <ctr:item property="content">old note</ctr:item>
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>
                     <notes>
                        <note id="nn1"></note>
                        <note id="nn2"></note>
                     </notes>
                     <segment>
                        <source>Yes</source>
                        <target>Ja</target>
                     </segment>
                     <segment>
                        <source>No</source>
                        <target>Nein</target>
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-ctr_revisions-not-using-ref-to-resolvableID.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="crt01">
                  <unit id="good-bad">
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="source" ref="nn1"><!-- good, resolves to an ID -->
                           <ctr:revision>
                              <ctr:item property="content">old note</ctr:item>
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="note" ref="no-match"><!-- bad, does not resolve to an ID
                        5.6.5.5 ref he value of the ref attribute MUST be the value of the id attribute of a single instance of an element that is a multiple instance within the enclosing element.
                        -->
                           <ctr:revision>
                              <ctr:item property="content">old note</ctr:item>
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="note">
                           <!-- violation of 5.6.4.3 revisions - When the appliesTo attribute refers to an element that\#u{20}
                              is a multiple instance within the enclosing element, the ref attribute MUST be\#u{20}
                              used to reference an individual instance if and only if the referenced instance\#u{20}
                              has an id.
                              -->
                           <ctr:revision>
                              <ctr:item property="content">old note</ctr:item>
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>
                     <notes>
                        <note id="nn1"></note>
                        <note id="nn2"></note>
                     </notes>
                     <segment>
                        <source>Yes</source>
                        <target>Ja</target>
                     </segment>
                     <segment>
                        <source>No</source>
                        <target>Nein</target>
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-fs_fs-not-valid-HTML.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="utf-8"?>

            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" xmlns:xmrk="urn:xmarker"
                   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                   xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
                   xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
                   xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
                   xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
                   xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
                   xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
                   xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
                   xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
                   xmlns:xhtml="http://www.w3.org/1999/xhtml"
                   xmlns:svg="http://www.w3.org/2000/svg"
                   srcLang="en-us"
                   version="2.0"
                   xsi:schemaLocation="urn:oasis:names:tc:xliff:document:2.0 file:/C:/Users/bryans/Desktop/presentations/schnabel_demos_under-construction/XLIFF2.0-utils/XLIFF2.0/xliff-core-v2.0-csprd03/schemas/xliff_core_2.0.xsd"
                   trgLang="de">
            \#u{20}
               <file id="bad-filesize2">\#u{20}\#u{20}
                  <notes>
                  <note category="reconstruction hints" fs:fs="i" id="myNote01" priority="1"
                     xmrk:any="notBound">Any notes in the category of reconstruction hints are only supplied as hints for reconstruction and MUST NOT be included in the translated output. But it is okay to include the hints in the HTML preview.</note>
                  <note category="reconstruction hints" fs:fs="i" id="myNote02" priority="2">The skeleton contains ALL the element and attribute hierarchy required to reconstruct the translated document from this XLIFF.</note>
                     <note id="n3" fs:fs="paragraph"><!-- 5.3.5.1 fs violation, paragraph not a valid value-->This note has an @fs that is not in the table of attribute values in the spec</note>
                     <note id="n4" fs:subFs="noFS">This note has a subFS but no fs.</note><!-- 5.3.5.2 subFs
             voiolation, If the attribute subFs is used, the attribute fs MUST be specified as well.
             -->
                  </notes>
                  <group id="slr-test">\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <group id="g1" slr:storageRestriction="255"
                        slr:sizeRestriction="90">
                        <unit id="u1" slr:sizeRestriction="*">
                           <segment id="seg1">
                              <source>Hello world.</source>
                           </segment>
                        </unit>
                     </group>
                  </group>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-fs_subFs-not-allowed-w-o-fs.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="utf-8"?>

            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" xmlns:xmrk="urn:xmarker"
                   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                   xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
                   xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
                   xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
                   xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
                   xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
                   xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
                   xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
                   xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
                   xmlns:xhtml="http://www.w3.org/1999/xhtml"
                   xmlns:svg="http://www.w3.org/2000/svg"
                   srcLang="en-us"
                   version="2.0"
                   xsi:schemaLocation="urn:oasis:names:tc:xliff:document:2.0 file:/C:/Users/bryans/Desktop/presentations/schnabel_demos_under-construction/XLIFF2.0-utils/XLIFF2.0/xliff-core-v2.0-csprd03/schemas/xliff_core_2.0.xsd"
                   trgLang="de">
            \#u{20}
               <file id="bad-filesize2">\#u{20}\#u{20}
                  <notes>
                  <note category="reconstruction hints" fs:fs="i" id="myNote01" priority="1"
                     xmrk:any="notBound">Any notes in the category of reconstruction hints are only supplied as hints for reconstruction and MUST NOT be included in the translated output. But it is okay to include the hints in the HTML preview.</note>
                  <note category="reconstruction hints" fs:fs="i" id="myNote02" priority="2">The skeleton contains ALL the element and attribute hierarchy required to reconstruct the translated document from this XLIFF.</note>
                     <note id="n3" fs:fs="paragraph"><!-- 5.3.5.1 fs violation, paragraph not a valid value-->This note has an @fs that is not in the table of attribute values in the spec</note>
                     <note id="n4" fs:subFs="noFS">This note has a subFS but no fs.</note><!-- 5.3.5.2 subFs
             voiolation, If the attribute subFs is used, the attribute fs MUST be specified as well.
             -->
                  </notes>
                  <group id="slr-test">\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <group id="g1" slr:storageRestriction="255"
                        slr:sizeRestriction="90">
                        <unit id="u1" slr:sizeRestriction="*">
                           <segment id="seg1">
                              <source>Hello world.</source>
                           </segment>
                        </unit>
                     </group>
                  </group>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-gls_glossEntry-and-translation-not-unique-in-glossary.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="f216">
                  <unit id="xmrk_000_concept">
                     <gls:glossary>
                        <gls:glossEntry id="ge1">
                           <gls:term source="SnowTerms">snow</gls:term>
                           <gls:translation id="t1" source="SnowTerms">Schnee</gls:translation
            >
                           <gls:definition source="SnowTermsDefinitions">atmospheric water vapor frozen into ice crystals and falling in light white flakes or lying on the ground as a white layer.</gls:definition
            >
                        </gls:glossEntry>
                        <gls:glossEntry id="ge1"><!-- 5.2.5.1 id
            Constraints

            The values of id attributes MUST be unique among all <glossEntry> and <translation> elements within the given enclosing <glossary> element.\#u{20}
            --><!-- violation, not unique. -->
                        <gls:term source="SnowTerms">slush</gls:term>
                           <gls:translation id="t1" source="SnowTerms">Schneematsch</gls:translation>
                        <gls:definition source="SnowTermsDefinitions">a slurry mixture of small ice crystals (e.g., snow) and liquid water.</gls:definition><!-- violation, not unique. -->
                       </gls:glossEntry>
                     </gls:glossary>

                     <segment id="xmrk_003_p">
                        <source>I like to ski. And Ctrl+C=<cp hex="0003"/>
                        </source>
                        <target>I like to ski. And Ctrl+C=<cp hex="0003"/>
                        </target>\#u{20}
            	     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-gls_glossEntry-w-o-translation-or-definition.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="f216">
                  <unit id="xmrk_000_concept">

                     <gls:glossary>
                        <gls:glossEntry id="ge1">
                           <gls:term source="SnowTerms">snow</gls:term>
                           <gls:translation id="t1" source="SnowTerms">Schnee</gls:translation
            >
                           <gls:definition source="SnowTermsDefinitions">atmospheric water vapor frozen into ice crystals and falling in light white flakes or lying on the ground as a white layer.</gls:definition
            >
                        </gls:glossEntry>
                        <gls:glossEntry id="ge2"><!-- invalid 5.2.4.3 contraint:\#u{20}
                           A <glossEntry> element MUST contain a <translation> or a <definition> element to be valid.
                           -->
                           <gls:term>slushy</gls:term>
                        </gls:glossEntry>
                     </gls:glossary>
                     <segment id="xmrk_001_title">
                        <source xml:lang="en-us" xml:space="default">Skiing</source>
                        <target xml:lang="de">Skiing</target>
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-gls_invalid-extension.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
             srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="f216">
                  <unit id="xmrk_000_concept">
                     <gls:glossary>
                        <gls:glossEntry id="ge2">
            				<gls:term>failed</gls:term>
            				<gls:translation id="target-term-1">ausgefallen</gls:translation>
            				<mda:metadata>"
            					<mda:metaGroup category="terminology">
            						<mda:meta type="concept-id">15910</mda:meta>
            					</mda:metaGroup>
            				</mda:metadata>"
                        </gls:glossEntry>
                     </gls:glossary>
                     <segment id="xmrk_001_title">
                        <source xml:lang="en-us" xml:space="default">Skiing</source>
                        <target xml:lang="de">Skiing</target>
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-mda_meta-missing-type.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            srcLang="en-us" version="2.0" trgLang="de">
            <file id="f1">
            	<mda:metadata id="md1">
            		<mda:metaGroup id="mg1">
            			<mda:meta>data</mda:meta>
            		</mda:metaGroup>
            	</mda:metadata>
            	<unit id="u1">
            		<segment id="s1">
            			<source>source</source>
                        <target>target</target>
            		</segment>
            	</unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-mda_meta-missplaced-appliesTo.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            srcLang="en-us" version="2.0" trgLang="de">
            <file id="f1">
            	<mda:metadata id="md1">
            		<mda:metaGroup id="mg1">
            			<mda:meta type="type" appliesTo="bad_value">data</mda:meta>
            		</mda:metaGroup>
            	</mda:metadata>
            	<unit id="u1">
            		<segment id="s1">
            			<source>source</source>
                        <target>target</target>
            		</segment>
            	</unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-mda_metaGroup-id-not-nmtoken.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            srcLang="en-us" version="2.0" trgLang="de">
            <file id="f1">
            	<mda:metadata id="md1">
            		<mda:metaGroup id="bad%$#id">
            			<mda:meta type="mytype">data</mda:meta>
            		</mda:metaGroup>
            	</mda:metadata>
            	<unit id="u1">
            		<segment id="s1">
            			<source>source</source>
                        <target>target</target>
            		</segment>
            	</unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-mda_metaGroup-id-not-unique.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            srcLang="en-us" version="2.0" trgLang="de">
            <file id="f1">
            	<mda:metadata id="md1">
            		<mda:metaGroup id="duplicated_id">
            			<mda:meta type="mytype">data</mda:meta>
            		</mda:metaGroup>
            		<mda:metaGroup id="duplicated_id">
            			<mda:meta type="mytype">data</mda:meta>
            		</mda:metaGroup>
            	</mda:metadata>
            	<unit id="u1">
            		<segment id="s1">
            			<source>source</source>
                        <target>target</target>
            		</segment>
            	</unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-mda_metaGroup-invalid-appliesTo.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            srcLang="en-us" version="2.0" trgLang="de">
            <file id="f1">
            	<mda:metadata id="md1">
            		<mda:metaGroup id="mg1" appliesTo="bad_value">
            			<mda:meta type="type">data</mda:meta>
            		</mda:metaGroup>
            	</mda:metadata>
            	<unit id="u1">
            		<segment id="s1">
            			<source>source</source>
                        <target>target</target>
            		</segment>
            	</unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-mda_metadata-id-not-nmtoken.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            srcLang="en-us" version="2.0" trgLang="de">
            <file id="f1">
            	<mda:metadata id="bad%$#id">
            		<mda:metaGroup>
            			<mda:meta type="mytype">data</mda:meta>
            		</mda:metaGroup>
            	</mda:metadata>
            	<unit id="u1">
            		<segment id="s1">
            			<source>source</source>
                        <target>target</target>
            		</segment>
            	</unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-mda_missing-metaGroup.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            srcLang="en-us" version="2.0" trgLang="de">
            <file id="f1">
            	<mda:metadata id="md1">
            		<mda:meta>data</mda:meta>
            	</mda:metadata>
            	<unit id="u1">
            		<segment id="s1">
            			<source>source</source>
                        <target>target</target>
            		</segment>
            	</unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-mtc_id-not-nmtoken.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="f216">
                  <unit id="u1">
                     <mtc:matches>
                        <mtc:match id="\bad" ref="#s1">
            			<!--Id value is not an NMTOKEN-->
                           <source>He is my best friend4.</source>
                           <target>Il est mon meilleur ami.</target>
                        </mtc:match>
                     </mtc:matches>
                     <segment id="s1">
                        <source>Skiing</source>
                        <target>Skiing</target>
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-mtc_match-ID-not-unique.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="f216">
                  <unit id="xmrk_000_concept">
                     <mtc:matches>
                        <mtc:match id="mtc1" ref="m1">
                           <source>He is my friend1.</source>
                           <target>Il est mon ami.</target>
                        </mtc:match>
                        <mtc:match id="mtc1" ref="m1"><!--
            			5.1.6.1 id
            Constraints
            The id value MUST be unique within the enclosing <matches> element.
            			--><!-- violation, non-unique ID within matches -->
                           <source>He is my best friend2.</source>
                           <target>Il est mon meilleur ami.</target>
                        </mtc:match>
                     </mtc:matches>
                     <segment id="m1">
                        <source xml:lang="en-us" xml:space="default">Skiing</source>
                        <target xml:lang="de">Skiing</target>
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-mtc_match-has-xml_lang.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="f216">
                  <unit id="xmrk_000_concept" canResegment="yes" fs:fs="html"
            fs:subFs="manifest,concept000" name="concept" srcDir="ltr"
            translate="yes" trgDir="ltr"
            xmrk:doctype_dec="concept PUBLIC '-//OASIS//DTD DITA Concept//EN' 'concept.dtd'"
            >

                     <mtc:matches>
                        <mtc:match id="mtc1" ref="m1" xml:lang="fr"> <!-- 5.1.5.3 match constraint\#u{20}

                xml:lang MUST NOT be set on the match element.
            	--><!-- violation xml:lang is not allowed via constraint -->
                           <source>He is my friend1.</source>
                           <target>Il est mon ami.</target>
                        </mtc:match>
                     </mtc:matches>
                     <segment id="m1" canResegment="no"
            state="translated" subState="xmrk:not_proofed">
                        <source xml:lang="en-us" xml:space="default">Skiing</source>
                        <target xml:lang="de">Skiing</target>
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-mtc_subType-w-o-type-match.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="f216">
                  <unit id="xmrk_000_concept">
                     <mtc:matches>
                        <mtc:match id="mtc111" subType="xyz-trans:exact" ref="m1"><!--
            5.1.6.8 subType
            Constraints
            If the attribute subtype is used, the attribute type MUST be specified as well.
            --><!-- violation, @subType w/o @type -->
                         <source>He is my best friend3.</source>
                         <target>Il est mon meilleur ami.</target>
                        </mtc:match>
                     </mtc:matches>
                     <segment id="m1">
                        <source xml:lang="en-us" xml:space="default">Skiing</source>
                        <target xml:lang="de">Skiing</target>
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-mtc_type-value-not-in-list.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="f216">
                  <unit id="xmrk_000_concept">
                     <mtc:matches>
                        <mtc:match id="mtc122" type="my.mt" ref="m1"><!--5.1.6.9 type --><!-- violation, @type not from list-->
                           <source>He is my best friend4.</source>
                           <target>Il est mon meilleur ami.</target>
                        </mtc:match>
                        <mtc:match id="mtc133" type="tb" ref="m1"><!-- @type good-->
                           <source>He is my best friend5.</source>
                           <target>Il est mon meilleur ami.</target>
                        </mtc:match>\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     </mtc:matches>
                     <segment id="xmrk_001_title" canResegment="no"
            state="translated" subState="xmrk:not_proofed">
                        <source xml:lang="en-us" xml:space="default">Skiing</source>
                        <target xml:lang="de">Skiing</target>
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-mtc_wrong-ref-syntax.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="f216">
                  <unit id="u1">
                     <mtc:matches>
                        <mtc:match id="mtc122" ref="s1">
            			<!--Not a correct fragment reference (it should be #s1)-->
                           <source>He is my best friend4.</source>
                           <target>Il est mon meilleur ami.</target>
                        </mtc:match>
                     </mtc:matches>
                     <segment id="s1">
                        <source>Skiing</source>
                        <target>Skiing</target>
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-mtc_wrong-ref-value.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="f216">
                  <unit id="u1">
                     <mtc:matches>
                        <mtc:match id="mtc122" ref="#u1">
            			<!--5.1.6.5 ref
            			The value of the ref attribute MUST point to a span of text within the same <unit>\#u{20}
            			element where the <match> is located.-->
                           <source>He is my best friend4.</source>
                           <target>Il est mon meilleur ami.</target>
                        </mtc:match>
                     </mtc:matches>
                     <segment id="s1">
                        <source>Skiing</source>
                        <target>Skiing</target>
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-res_resourceItem-not-unique.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="rd333b">
                  <res:resourceData>
                     <res:resourceItem id="r1" mimeType="image/jpeg" context="yes"
            >
                        <res:source xml:lang="en-us"
            href="resources\en\registryconfig1.resources.jpg"></res:source>
                        <res:target xml:lang="lb-lu"
            href="resources\lb\registryconfig1.resources.jpg"></res:target>
                        <res:reference xml:lang="de-de"
            href="resources\de\registryconfig1.resources.jpg"/>
                     </res:resourceItem>
                     <res:resourceItem id="r1" mimeType="image/jpeg" context="yes"
            > <!--
            5.5.4.3 resourceItemRef
            5.5.4.4 resourceItem
            Constraints
            The value of the OPTIONAL id attribute MUST be unique among all <resourceItem> and <resourceItemRef> elements of the immediate enclosing <file> or <unit> element.
            -->
                       <!-- violation not unique -->
                        <res:source xml:lang="en-us"
            href="resources\en\registryconfig2.resources.jpg"></res:source>
                        <res:target xml:lang="lb-lu"
            href="resources\lb\registryconfig2.resources.jpg"></res:target>
                     </res:resourceItem>
                  </res:resourceData>
            \#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                  <unit id="1">
                     <res:resourceData>
                        <res:resourceItemRef ref="r1"/>
                        <res:resourceItemRef ref="r2" id="rr1"/>
                        <res:resourceItem id="rr1" mimeType="image/jpeg"
            context="yes"><!-- violation not unique -->
                           <res:source xml:lang="en-us"
            href="resources\en\registryconfig2.resources.jpg"></res:source>
                           <res:target xml:lang="lb-lu"
            href="resources\lb\registryconfig2.resources.jpg"></res:target>
                        </res:resourceItem>
                     </res:resourceData>
                     <segment id="1" state="translated">
                        <source>Remove Registry Config</source>
                        <target>Registrierungskonfiguration entfernen</target
            >
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-res_resourceItemRef-not-unique.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="rd333b">
                  <res:resourceData>
                     <res:resourceItem id="r1" mimeType="image/jpeg" context="yes"
            >
                        <res:source xml:lang="en-us"
            href="resources\en\registryconfig1.resources.jpg"></res:source>
                        <res:target xml:lang="lb-lu"
            href="resources\lb\registryconfig1.resources.jpg"></res:target>
                        <res:reference xml:lang="de-de"
            href="resources\de\registryconfig1.resources.jpg"/>
                     </res:resourceItem>
                     <res:resourceItem id="r1" mimeType="image/jpeg" context="yes"
            > <!--
            5.5.4.3 resourceItemRef
            5.5.4.4 resourceItem
            Constraints
            The value of the OPTIONAL id attribute MUST be unique among all <resourceItem> and <resourceItemRef> elements of the immediate enclosing <file> or <unit> element.
            -->
                       <!-- violation not unique -->
                        <res:source xml:lang="en-us"
            href="resources\en\registryconfig2.resources.jpg"></res:source>
                        <res:target xml:lang="lb-lu"
            href="resources\lb\registryconfig2.resources.jpg"></res:target>
                     </res:resourceItem>
                  </res:resourceData>
            \#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                  <unit id="1">
                     <res:resourceData>
                        <res:resourceItemRef ref="r1"/>
                        <res:resourceItemRef ref="r2" id="rr1"/>
                        <res:resourceItem id="rr1" mimeType="image/jpeg"
            context="yes"><!-- violation not unique -->
                           <res:source xml:lang="en-us"
            href="resources\en\registryconfig2.resources.jpg"></res:source>
                           <res:target xml:lang="lb-lu"
            href="resources\lb\registryconfig2.resources.jpg"></res:target>
                        </res:resourceItem>
                     </res:resourceData>
                     <segment id="1" state="translated">
                        <source>Remove Registry Config</source>
                        <target>Registrierungskonfiguration entfernen</target
            >
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-res_source-has-content-and-href.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="rd333b">
                  <unit id="1">
                     <res:resourceData>
                        <res:resourceItemRef ref="r1"/>
                        <res:resourceItemRef ref="r2" id="rr1"/>
                        <res:resourceItem id="rr1-temp" mimeType="image/jpeg"
            context="yes">
                           <res:source xml:lang="en-us"
            href="resources\en\registryconfig2.resources.jpg"></res:source>
                           <res:target xml:lang="lb-lu"
            href="resources\lb\registryconfig2.resources.jpg"></res:target>
                        </res:resourceItem>
                        <res:resourceItem id="non-empty-and-href"
            mimeType="image/jpeg" context="yes">
                           <res:source xml:lang="en-us"
            href="resources\en\registryconfig2.resources.jpg"><source>Hello</source></res:source><!--
            5.5.4.5 source
            Constraints

            The attribute href is REQUIRED if and only if <source> is empty.

            --><!--violation  not empty but has href -->
                           <res:target xml:lang="lb-lu"
            href="resources\lb\registryconfig2.resources.jpg"></res:target>
                        </res:resourceItem>
                     </res:resourceData>
                     <segment id="1" state="translated">
                        <source>Remove Registry Config</source>
                        <target>Registrierungskonfiguration entfernen</target>
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-res_source-xml_lang-not-same-as-xliff.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="rd333b">
                  <unit id="1">
                     <res:resourceData>
                        <res:resourceItem id="bad-xml-lang-and-href"
            mimeType="image/jpeg" context="yes">
                           <res:source xml:lang="en-yoda"
            href="resources\en\registryconfig2.resources.jpg"></res:source>
                           <!--
            5.5.4.5 source
            Constraints

            When the OPTIONAL xml:lang attribute is present, its value MUST be equal to the value of the srcLang attribute of the enclosing <xliff> element.
            -->
            <!--violation xml:lang disagrees w/xliff srcLang -->
                           <res:target xml:lang="lb-lu"
            href="resources\lb\registryconfig2.resources.jpg"></res:target>
                        </res:resourceItem>
                        <res:resourceItem id="bad-xml-lang" mimeType="image/jpeg"
            context="yes">
                           <res:source xml:lang="en-yoda"><source>Hi</source></res:source
            ><!--violation xml:lang disagrees w/xliff srcLang -->
                           <res:target xml:lang="lb-lu"><target>Hi</target></res:target
            >
                        </res:resourceItem>
                     </res:resourceData>
                     <segment id="1" state="translated">
                        <source>Remove Registry Config</source>
                        <target>Registrierungskonfiguration entfernen</target
            >
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-slr_equivStorage-ec-not-isolated.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="bad-filesize2">\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                  <slr:profiles generalProfile="xliff:codepoints"
            storageProfile="xliff:utf8">
                     <slr:normalization general="nfc" storage="nfc"/>
                  </slr:profiles>
                  <group id="slr-test">\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <group id="g1" slr:storageRestriction="255"
            slr:sizeRestriction="90">
                        <unit id="u1" slr:sizeRestriction="*">
                           <segment>
                              <source>This <sc id="1" slr:sizeInfo="0"
            slr:equivStorage="7"/>is a small <pc
            id="slr1" slr:equivStorage="seven" slr:sizeRestriction="25,100">size restriction</pc
            > example.</source
            >
                           </segment>
                        </unit>
                        <unit id="u2" slr:sizeRestriction="35,*">
                           <segment>
                              <source>With a group structure<ec startRef="1"
            slr:equivStorage="7" id="ec"/><!-- test if equivStorage is:
                                                         (1) on an <ec> that is not isolated 5.7.5.8
            											 -->
            											 <!-- violation, no @isolated-->.</source
            >
                           </segment>
                        </unit>
                     </group>
                  </group>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-slr_equivStorage-not-integer.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="bad-filesize2">\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                  <slr:profiles generalProfile="xliff:codepoints"
            storageProfile="xliff:utf8">
                     <slr:normalization general="nfc" storage="nfc"/>
                  </slr:profiles>
                  <group id="slr-test">\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <group id="g1" slr:storageRestriction="255"
            slr:sizeRestriction="90">
                        <unit id="u1" slr:sizeRestriction="*">
                           <segment>
                              <source>This <sc id="1" slr:sizeInfo="zero"
            slr:equivStorage="7.1"/> <!-- test if equivStorage is:
            \#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
            											 (2) an integer 5.7.6.2.2 -->
            											 <!-- violation, not an integer -->is a small <pc
            id="slr1" slr:equivStorage="seven" slr:sizeRestriction="25,100"><!-- test if equivStorage is:

            											 (2) an integer 5.7.6.2.2 --><!-- violation, @equivStorage not an integer -->size restriction</pc
            > example<ec startRef="1"/>.</source
            >
                           </segment>
                        </unit>
                     </group>
                  </group>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-slr_sizeInfo-ec-not-isolated.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="bad-filesize2">\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                  <slr:profiles generalProfile="xliff:codepoints"
            storageProfile="xliff:utf8">
                     <slr:normalization general="nfc" storage="nfc"/>
                  </slr:profiles>
                  <group id="slr-test">\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <group id="g1" slr:storageRestriction="255"
            slr:sizeRestriction="90">
                        <unit id="u1" slr:sizeRestriction="*">
                           <segment>
                              <source>This <sc id="1" slr:sizeInfo="0"
            slr:equivStorage="7"/>is a small <pc
            id="slr1" slr:equivStorage="seven" slr:sizeRestriction="25,100">size restriction</pc
            > example<ec startRef="1" slr:sizeInfo="0" /><!-- test if sizeInfo is:
                                                         (1) on an <ec> that is not isolated 5.7.5.9
            											 -->
            											 <!-- violation, would be valid with @isolated.--></source
            >
                           </segment>
                        </unit>
                     </group>
                  </group>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-slr_sizeInfo-not-integer.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="sizeInfoRef-good_bad">
                     <unit id="sm1">
                        <segment id="testsize">
                           <source>Hello <pc id="22" slr:sizeInfo="25.5"><!-- test if sizeInfo is:
            \#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
            											 (2) an integer 5.7.6.1.2\#u{20}
            											 -->
            											 <!-- violation, sizeInfo is not an integer -->
                              size</pc> tests.</source>
                        </segment>
                     </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-slr_sizeInfo-with-sizeInfoRef.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="bad-filesize2">\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                  <slr:profiles generalProfile="xliff:codepoints"
            storageProfile="xliff:utf8">
                     <slr:normalization general="nfc" storage="nfc"/>
                  </slr:profiles>
            	  <slr:data profile="xliff:codepoints">
                     <svg:sizeData id="sir1">
                        <svg:sub_sizeData id="s2">44</svg:sub_sizeData>
                     </svg:sizeData>
                  </slr:data>
                  <group id="slr-test">\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <group id="g1" slr:storageRestriction="255"
            slr:sizeRestriction="90">
                        <unit id="u1" slr:sizeRestriction="*">
                           <segment id="seg1">
                              <source>This is a small <pc id="slr1" slr:equivStorage="7" slr:sizeRestriction="25,100">size restriction</pc> example<ec slr:sizeInfo="0" slr:sizeInfoRef="sir1" isolated="yes" id="e1" /><!-- test sizeInfo:
                                                         5.7.6.1.2\#u{20}
            											 (3) cannot be present with sizeInfoRef
            											 -->
            											 <!-- violation, would be invalid without @sizeInfoRef.--></source>
                           </segment>
                        </unit>
                     </group>
                  </group>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-slr_sizeInfoRef-ec-not-isolated.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="sizeInfo-and-sizeInfoRef">
                  <slr:profiles generalProfile="xliff:codepoints"
            storageProfile="xliff:utf8">
                     <slr:normalization general="nfc" storage="nfc"/>
                  </slr:profiles>
            	  <slr:data profile="xliff:codepoints">
                     <svg:sizeData id="sir1">
                        <svg:sub_sizeData id="s2">44</svg:sub_sizeData>
                     </svg:sizeData>
                  </slr:data>
                  <group id="mygroupsizemodule">
                     <!-- test if sizeInfoRef is:
                                                         (1) on an <ec> that is not isolated 5.7.5.10
            											 -->
                     <!-- violation: cannot have @sizeInfoRef on <ec> without @isolated -->
                     <unit id="sm1">
                        <segment id="testsize">
                         <source>Hello <sc id="s1" />size <ec startRef="s1" slr:sizeInfoRef="sir1" />tests.</source>
                        </segment>
                     </unit>
                  </group>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-slr_sizeInfoRef-has-no-data-sib.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="sizeInfo-and-sizeInfoRef">
                  <slr:profiles generalProfile="xliff:codepoints"
            storageProfile="xliff:utf8">
                     <slr:normalization general="nfc" storage="nfc"/>
                  </slr:profiles>
            	  <slr:data profile="xliff:codepoints">
                     <svg:sizeData id="sir1">
                        <svg:sub_sizeData id="s2">44</svg:sub_sizeData>
                     </svg:sizeData>
                  </slr:data>
                  <group id="mygroupsizemodule" slr:sizeInfoRef="sir2">
                     <!-- sizeInfoRef:
            (2) The reference MUST point to an element in a <data> element that is a sibling to the element this attribute is attached to or a sibling to one of its ancestors-->
                     <!-- violation: @sizeInfoRef does not point to valid <slr:data> sibling or ancestor -->
                     <unit id="sm1">
                        <segment id="testsize">
                         <source>Hello size tests.</source>
                        </segment>
                     </unit>
                  </group>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-slr_sizeInfoRef-with-sizeInfo.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="sizeInfo-and-sizeInfoRef">
                  <slr:profiles generalProfile="xliff:codepoints"
            storageProfile="xliff:utf8">
                     <slr:normalization general="nfc" storage="nfc"/>
                  </slr:profiles>
            	  <slr:data profile="xliff:codepoints">
                     <svg:sizeData id="sir1">
                        <svg:sub_sizeData id="s2">44</svg:sub_sizeData>
                     </svg:sizeData>
                  </slr:data>
                  <group id="mygroupsizemodule" slr:sizeInfo="22"
            slr:sizeInfoRef="sir1">
                     <!-- sizeInfoRef:


            											 (3) cannot be present with sizeInfo-->
                     <!-- violation: cannot have @sizeInfo and @sizeInfoRef on the same element -->
                     <unit id="sm1">
                        <segment id="testsize">
                         <source>Hello size tests.</source>
                        </segment>
                     </unit>
                  </group>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-slr_sizeRestriction-patterns.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="bad-filesize">\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                  <slr:profiles generalProfile="xliff:codepoints"
            storageProfile="xliff:utf8">
                     <slr:normalization general="nfc" storage="nfc"/>
                  </slr:profiles>
                  <group id="slr-test" slr:sizeRestriction="22">\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <group id="g1" slr:storageRestriction="255"
            slr:sizeRestriction="ninety"><!-- violation, 90 would be correct--><!-- 5.7.6.1.1 sizeRestriction
            Must be one of the following patterns:
            "*" or\#u{20}
            "0" (where 0 means integer) or\#u{20}
            "0,0" or "0,*"
            -->
                        <unit id="u1" slr:sizeRestriction="*6"><!-- violation, * would be correct -->
                           <segment>
                              <source>This is a small <pc id="slr1"
            slr:equivStorage="7" slr:sizeRestriction="25,100.5"><!-- violation 25,100 would be correct-->size restriction</pc
            > example.</source>
                           </segment>
                        </unit>
                        <unit id="u2" slr:sizeRestriction="35,star"><!-- violation, 35,* would be correct -->
                           <segment>
                              <source>With a group structure.</source>
                           </segment>
                        </unit>
                     </group>
                  </group>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-slr_storageRestriction-patterns.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="bad-filesize">\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                  <slr:profiles generalProfile="xliff:codepoints"
            storageProfile="xliff:utf8">
                     <slr:normalization general="nfc" storage="nfc"/>
                  </slr:profiles>
                  <group id="slr-test" slr:sizeRestriction="22">\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <group id="g1" slr:storageRestriction="255"
            slr:sizeRestriction="ninety"><!-- violation, 90 would be correct--><!-- 5.7.6.2.1 sizeRestriction
            Must be one of the following patterns:
            "*" or\#u{20}
            "0" (where 0 means integer) or\#u{20}
            "0,0" or "0,*"
            -->
                        <unit id="u1" slr:storageRestriction="*6"><!-- violation, * would be correct -->
                           <segment>
                              <source>This is a small <pc id="slr1"
            slr:equivStorage="7" slr:storageRestriction="25,100.5"><!-- violation 25,100 would be correct-->storage restriction</pc
            > example.</source>
                           </segment>
                        </unit>
                        <unit id="u2" slr:storageRestriction="35,star"><!-- violation, 35,* would be correct -->
                           <segment>
                              <source>With a group structure.</source>
                           </segment>
                        </unit>
                     </group>
                  </group>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-val_ExactlyOneAttributeOnRule.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="f-val-1">
                  <val:validation>
                     <val:rule/><!-- violation
                        5.8.4.3 rule
                 Exactly one of the following attributes:
                    isPresent
                    isNotPresent
                    startsWith
                    endsWith
                    a custom rule defined by attributes from any namespace

                is REQUIRED in any one <rule> element.
                        -->
                  </val:validation>
                  <unit id="1">
                     <val:validation>
                        <val:rule isNotPresent="artic" xmrk:isValid="test"/><!-- violation: only one can exist -->
                     </val:validation>
                     <segment id="s1">
                        <source></source>
                        <target></target>\#t
                     </segment>
                     <segment id="s2">
                        <source></source>
                        <target></target>\#t
                     </segment>
                  </unit>
                  <unit id="2">
                     <val:validation>
                        <val:rule isNotPresent="artic" startsWith="snow"/><!-- violation: only one can exist -->
                     </val:validation>
                     <segment id="s1">
                        <source>snow</source>
                        <target>snow</target>\#t
                     </segment>
                  </unit>
                  <unit id="3">
                     <val:validation>
                        <val:rule isNotPresent="artic" occurs="1"/><!-- valid per constraint-->
                     </val:validation>
                     <segment id="s1">
                        <source></source>
                        <target></target>\#t
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-val_existsInSourcePatternOnRule.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
            xmlns:xmrk="urn:xmarker"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
            xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
            xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
            xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
            xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
            xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.0"
            xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0"
            xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
            xmlns:xhtml="http://www.w3.org/1999/xhtml"
            xmlns:svg="http://www.w3.org/2000/svg" srcLang="en-us" version="2.0"
            trgLang="de">
            <file id="f-val-1">
                  <val:validation>
                     <val:rule  isNotPresent="artic"/>
                  </val:validation>
                  <unit id="4">
                     <val:validation>
                        <val:rule existsInSource="yes"/><!-- violation 5.8.5.6 existsInSource
                            When existsInSource is specified, exactly one of
                            isPresent
                            startsWith
                            endsWith
                        -->
                     </val:validation>
                     <segment id="s1">
                        <source>This:</source>
                        <target>Das:</target>\#t
                     </segment>
                  </unit>
                  <unit id="9">
                     <val:validation>
                        <val:rule isNotPresent="yes" existsInSource="yes"/>
                        <!--  5.8.5.6 existsInSource
                            When existsInSource is specified, exactly one of
                            isPresent
                            startsWith
                            endsWith
            \#t\#t\#t\#t
            				-->
                        <!-- violation -->
                     </val:validation>
                     <segment id="s1">
                        <source>This:</source>
                        <target>Das:</target>\#t
                     </segment>
                  </unit>\#t\#u{20}\#u{20}
                  <unit id="5">
                     <val:validation>
                        <val:rule existsInSource="yes" endsWith=":"/><!-- valid per constraint-->
                     </val:validation>
                     <segment id="s1">
                        <source>This:</source>
                        <target>Das:</target>\#t
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-val_invalid-caseSensitive.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
                   xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
                   srcLang="en-us" version="2.0">
            <file id="f1">
            	<val:validation>
            		<val:rule isPresent="test" caseSensitive="false"/>
            	</val:validation>
            	<unit id="4">
            		<segment id="s1">
            			<source>test</source>
            		</segment>
            	</unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-val_invalid-normalization.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
                   xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
                   srcLang="en-us" version="2.0">
            <file id="f1">
            	<val:validation>
            		<val:rule isPresent="test" normalization="badvalue"/>
            	</val:validation>
            	<unit id="4">
            		<segment id="s1">
            			<source>text</source>
            		</segment>
            	</unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/invalid/Bad-val_invalid-occurs.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
                   xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
                   srcLang="en-us" version="2.0">
            <file id="f1">
            	<val:validation>
            		<val:rule isPresent="test" occurs="0"/>
            	</val:validation>
            	<unit id="4">
            		<segment id="s1">
            			<source>text</source>
            		</segment>
            	</unit>
            </file>
            </xliff>
            """#
        ),
    ]
}
