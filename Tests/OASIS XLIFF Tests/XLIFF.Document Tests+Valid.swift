extension `XLIFF.Document Tests` {

    static let valid: [Fixture] = [
        Fixture(
            "core/valid/allExtensions.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr" xmlns:my="myNS" xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0" xmlns:val="urn:oasis:names:tc:xliff:validation:2.0">
             <file id="f1" my:attr="val">
              <skeleton>data<my:elem/></skeleton>
              <my:elem id="my1">data</my:elem>
              <notes>
               <note my:attr="val" id="n1">note-file</note>
              </notes>
              <group id="g123" my:attr="val" fs:fs="p">
                <notes>
                 <note id="n1" my:attr="val">note-group</note>
                </notes>
               <unit id="1" my:attr="val">
            	<my:elem>data</my:elem>
                <notes>
                 <note id="n1" my:attr="val">note-unit</note>
                </notes>
                <originalData>
                 <data id="d1">[code/]</data>
                </originalData>
                <segment>
                 <source>
            	  <ph id="1" dataRef="d1" fs:fs="b"/>
            	  <pc id="2" fs:fs="b">text</pc>
            	  <sc id="3" fs:fs="b"/>
            	   <sm id="m1" translate="yes" my:attr="val"/>
            	    text
            		<cp hex="0001"/>
            	   <ec startRef="3"/>
            	  <em startRef="m1"/>
            	  <mrk id="m2" type="my:type" my:attr="val">text</mrk>
            	 </source>
                </segment>
               </unit>
               <unit id="2" my:attr="val">
                <my:elem>data</my:elem>
                <notes>
                 <note my:attr="val">note</note>
                </notes>
                <segment>
                 <source>text<ec id='1' isolated='yes' fs:fs='b'/></source>
                 <target>texte<ec id='1' isolated='yes' fs:fs='b'/><ph id='trgOnly'/></target>
            	</segment>
               </unit>
               <unit id="3">
                <val:validation>
                 <val:rule isPresent="loja" occurs="2" />
                </val:validation>
                <segment id="1">
                 <source>Choose a store option in the online store.</source>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/almostEmpty.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <group id="g1">
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/emptySkeletonWithHref.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <skeleton href="skeleton.skl"></skeleton>
              <unit id="1">
               <segment>
                <source>source</source>
                <target>target</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/everything-core.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr" xmlns:my="myNamespace" xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0" my:attr="value1">
             <file id="f1" canResegment="no" translate="no" srcDir="rtl" trgDir="rtl" original="myfile" my:attr="value2" xml:space="preserve">
              <skeleton>
               Some non-standard data
              </skeleton>
              <mda:metadata xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0">
               <mda:metaGroup category="someCat">
                <mda:meta type="mtype1">info-mtype1</mda:meta>
                <mda:metaGroup category="subCat">
                 <mda:meta type="mtype2">info-mtype2</mda:meta>
                </mda:metaGroup>
               </mda:metaGroup>
              </mda:metadata>
              <notes>
               <note id="note1" appliesTo="source" priority="2" category="mycat" my:attr="value3">Text of note1</note>
              </notes>
              <unit id="tu1" canResegment="yes" translate="yes" srcDir="ltr" trgDir="ltr" name="unit1" type="z:typeu" my:attr="value5">
               <segment id="1" canResegment="no" state="translated" subState="my:state">
                <source>Sample segment.</source>
                <target order="3">Exemple de segment.</target>
               </segment>
               <ignorable>
                <source> </source>
               </ignorable>
               <segment id="2">
                <source xml:space="default">Segment's content.</source>
                <target xml:space="default" order="1">Contenu du segment.</target>
               </segment>
              </unit>
              <group id="g1" canResegment="yes" translate="yes" srcDir="ltr" trgDir="ltr" name="group1" type="z:typeg" my:attr="value4">
               <notes>
                <note id="note-g1" appliesTo="source" priority="2" category="mycat" my:attr="value3">Text of note-g1</note>
               </notes>
               <unit id="tu3">
                <segment id="1">
                 <source>Bolded text</source>
                </segment>
               </unit>
               <unit id="tu3end">
                <segment id="1">
                 <source>Extra stuff</source>
                </segment>
               </unit>
               <unit id="tu2">
                <originalData>
                 <data id="d1">[b [#$tu3]   ]</data>
                 <data id="d2">[/b [#t3end]   ]</data>
                 <data id="d3" dir="rtl">[rtl-data   ]</data>
                </originalData>
                <segment id="s1">
                 <source><pc id="1" subFlowsStart="tu3" subFlowsEnd="tu3end" dataRefEnd="d2" dataRefStart="d1">special text</pc> and more
            <ph id="2" canDelete="no" canReorder="firstNo" canCopy="no" dataRef="d3"/>.</source>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/nonEmptySkeletonWithoutHref.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <skeleton href="skeleton.skl"></skeleton>
              <unit id="1">
               <segment>
                <source>source</source>
                <target>target</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/sample1.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="de"
                xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0">
                <file id="f1">
                <unit id="1">
                    <gls:glossary>
                        <gls:glossEntry ref="#m1">
                            <gls:term source="publicTermbase">TAB key</gls:term>
                            <gls:translation id="1" source="myTermbase">Tabstopptaste
                            </gls:translation>
                            <gls:translation ref="t=#m2" source="myTermbase">TAB-TASTE
                            </gls:translation>
                            <gls:definition source="publicTermbase">A keyboard key that is
                                traditionally used to insert tab characters into a document.
                            </gls:definition>
                        </gls:glossEntry>
                    </gls:glossary>
                    <segment>
                        <source>Press the <mrk id="m1" type="term">TAB key</mrk>.
                        </source>
                        <target>Drücken Sie die <mrk id="m2" type="term">TAB-TASTE</mrk>.
                        </target>
                    </segment>
                </unit>
                </file>
            \#u{20}\#u{20}\#u{20}\#u{20}
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/sourceOnly.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment id="s1">
                <source>source</source>
               </segment>
               <ignorable>
                <source> </source>
               </ignorable>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/testTranslateWithTarget.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1" translate="no">
               <segment id="s1">
                <source>Sentence 1.</source>
                <target>Sentence 1.</target>
               </segment>
               <ignorable>
                <source> <sm id='m1' translate='yes'/></source>
                <target order="4"> <sm id='m1' translate='yes'/></target>
               </ignorable>
               <segment id="s2">
                <source>Sentence 2.</source>
                <target order="5">Phrase 2-3.</target>
               </segment>
               <ignorable>
                <source> <sm id='m2' translate='no'/></source>
                <target order="2"> <sm id='m2' translate='no'/></target>
               </ignorable>
               <segment id="s3">
                <source>Sentence 3.<em startRef='m2'/></source>
                <target order="3">Sentence 3.<em startRef='m2'/></target>
               </segment>
               <ignorable>
                <source><em startRef='m1'/></source>
                <target><em startRef='m1'/></target>
               </ignorable>
              </unit>
              <group id='g1' translate="yes">
               <unit id='2'>
                <segment>
                 <source>t1 <sm id='1' translate='no'/>t2 <sm id='2' translate='yes'/></source>
                 <target>t1 <sm id='1' translate='no'/>t2 <sm id='2' translate='yes'/></target>
                </segment>
                <segment>
                 <source>t3 <em startRef='2'/>t4 </source>
                 <target>t3 <em startRef='2'/>t4 </target>
                </segment>
                <segment>
                 <source><em startRef='1'/>t5</source>
                 <target><em startRef='1'/>t5</target>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/toJoin.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment id="s1" state="translated" subState="my:value1">
                <source><sc id='1'/>Sentence 1.</source>
                <target><sc id='1'/>Phrase 1.</target>
               </segment>
               <ignorable>
                <source> </source>
               </ignorable>
               <segment id="s2" state="translated" subState="my:value2">
                <source xml:space="preserve">Sentence [  ] 2.<ec startRef='1'/> </source>
                <target xml:space="preserve">Phrase [  ] 2.<ec startRef='1'/> </target>
               </segment>
               <ignorable>
                <source> </source>
               </ignorable>
               <segment id="s3" state="final">
                <source xml:space="preserve">Sentence 3. </source>
                <target xml:space="preserve">sentence 3. </target>
               </segment>
               <segment id="s4" canResegment="no">
                <source>Sentence 4.</source>
                <target>Phrase 4.</target>
               </segment>
               <ignorable>
                <source> </source>
               </ignorable>
               <segment id="s5">
                <source>Sentence 5.</source>
                <target>Phrase 5.</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/toSegment.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment id="s1" state="initial" subState="my:value">
                <source>Sentence 1. Sentence 2. Sentence 3. Sentence 4.</source>
               </segment>
               <ignorable>
                <source> </source>
               </ignorable>
               <segment id="s2">
                <source xml:space="preserve">Sentence [  ] 5. Sentence [  ] 6. </source>
                <target xml:space="preserve">Phrase [  ] 5. Phrase [  ] 6. </target>
               </segment>
               <segment id="s3" canResegment="no">
                <source>Sentence 7. Sentence 8.</source>
               </segment>
               <ignorable>
                <source> </source>
               </ignorable>
               <segment id="s4">
                <source><pc id='1'>Sentence 9. Sentence 10</pc>.</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/toSegmentAndOrder.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment id="s1">
                <source>Sentence 1-t7. Sentence 2-t8.</source>
                <target order="6">Phrase 1-t7. Phrase 2-t8.</target>
               </segment>
               <ignorable>
                <source> </source>
                <target></target>
               </ignorable>
               <segment id="s2">
                <source>Sentence 3-t1. Sentence 4-t2. </source>
                <target order="1">Phrase 3-t1. Phrase 4-t2. </target>
               </segment>
               <segment id="s3">
                <source>Sentence 5-t5. Sentence 6-t6.</source>
               </segment>
               <ignorable>
                <source> </source>
               </ignorable>
               <segment id="s4">
                <source>Sentence 7-t3. Sentence 8-t4.</source>
                <target order="3">Phrase 7-t3. Phrase 8-t4. </target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/typeSubTypeValues.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source>
            	 <ph id="1" type="ui" subType="xlf:var"/>
            	 <ph id="2" type="fmt" subType="xlf:lb"/>
            	 <ph id="3" type="fmt" subType="xlf:pb"/>
            	 <ph id="4" type="fmt" subType="xlf:b"/>
            	 <ph id="5" type="fmt" subType="xlf:i"/>
            	 <ph id="6" type="fmt" subType="xlf:u"/>
            	 <ph id="7" type="quote" subType="abc:ref"/>
            	 <ph id="8" type="link" subType="xyz:toHTML"/>
            	</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/withCDataSections.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment id="s1">
                <source>source<![CDATA[ & and < etc.]]></source>
                <target>target<![CDATA[ & and < etc.]]></target>
               </segment>
               <ignorable>
                <source> <![CDATA[ & and < etc.]]></source>
                <target> <![CDATA[ & and < etc.]]></target>
               </ignorable>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/withCommentAnnotations.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <notes>
                <note id='n1'>note</note>
               </notes>
               <segment id="1">
                <source>
            	 <mrk id="2" type="comment" value="the comment">text</mrk>
            	 <mrk id="3" type="comment" ref="#n=n1">text</mrk>
            	</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/withGlossary.xlf",
            byteOrderMark: true,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr"
             xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0">
             <file id="f1">
              <unit id="1">
               <gls:glossary>
                <gls:glossEntry id="g1" ref="#m1" xmlns:my="myNamespace" my:attr1="value1">
                 <gls:term source="term-source" my:attr2="value2">doppelgänger</gls:term>
                 <gls:translation id="trans1" ref="#t=m3" source="trans1-source" my:attr3="value3">double</gls:translation>
                 <gls:translation id="trans2" ref="#m2" source="trans2-source" my:attr4="value4">alter-ego</gls:translation>
                 <gls:definition source="dictionary.com">A ghostly double or counterpart of a living person.</gls:definition>
                 <my:elem attr1="value1"/>
                </gls:glossEntry>
               </gls:glossary>
               <segment>
                <source>He is my <mrk id="m1" type="term">doppelgänger</mrk>. </source>
                <target>Il est mon <mrk id="m1" type="term">alter ego</mrk>. </target>
               </segment>
               <segment> <!-- using different references (on purpose: trans2 refers to the source (it is allowed))-->
                <source>Another <mrk id="m2" type="term">doppelgänger</mrk>.</source>
                <target>Un autre <mrk id="m3" type="term">double</mrk>.</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/withMatches.xlf",
            byteOrderMark: true,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr"
             xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0">
             <file id="f1">
              <unit id="1">
               <mtc:matches xmlns:xlf="urn:oasis:names:tc:xliff:document:2.0">
                <mtc:match id="1" ref="#m1">
                 <metadata xmlns="urn:oasis:names:tc:xliff:metadata:2.0" >
                  <metaGroup>
                   <meta type="mytype">data</meta>
                  </metaGroup>
                 </metadata>
                 <xlf:originalData>
                  <xlf:data id="d1">[code]</xlf:data>
                 </xlf:originalData>
                 <xlf:source><xlf:ph id='1' dataRef='d1'/>Text</xlf:source>
                 <xlf:target><xlf:ph id='1' dataRef='d1'/>Texte</xlf:target>
                 <my:element xmlns:my="myNs">data</my:element>
                </mtc:match>
                <mtc:match id="2" ref="#t=m2"> <!-- Refers to a target (unlikely but allowed) -->
                 <xlf:source>Text2</xlf:source>
                 <xlf:target>Texte2</xlf:target>
                </mtc:match>
               </mtc:matches>
               <segment>
                <source><mrk id="m1" type="mtc:match">Text</mrk></source>
                <target><mrk id="m2" type="some:annotation">Texte2</mrk></target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/withModulesAttributesInEc.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en"
             xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0">
             <file id="f1">
              <unit id="1" xmlns:slr="urn:oasis:names:tc:xliff:sizerestriction:2.0">
               <segment>
                <source><sc id='1' fs:fs="b" slr:sizeInfo="some info"/>text </source>
               </segment>
               <segment>
                <source><ec isolated='yes' id='2' fs:fs="b" slr:sizeInfo="some info"/>text<ec startRef='1'/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/withNotes.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <notes>
               <note>note for file</note>
              </notes>
              <group id='g1'>
               <notes>
                <note>note for group</note>
               </notes>
               <unit id="1">
                <notes>
                 <note>note for unit</note>
                </notes>
                <segment id="s1">
                 <source><sc id='1' isolated='yes'/>Sentence 1.</source>
                 <target><sc id='1' isolated='yes'/>Phrase 1.</target>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/withNotes_complex.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <notes>
               <note id="1">note for file</note>
               <note id="7" priority="1">another highest priority note for file</note>
               <note id="2" appliesTo="source">note for all source content within file</note>
               <note id="3" appliesTo="target">note for all target content within file</note>
               <note id="4" priority="2">lower priority note for file</note>
               <note id="5" priority="3" appliesTo="source">lower priority note for all source content within file</note>
               <note id="6" appliesTo="target" priority="3">lower priority note for all target content within file</note>
               <note id="8" priority="10">lowest priority note for file</note>
              </notes>
              <group id='g1'>
               <notes>
                <note id="1">note for group</note>
                <note id="7" priority="1">another highest priority note for group</note>
                <note id="2" appliesTo="source">note for all source content within group</note>
                <note id="3" appliesTo="target">note for all target content within group</note>
                <note id="4" priority="2">lower priority note for group</note>
                <note id="5" priority="3" appliesTo="source">lower priority note for all source content within group</note>
                <note id="6" appliesTo="target" priority="3">lower priority note for all target content within group</note>
                <note id="8" priority="10">lowest priority note for group</note>
               </notes>
               <unit id="1">
                <notes>
                 <note id="1">note for unit</note>
                 <note id="7" priority="1">another highest priority note for unit</note>
                 <note id="2" appliesTo="source">note for all source content within unit</note>
                 <note id="3" appliesTo="target">note for all target content within unit</note>
                 <note id="4" priority="2">lower priority note for unit</note>
                 <note id="5" priority="3" appliesTo="source">lower priority note for all source content within unit</note>
                 <note id="6" appliesTo="target" priority="3">lower priority note for all target content within unit</note>
                 <note id="8" priority="10">lowest priority note for unit</note>
                 <note id="9" >note content for the inline comment delimited with &lt;mrk id="3"></note>
                 <note id="10" priority="7">lower priority note content for the inline comment delimited with &lt;mrk id="5"></note>
                </notes>
                <segment id="s1">
                 <source><mrk id="5" type="comment" ref="#n=10"><sc id='1' isolated='yes'/>Sentence 1.</mrk></source>
                 <target><sc id='1' isolated='yes'/>Phrase 1.</target>
                </segment>
                <segment id="s2">
                 <source><mrk id="3" type="comment" ref="#n=9"><sc id='2' isolated='yes'/>Sentence 2.</mrk></source>
                 <target><mrk id="4" type="comment" value="an inline comment applying just to the delimited target span"><sc id='2' isolated='yes'/>Phrase 2.</mrk></target>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/withReferences.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1" xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0">
              <res:resourceData>
               <res:resourceItem id="r1" mimeType="text/xml" context="no">
                <res:source href="resources\en\registryconfig.resources.xml" />
                <res:target href="resources\fr\registryconfig.resources.xml" />
               </res:resourceItem>
              </res:resourceData>
             <notes>
               <note id="globalNote1">note for file (f1)</note>
              </notes>
              <unit id="u1">
               <segment>
                <source>First segment</source>
               </segment>
              </unit>
              <unit id="2" name="130;WIN_DLG_CTRL_">
               <res:resourceData>
                <res:resourceItemRef ref="r1" />
               </res:resourceData>
               <segment id="1" state="translated">
                <source><mrk id="m1" type="my:resource" ref="#f=f1/res=r1">Load Registry Config</mrk></source>
                <target>Chargement du registre de configuration</target>
               </segment>
              </unit>
             </file>
             <file id="f2">
              <notes>
               <note id="n1">note for file (f2)</note>
              </notes>
              <group id="g1">
               <notes>
                <note id="n1">note for group</note>
               </notes>
               <unit id="u1">
                <notes>
                 <note id="n1">note for unit</note>
                </notes>
                <segment id="s1">
                 <source><mrk id='m1' type="comment" ref="#n=n1"><mrk id='m2' type="term" ref="http://en.wikipedia.org/wiki/Comment"><mrk id='m3' type="comment" ref="#f=f2/u=u1/n=n1">Sentence 1.</mrk></mrk></mrk></source>
                 <target><mrk id='m4' type="comment" ref="#n=n1"><mrk id='m5' type="xyz:comment" ref="myFile.xml#f=1/n=n1"><mrk id='m6' type='xyz:comment' ref="someFile.xml#id1">Phrase 1.</mrk></mrk></mrk></target>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/withReorderedCodes.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
            \#u{20}
              <unit id="1">
               <segment>
                <source>
            	 <pc id="1" canReorder="firstNo" canDelete="no" canCopy="no">
            	  text
            	  <ph id="2" canReorder="no" canDelete="no" canCopy="no"/>
            	 </pc>
            	 <ph id="3"/>
                </source>
                <target>
            	 <ph id="3"/>
            	 <pc id="1" canReorder="firstNo" canDelete="no" canCopy="no">
            	  text
            	  <ph id="2" canReorder="no" canDelete="no" canCopy="no"/>
            	 </pc>
            	</target>
               </segment>
              </unit>
            \#u{20}
              <unit id="2">
               <segment>
                <source>
            	 <pc id="1" canReorder="firstNo" canDelete="no" canCopy="no">
            	  text
            	  <ph id="2" canReorder="no" canDelete="no" canCopy="no"/>
            	 </pc>
            	 <ph id="3"/>
                </source>
                <target>
            	 <pc id="1" canReorder="firstNo" canDelete="no" canCopy="no">
            	  <mrk id="m1" type="term">text</mrk>
            	  <ph id="2" canReorder="no" canDelete="no" canCopy="no"/>
            	 </pc>
            	</target>
               </segment>
              </unit>
            \#u{20}\#u{20}
              <unit id="3"> <!-- Two sequences are swapped -->
               <segment>
                <source>
            	 <ph id="1" canReorder="firstNo" canDelete="no" canCopy="no"/>
            	 <ph id="2" canReorder="no" canDelete="no" canCopy="no"/>
            	 <ph id="c1"/>
            	 </source>
                <target order="3">
            	 <ph id="1" canReorder="firstNo" canDelete="no" canCopy="no"/>
            	 <ph id="2" canReorder="no" canDelete="no" canCopy="no"/>
            	</target>
               </segment>
               <segment>
                <source>
            	 <ph id="extra"/>
            	 </source>
                <target>
            	 <ph id="extra"/>
            	</target>
               </segment>
               <segment>
                <source>
            	 <ph id="3" canReorder="firstNo" canDelete="no" canCopy="no"/>
            	 <ph id="4" canReorder="no" canDelete="no" canCopy="no"/>
            	 </source>
                <target order="1">
            	 <ph id="3" canReorder="firstNo" canDelete="no" canCopy="no"/>
            	 <ph id="4" canReorder="no" canDelete="no" canCopy="no"/>
            	</target>
               </segment>
              </unit>
            \#u{20}\#u{20}
              <unit id="4"> <!-- Two sequences are moved side by side -->
               <segment>
                <source>
            	 <ph id="1" canReorder="firstNo" canDelete="no" canCopy="no"/>
            	 <ph id="2" canReorder="no" canDelete="no" canCopy="no"/>
            	 <ph id="c1"/>
            	 </source>
                <target>
            	 <ph id="1" canReorder="firstNo" canDelete="no" canCopy="no"/>
            	 <ph id="2" canReorder="no" canDelete="no" canCopy="no"/>
            	</target>
               </segment>
               <segment>
                <source>
            	 <ph id="extra"/>
            	 </source>
                <target order="3">
            	 <ph id="extra"/>
            	</target>
               </segment>
               <segment>
                <source>
            	 <ph id="3" canReorder="firstNo" canDelete="no" canCopy="no"/>
            	 <ph id="4" canReorder="no" canDelete="no" canCopy="no"/>
            	 </source>
                <target order="2">
            	 <ph id="3" canReorder="firstNo" canDelete="no" canCopy="no"/>
            	 <ph id="4" canReorder="no" canDelete="no" canCopy="no"/>
            	</target>
               </segment>
              </unit>
            \#u{20}
              <unit id="5">
               <segment>
                <source>
            	 <ph id="c1" canReorder="firstNo" canDelete="no" canCopy="no"/>
            	 <ph id="c2" canReorder="no" canDelete="no" canCopy="no"/>
            	 <ph id="c3" canReorder="firstNo" canDelete="no" canCopy="no"/>
            	 <ph id="c4" canReorder="no" canDelete="no" canCopy="no"/>
            	 <ph id="c5"/>
            	 </source>
                <target>
            	 <ph id="c1" canReorder="firstNo" canDelete="no" canCopy="no"/>
            	 <ph id="c2" canReorder="no" canDelete="no" canCopy="no"/>
            	 <ph id="c5"/>
            	 <ph id="c3" canReorder="firstNo" canDelete="no" canCopy="no"/>
            	 <ph id="c4" canReorder="no" canDelete="no" canCopy="no"/>
            	</target>
               </segment>
              </unit>

              </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/withTBXExtension.xlf",
            byteOrderMark: true,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="pt"
             xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0">
             <file id="f1">
              <martif type="TBX" xml:lang="en" xmlns="urn:iso:std:iso:30042:ed-1:v1:en">
               <martifHeader>
                <fileDesc>
                 <sourceDesc>
                  <p>From the TaaS Terminology Annotation Service</p>
                 </sourceDesc>
                 </fileDesc>
                 <encodingDesc>
                  <p type="XCSURI">http://www.ttt.org/oscarstandards/tbx/TBXXCS.xcs</p>
                 </encodingDesc>
                </martifHeader>
                <text>
                 <body>
                  <termEntry xml:id="tbx44">
                   <descrip type="subjectField">TaaS-1001</descrip>
                   <langSet xml:lang="en">
                    <ntig>
                     <termGrp>
                      <term>sustainable agriculture</term>
                      <termNote type="termExtractionScore">0.31</termNote>
                      <termNote type="MSD">JJ NN</termNote>
                      <termCompList type="lemma">
                       <termCompGrp>
                        <termComp>sustainable</termComp>
                        <termNote type="partOfSpeech">adjective</termNote>
                       </termCompGrp>
                       <termCompGrp>
                        <termComp>agriculture</termComp>
                        <termNote type="partOfSpeech">noun</termNote>
                        <termNote type="grammaticalNumber">singular</termNote>
                       </termCompGrp>
                      </termCompList>
                     </termGrp>
                    <transacGrp>
                     <transac type="transactionType">origination</transac>
                     <transacNote type="responsibility">Manual example</transacNote>
                     <date>2013-12-23</date>
                    </transacGrp>
                    <xref target="http://taas.eurotermbank.com/extractor" type="xSource" />
                    <descripGrp>
                     <descrip type="context">growing support for<hi>sustainable agriculture</hi></descrip>
                     <admin target="07d2dbae-31d3-4c67-9bdf-3cd8498a8356.output.step1.completed" type="sourceIdentifier" />
                    </descripGrp>
                    <xref target="http://www.eurotermbank.com/Collection.aspx?collectionid=301" type="xSource">Europos žodynas</xref>
                   </ntig>
                  </langSet>
                 </termEntry>
                </body>
               </text>
              </martif>
              <unit id="1">
               <segment>
                <source>There is growing support for <mrk id="t1" ref="#f=f1/tbx=tbx44" type="term">sustainable agriculture</mrk>.</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/withValidation.xlf",
            byteOrderMark: true,
            #"""
            <xliff xmlns='urn:oasis:names:tc:xliff:document:2.0' version='2.0' srcLang='en' trgLang='pt'
             xmlns:val='urn:oasis:names:tc:xliff:validation:2.0'>
             <file id='1'>
              <val:validation>
               <val:rule isPresent="store" />
              </val:validation>
              <unit id="1">
               <segment id="1">
                <source>Choose an option in the online store:</source>
                <target>Escolha uma opção na loja online:</target>
               </segment>
              </unit>
              <unit id="2">
               <val:validation>
                <val:rule isPresent="store" disabled="yes" />
               </val:validation>
               <segment id="1">
                <source>Choose an option in the application store:</source>
                <target>Escolha uma opção na application store:</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/withXmlLang.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr" xml:lang="ru">
             <file id="f1" xml:lang="ja">
              <unit id="1" xml:lang="en">
               <segment>
                <source>source</source>
                <target xml:lang="fr">target</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/valid/withXmlSpace.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1" xml:space="preserve">
              <unit id="1">
               <segment>
                <source xml:space="preserve">source</source>
                <target>target</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/in-out/toJoin1_in.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment id="s1" state="reviewed" subState="my:info">
                <source><sm id="m1" type="comment" value="My comment"/><sc id="1" type="fmt"/>Sentence 1.</source>
                <target>Phrase 1.</target>
               </segment>
               <ignorable>
                <source> </source>
                <target> </target>
               </ignorable>
               <segment id="s2">
                <source>Sentence 2.<ec startRef="1"/><em startRef="m1"/></source>
                <target>Phrase 2.</target>
               </segment>
              </unit>
              <unit id="2">
               <segment id="s1" canResegment="no">
                <source>Sentence 1. </source>
                <target>Phrase 1. </target>
               </segment>
               <segment id="s2" canResegment="no">
                <source>Sentence 2.</source>
                <target>Phrase 2.</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/in-out/toJoin1_out.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
            <file id="f1">
            <unit id="1">
            <segment id="s1">
            <source><mrk id="m1" type="comment" value="My comment"><pc id="1" canOverlap="yes" type="fmt">Sentence 1. Sentence 2.</pc></mrk></source>
            <target>Phrase 1. Phrase 2.</target>
            </segment>
            </unit>
            <unit id="2">
            <segment id="s1" canResegment="no">
            <source>Sentence 1. </source>
            <target>Phrase 1. </target>
            </segment>
            <segment id="s2" canResegment="no">
            <source>Sentence 2.</source>
            <target>Phrase 2.</target>
            </segment>
            </unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/in-out/toJoin2_in.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
            <file id="f1">
            <unit id="1">
            <segment id="s1" state="translated" subState="my:value1">
            <source><sc id="1"/>Sentence 1.</source>
            <target><sc id="1"/>Phrase 1.</target>
            </segment>
            <ignorable>
            <source> </source>
            </ignorable>
            <segment id="s2" state="translated" subState="my:value2">
            <source xml:space="preserve">Sentence [  ] 2.<ec startRef="1"/> </source>
            <target xml:space="preserve">Phrase [  ] 2.<ec startRef="1"/> </target>
            </segment>
            <ignorable>
            <source> </source>
            </ignorable>
            <segment id="s3" state="final">
            <source xml:space="preserve">Sentence 3. </source>
            <target xml:space="preserve">sentence 3. </target>
            </segment>
            <segment id="s4" canResegment="no">
            <source>Sentence 4.</source>
            <target>Phrase 4.</target>
            </segment>
            <ignorable>
            <source> </source>
            </ignorable>
            <segment id="s5">
            <source>Sentence 5.</source>
            <target>Phrase 5.</target>
            </segment>
            </unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/in-out/toJoin2_out.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
            <file id="f1">
            <unit id="1">
            <segment id="s1" state="translated" subState="my:value1">
            <source xml:space="preserve"><pc id="1" canOverlap="yes">Sentence 1. Sentence [  ] 2.</pc>  Sentence 3. </source>
            <target xml:space="preserve"><pc id="1" canOverlap="yes">Phrase 1.Phrase [  ] 2.</pc> sentence 3. </target>
            </segment>
            <segment id="s4" canResegment="no">
            <source>Sentence 4.</source>
            <target>Phrase 4.</target>
            </segment>
            <ignorable>
            <source> </source>
            </ignorable>
            <segment id="s5">
            <source>Sentence 5.</source>
            <target>Phrase 5.</target>
            </segment>
            </unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/in-out/toJoin3_in.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment id="s1" state="translated" subState="my:value1">
                <source><sc id='1'/>a1 </source>
                <target><sc id='1'/>a1 </target>
               </segment>
               <segment id="s2" state="translated" subState="my:value2">
                <source xml:space="preserve">b2[  ] <ec startRef='1'/> </source>
                <target order="3" xml:space="preserve">B3[  ] <ec startRef='1'/> </target>
               </segment>
               <segment id="s3" state="translated">
                <source xml:space="preserve">c3 </source>
                <target order="2" xml:space="preserve">C2 </target>
               </segment>
               <segment id="s4" state="translated">
                <source>d4.</source>
                <target>D4.</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/in-out/toJoin3_out.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
            <file id="f1">
            <unit id="1">
            <segment id="s1" state="translated" subState="my:value1">
            <source xml:space="preserve"><pc id="1" canOverlap="yes">a1 c3 b2[  ] </pc> d4.</source>
            <target xml:space="preserve"><pc id="1" canOverlap="yes">a1 C2 B3[  ] </pc> D4.</target>
            </segment>
            </unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/in-out/toJoin4_in.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment id="s1" state="translated" subState="my:value1">
                <source><sc id='1'/>a1 </source>
                <target><sc id='1'/>a1 </target>
               </segment>
               <segment id="s2" state="translated" subState="my:value2">
                <source xml:space="preserve">b2[  ] <ec startRef='1'/> </source>
                <target order="3" xml:space="preserve">B3[  ] <ec startRef='1'/> </target>
               </segment>
               <segment id="s3" state="translated">
                <source xml:space="preserve">c3 </source>
                <target order="2" xml:space="preserve">C2 </target>
               </segment>
               <segment id="s4" state="translated" canResegment="no">
                <source>d4 </source>
                <target>D4 </target>
               </segment>
               <segment id="s5" state="final">
                <source>e5 </source>
                <target order="6">E5 </target>
               </segment>
               <segment id="s6" state="reviewed">
                <source>f6 </source>
                <target order="5">F6 </target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/in-out/toJoin4_out.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
            <file id="f1">
            <unit id="1">
            <segment id="s1" state="translated" subState="my:value1">
            <source xml:space="preserve"><pc id="1" canOverlap="yes">a1 c3 b2[  ] </pc> </source>
            <target xml:space="preserve"><pc id="1" canOverlap="yes">a1 C2 B3[  ] </pc> </target>
            </segment>
            <segment id="s4" canResegment="no" state="translated">
            <source>d4 </source>
            <target>D4 </target>
            </segment>
            <segment id="s6" state="reviewed">
            <source>f6 e5 </source>
            <target order="3">F6 E5 </target>
            </segment>
            </unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/in-out/toRemoveAnnotations_in.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <notes>
                <note id="n1">text of note n1</note>
               </notes>
               <segment id="s1">
                <source><mrk id="m1" type="comment" value="the comment">text <sm id="m2" type="comment" ref="#n=n1"/>part 1;</mrk></source>
                <target><mrk id="m1" type="comment" value="the comment">texte <sm id="m2" type="comment" ref="#n=n1"/>partie 1;</mrk></target>
               </segment>
               <ignorable>
                <source> </source>
               </ignorable>
               <segment id="s2">
                <source>and part2.<em startRef="m2"/></source>
                <target>et partie 2.<em startRef="m2"/></target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/in-out/toRemoveAnnotations_out.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
            <file id="f1">
            <unit id="1">
            <notes>
            <note id="n1">text of note n1</note>
            </notes>
            <segment id="s1">
            <source>text part 1;</source>
            <target>texte partie 1;</target>
            </segment>
            <ignorable>
            <source> </source>
            </ignorable>
            <segment id="s2">
            <source>and part2.</source>
            <target>et partie 2.</target>
            </segment>
            </unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/in-out/toRemoveExtensions_in.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr"
             xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
             xmlns:my="privateNamespace"
             my:attr1="value1">
             <file id="f1" my:attr2="value2">
              <unit id="1" my:attr3="value3" fs:fs="p">
               <my:elem1>
                <my:item>data1</my:item>
                <my:item>data2</my:item>
               </my:elem1>
               <segment id="s1">
                <source><mrk id="m1" type="my:info" value="some info" fs:fs="u">text <sm id="m2" type="my:info" value="more info" fs:fs="b"/>part 1;</mrk></source>
                <target><mrk id="m1" type="my:info" value="source target info" fs:fs="u">texte <sm id="m2" type="my:info" value="more target info" fs:fs="b"/>partie 1;</mrk></target>
               </segment>
               <ignorable>
                <source> </source>
               </ignorable>
               <segment id="s2">
                <source>and part 2.<em startRef="m2"/></source>
                <target>et partie 2.<em startRef="m2"/></target>
               </segment>
              </unit>
              <unit id="2" my:attr3="value3" fs:fs="p">
               <segment id="s1">
                <source><pc id="1" fs:fs="u">text <sc id="2" fs:fs="b"/>part 1;</pc> </source>
                <target><pc id="1" fs:fs="u">texte <sc id="2" fs:fs="b"/>partie 1;</pc> </target>
               </segment>
               <segment id="s2">
                <source>and part 2.<ec startRef="2"/></source>
                <target>et partie 2.<ec startRef="2"/></target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/in-out/toRemoveExtensions_out.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr" xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0" xmlns:my="privateNamespace" my:attr1="value1">
            <file id="f1" my:attr2="value2">
            <unit id="1" my:attr3="value3" fs:fs="p">
            <my:elem1>
                <my:item>data1</my:item>
                <my:item>data2</my:item>
               </my:elem1>
            <segment id="s1">
            <source>text part 1;</source>
            <target>texte partie 1;</target>
            </segment>
            <ignorable>
            <source> </source>
            </ignorable>
            <segment id="s2">
            <source>and part 2.</source>
            <target>et partie 2.</target>
            </segment>
            </unit>
            <unit id="2" my:attr3="value3" fs:fs="p">
            <segment id="s1">
            <source><sc id="1" canOverlap="no" fs:fs="u"/>text <sc id="2" fs:fs="b"/>part 1;<ec startRef="1" canOverlap="no"/> </source>
            <target><sc id="1" canOverlap="no" fs:fs="u"/>texte <sc id="2" fs:fs="b"/>partie 1;<ec startRef="1" canOverlap="no"/> </target>
            </segment>
            <segment id="s2">
            <source>and part 2.<ec startRef="2"/></source>
            <target>et partie 2.<ec startRef="2"/></target>
            </segment>
            </unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/in-out/toRewrite1_in.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment id="s1">
                <source xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"><pc id="1" fs:fs="b">text</pc></source>
                <target xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"><pc id="1" fs:fs="b">texte</pc></target>
               </segment>
              </unit>
              <unit id="2">
               <validation xmlns="urn:oasis:names:tc:xliff:validation:2.0">
                <rule isPresent="en-ligne" />
               </validation>
               <segment id="1">
                <source>Choose an option in the online store.</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/in-out/toRewrite1_out.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
            <file id="f1">
            <unit id="1">
            <segment id="s1">
            <source><pc id="1" xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0" fs:fs="b">text</pc></source>
            <target><pc id="1" xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0" fs:fs="b">texte</pc></target>
            </segment>
            </unit>
            <unit id="2">
            <validation xmlns="urn:oasis:names:tc:xliff:validation:2.0">
                <rule isPresent="en-ligne"></rule>
               </validation>
            <segment id="1">
            <source>Choose an option in the online store.</source>
            </segment>
            </unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/in-out/toRewrite2_in.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr" xmlns:my="myNS" xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0" my:attr="val-in-xliff">
             <file id="f1" my:attr="val-in-file">
              <skeleton>
               <skl:elem xmlns:skl="mySkeletonNS" attr="value">some data</skl:elem>
               Some text-based data
               <?myPI info="data1"?>
              </skeleton>
              <my:elem id="my1" xml:space="preserve">data [   ]</my:elem>
              <?myPI info="data2"?>
              <notes>
               <note id="n1" my:attr="val-in-note">note-file</note>
              </notes>
              <group id="g123" my:attr="val-in-group" fs:fs="p">
               <?myPI info="data3"?>
               <notes>
                <note id="n1" my:attr="val-in-note">note-group</note>
               </notes>
               <unit id="1" my:attr="val-in-unit">
            	<my:elem>data</my:elem>
                <?myPI info="data4"?>
                <notes>
                 <note id="n1" my:attr="val-in-note">note-unit</note>
                </notes>
                <originalData>
                 <data id="d1">[code [   ]]</data>
                </originalData>
                <segment>
                 <source>
            	  <ph id="1" dataRef="d1" fs:fs="b"/>
            	  <pc id="2" fs:fs="b">text</pc>
            	  <sc id="3" fs:fs="b"/>
            	   <sm id="m1" translate="yes" my:attr="val"/>
            	    text
            		<cp hex="0001"/>
            	   <ec startRef="3"/>
            	  <em startRef="m1"/>
            	  <mrk id="m2" type="my:type" my:attr="val-in-mrk">text</mrk>
            	 </source>
                </segment>
               </unit>
               <unit id="2" my:attr="val-in-unit" xml:space="preserve">
                <my:elem>data [   ]</my:elem>
                <notes>
                 <note my:attr="val-in-note">note</note>
                </notes>
                <segment>
                 <source>text<ec id="1" isolated="yes" fs:fs="b"/>[   ]</source>
                 <target>texte<ec id="1" isolated="yes" fs:fs="b"/>[   ]<ph id="trgOnly"/></target>
            	</segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/in-out/toRewrite2_out.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr" xmlns:my="myNS" xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0" my:attr="val-in-xliff">
            <file id="f1" my:attr="val-in-file">
            <skeleton>
               <skl:elem xmlns:skl="mySkeletonNS" attr="value">some data</skl:elem>
               Some text-based data
               <?myPI info="data1"?>
              </skeleton>
            <my:elem id="my1" xml:space="preserve">data [   ]</my:elem>
            <notes>
            <note id="n1" my:attr="val-in-note">note-file</note>
            </notes>
            <group id="g123" my:attr="val-in-group" fs:fs="p">
            <notes>
            <note id="n1" my:attr="val-in-note">note-group</note>
            </notes>
            <unit id="1" my:attr="val-in-unit">
            <my:elem>data</my:elem>
            <notes>
            <note id="n1" my:attr="val-in-note">note-unit</note>
            </notes>
            <originalData>
            <data id="d1">[code [   ]]</data>
            </originalData>
            <segment>
            <source>
            	  <ph id="1" dataRef="d1" fs:fs="b"/>
            	  <pc id="2" fs:fs="b">text</pc>
            	  <sc id="3" fs:fs="b"/>
            	   <sm id="m1" translate="yes" my:attr="val"/>
            	    text
            		<cp hex="0001"/>
            	   <ec startRef="3"/>
            	  <em startRef="m1"/>
            	  <mrk id="m2" type="my:type" my:attr="val-in-mrk">text</mrk>
            	 </source>
            </segment>
            </unit>
            <unit id="2" my:attr="val-in-unit" xml:space="preserve">
            <my:elem>data [   ]</my:elem>
            <notes>
            <note my:attr="val-in-note">note</note>
            </notes>
            <segment>
            <source xml:space="preserve">text<ec id="1" isolated="yes" fs:fs="b"/>[   ]</source>
            <target xml:space="preserve">texte<ec id="1" isolated="yes" fs:fs="b"/>[   ]<ph id="trgOnly"/></target>
            </segment>
            </unit>
            </group>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/in-out/toSegment1_in.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <originalData>
                <data id="d1">[b]</data>
            	<data id="d2">[/b]</data>
               </originalData>
               <segment id="s1" state="initial" subState="my:value">
                <source>Sentence 1. <mrk id="1" type="comment" value="my comment">Sentence 2. Sentence 3.</mrk> Sentence 4.</source>
               </segment>
               <ignorable>
                <source> </source>
               </ignorable>
               <segment id="s2" state="reviewed">
                <source xml:space="preserve">Sentence  5. Sentence  6. </source>
                <target xml:space="preserve">Phrase  5. Phrase  6. </target>
               </segment>
               <segment id="s3" canResegment="no">
                <source>Sentence 7. Sentence 8.</source>
               </segment>
               <ignorable>
                <source> </source>
               </ignorable>
               <segment id="s4">
                <source><pc id="2" type="fmt" subType="xlf:b" dataRefStart="d1" dataRefEnd="d2">Sentence 9. Sentence 10</pc>.</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/in-out/toSegment1_out.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
            <file id="f1">
            <unit id="1">
            <originalData>
            <data id="d1">[b]</data>
            <data id="d2">[/b]</data>
            </originalData>
            <segment id="s1" state="initial" subState="my:value">
            <source>Sentence 1. </source>
            </segment>
            <segment id="s5" state="initial" subState="my:value">
            <source><sm id="1" type="comment" value="my comment"/>Sentence 2. </source>
            </segment>
            <segment id="s6" state="initial" subState="my:value">
            <source>Sentence 3.<em startRef="1"/> Sentence 4.</source>
            </segment>
            <ignorable>
            <source> </source>
            </ignorable>
            <segment id="s2" state="translated">
            <source xml:space="preserve">Sentence  5. </source>
            <target xml:space="preserve">Phrase  5. </target>
            </segment>
            <segment id="s7" state="translated">
            <source xml:space="preserve">Sentence  6. </source>
            <target xml:space="preserve">Phrase  6. </target>
            </segment>
            <segment id="s3" canResegment="no">
            <source>Sentence 7. Sentence 8.</source>
            </segment>
            <ignorable>
            <source> </source>
            </ignorable>
            <segment id="s4">
            <source><sc id="2" canOverlap="no" type="fmt" subType="xlf:b" dataRef="d1"/>Sentence 9. </source>
            </segment>
            <segment id="s8">
            <source>Sentence 10<ec startRef="2" canOverlap="no" type="fmt" subType="xlf:b" dataRef="d2"/>.</source>
            </segment>
            </unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/valid/Good-ctr-property-legit-category.xlf",
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
                              <ctr:item property="category">comment</ctr:item><!--
            5.6.5.6 property
            MUST be either content to signify the content of an element, or the name of the attribute relating to the revision data.
            --><!-- valid - legit category -->
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
            "modules/valid/Good-ctr_appliesTo-using-ref-to-resolvableID.xlf",
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
                        <ctr:revisions appliesTo="note" ref="nn1"><!-- change back to note --><!-- good, resolves to an ID -->
                           <ctr:revision>
                              <ctr:item property="content">old note</ctr:item>
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="note" ref="nn1"><!-- good, does resolve to an ID
                        5.6.5.5 ref he value of the ref attribute MUST be the value of the id attribute of a single instance of an element that is a multiple instance within the enclosing element.
                        -->
                           <ctr:revision>
                              <ctr:item property="content">old note</ctr:item>
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="note" ref="nn2">
                           <!-- valid for 5.6.4.3 revisions - When the appliesTo attribute refers to an element that\#u{20}
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
                  <unit id="not-bad">
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="note"><!-- no @ref, but that is okay, only one note - no ambiguity -->
                           <ctr:revision>
                              <ctr:item property="content">old note</ctr:item>
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>
            \#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <notes>
                        <note id="nn1"></note>
                     </notes>
                     <segment>
                        <source>Yes</source>
                        <target>Ja</target>
                     </segment>
                     <segment>
                        <source>No</source>
                        <target>Nein</target>
                     </segment>
                  </unit>\#t\#u{20}\#u{20}
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/valid/Good-ctr_property-content-or-valid-attribute-ref.xlf",
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
                        <ctr:revisions appliesTo="note" ref="nn111">
                           <ctr:revision>
                              <ctr:item property="priority">1</ctr:item><!--
            5.6.5.6 property
            MUST be either content to signify the content of an element, or the name of the attribute relating to the revision data.
            --><!-- good; since note[@id='nn1'] have @priority it is not a violation of\#u{20}
                                                                                    "or the name of the attribute relating to the revision data" -->
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <notes>
                        <note category="riddles" id="nn111" priority="1">Set the priority</note>
                        <note id="nn22"></note>
            			<note id="nn11">This note.</note>
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
            "modules/valid/Good-ctr_ref-pointed-to-resolvableID.xlf",
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
                        <ctr:revisions appliesTo="note" ref="nn1"><!-- good, does resolve to an ID
                        5.6.5.5 ref he value of the ref attribute MUST be the value of the id attribute of a single instance of an element that is a multiple instance within the enclosing element.
                        -->
                           <ctr:revision>
                              <ctr:item property="content">old note</ctr:item>
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="note" ref="nn2">
                           <!-- valid for 5.6.4.3 revisions - When the appliesTo attribute refers to an element that\#u{20}
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
            "modules/valid/Good-ctr_revisions-using-ref-to-resolvableID.xlf",
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
                        <ctr:revisions appliesTo="note" ref="nn1"><!-- change back to note --><!-- good, resolves to an ID -->
                           <ctr:revision>
                              <ctr:item property="content">old note</ctr:item>
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="note" ref="nn1"><!-- good, does resolve to an ID
                        5.6.5.5 ref he value of the ref attribute MUST be the value of the id attribute of a single instance of an element that is a multiple instance within the enclosing element.
                        -->
                           <ctr:revision>
                              <ctr:item property="content">old note</ctr:item>
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="note" ref="nn2">
                           <!-- valid for 5.6.4.3 revisions - When the appliesTo attribute refers to an element that\#u{20}
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
                  <unit id="not-bad">
                     <ctr:changeTrack>
                        <ctr:revisions appliesTo="note"><!-- no @ref, but that is okay, only one note - no ambiguity -->
                           <ctr:revision>
                              <ctr:item property="content">old note</ctr:item>
                           </ctr:revision>
                        </ctr:revisions>
                     </ctr:changeTrack>
            \#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                     <notes>
                        <note id="nn1"></note>
                     </notes>
                     <segment>
                        <source>Yes</source>
                        <target>Ja</target>
                     </segment>
                     <segment>
                        <source>No</source>
                        <target>Nein</target>
                     </segment>
                  </unit>\#t\#u{20}\#u{20}
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/valid/Good-ctr_storageRestriction-patterns.xlf",
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
            slr:sizeRestriction="90"><!-- valid, ninety would be incorrect--><!-- 5.7.6.2.1 sizeRestriction
            Must be one of the following patterns:
            "*" or\#u{20}
            "0" (where 0 means integer) or\#u{20}
            "0,0" or "0,*"
            -->
                        <unit id="u1" slr:storageRestriction="*"><!-- valid, *6 would be incorrect -->
                           <segment>
                              <source>This is a small <pc id="slr1"
            slr:equivStorage="7" slr:storageRestriction="25,100"><!-- valid, 25,100.5 would be incorrect-->storage restriction</pc
            > example.</source>
                           </segment>
                        </unit>
                        <unit id="u2" slr:storageRestriction="35,*"><!-- valid, 35,star would be incorrect -->
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
            "modules/valid/Good-fs_fs-with-valid-HTML.xlf",
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
                     <note id="n3" fs:fs="p"><!-- 5.3.5.1 fs valid, p is a valid value-->This note has an @fs that is not in the table of attribute values in the spec</note>
                     <note id="n4" fs:fs="img" fs:subFs="src,smileface.png">This note has a subFS and fs.</note><!-- 5.3.5.2 subFs
             valid, If the attribute subFs is used, the attribute fs MUST be specified as well.
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
            "modules/valid/Good-fs_subFs-has-fs.xlf",
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
                     <note id="n3" fs:fs="p"><!-- 5.3.5.1 fs valid, p is a valid value-->This note has an @fs that is not in the table of attribute values in the spec</note>
                     <note id="n4" fs:fs="img" fs:subFs="src,smileface.png">This note has a subFS and fs.</note><!-- 5.3.5.2 subFs
             valid, If the attribute subFs is used, the attribute fs MUST be specified as well.
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
            "modules/valid/Good-gls_glossEntry-and-translation-unique-in-glossary.xlf",
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
                        <gls:glossEntry id="ge11"><!-- 5.2.5.1 id
            Constraints

            The values of id attributes MUST be unique among all <glossEntry> and <translation> elements within the given enclosing <glossary> element.\#u{20}
            --><!-- valid, unique. -->
                        <gls:term source="SnowTerms">slush</gls:term>
                           <gls:translation id="t11" source="SnowTerms">Schneematsch</gls:translation>
                        <gls:definition source="SnowTermsDefinitions">a slurry mixture of small ice crystals (e.g., snow) and liquid water.</gls:definition><!-- valid, unique. -->
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
            "modules/valid/Good-gls_glossEntry-w-translation-or-definition.xlf",
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
                           <gls:translation id="t1" source="SnowTerms">Schnee</gls:translation>
                           <gls:definition source="SnowTermsDefinitions">atmospheric water vapor frozen into ice crystals and falling in light white flakes or lying on the ground as a white layer.</gls:definition>
                        </gls:glossEntry>
                        <gls:glossEntry id="ge2"><!-- valid 5.2.4.3 contraint:\#u{20}
                           A <glossEntry> element MUST contain a <translation> or a <definition> element to be valid.
                           -->
                           <gls:term>slushy</gls:term>
                           <gls:definition source="SnowTermsDefinitions">Having qualities of partially melted snow or ice.
            			   </gls:definition>
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
            "modules/valid/Good-itsm_text-analytics.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff version="2.1" xmlns="urn:oasis:names:tc:xliff:document:2.0" srcLang="en" trgLang="fr"
               xmlns:its="http://www.w3.org/2005/11/its" its:version="2.0">
               <file id="f1">
                  <unit id="u1">
                     <segment>
                        <source><mrk id="m1" type="its:generic"
                              its:taClassRef="http://nerd.eurecom.fr/ontology#Place"
                              its:taIdentRef="http://dbpedia.org/resource/Arizona">Arizona</mrk></source>
                     </segment>
                     <segment>
                        <source><sm id="sm1" type="its:generic"
                              its:taClassRef="http://nerd.eurecom.fr/ontology#Place"
                              its:taIdentRef="http://dbpedia.org/resource/Arizona"/>Arizona<em startRef="sm1"
                           /></source>
                     </segment>
                  </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/valid/Good-mtc_match-ID-unique.xlf",
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
                        <mtc:match id="mtc1" ref="#m1">
                           <source>He is my friend1.</source>
                           <target>Il est mon ami.</target>
                        </mtc:match>
                        <mtc:match id="mtc2" ref="#m1"><!--
            			5.1.6.1 id
            Constraints
            The id value MUST be unique within the enclosing <matches> element.
            			--><!-- valid, unique ID within matches -->
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
            "modules/valid/Good-mtc_match-has-no-xml_lang.xlf",
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
                        <mtc:match id="mtc1" ref="#m1"> <!-- 5.1.5.3 match constraint\#u{20}

                xml:lang MUST NOT be set on the match element.
            	--><!-- valid, add xml:lang to break constraint -->
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
            "modules/valid/Good-mtc_match-with-inlines.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
             xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
             srcLang="en-us" version="2.0" trgLang="fr">
            <file id="f1">
            	<unit id="u1">
            		<mtc:matches>
            			<mtc:match id="mtc1" ref="#m1">
            				<source><pc id="1">Bold</pc> text.<ph id="2"/></source>
            				<target>Text en <pc id="1">gras</pc>.<ph id="2"/></target>
            			</mtc:match>
            			<mtc:match id="mtc2" ref="#m1">
            				<source><pc id="1">Bold</pc> text.<ph id="2"/></source>
            				<target>Text <pc id="1">gras</pc>.<ph id="2"/></target>
            			</mtc:match>
            		</mtc:matches>
            		<segment id="m1">
            			<source><pc id="1">Bold</pc> text.<ph id="2"/></source>
            		</segment>
            	</unit>
            </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/valid/Good-mtc_reference-lang.xlf",
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
                        <mtc:match id="mtc122" ref="#m1">
                           <source>He is my best friend.</source>
                           <target>Er ist mein bester Freund.</target>
                        </mtc:match>
                        <mtc:match id="mtc133" reference="yes" ref="#m1">
                           <source>He is my best friend.</source>
                           <target xml:lang="fr">Il est mon meilleur ami.</target>
                        </mtc:match>\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
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
            "modules/valid/Good-mtc_subType-w-type-match.xlf",
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
                        <mtc:match id="mtc111" type="mt" subType="xyz-trans:exact" ref="#m1"><!--
            5.1.6.8 subType
            Constraints
            If the attribute subtype is used, the attribute type MUST be specified as well.
            --><!-- valid, @subType w @type -->
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
            "modules/valid/Good-mtc_type-type-not-on-list.xlf",
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
                        <mtc:match id="mtc122" type="mt" ref="#m1"><!--5.1.6.9 type --><!-- valid, @type from list-->
                           <source>He is my best friend4.</source>
                           <target>Il est mon meilleur ami.</target>
                        </mtc:match>
                        <mtc:match id="mtc133" type="tb" ref="#m1"><!-- @type good-->
                           <source>He is my best friend5.</source>
                           <target>Il est mon meilleur ami.</target>
                        </mtc:match>\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
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
            "modules/valid/Good-res_resourceItem-unique.xlf",
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
            trgLang="lb-lu">
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
                     <res:resourceItem id="r1-temp" mimeType="image/jpeg" context="yes"
            > <!--
            5.5.4.3 resourceItemRef
            5.5.4.4 resourceItem
            Constraints
            The value of the OPTIONAL id attribute MUST be unique among all <resourceItem> and <resourceItemRef> elements of the immediate enclosing <file> or <unit> element.
            -->
                       <!-- valid, unique -->
                        <res:source xml:lang="en-us"
            href="resources\en\registryconfig2.resources.jpg"></res:source>
                        <res:target xml:lang="lb-lu"
            href="resources\lb\registryconfig2.resources.jpg"></res:target>
                     </res:resourceItem>
                  </res:resourceData>
            \#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                  <unit id="1">
                     <res:resourceData>
                        <res:resourceItemRef ref="rr1-temp" id="r2"/>
                        <res:resourceItem id="rr1-temp" mimeType="image/jpeg"
            context="yes"><!-- valid, unique -->
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
            "modules/valid/Good-res_resourceItemRef-unique.xlf",
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
            trgLang="lb-lu">
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
                     <res:resourceItem id="r1-temp" mimeType="image/jpeg" context="yes"
            > <!--
            5.5.4.3 resourceItemRef
            5.5.4.4 resourceItem
            Constraints
            The value of the OPTIONAL id attribute MUST be unique among all <resourceItem> and <resourceItemRef> elements of the immediate enclosing <file> or <unit> element.
            -->
                       <!-- valid, unique -->
                        <res:source xml:lang="en-us"
            href="resources\en\registryconfig2.resources.jpg"></res:source>
                        <res:target xml:lang="lb-lu"
            href="resources\lb\registryconfig2.resources.jpg"></res:target>
                     </res:resourceItem>
                  </res:resourceData>
            \#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
                  <unit id="1">
                     <res:resourceData>
                        <res:resourceItemRef ref="rr1-temp" id="r2"/>
                        <res:resourceItem id="rr1-temp" mimeType="image/jpeg"
            context="yes"><!-- valid, unique -->
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
            "modules/valid/Good-res_source-has-no-content-and-href.xlf",
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
            href="resources\en\registryconfig2.resources.jpg" /><!--
            5.5.4.5 source
            Constraints

            The attribute href is REQUIRED if and only if <source> is empty.

            --><!--valid  is empty and has href -->
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
            "modules/valid/Good-res_source-xml_lang-same-as-xliff.xlf",
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
                        <res:resourceItem id="good-xml-lang-"
            mimeType="image/jpeg" context="yes">
                           <res:source xml:lang="en-us"
            href="resources\en\registryconfig2.resources.jpg"></res:source>
                           <!--
            5.5.4.5 source
            Constraints

            When the OPTIONAL xml:lang attribute is present, its value MUST be equal to the value of the srcLang attribute of the enclosing <xliff> element.
            -->
            <!--valid xml:lang agrees w/xliff srcLang -->
                           <res:target xml:lang="de"
            href="resources\lb\registryconfig2.resources.jpg"></res:target>
                        </res:resourceItem>
                        <res:resourceItem id="good-xml-lang" mimeType="image/jpeg"
            context="yes">
                           <res:source xml:lang="en-us"><source>Hi</source></res:source
            ><!--valid xml:lang agrees w/xliff trgLang -->
                           <res:target xml:lang="de"><target>Hi</target></res:target
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
            "modules/valid/Good-slr_equivStorage-ec-not-isolated.xlf",
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
            id="slr1" slr:equivStorage="7" slr:sizeRestriction="25,100">size restriction</pc
                                 > example<ec startRef="1"/>.</source
            >
                           </segment>
                        </unit>
                        <unit id="u2" slr:sizeRestriction="35,*">
                           <segment>
                              <source>With a group structure<ec\#u{20}
                                 slr:sizeInfo="0" slr:equivStorage="7" id="ec"  isolated="yes"/><!-- test if equivStorage is:
                                                         (1) on an <ec> that IS isolated 5.7.5.8-->
            											 <!-- valid, would be invalid if not @isolated="yes"-->.</source
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
            "modules/valid/Good-slr_equivStorage-is-integer.xlf",
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
                              <source>This <sc id="1" slr:sizeInfo="1"
            slr:equivStorage="7"/> <!-- test if equivStorage is:
            \#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
            											 (2) an integer 5.7.6.2.2 -->
            											 <!-- valid, is an integer -->is a small <pc
            id="slr1" slr:equivStorage="8" slr:sizeRestriction="25,100"><!-- test if equivStorage is:

            											 (2) an integer 5.7.6.2.2 --><!-- valid, @equivStorage is an integer -->size restriction</pc
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
            "modules/valid/Good-slr_sizeInfo-is-integer.xlf",
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
                           <source>Hello <pc id="22" slr:sizeInfo="25"><!-- test if sizeInfo is:
            \#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}
            											 (2) an integer 5.7.6.1.2\#u{20}
            											 -->
            											 <!-- valid, sizeInfo is an integer -->
                              size</pc> tests.</source>
                        </segment>
                     </unit>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/valid/Good-slr_sizeInfo-not-with-sizeInfoRef.xlf",
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
            <!-- lynx debug 3 -->
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
                              <source>This is a small <pc
            id="slr1" slr:equivStorage="7" slr:sizeRestriction="25,100">size restriction</pc
            > example<ec slr:sizeInfo="0" isolated="yes" id="e1" /><!-- test sizeInfo:
                                                         5.7.6.1.2\#u{20}
            											 (3) cannot be present with sizeInfoRef
            											 -->
            											 <!-- valid, would be invalid with @sizeInfoRef.--></source
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
            "modules/valid/Good-slr_sizeInfoRef-ec-isolated.xlf",
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
                                                         (1) on an <ec> that IS isolated 5.7.5.10
            											 -->
                     <!-- valid: has @isolated='yes' - cannot have @sizeInfoRef on <ec> without @isolated -->
                     <unit id="sm1">
                        <segment id="test2">
                         <source>Hello <sc id="s1" isolated="yes" />size </source>
                        </segment>
                     </unit>
            		 <unit id="sm2">
            			<segment id="test2">
            			 <source><ec slr:sizeInfoRef="sir1" isolated="yes" id="e1" />tests.</source>
                        </segment>\#t\#t\#u{20}
            		 </unit>
                  </group>
               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/valid/Good-slr_sizeInfoRef-has-data-sib.xlf",
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
                  <group id="mygroupsizemodule" slr:sizeInfoRef="sir1">
                     <!-- sizeInfoRef:
            (2) The reference MUST point to an element in a <data> element that is a sibling to the element this attribute is attached to or a sibling to one of its ancestors-->
                     <!-- valid: @sizeInfoRef points to valid <slr:data> sibling or ancestor -->
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
            "modules/valid/Good-slr_sizeInfoRef-not-with-sizeInfo.xlf",
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
                  <group id="mygroupsizemodule" slr:sizeInfoRef="sir1">
                     <!-- sizeInfoRef:


            											 (3) cannot be present with sizeInfo-->
                     <!-- valid: can @sizeInfo as long as no @sizeInfoRef on the same element -->
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
            "modules/valid/Good-slr_sizeRestriction-patterns.xlf",
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
            slr:sizeRestriction="90"><!-- valid, ninety would be incorrect--><!-- 5.7.6.1.1 sizeRestriction
            Must be one of the following patterns:
            "*" or\#u{20}
            "0" (where 0 means integer) or\#u{20}
            "0,0" or "0,*"
            -->
                        <unit id="u1" slr:sizeRestriction="*"><!-- valid, *6 would be incorrect -->
                           <segment>
                              <source>This is a small <pc id="slr1"
            slr:equivStorage="7" slr:sizeRestriction="25,100"><!-- valid, 25,100.5 would be incorrect-->size restriction</pc
            > example.</source>
                           </segment>
                        </unit>
                        <unit id="u2" slr:sizeRestriction="35,*"><!-- valid, 35,star would be incorrect -->
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
            "modules/valid/Good-val_ExactlyOneAttributeOnRule.xlf",
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
                     <val:rule isPresent="snow" /><!-- valid per constraint-->
            		 <!-- violation
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

                  <unit id="3">
                     <val:validation>
                        <val:rule isNotPresent="artic"/><!-- valid per constraint-->
                     </val:validation>
                     <segment id="s1">
                        <source></source>
                        <target></target>\#t
                     </segment>
                  </unit>
            \#u{20}\#u{20}\#u{20}\#u{20}\#u{20}\#u{20}

               </file>
            </xliff>
            """#
        ),
        Fixture(
            "modules/valid/Good-val_existsInSourcePatternOnRule.xlf",
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
                  <unit id="5">
                     <val:validation>
                        <val:rule existsInSource="yes" endsWith=":"/><!-- valid per constraint-->
            			            <!--  5.8.5.6 existsInSource
                            When existsInSource is specified, exactly one of
                            isPresent
                            startsWith
                            endsWith
            \#t\#t\#t\#t
            				-->
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
            "modules/valid/Good-val_extension-rule.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0" encoding="UTF-8"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0"
                   xmlns:val="urn:oasis:names:tc:xliff:validation:2.0"
                   srcLang="en-us" version="2.0">
            <file id="f1">
            	<val:validation>
            		<val:rule xmlns:my="myNS" my:ruleType="some data"/>
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
            "modules/valid/Goodslr_sizeRestriction-isolated.xlf",
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
                              <source>This is a small <pc
            id="slr1" slr:equivStorage="7" slr:sizeRestriction="25,100">size restriction</pc
            > example<ec slr:sizeInfo="0" id="i-ec-yes" isolated="yes" /><!-- test if sizeInfo is:
                                                         (1) on an <ec> that is not isolated 5.7.5.9
            											 -->
            											 <!-- valid, would be invalid without @isolated.--></source
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
            "modules/valid/withNotes_complex_for_ITS_Processors.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <notes>
               <!-- needs parsed as an alert that applies to the whole file -->
               <note id="1">note for file</note>
               <!-- needs parsed as an alert that applies to the whole file -->
               <note id="7" priority="1">another highest priority note for file</note>
               <!-- needs parsed as an alert that applies to all source content within file -->
               <note id="2" appliesTo="source">note for all source content within file</note>
               <!-- needs parsed as an alert that applies to all target content within file -->
               <note id="3" appliesTo="target">note for all target content within file</note>
               <!-- needs parsed as a description that applies to the whole file -->
               <note id="4" priority="2">lower priority note for file</note>
               <!-- needs parsed as a description that applies to all source content within file -->
               <note id="5" priority="3" appliesTo="source">lower priority note for all source content within file</note>
               <!-- needs parsed as a description that applies to all target content within file -->
               <note id="6" appliesTo="target" priority="3">lower priority note for all target content within file</note>
               <!-- needs parsed as a description that applies to the whole file -->
               <note id="8" priority="10">lowest priority note for file</note>
              </notes>
              <group id='g1'>
               <notes>
                <!-- needs parsed as an alert that applies to the whole group -->
                <note id="1">note for group</note>
                <!-- needs parsed as an alert that applies to the whole group -->
                <note id="7" priority="1">another highest priority note for group</note>
                <!-- needs parsed as an alert that applies to all source content within group -->
                <note id="2" appliesTo="source">note for all source content within group</note>
                <!-- needs parsed as an alert that applies to all target content within group -->
                <note id="3" appliesTo="target">note for all target content within group</note>
                <!-- needs parsed as a description that applies to the whole group -->
                <note id="4" priority="2">lower priority note for group</note>
                <!-- needs parsed as a description that applies to all source content within group -->
                <note id="5" priority="3" appliesTo="source">lower priority note for all source content within group</note>
                <!-- needs parsed as a description that applies to all target content within group -->
                <note id="6" appliesTo="target" priority="3">lower priority note for all target content within group</note>
                <!-- needs parsed as a description that applies to the whole group -->
                <note id="8" priority="10">lowest priority note for group</note>
               </notes>
               <unit id="1">
                <notes>
                 <!-- needs parsed as an alert that applies to the whole unit -->
                 <note id="1">note for unit</note>
                 <!-- needs parsed as an alert that applies to the whole unit -->
                 <note id="7" priority="1">another highest priority note for unit</note>
                 <!-- needs parsed as an alert that applies to all source content within unit -->
                 <note id="2" appliesTo="source">note for all source content within unit</note>
                 <!-- needs parsed as an alert that applies to all target content within unit -->
                 <note id="3" appliesTo="target">note for all target content within unit</note>
                 <!-- needs parsed as a description that applies to the whole unit -->
                 <note id="4" priority="2">lower priority note for unit</note>
                 <!-- needs parsed as a description that applies to all source content within unit -->
                 <note id="5" priority="3" appliesTo="source">lower priority note for all source content within unit</note>
                 <!-- needs parsed as a description that applies to all target content within unit -->
                 <note id="6" appliesTo="target" priority="3">lower priority note for all target content within unit</note>
                 <!-- needs parsed as a description that applies to the whole unit -->
                 <note id="8" priority="10">lowest priority note for unit</note>
                 <!-- cannot be parsed by generic ITS processors, is an alert that applies to the span delimited with &lt;mrk id="3"> -->
                 <note id="9" >note content for the inline comment delimited with &lt;mrk id="3"></note>
                 <!-- cannot be parsed by generic ITS processors, is a description that applies to the span delimited with &lt;mrk id="5"> -->
                 <note id="10" priority="7">lower priority note content for the inline comment delimited with &lt;mrk id="5"></note>
                </notes>
                <segment id="s1">
                 <source><mrk id="5" type="comment" ref="#n=10"><sc id='1' isolated='yes'/>Sentence 1.</mrk></source>
                 <target><sc id='1' isolated='yes'/>Phrase 1.</target>
                </segment>
                <segment id="s2">
                 <source><mrk id="3" type="comment" ref="#n=9"><sc id='2' isolated='yes'/>Sentence 2.</mrk></source>
                 <!-- @value should be parsed as a description applying to the span delimited with &lt;mrk id="4"> -->
                 <target><mrk id="4" type="comment" value="an inline comment applying just to the delimited target span"><sc id='2' isolated='yes'/>Phrase 2.</mrk></target>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
    ]
}
