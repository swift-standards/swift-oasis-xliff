extension `XLIFF.Document Tests` {

    static let invalid: [Fixture] = [
        Fixture(
            "core/invalid/bad_CommentWithValueAndRef.xlf",
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
            	 <mrk id="4" type="comment" value="this is also valid" ref="#n=n1">text</mrk>
            	</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_ConfusedIsolatedOnEc.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source>Text.<ec startRef="1" id="1"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_CopyOfWithBadReference.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <originalData>
                <data id="d1">code1</data>
               </originalData>
               <segment>
                <source>
            	 <ph id="1" dataRef="d1"/><ph id="2" copyOf="not1"/>
            	</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_CopyOfWithNoCopyReference.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <originalData>
                <data id="d1">code1</data>
               </originalData>
               <segment>
                <source>
            	 <ph id="1" dataRef="d1" canCopy="no"/><ph id="2" copyOf="1"/>
            	</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_CopyOfWithOriginalData.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <originalData>
                <data id="d1">code1</data>
               </originalData>
               <segment>
                <source>
            	 <ph id="1" dataRef="d1"/><ph id="2" copyOf="1" dataRef="d1"/>
            	</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_DataIdNotUnique.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <originalData>
                <data id="d1twice">code1</data>
                <data id="d1twice">code2</data>
               </originalData>
               <segment>
                <source><ph id="1" dataRef="d1twice"/><ph id="2" dataRef="d1twice"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_DataRefWithoutOriginalData.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="u1">
               <segment id="s1">
                <source><ph id='1' dataRef='d1'/>source</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_DifferentCanCopyInScAndEc.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><sc id="1" canCopy="no"/>text. </source>
               </segment>
               <segment>
                <source><ec startRef="1" canCopy="yes"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_DifferentCanDeleteInScAndEc.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><sc id="1" canDelete="no"/>text<ec startRef="1" canDelete="yes"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_DifferentCanOverlapInScAndEc.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><sc id="1" canOverlap="no"/>text. </source>
               </segment>
               <segment>
                <source><ec startRef="1" canOverlap="yes"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_DifferentCanReorderInScAndEc.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><sc id="1" canReorder="no" canCopy="no" canDelete="no"/>text<ec startRef="1" canReorder="yes" canCopy="no" canDelete="no"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_DifferentXmlSpace.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
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
            "core/invalid/bad_DuplicateExtElemIdsInFile.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en"
             xmlns:my="myNS">
             <file id="f1">
              <my:elem1 id="e1">
               <my:elem2 id="x1">f-elem1</my:elem2>
               <my:elem2 xml:id="x1">f-elem2</my:elem2>
              </my:elem1>
              <group id="g1">
               <my:elem1 id="e1">
                <my:elem2 id="x1">g-elem1</my:elem2>
                <my:elem2 id="x2">g-elem2</my:elem2>
               </my:elem1>
               <unit id="1">
                <my:elem1 id="e1">
                 <my:elem2 id="x1">u-elem1</my:elem2>
                 <my:elem2 id="x2">u-elem2</my:elem2>
                </my:elem1>
                <segment>
                 <source>text</source>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_DuplicateExtElemIdsInGroup.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en"
             xmlns:my="myNS">
             <file id="f1">
              <my:elem1 id="e1">
               <my:elem2 id="x1">f-elem1</my:elem2>
               <my:elem2 id="x2">f-elem2</my:elem2>
              </my:elem1>
              <group id="g1">
               <my:elem1 id="e1">
                <my:elem2 id="x1">g-elem1</my:elem2>
                <my:elem2 id="x1">g-elem2</my:elem2>
               </my:elem1>
               <unit id="1">
                <my:elem1 id="e1">
                 <my:elem2 id="x1">u-elem1</my:elem2>
                 <my:elem2 id="x2">u-elem2</my:elem2>
                </my:elem1>
                <segment>
                 <source>text</source>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_DuplicateExtElemIdsInUnit.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en"
             xmlns:my="myNS">
             <file id="f1">
              <my:elem1 id="e1">
               <my:elem2 id="x1">f-elem1</my:elem2>
               <my:elem2 id="x2">f-elem2</my:elem2>
              </my:elem1>
              <group id="g1">
               <my:elem1 id="e1">
                <my:elem2 id="x1">g-elem1</my:elem2>
                <my:elem2 id="x2">g-elem2</my:elem2>
               </my:elem1>
               <unit id="1">
                <my:elem1 id="e1">
                 <my:elem2 id="x1">u-elem1</my:elem2>
                 <my:elem2 id="x1">u-elem2</my:elem2>
                </my:elem1>
                <segment>
                 <source>text</source>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_DuplicateNoteIdsInFile.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <notes>
               <note id="n1">f-note1</note>
               <note id="n1">f-note2</note>
              </notes>
              <group id="g1">
               <notes>
                <note id="n1">g-note1</note>
                <note id="n2">g-note2</note>
               </notes>
               <unit id="1">
                <notes>
                 <note id="n1">u-note1</note>
                 <note id="n2">u-note2</note>
                </notes>
                <segment>
                 <source>text</source>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_DuplicateNoteIdsInGroup.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <notes>
               <note id="n1">f-note</note>
              </notes>
              <group id="g1">
               <notes>
                <note id="n1">g-note1-1</note>
                <note id="n2">g-note2-1</note>
               </notes>
               <group id="g2">
                <notes>
                 <note id="n1">g-note1-2</note>
                 <note id="n1">g-note2-2</note>
                </notes>
                <unit id="1">
                 <notes>
                  <note id="n1">u-note1</note>
                  <note id="n2">u-note2</note>
                 </notes>
                 <segment>
                  <source>text</source>
                 </segment>
                </unit>
               </group>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_DuplicateNoteIdsInUnit.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <notes>
               <note id="n1">f-note</note>
              </notes>
              <group id="g1">
               <notes>
                <note id="n1">g-note</note>
               </notes>
               <unit id="1">
                <notes>
                 <note id="n1">u-note1</note>
                 <note id="n1">u-note2</note>
                </notes>
                <segment>
                 <source>text</source>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_EcBeforeSc.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><ec startRef="1"/>text </source>
               </segment>
               <segment>
                <source><sc id="1"/> text</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_EmBeforeSm.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><em startRef="1"/>text </source>
               </segment>
               <segment>
                <source><sm id="1" translate="no"/> text</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_EmptySkeletonWithoutHref.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <skeleton></skeleton>
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
            "core/invalid/bad_FileIdNotUnique.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="1twice">
              <unit id="1">
               <segment>
                <source>source</source>
                <target>target</target>
               </segment>
              </unit>
             </file>
             <file id="1twice">
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
            "core/invalid/bad_GroupIdNotUnique.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="1twice">
              <group id="1twice">
               <group id="1twice">
                <unit id="1">
                 <segment>
                  <source>source</source>
                 </segment>
                </unit>
               </group>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_GroupWithoutId.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <group>
               <unit id="1">
                <segment>
                 <source>source</source>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_IgnorableIdNotUnique.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <ignorable id="i1twice">
                <source> </source>
               </ignorable>
               <segment>
                <source>source</source>
               </segment>
               <ignorable id="i1twice">
                <source> </source>
               </ignorable>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_IgnorableWithoutSource.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment>
                <source>source</source>
                <target>target</target>
               </segment>
               <ignorable>
                <target> </target>
               </ignorable>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidCommentAnnotation1.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment id="1">
                <source><mrk id="2" type="comment">text</mrk></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidCommentAnnotation2.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <notes>
                <note id='n1'>note</note>
               </notes>
               <segment id="1"> <!-- Not a reference to a note -->
                <source><mrk id="2" type="comment" ref="#n1">text</mrk></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidCommentAnnotation3.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <notes>
               <note id='n1'>note</note>
              </notes>
              <unit id="1">
               <segment id="1"> <!-- Not a reference to a note of the unit -->
                <source><mrk id="2" type="comment" ref="#f=f1/n=n1">text</mrk></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidCommentAnnotation4.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <group id='g1'>
               <notes>
                <note id='n1'>note</note>
               </notes>
               <unit id="1">
                <segment id="1"> <!-- Not a reference to a note of the unit -->
                 <source><mrk id="2" type="comment" ref="#g=g1/n=n1">text</mrk></source>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidDataRef.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <originalData>
                <data id="d1">code1</data>
                <data id="d2">code2</data>
               </originalData>
               <segment>
                <source><ph id="1" dataRef="d1"/><ph id="2" dataRef="bad"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidDataRefEnd.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <originalData>
                <data id="d1">code1</data>
                <data id="d2">code2</data>
               </originalData>
               <segment>
                <source><pc id="1" dataRefStart="d1" dataRefEnd="bad">text</pc></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidDataRefStart.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <originalData>
                <data id="d1">code1</data>
                <data id="d2">code2</data>
               </originalData>
               <segment>
                <source><pc id="1" dataRefStart="bad" dataRefEnd="d2">text</pc></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidDirAttributeOnSource.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source dir="rtl">source</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidExtensionAttributeOnPc.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en"
                   xmlns:my="myNS">
             <file id="f1" my:okAttr="val">
              <group id="g1" my:okAttr="val">
               <unit id="1" my:okAttr="val">
                <segment id="1">
                 <source>
            	  <pc id="1" my:badAttr="val">text</pc>
            	 </source>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidExtensionAttributeOnSegment.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en"
                   xmlns:my="myNS">
             <file id="f1" my:okAttr="val">
              <group id="g1" my:okAttr="val">
               <unit id="1" my:okAttr="val">
                <segment id="1" my:badAttr="val">
                 <source>text</source>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidExtensionAttributeOnSource.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en"
                   xmlns:my="myNS">
             <file id="f1" my:okAttr="val">
              <group id="g1" my:okAttr="val">
               <unit id="1" my:okAttr="val">
                <segment id="1">
                 <source my:badAttr="val">text</source>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidExtensionAttributeOnTarget.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr" xmlns:my="myNS">
             <file id="f1" my:okAttr="val">
              <group id="g1" my:okAttr="val">
               <unit id="1" my:okAttr="val">
                <segment id="1">
                 <source>text</source>
                 <target my:badAttr="val">texte</target>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidExtensionElementInData.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <originalData>
                <data id="d1"><cp hex="0001"/><my:badElem xmlns:my="myNS"/></data>
               </originalData>
               <segment>
                <source><ph id="1" dataRef="d1"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidExtensionElementInFile.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <group id="g1">
               <unit id="1">
                <segment id="1">
                 <source>text</source>
                </segment>
               </unit>
              </group>
              <my:badElem xmlns:my="myNS">data</my:badElem>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidExtensionElementInOriginalData.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <originalData>
                <data id="d1">[code/]</data>
            	<my:badElem xmlns:my="myNS">data</my:badElem>
               </originalData>
               <segment>
                <source><ph id="1" dataRef="d1"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidExtensionElementInSegment.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment id="1">
                <source>text</source>
                <my:badElem xmlns:my="myNS">data</my:badElem>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidExtensionElementOutsideFile.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <my:okElem xmlns:my="myNS">data</my:okElem>
              <group id="g1">
               <my:okElem xmlns:my="myNS">data</my:okElem>
               <unit id="1">
                <my:okElem xmlns:my="myNS">data</my:okElem>
                <segment id="1">
                 <source>text</source>
                </segment>
               </unit>
              </group>
             </file>
             <my:badElem xmlns:my="myNS">data</my:badElem>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidFSAttribute.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en"
             xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0">
             <file id="f1">
              <group id="g1" fs:Bad="value">
               <unit id="1">
                <segment>
                 <source>source</source>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidFSAttributeOnEc.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en"
             xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><sc id='1' fs:fs="b"/>text </source>
               </segment>
               <segment>
                <source><ec startRef='1' fs:fs="b"/>text</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidFSAttributeValue.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en"
             xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0">
             <file id="f1">
              <group id="g1" fs:fs="BadValue">
               <unit id="1">
                <segment>
                 <source>source</source>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidFragIdBadOrder.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="pt"
             xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0">
             <file id="f1">
              <unit id="1">
               <gls:glossary>
                <gls:glossEntry id="g1" ref="#m1">
                 <gls:term>doppelgänger</gls:term>
                 <gls:definition source="dictionary.com">A ghostly double or counterpart of a living person.</gls:definition>
                </gls:glossEntry>
               </gls:glossary>
               <segment>
                <source>He is my <mrk id="m1" type="term" ref="#/u=u1/f=f1/gls=g1">doppelgänger</mrk>.</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidFragIdDuplicatedPrefix.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="pt"
             xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0">
             <file id="f1">
              <unit id="1">
               <gls:glossary>
                <gls:glossEntry id="g1" ref="#m1">
                 <gls:term>doppelgänger</gls:term>
                 <gls:definition source="dictionary.com">A ghostly double or counterpart of a living person.</gls:definition>
                </gls:glossEntry>
               </gls:glossary>
               <segment>
                <source>He is my <mrk id="m1" type="term" ref="#/u=f1/u=1/gls=g1">doppelgänger</mrk>.</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidFragIdMissplacedLeaf.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="pt"
             xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0">
             <file id="f1">
              <unit id="1">
               <originalData>
                <data id='d1'>[br/]</data>
               </originalData>
               <segment>
                <source><mrk id="m1" type="my:type" ref="#f=f1/d=d1/u=1"><ph id="d1" dataRef="d1"/>text</mrk></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidFragIdNoSingleLeaf.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en"
             xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0">
             <file id="f1">
              <unit id="u1">
               <segment>
                <source><mrk id='m1' type='my:type' ref='#c1/c2'><pc id='c1'><ph id='c2'/></pc>text</mrk></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidFragIdPrefixNotNmtoken.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="pt"
             xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0">
             <file id="f1">
              <unit id="1">
               <my:elem id="myid1" xmlns:my="myNS">data</my:elem>
               <segment>
                <source>He is my <mrk id="m1" type="my:term" ref="#/f=f1/u=1/r$d=myid1">doppelgänger</mrk>.</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidFragIdPrefixTooShort.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="pt"
             xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0">
             <file id="f1">
              <unit id="1">
               <my:elem id="myid1" xmlns:my="myNS">data</my:elem>
               <segment>
                <source>He is my <mrk id="m1" type="my:term" ref="#/f=f1/u=1/z=myid1">doppelgänger</mrk>.</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidFragIdSyntax.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en"
             xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0">
             <file id="f1">
              <unit id="u1">
                <notes>
            	 <note id='n1'>note 1</note>
            	</notes>
               <segment>
                <source><mrk id='m1' type='comment' ref='#n/n1'>text</mrk></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidFragIdUnknownPrefix.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="pt"
             xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0">
             <file id="f1">
              <unit id="1">
               <my:elem id="myid1" xmlns:my="myNS">data</my:elem>
               <segment>
                <source>He is my <mrk id="m1" type="my:term" ref="#/f=f1/u=1/my=myid1">doppelgänger</mrk>.</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidHexRangeOnCp.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment> <!-- U+00a0 is not an XML invalid character and must not be coded with cp -->
                <source><cp hex="00a0"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidHexValueOnCp.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><cp hex="notOK"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidId1.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="/1">
               <segment>
                <source>source</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidId2.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment id="#1">
                <source>source</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidId3.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="u1">
               <segment id="s1">
                <source><ph id="\1"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidIsolatedOnEc.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><sc id='1'/>Text.<ec startRef="1" isolated='yes'/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidIsolatedOnSc.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><sc id='1' isolated='yes'/>Text.<ec startRef="1"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidLoneEm.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source>part 1 part 2<em startRef="m1"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidLoneSm.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source>part 1 <sm translate="no" id="m1"/>part 2</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidNoteRefInUnit.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <notes>
               <note id='n1'>file note</note>
              </notes>
              <unit id="1">
               <notes>
                <note id='n1'>unit note</note>
               </notes>
               <segment>
                <source><mrk id='m1' type='comment' ref='#f=f1/n=n1'>text</mrk></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidNotesInFile.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source>text</source>
               </segment>
              </unit>
              <notes>
               <note>note</note>
              </notes>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidNotesInGroup.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <group id="g1">
               <unit id="1">
                <segment>
                 <source>text</source>
                </segment>
               </unit>
               <notes>
                <note>note</note>
               </notes>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidNotesInUnit.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source>text</source>
               </segment>
               <notes>
                <note>note</note>
               </notes>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidStateValue.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment state="badState">
                <source>source</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidTranslateInSegment.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment id="1" translate="no">
                <source>source</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidTypeSubTypeValues.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><ph id="1" type="fmt" subType="xlf:var"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidTypeValue.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source>
            	 <pc id="1" type="fmt">text</pc>
            	 <pc id="2" type="ui">text</pc>
            	 <pc id="3" type="quote">text</pc>
            	 <pc id="4" type="link">text</pc>
            	 <ph id="5" type="image"/>
            	 <pc id="6" type="other">text</pc>
            	 <pc id="7" type="badType">text</pc>
            	</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidValidation.xlf",
            byteOrderMark: true,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="pt"
             xmlns:val="urn:oasis:names:tc:xliff:validation:2.0">
             <file id="f1">
              <unit id="1">
               <val:validationBad>
                <val:rule isPresent="loja" occurs="2" />
               </val:validationBad>
               <segment id="1">
                <source>Choose a store option in the online store.</source>
                <target>Escolha uma opção de loja na loja online.</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidXmlLangInheritedFromFile.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1" xml:lang="ja">
              <unit id="1">
               <segment>
                <source>text.</source>
                <target>texte.</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidXmlLangInheritedFromGroup.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <group id="g1" xml:lang="ja">
               <unit id="1">
                <segment>
                 <source>text.</source>
                 <target>texte.</target>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidXmlLangInheritedFromUnit.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1" xml:lang="ja">
               <segment>
                <source>text.</source>
                <target>texte.</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidXmlLangOnFile.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1" xml:lang="ja">
              <unit id="1">
               <segment>
                <source>text.</source>
                <target>texte.</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidXmlLangOnGroup.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <group id="g1" xml:lang="ja">
               <unit id="1">
                <segment>
                 <source>text.</source>
                 <target>texte.</target>
                </segment>
               </unit>
              </group>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_InvalidXmlLangOnUnit.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1" xml:lang="ja">
               <segment>
                <source>text.</source>
                <target>texte.</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_IsolatedEcWithId.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><ec startRef="1" isolated="yes"/></source> <!-- should use id not startRef -->
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_MissingIsolatedOnEc.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><ec id='1'/>Text.</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_MissingIsolatedOnSc.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><sc id='1'/>Text.</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_MissingNonRemovable1.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="1">
              <unit id="1">
               <segment>
                <source><ph id='1' canDelete="no"/>Text1. </source>
                <!-- OK if there is no target -->
               </segment>
               <segment>
                <source><ph id='2' canDelete="no"/>Text2. </source>
                <target><ph id='2' canDelete="no"/>Texte2. <ph id='3' canDelete="no"/></target>
               </segment>
               <segment>
                <source><ph id='3' canDelete="no"/>Text3. </source>
                <target>Texte3. </target><!-- OK because the code is in another segment -->
               </segment>
               <segment>
                <source><ph id='4' canDelete="no"/>Text4. </source>
                <target>Texte4. </target><!-- NOT OK -->
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_MissingNonRemovable2.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="1">
              <unit id="1">
               <segment>
                <source><ph id='1' canDelete="no"/>Text1. </source>
                <target></target> <!-- Not OK if there is a target 9even an empty one) -->
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_MissingReorderFirstNo.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><ph id="1" canReorder="no" canDelete="no" canCopy="no"/>text <ph id="2"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_NoFile.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_NoTrgLang.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
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
            "core/invalid/bad_NoTrgLangWithIgnorable.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <ignorable>
                <source> </source>
                <target> </target>
               </ignorable>
               <segment>
                <source>source</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_NoUnitOrGroupInFile.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_NonEmptySkeletonWithHref.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <skeleton href="skeleton.skl">some data</skeleton>
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
            "core/invalid/bad_NonIsolatedEcWithoutStartRef.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><sc id="1"/>text</source>
               </segment>
               <segment>
                <source><ec id="1"/>.</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_NotesWithoutNote.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <notes>
              </notes>
              <unit id="1">
               <segment>
                <source/>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_OrderNotUnique1.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment>
                <source>s1</source>
                <target order="1">t1</target>
               </segment>
               <segment>
                <source>s2</source>
                <target order="1">t2</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_OrderNotUnique2.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment>
                <source>s1</source>
                <target order="2">t1</target>
               </segment>
               <segment>
                <source>s2</source>
                <target>t2</target> <!-- Implicit 2 -->
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_OriginalDataWithoutData.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <originalData>
               </originalData>
               <segment id="1">
                <source>source</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_PartIdNotUnique.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment id="1twice">
                <source>source</source>
               </segment>
               <ignorable id="1twice">
                <source> </source>
               </ignorable>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_RefAndValueInComment.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><mrk id="1" type="comment" ref="someURI" value="text">text</mrk></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_SegmentIdNotUnique.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment id="s1twice">
                <source>source</source>
               </segment>
               <segment id="s1twice">
                <source>source</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_SegmentWithoutSource.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment>
                <target>traget</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_SrcLangNotWellFormed.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="e" trgLang="fr">
             <file id="1">
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
            "core/invalid/bad_SubFlowWithInvalidReference.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en-us" trgLang="fr-fr">
             <file id="351d0b92-afc0-4172-a4a6-55f06f5e8dca">
              <unit id="tu1">
               <segment id="0">
                <source>Sample document</source>
               </segment>
              </unit>
              <unit id="tu3">
               <segment id="0">
                <source>Bolded text</source>
               </segment>
              </unit>
              <unit id="tu2">
               <originalData>
                <data id="d1">&lt;b [#$tu3]></data>
                <data id="d2">&lt;/b></data>
               </originalData>
               <segment id="0">
                <source>This paragraph has 3 sentences. <pc id="1" subFlowsStart="badRef" dataRefEnd="d2" dataRefStart="d1">This is the second sentence.</pc> This is the last sentence.</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_SubFlowWithInvalidValue.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en-us" trgLang="fr-fr">
             <file id="f1">
              <unit id="tu7">
               <segment id="0">
                <source>Title of the image</source>
               </segment>
              </unit>
              <unit id="tu8">
               <segment id="0">
                <source>Alternate text for the image</source>
               </segment>
              </unit>
              <unit id="tu5">
               <originalData>
                <data id="d1">[#$dp9]</data>
               </originalData>
               <segment id="0">
                <source>Image goes here [<ph id="1" subFlows="tu7, tu8" dataRef="d1"/>]</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_SubStateWithoutState.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment subState="my:value">
                <source>text</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_SubTypeWithoutType.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><pc id="1" subType="xlf:b">text</pc></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_TrgLangNotWellFormed.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="f r">
             <file id="1">
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
            "core/invalid/bad_TwoSourceInUnit.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment id="s1">
                <source>source</source>
                <source>target</source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_UnitWithoutSegment.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <ignorable>
                <source> </source>
               </ignorable>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_UnknownDataRefEndValue.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <originalData>
                <data id="d1">code1</data>
                <data id="d2">code2</data>
               </originalData>
               <segment id="1">
                <source><pc id="1" dataRefStart="d1" dataRefEnd="badId">text</pc></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_UnknownDataRefStartValue.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <originalData>
                <data id="d1">code1</data>
                <data id="d2">code2</data>
               </originalData>
               <segment id="1">
                <source><pc id="1" dataRefStart="badId" dataRefEnd="d2">text</pc></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_UnknownDataRefValue.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <originalData>
                <data id="1">code1</data>
               </originalData>
               <segment id="1">
                <source><ph id="1" dataRef="badId"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_WrongLangOnTarget.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr"
             xml:lang="ja">
             <file id="f1">
              <unit id="1">
               <segment>
                <source xml:lang="en">text.</source>
                <target>texte.</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_WrongReordering1.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment>
                <source>
            	 <ph id="1" canReorder="firstNo" canDelete="no" canCopy="no"/>
            	 <ph id="2" canReorder="no" canDelete="no" canCopy="no"/>
            	 <ph id="3" canReorder="no" canDelete="no" canCopy="no"/>
            	 text
            	 <ph id="5" />
            	 </source>
                <target>
            	 <ph id="1" canReorder="firstNo" canDelete="no" canCopy="no"/>
            	 <ph id="2" canReorder="no" canDelete="no" canCopy="no"/>
            	 <ph id="5" />
            	 <ph id="3" canReorder="no" canDelete="no" canCopy="no"/>
            	 text
            	</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_WrongReordering2.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment>
                <source>
            	 <pc id="1" canReorder="firstNo" canDelete="no" canCopy="no">
            	  text
            	  <ph id="2" canReorder="no" canDelete="no" canCopy="no"/>
            	 </pc>
                </source>
                <target>
            	 <pc id="1" canReorder="firstNo" canDelete="no" canCopy="no">
            	  text
            	 </pc>
                 <ph id="2" canReorder="no" canDelete="no" canCopy="no"/>
            	</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_WrongSourceLang.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment>
                <source xml:lang="ja">source</source>
                <target>target</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_WrongTargetLang.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="f1">
              <unit id="1">
               <segment>
                <source>source</source>
                <target xml:lang="de">target</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_XmlLangNotWellFormed.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en" trgLang="fr">
             <file id="1">
              <unit id="1">
               <segment>
                <source>source</source>
                <target xml:lang="f r">target</target>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_YesCanReorderInEcForFirstNoInSc.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><sc id="1" canReorder="firstNo" canCopy="no" canDelete="no"/>text<ec startRef="1" canReorder="yes" canCopy="no" canDelete="no"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_canReorderContext1.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><ph id="1" canReorder="firstNo"/>text <ph id="2"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_canReorderContext2.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><ph id="1" canReorder="firstNo" canCopy="no" canDelete="yes"/>text <ph id="2"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
        Fixture(
            "core/invalid/bad_canReorderContext3.xlf",
            byteOrderMark: false,
            #"""
            <?xml version="1.0"?>
            <xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0" srcLang="en">
             <file id="f1">
              <unit id="1">
               <segment>
                <source><ph id="1" canReorder="firstNo" canDelete="no" canCopy="yes"/>text <ph id="2"/></source>
               </segment>
              </unit>
             </file>
            </xliff>
            """#
        ),
    ]
}
