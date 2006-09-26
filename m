Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 15:34:20 +0100 (BST)
Received: from smtp-out.sigp.net ([63.237.78.44]:45820 "EHLO smtp-out.sigp.net")
	by ftp.linux-mips.org with ESMTP id S20037584AbWIZOeQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2006 15:34:16 +0100
Received: from gamd-ex-001.ss.drs.master (gamd-ex-001.ss.drs.master [172.22.132.94])
	by smtp-out.sigp.net (8.13.1/8.13.6) with ESMTP id k8QEYCOH011947
	for <linux-mips@linux-mips.org>; Tue, 26 Sep 2006 10:34:15 -0400 (EDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6E178.D5788177"
Subject: oprofile configure?
Date:	Tue, 26 Sep 2006 10:34:12 -0400
Message-ID: <DEB94D90ABFC8240851346CFD4ACFF149E1C7F@gamd-ex-001.ss.drs.master>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: oprofile configure?
Thread-Index: AcbheNVzisvHJh+ZQrC/gpAimQjepw==
From:	"Azer, William" <Bill.Azer@drs-ss.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <Bill.Azer@drs-ss.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Bill.Azer@drs-ss.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6E178.D5788177
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

i have natively built oprofile for sb1 platform and i get a lot of =
warnings from the compiler.  i had to use --disable-werror in order to =
build.  has anyone encountered this?  am i doing something wrong?

i did compile, install and run.

thx,

Bill Azer


if g++ -DHAVE_CONFIG_H -I. -I. -I..  -I ../libutil -I ../libop  -W -Wall =
-fno-common -ftemplate-depth-50 -g -O2 -MT op_exception.o -MD -MP -MF =
".deps/op_exception.Tpo" -c -o op_exception.o op_exception.cpp; \
then mv -f ".deps/op_exception.Tpo" ".deps/op_exception.Po"; else rm -f =
".deps/op_exception.Tpo"; exit 1; fi
/usr/lib32/gcc/mips64-montavista-linux/3.4.3/../../../../include/c++/3.4.=
3/bits/basic_string.h: In static member function `static =
std::basic_string<_CharT, _Traits, _Alloc>::_Rep& =
std::basic_string<_CharT, _Traits, _Alloc>::_Rep::_S_empty_rep() [with =
_CharT =3D char, _Traits =3D std::char_traits<char>, _Alloc =3D =
std::allocator<char>]':
/usr/lib32/gcc/mips64-montavista-linux/3.4.3/../../../../include/c++/3.4.=
3/bits/basic_string.h:215:   instantiated from `void =
std::basic_string<_CharT, _Traits, _Alloc>::_Rep::_M_dispose(const =
_Alloc&) [with _CharT =3D char, _Traits =3D std::char_traits<char>, =
_Alloc =3D std::allocator<char>]'
/usr/lib32/gcc/mips64-montavista-linux/3.4.3/../../../../include/c++/3.4.=
3/bits/basic_string.h:418:   instantiated from =
`std::basic_string<_CharT, _Traits, _Alloc>::~basic_string() [with =
_CharT =3D char, _Traits =3D std::char_traits<char>, _Alloc =3D =
std::allocator<char>]'
op_exception.cpp:21:   instantiated from here
/usr/lib32/gcc/mips64-montavista-linux/3.4.3/../../../../include/c++/3.4.=
3/bits/basic_string.h:178: warning: dereferencing type-punned pointer =
will break strict-aliasing rules

------_=_NextPart_001_01C6E178.D5788177
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7233.28">
<TITLE>oprofile configure?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi,<BR>
<BR>
i have natively built oprofile for sb1 platform and i get a lot of =
warnings from the compiler.&nbsp; i had to use --disable-werror in order =
to build.&nbsp; has anyone encountered this?&nbsp; am i doing something =
wrong?<BR>
<BR>
i did compile, install and run.<BR>
<BR>
thx,<BR>
<BR>
Bill Azer<BR>
<BR>
<BR>
if g++ -DHAVE_CONFIG_H -I. -I. -I..&nbsp; -I ../libutil -I =
../libop&nbsp; -W -Wall -fno-common -ftemplate-depth-50 -g -O2 -MT =
op_exception.o -MD -MP -MF &quot;.deps/op_exception.Tpo&quot; -c -o =
op_exception.o op_exception.cpp; \<BR>
then mv -f &quot;.deps/op_exception.Tpo&quot; =
&quot;.deps/op_exception.Po&quot;; else rm -f =
&quot;.deps/op_exception.Tpo&quot;; exit 1; fi<BR>
/usr/lib32/gcc/mips64-montavista-linux/3.4.3/../../../../include/c++/3.4.=
3/bits/basic_string.h: In static member function `static =
std::basic_string&lt;_CharT, _Traits, _Alloc&gt;::_Rep&amp; =
std::basic_string&lt;_CharT, _Traits, _Alloc&gt;::_Rep::_S_empty_rep() =
[with _CharT =3D char, _Traits =3D std::char_traits&lt;char&gt;, _Alloc =
=3D std::allocator&lt;char&gt;]':<BR>
/usr/lib32/gcc/mips64-montavista-linux/3.4.3/../../../../include/c++/3.4.=
3/bits/basic_string.h:215:&nbsp;&nbsp; instantiated from `void =
std::basic_string&lt;_CharT, _Traits, _Alloc&gt;::_Rep::_M_dispose(const =
_Alloc&amp;) [with _CharT =3D char, _Traits =3D =
std::char_traits&lt;char&gt;, _Alloc =3D =
std::allocator&lt;char&gt;]'<BR>
/usr/lib32/gcc/mips64-montavista-linux/3.4.3/../../../../include/c++/3.4.=
3/bits/basic_string.h:418:&nbsp;&nbsp; instantiated from =
`std::basic_string&lt;_CharT, _Traits, _Alloc&gt;::~basic_string() [with =
_CharT =3D char, _Traits =3D std::char_traits&lt;char&gt;, _Alloc =3D =
std::allocator&lt;char&gt;]'<BR>
op_exception.cpp:21:&nbsp;&nbsp; instantiated from here<BR>
/usr/lib32/gcc/mips64-montavista-linux/3.4.3/../../../../include/c++/3.4.=
3/bits/basic_string.h:178: warning: dereferencing type-punned pointer =
will break strict-aliasing rules<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6E178.D5788177--
