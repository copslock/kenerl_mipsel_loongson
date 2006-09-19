Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Sep 2006 16:39:40 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:22995 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S20038625AbWISPje (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Sep 2006 16:39:34 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6DC01.C95E134A"
Subject: Differing results from cross and native compilers
Date:	Tue, 19 Sep 2006 08:39:25 -0700
Message-ID: <2E96546B3C2C8B4CA739323C6058204A0163548B@hq-ex-mb01.razamicroelectronics.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Differing results from cross and native compilers
Thread-Index: AcbcAclb8MTuu14LT86YiDumaL+whA==
From:	"Eric DeVolder" <edevolder@razamicroelectronics.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <edevolder@razamicroelectronics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: edevolder@razamicroelectronics.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6DC01.C95E134A
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

=20
Hi, I have a MIPS native and cross compiler (gcc 3.4.4 and binutils =
2.15)
both built using crosstool-0.42. I have an Alchemy system (MIPS32)
for which I am building code. When I compile a simple example, I get
different instructions from the cross and native compilers.
=20
Specifically, the source file is:
=20
 #include <stdio.h>
 int
 main (int argc, char **argv)
 {
     return -printf("Hello, world!\n");
 }
=20
To compile natively, I use:
=20
 % gcc -c hello.c -o obj1.o
=20
To cross compile, I use:
=20
 % mipsel-unknown-linux-gnu-gcc -c hello.c -o obj2.o
=20
If I use the -O0 or -O1 flags with each, I get identical output
(for the .text), but when I compile in both environments with -O2;
the compilers produce different results.
=20
The native compiler on the Alchemy board results in the following:
=20
obj1.o:     file format elf32-tradlittlemips
Disassembly of section .text:
00000000 <main>:
   0:   3c1c0000        lui     gp,0x0
   4:   279c0000        addiu   gp,gp,0
   8:   0399e021        addu    gp,gp,t9
   c:   27bdffe0        addiu   sp,sp,-32
  10:   afbf0018        sw      ra,24(sp)
  14:   afbc0010        sw      gp,16(sp)
  18:   8f840000        lw      a0,0(gp)
  1c:   00000000        nop
  20:   24840000        addiu   a0,a0,0
  24:   8f990000        lw      t9,0(gp)
  28:   00000000        nop
  2c:   0320f809        jalr    t9
  30:   00000000        nop
  34:   8fbc0010        lw      gp,16(sp)
  38:   8fbf0018        lw      ra,24(sp)
  3c:   00021023        negu    v0,v0
  40:   03e00008        jr      ra
  44:   27bd0020        addiu   sp,sp,32
=20
The cross compiler results in:
=20
obj2.o:     file format elf32-tradlittlemips
Disassembly of section .text:
00000000 <main>:
   0:   3c1c0000        lui     gp,0x0
   4:   279c0000        addiu   gp,gp,0
   8:   0399e021        addu    gp,gp,t9
   c:   27bdffe0        addiu   sp,sp,-32
  10:   afbf0018        sw      ra,24(sp)
  14:   afbc0010        sw      gp,16(sp)
  18:   8f840000        lw      a0,0(gp)
  1c:   8f990000        lw      t9,0(gp)
  20:   00000000        nop
  24:   0320f809        jalr    t9
  28:   24840000        addiu   a0,a0,0
  2c:   8fbc0010        lw      gp,16(sp)
  30:   8fbf0018        lw      ra,24(sp)
  34:   00021023        negu    v0,v0
  38:   03e00008        jr      ra
  3c:   27bd0020        addiu   sp,sp,32
=20
I would have thought that for this simple example I'd get identical
results. For reasons I have yet to figure out, the cross compiler is
finding better optimizations than the native, though both are the
same gcc version. I checked the specs files, and the two are identical
other than the "cross_compile" setting.
=20
I'd like to solve this little mystery to get to the bigger prize, and
that is the ability to actually compile code (e.g. the entire system)
for MIPS32. As is demonstrated above, the compilers are generating
MIPS1 code (based on the NOPs between the load-to-use), but if I
could get the compiler to honor -mips32 (this discovery I originally
made while trying to get native -mips32 to work), I can get even
tighter code...
=20
I've done quite a bit of googling to no avail. I've also done some
digging into gcc/binutils sources, and it appears that binutils has a
"from-abi" option for choosing its architecture, which is o32 which
probably means just MIPS1. I thought about trying to rebuild all the
tools for mipsisa32-unknown-linux-gnu, but am concerned I'd still
have the same problem of a particular compiler optimziation option
not being honored by the compiler.
=20
Any tips/advice much appreciated, thanks!
Eric
=20

------_=_NextPart_001_01C6DC01.C95E134A
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"><HTML =
DIR=3Dltr><HEAD><META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1"></HEAD><BODY>=0A=
<DIV><FONT face=3D'Arial' color=3D#000000 size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT color=3D#000000 face=3DArial size=3D2>Hi, I have a MIPS =
native and cross =0A=
compiler (gcc 3.4.4 and binutils 2.15)<BR>both built using =
crosstool-0.42. I =0A=
have an Alchemy system (MIPS32)<BR>for which I am building code. When I =
compile =0A=
a simple example, I get<BR>different instructions from the cross and =
native =0A=
compilers.</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT color=3D#000000 face=3DArial size=3D2>Specifically, the =
source file =0A=
is:</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT color=3D#000000 face=3D"Courier New" size=3D2>&nbsp;#include =0A=
&lt;stdio.h&gt;<BR>&nbsp;int<BR>&nbsp;main (int argc, char =0A=
**argv)<BR>&nbsp;{<BR>&nbsp;&nbsp;&nbsp;&nbsp; return -printf("Hello, =0A=
world!\n");<BR>&nbsp;}</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT color=3D#000000 face=3DArial size=3D2>To compile natively, I =0A=
use:</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT color=3D#000000 face=3D"Courier New" size=3D2>&nbsp;% gcc -c =
hello.c -o =0A=
obj1.o</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT color=3D#000000 face=3DArial size=3D2>To cross compile, I =
use:</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT color=3D#000000 face=3D"Courier New" size=3D2>&nbsp;% =0A=
mipsel-unknown-linux-gnu-gcc -c hello.c -o obj2.o</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT color=3D#000000 face=3DArial size=3D2>If I use the -O0 or -O1 =
flags with =0A=
each, I get identical output<BR>(for the .text), but when I compile in =
both =0A=
environments with -O2;<BR>the compilers produce different =
results.</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT color=3D#000000 face=3DArial size=3D2>The native compiler on =
the Alchemy =0A=
board results in the following:</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT color=3D#000000 face=3D"Courier New" =0A=
size=3D2>obj1.o:&nbsp;&nbsp;&nbsp;&nbsp; file format =0A=
elf32-tradlittlemips</FONT></DIV>=0A=
<DIV><FONT color=3D#000000 face=3D"Courier New" size=3D2>Disassembly of =
section =0A=
.text:</FONT></DIV>=0A=
<DIV><FONT color=3D#000000 face=3D"Courier New" size=3D2>00000000 =0A=
&lt;main&gt;:<BR>&nbsp;&nbsp; 0:&nbsp;&nbsp; =0A=
3c1c0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
lui&nbsp;&nbsp;&nbsp;&nbsp; =0A=
gp,0x0<BR>&nbsp;&nbsp; 4:&nbsp;&nbsp; =0A=
279c0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addiu&nbsp;&nbsp; =0A=
gp,gp,0<BR>&nbsp;&nbsp; 8:&nbsp;&nbsp; =0A=
0399e021&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
addu&nbsp;&nbsp;&nbsp; =0A=
gp,gp,t9<BR>&nbsp;&nbsp; c:&nbsp;&nbsp; =0A=
27bdffe0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addiu&nbsp;&nbsp; =0A=
sp,sp,-32<BR>&nbsp; 10:&nbsp;&nbsp; =0A=
afbf0018&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
sw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ra,24(sp)<BR>&nbsp; 14:&nbsp;&nbsp; =0A=
afbc0010&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
sw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gp,16(sp)<BR>&nbsp; 18:&nbsp;&nbsp; =0A=
8f840000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
lw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a0,0(gp)<BR>&nbsp; 1c:&nbsp;&nbsp; =0A=
00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nop<BR>&nbsp; =
20:&nbsp;&nbsp; =0A=
24840000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addiu&nbsp;&nbsp; =0A=
a0,a0,0<BR>&nbsp; 24:&nbsp;&nbsp; =0A=
8f990000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
lw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t9,0(gp)<BR>&nbsp; 28:&nbsp;&nbsp; =0A=
00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nop<BR>&nbsp; =
2c:&nbsp;&nbsp; =0A=
0320f809&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
jalr&nbsp;&nbsp;&nbsp; =0A=
t9<BR>&nbsp; 30:&nbsp;&nbsp; =
00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
nop<BR>&nbsp; 34:&nbsp;&nbsp; =
8fbc0010&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
lw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gp,16(sp)<BR>&nbsp; 38:&nbsp;&nbsp; =0A=
8fbf0018&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
lw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ra,24(sp)<BR>&nbsp; 3c:&nbsp;&nbsp; =0A=
00021023&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
negu&nbsp;&nbsp;&nbsp; =0A=
v0,v0<BR>&nbsp; 40:&nbsp;&nbsp; =0A=
03e00008&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
jr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ra<BR>&nbsp; 44:&nbsp;&nbsp; =0A=
27bd0020&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addiu&nbsp;&nbsp; =0A=
sp,sp,32</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT color=3D#000000 face=3DArial size=3D2>The cross compiler =
results =0A=
in:</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT color=3D#000000 face=3D"Courier New" =0A=
size=3D2>obj2.o:&nbsp;&nbsp;&nbsp;&nbsp; file format =0A=
elf32-tradlittlemips</FONT></DIV>=0A=
<DIV><FONT color=3D#000000 face=3D"Courier New" size=3D2>Disassembly of =
section =0A=
.text:</FONT></DIV>=0A=
<DIV><FONT color=3D#000000 face=3D"Courier New" size=3D2>00000000 =0A=
&lt;main&gt;:<BR>&nbsp;&nbsp; 0:&nbsp;&nbsp; =0A=
3c1c0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
lui&nbsp;&nbsp;&nbsp;&nbsp; =0A=
gp,0x0<BR>&nbsp;&nbsp; 4:&nbsp;&nbsp; =0A=
279c0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addiu&nbsp;&nbsp; =0A=
gp,gp,0<BR>&nbsp;&nbsp; 8:&nbsp;&nbsp; =0A=
0399e021&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
addu&nbsp;&nbsp;&nbsp; =0A=
gp,gp,t9<BR>&nbsp;&nbsp; c:&nbsp;&nbsp; =0A=
27bdffe0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addiu&nbsp;&nbsp; =0A=
sp,sp,-32<BR>&nbsp; 10:&nbsp;&nbsp; =0A=
afbf0018&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
sw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ra,24(sp)<BR>&nbsp; 14:&nbsp;&nbsp; =0A=
afbc0010&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
sw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gp,16(sp)<BR>&nbsp; 18:&nbsp;&nbsp; =0A=
8f840000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
lw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a0,0(gp)<BR>&nbsp; 1c:&nbsp;&nbsp; =0A=
8f990000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
lw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t9,0(gp)<BR>&nbsp; 20:&nbsp;&nbsp; =0A=
00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nop<BR>&nbsp; =
24:&nbsp;&nbsp; =0A=
0320f809&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
jalr&nbsp;&nbsp;&nbsp; =0A=
t9<BR>&nbsp; 28:&nbsp;&nbsp; =
24840000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
addiu&nbsp;&nbsp; a0,a0,0<BR>&nbsp; 2c:&nbsp;&nbsp; =0A=
8fbc0010&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
lw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gp,16(sp)<BR>&nbsp; 30:&nbsp;&nbsp; =0A=
8fbf0018&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
lw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ra,24(sp)<BR>&nbsp; 34:&nbsp;&nbsp; =0A=
00021023&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
negu&nbsp;&nbsp;&nbsp; =0A=
v0,v0<BR>&nbsp; 38:&nbsp;&nbsp; =0A=
03e00008&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
jr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ra<BR>&nbsp; 3c:&nbsp;&nbsp; =0A=
27bd0020&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addiu&nbsp;&nbsp; =0A=
sp,sp,32</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>I would have thought that for this =
simple example =0A=
I'd get identical<BR>results. For reasons I have yet to figure out, the =
cross =0A=
compiler is<BR>finding better optimizations than the native, though both =
are =0A=
the<BR>same gcc version. I checked the specs files, and the two are =0A=
identical<BR>other than the "cross_compile" setting.</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>I'd like to solve this little mystery =
to get to the =0A=
bigger prize, and<BR>that is the ability to actually compile code (e.g. =
the =0A=
entire system)<BR>for MIPS32. As is demonstrated above, the compilers =
are =0A=
generating<BR>MIPS1 code (based on the NOPs between the load-to-use), =
but if =0A=
I<BR>could get the compiler to honor -mips32 (this discovery =
I</FONT><FONT =0A=
face=3DArial size=3D2> originally</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>made while trying to get native -mips32 =
to work), I =0A=
can get even</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>tighter code...</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>I've done quite a bit of googling to no =
avail. I've =0A=
also done some<BR>digging into gcc/binutils sources, and it appears that =0A=
binutils has a<BR>"from-abi" option for choosing its architecture, which =
is o32 =0A=
which<BR>probably means just MIPS1. I thought about trying to rebuild =
all =0A=
the<BR>tools for mipsisa32-unknown-linux-gnu, but am concerned I'd =
still<BR>have =0A=
the same problem of a particular compiler optimziation option<BR>not =
being =0A=
honored by the compiler.</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Any tips/advice much appreciated, =0A=
thanks!<BR>Eric</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>
------_=_NextPart_001_01C6DC01.C95E134A--
