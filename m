Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Sep 2006 17:58:03 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:39184 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S20038644AbWISQ6B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Sep 2006 17:58:01 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6DC0C.BF680F2A"
Subject: RE: Differing results from cross and native compilers
Date:	Tue, 19 Sep 2006 09:57:53 -0700
Message-ID: <2E96546B3C2C8B4CA739323C6058204A0163548C@hq-ex-mb01.razamicroelectronics.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Differing results from cross and native compilers
Thread-Index: AcbcBWcGsplfevXUTWiUW0MsJ4LnHAABZ+IV
From:	"Eric DeVolder" <edevolder@razamicroelectronics.com>
To:	"Thiemo Seufer" <ths@networkno.de>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <edevolder@razamicroelectronics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: edevolder@razamicroelectronics.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6DC0C.BF680F2A
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes, it appears to me that the compiler (cc1) and assembler (as) =
invocations are the same. I've included the "-v" output of each below =
for reference. Furthermore, the -save-temps output .i files are =
effectively the same (differences due to cross vs. native paths, but =
that is it). Nonetheless, the output assembly source still contains =
differences!
=20
I'm curious if anybody examined the output of a cross and native =
toolchain of the same (recent) version?
=20
Eric
=20
=20
0:~$ diff -wbup cross.s native.s
--- cross.s 2006-09-19 11:38:54.000000000 -0500
+++ native.s     2006-09-19 11:39:07.000000000 -0500
@@ -17,24 +17,20 @@ main:
        .fmask  0x00000000,0
        .set    noreorder
        .cpload $25
-       .set    nomacro
-
+       .set    reorder
        addiu   $sp,$sp,-32
        sw      $31,24($sp)
        .cprestore      16
-       lw      $4,%got($LC0)($28)
-       lw      $25,%call16(printf)($28)
-       nop
-       jalr    $25
-       addiu   $4,$4,%lo($LC0)
-
-       lw      $28,16($sp)
+       la      $4,$LC0
+       jal     printf
        lw      $31,24($sp)
        subu    $2,$0,$2
+       .set    noreorder
+       .set    nomacro
        j       $31
        addiu   $sp,$sp,32
-
        .set    macro
        .set    reorder
+
        .end    main
        .ident  "GCC: (GNU) 3.4.4"

For good measure, here's the assembly output from the cross compiler:
=20
0:~$ more cross.s
  .file 1 "t.c"
  .section .mdebug.abi32
  .previous
  .abicalls
  .section  .rodata.str1.4,"aMS",@progbits,1
  .align  2
$LC0:
  .ascii  "Hello, World!\n\000"
  .text
  .align  2
  .globl  main
  .ent  main
  .type main, @function
main:
  .frame  $sp,32,$31    # vars=3D 0, regs=3D 1/0, args=3D 16, gp=3D 8
  .mask 0x80000000,-8
  .fmask  0x00000000,0
  .set  noreorder
  .cpload $25
  .set  nomacro
  addiu $sp,$sp,-32
  sw  $31,24($sp)
  .cprestore  16
  lw  $4,%got($LC0)($28)
  lw  $25,%call16(printf)($28)
  nop
  jalr  $25
  addiu $4,$4,%lo($LC0)
  lw  $28,16($sp)
  lw  $31,24($sp)
  subu  $2,$0,$2
  j $31
  addiu $sp,$sp,32
  .set  macro
  .set  reorder
  .end  main
  .ident  "GCC: (GNU) 3.4.4"

And here is the cross and native screen capture due to -v:
=20
=3D=3D=3D=3D cross =3D=3D=3D=3D
0:~$ mipsel-unknown-linux-gnu-gcc -v -save-temps -O2 -c =
/opt/oe/target/root/t.c  -o obj2.o
Reading specs from =
/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linux-gnu/lib/gcc/mip=
sel-unknown-linux-gnu/3.4.4/specs
Configured with: =
/home/edevolder/downloads/crosstool-0.42/build/mipsel-unknown-linux-gnu/g=
cc-3.4.4-glibc-2.3.6/gcc-3.4.4/configure =
--target=3Dmipsel-unknown-linux-gnu =
--host=3Dx86_64-host_unknown-linux-gnu =
--prefix=3D/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linux-gnu =
--with-sysroot=3D/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linu=
x-gnu/mipsel-unknown-linux-gnu/sys-root =
--with-local-prefix=3D/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown=
-linux-gnu/mipsel-unknown-linux-gnu/sys-root --disable-nls =
--enable-threads=3Dposix --enable-symvers=3Dgnu --enable-__cxa_atexit =
--enable-languages=3Dc,c++ --enable-shared --enable-c99 =
--enable-long-long
Thread model: posix
gcc version 3.4.4
 =
/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linux-gnu/libexec/gcc=
/mipsel-unknown-linux-gnu/3.4.4/cc1 -E -quiet -v /opt/oe/target/root/t.c =
-O2 -o t.i
ignoring nonexistent directory =
"/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linux-gnu/mipsel-unk=
nown-linux-gnu/sys-root/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknow=
n-linux-gnu/mipsel-unknown-linux-gnu/sys-root/include"
ignoring nonexistent directory =
"/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linux-gnu/lib/gcc/mi=
psel-unknown-linux-gnu/3.4.4/../../../../mipsel-unknown-linux-gnu/include=
"
#include "..." search starts here:
#include <...> search starts here:
 =
/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linux-gnu/lib/gcc/mip=
sel-unknown-linux-gnu/3.4.4/include
 =
/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linux-gnu/mipsel-unkn=
own-linux-gnu/sys-root/usr/include
End of search list.
 =
/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linux-gnu/libexec/gcc=
/mipsel-unknown-linux-gnu/3.4.4/cc1 -fpreprocessed t.i -quiet -dumpbase =
t.c -auxbase-strip obj2.o -O2 -version -o t.s
GNU C version 3.4.4 (mipsel-unknown-linux-gnu)
        compiled by GNU C version 3.2.3 20030502 (Red Hat Linux =
3.2.3-54).
GGC heuristics: --param ggc-min-expand=3D97 --param =
ggc-min-heapsize=3D126001
 =
/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linux-gnu/lib/gcc/mip=
sel-unknown-linux-gnu/3.4.4/../../../../mipsel-unknown-linux-gnu/bin/as =
-EL -O2 -no-mdebug -32 -v -KPIC -o obj2.o t.s
GNU assembler version 2.15 (mipsel-unknown-linux-gnu) using BFD version =
2.15
=20
=3D=3D=3D native =3D=3D=3D
root@db1200:~# gcc -v -save-temps -O2 -c t.c -o obj1.o
Reading specs from /usr/lib/gcc/mipsel-unknown-linux-gnu/3.4.4/specs
Configured with: =
/home/edevolder/downloads/crosstool-0.42/build/mipsel-unknown-linux-gnu/g=
cc-3.4.4-glibc-2.3.6/gcc-3.4.4/configure =
--build=3Dx86_64-build_unknown-linux-gnu =
--target=3Dmipsel-unknown-linux-gnu --host=3Dmipsel-unknown-linux-gnu =
--prefix=3D/usr --disable-nls --enable-threads=3Dposix =
--enable-symvers=3Dgnu --enable-__cxa_atexit --enable-languages=3Dc,c++ =
--enable-shared --enable-c99 --enable-long-long
Thread model: posix
gcc version 3.4.4
 /usr/libexec/gcc/mipsel-unknown-linux-gnu/3.4.4/cc1 -E -quiet -v t.c =
-O2 -o t.iignoring nonexistent directory =
"/usr/lib/gcc/mipsel-unknown-linux-gnu/3.4.4/../../../../mipsel-unknown-l=
inux-gnu/include"
#include "..." search starts here:
#include <...> search starts here:
 /usr/local/include
 /usr/lib/gcc/mipsel-unknown-linux-gnu/3.4.4/include
 /usr/include
End of search list.
 /usr/libexec/gcc/mipsel-unknown-linux-gnu/3.4.4/cc1 -fpreprocessed t.i =
-quiet -dumpbase t.c -auxbase-strip obj1.o -O2 -version -o t.s
GNU C version 3.4.4 (mipsel-unknown-linux-gnu)
        compiled by GNU C version 3.4.4.
GGC heuristics: --param ggc-min-expand=3D47 --param =
ggc-min-heapsize=3D31868
 =
/usr/lib/gcc/mipsel-unknown-linux-gnu/3.4.4/../../../../mipsel-unknown-li=
nux-gnu/bin/as -EL -O2 -no-mdebug -32 -v -KPIC -o obj1.o t.s
GNU assembler version 2.15 (mipsel-unknown-linux-gnu) using BFD version =
2.15


________________________________

From: Thiemo Seufer [mailto:ths@networkno.de]
Sent: Tue 9/19/2006 11:05 AM
To: Eric DeVolder
Cc: linux-mips@linux-mips.org
Subject: Re: Differing results from cross and native compilers



Eric DeVolder wrote:
[snip]
> I would have thought that for this simple example I'd get identical
> results. For reasons I have yet to figure out, the cross compiler is
> finding better optimizations than the native, though both are the
> same gcc version. I checked the specs files, and the two are identical
> other than the "cross_compile" setting.

Have you checked (with -v) if the assembler gets the same optimisations
in both cases, and/or (with -save-temps) where in the compile things
start to diverge?


Thiemo



------_=_NextPart_001_01C6DC0C.BF680F2A
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">=0A=
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">=0A=
<HTML>=0A=
<HEAD>=0A=
=0A=
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">=0A=
<TITLE>Re: Differing results from cross and native compilers</TITLE>=0A=
</HEAD>=0A=
<BODY>=0A=
<DIV dir=3Dltr id=3DidOWAReplyText18876>=0A=
<DIV dir=3Dltr><FONT color=3D#000000 face=3DArial size=3D2>Yes, it =
appears to me that =0A=
the compiler (cc1) and assembler (as) invocations are the same. I've =
included =0A=
the "-v" output of each below for reference. Furthermore, the =
-save-temps output =0A=
.i files are effectively the same (differences due to cross vs. native =
paths, =0A=
but that is it).&nbsp;Nonetheless, the output assembly source still =
contains =0A=
differences!</FONT></DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>I'm curious if&nbsp;anybody =
examined the =0A=
output of a cross and native toolchain of the same (recent) =0A=
version?</FONT></DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Eric</FONT></DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3D"Courier New">0:~$ diff -wbup cross.s =
native.s<BR>--- =0A=
cross.s 2006-09-19 11:38:54.000000000 -0500<BR>+++ =0A=
native.s&nbsp;&nbsp;&nbsp;&nbsp; 2006-09-19 11:39:07.000000000 =
-0500<BR>@@ =0A=
-17,24 +17,20 @@ main:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
.fmask&nbsp; 0x00000000,0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
.set&nbsp;&nbsp;&nbsp; =
noreorder<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
.cpload $25<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.set&nbsp;&nbsp;&nbsp; =0A=
nomacro<BR>-<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.set&nbsp;&nbsp;&nbsp; =0A=
reorder<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addiu&nbsp;&nbsp; =0A=
$sp,$sp,-32<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
sw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
$31,24($sp)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
.cprestore&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
16<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
lw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
$4,%got($LC0)($28)<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
lw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
$25,%call16(printf)($28)<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
nop<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; jalr&nbsp;&nbsp;&nbsp; =0A=
$25<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addiu&nbsp;&nbsp; =0A=
$4,$4,%lo($LC0)<BR>-<BR>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
lw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
$28,16($sp)<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
la&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
$4,$LC0<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
jal&nbsp;&nbsp;&nbsp;&nbsp; =0A=
printf<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
lw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
$31,24($sp)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
subu&nbsp;&nbsp;&nbsp; =0A=
$2,$0,$2<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set&nbsp;&nbsp;&nbsp; =0A=
noreorder<BR>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.set&nbsp;&nbsp;&nbsp; =0A=
nomacro<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
j&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
$31<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addiu&nbsp;&nbsp; =0A=
$sp,$sp,32<BR>-<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
.set&nbsp;&nbsp;&nbsp; =
macro<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
.set&nbsp;&nbsp;&nbsp; =0A=
reorder<BR>+<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
.end&nbsp;&nbsp;&nbsp; =
main<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
.ident&nbsp; "GCC: (GNU) 3.4.4"<BR></FONT></DIV></DIV>=0A=
<DIV dir=3Dltr>For good measure, here's the assembly output from the =
cross =0A=
compiler:</DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3D"Courier New">0:~$ more cross.s<BR>&nbsp; =
.file 1 =0A=
"t.c"<BR>&nbsp; .section .mdebug.abi32<BR>&nbsp; .previous<BR>&nbsp; =0A=
.abicalls<BR>&nbsp; .section&nbsp; =
.rodata.str1.4,"aMS",@progbits,1<BR>&nbsp; =0A=
.align&nbsp; 2<BR>$LC0:<BR>&nbsp; .ascii&nbsp; "Hello, =
World!\n\000"<BR>&nbsp; =0A=
.text<BR>&nbsp; .align&nbsp; 2<BR>&nbsp; .globl&nbsp; main<BR>&nbsp; =
.ent&nbsp; =0A=
main<BR>&nbsp; .type main, @function<BR>main:<BR>&nbsp; .frame&nbsp; =0A=
$sp,32,$31&nbsp;&nbsp;&nbsp; # vars=3D 0, regs=3D 1/0, args=3D 16, gp=3D =
8<BR>&nbsp; =0A=
.mask 0x80000000,-8<BR>&nbsp; .fmask&nbsp; 0x00000000,0<BR>&nbsp; =
.set&nbsp; =0A=
noreorder<BR>&nbsp; .cpload $25<BR>&nbsp; .set&nbsp; nomacro</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3D"Courier New">&nbsp; addiu =
$sp,$sp,-32<BR>&nbsp; =0A=
sw&nbsp; $31,24($sp)<BR>&nbsp; .cprestore&nbsp; 16<BR>&nbsp; lw&nbsp; =0A=
$4,%got($LC0)($28)<BR>&nbsp; lw&nbsp; $25,%call16(printf)($28)<BR>&nbsp; =0A=
nop<BR>&nbsp; jalr&nbsp; $25<BR>&nbsp; addiu $4,$4,%lo($LC0)</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3D"Courier New">&nbsp; lw&nbsp; =
$28,16($sp)<BR>&nbsp; =0A=
lw&nbsp; $31,24($sp)<BR>&nbsp; subu&nbsp; $2,$0,$2<BR>&nbsp; j =
$31<BR>&nbsp; =0A=
addiu $sp,$sp,32</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3D"Courier New">&nbsp; .set&nbsp; =
macro<BR>&nbsp; =0A=
.set&nbsp; reorder<BR>&nbsp; .end&nbsp; main<BR>&nbsp; .ident&nbsp; =
"GCC: (GNU) =0A=
3.4.4"<BR></FONT></DIV>=0A=
<DIV dir=3Dltr>And here is the cross and native screen capture due to =
-v:</DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>=3D=3D=3D=3D cross =3D=3D=3D=3D</DIV>=0A=
<DIV dir=3Dltr>0:~$ mipsel-unknown-linux-gnu-gcc -v -save-temps -O2 -c =0A=
/opt/oe/target/root/t.c&nbsp; -o obj2.o<BR>Reading specs from =0A=
/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linux-gnu/lib/gcc/mip=
sel-unknown-linux-gnu/3.4.4/specs<BR>Configured =0A=
with: =0A=
/home/edevolder/downloads/crosstool-0.42/build/mipsel-unknown-linux-gnu/g=
cc-3.4.4-glibc-2.3.6/gcc-3.4.4/configure =0A=
--target=3Dmipsel-unknown-linux-gnu =
--host=3Dx86_64-host_unknown-linux-gnu =0A=
--prefix=3D/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linux-gnu =0A=
--with-sysroot=3D/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linu=
x-gnu/mipsel-unknown-linux-gnu/sys-root =0A=
--with-local-prefix=3D/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown=
-linux-gnu/mipsel-unknown-linux-gnu/sys-root =0A=
--disable-nls --enable-threads=3Dposix --enable-symvers=3Dgnu =
--enable-__cxa_atexit =0A=
--enable-languages=3Dc,c++ --enable-shared --enable-c99 =0A=
--enable-long-long<BR>Thread model: posix<BR>gcc version =0A=
3.4.4<BR>&nbsp;/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linux-=
gnu/libexec/gcc/mipsel-unknown-linux-gnu/3.4.4/cc1 =0A=
-E -quiet -v /opt/oe/target/root/t.c -O2 -o t.i<BR>ignoring nonexistent =0A=
directory =0A=
"/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linux-gnu/mipsel-unk=
nown-linux-gnu/sys-root/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknow=
n-linux-gnu/mipsel-unknown-linux-gnu/sys-root/include"<BR>ignoring =0A=
nonexistent directory =0A=
"/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linux-gnu/lib/gcc/mi=
psel-unknown-linux-gnu/3.4.4/../../../../mipsel-unknown-linux-gnu/include=
"<BR>#include =0A=
"..." search starts here:<BR>#include &lt;...&gt; search starts =0A=
here:<BR>&nbsp;/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linux-=
gnu/lib/gcc/mipsel-unknown-linux-gnu/3.4.4/include<BR>&nbsp;/opt/crosstoo=
l/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linux-gnu/mipsel-unknown-linux-gnu=
/sys-root/usr/include<BR>End =0A=
of search =0A=
list.<BR>&nbsp;/opt/crosstool/gcc-3.4.4-glibc-2.3.6/mipsel-unknown-linux-=
gnu/libexec/gcc/mipsel-unknown-linux-gnu/3.4.4/cc1 =0A=
-fpreprocessed t.i -quiet -dumpbase t.c -auxbase-strip obj2.o -O2 =
-version -o =0A=
t.s<BR>GNU C version 3.4.4 =0A=
(mipsel-unknown-linux-gnu)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
compiled by GNU C version 3.2.3 20030502 (Red Hat Linux =
3.2.3-54).<BR>GGC =0A=
heuristics: --param ggc-min-expand=3D97 --param =0A=
ggc-min-heapsize=3D126001<BR>&nbsp;/opt/crosstool/gcc-3.4.4-glibc-2.3.6/m=
ipsel-unknown-linux-gnu/lib/gcc/mipsel-unknown-linux-gnu/3.4.4/../../../.=
./mipsel-unknown-linux-gnu/bin/as =0A=
-EL -O2 -no-mdebug -32 -v -KPIC -o obj2.o t.s<BR>GNU assembler version =
2.15 =0A=
(mipsel-unknown-linux-gnu) using BFD version 2.15</DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>=3D=3D=3D native =3D=3D=3D</DIV>=0A=
<DIV dir=3Dltr>root@db1200:~# gcc -v -save-temps -O2 -c t.c -o =
obj1.o<BR>Reading =0A=
specs from =
/usr/lib/gcc/mipsel-unknown-linux-gnu/3.4.4/specs<BR>Configured with: =0A=
/home/edevolder/downloads/crosstool-0.42/build/mipsel-unknown-linux-gnu/g=
cc-3.4.4-glibc-2.3.6/gcc-3.4.4/configure =0A=
--build=3Dx86_64-build_unknown-linux-gnu =
--target=3Dmipsel-unknown-linux-gnu =0A=
--host=3Dmipsel-unknown-linux-gnu --prefix=3D/usr --disable-nls =0A=
--enable-threads=3Dposix --enable-symvers=3Dgnu --enable-__cxa_atexit =0A=
--enable-languages=3Dc,c++ --enable-shared --enable-c99 =0A=
--enable-long-long<BR>Thread model: posix<BR>gcc version =0A=
3.4.4<BR>&nbsp;/usr/libexec/gcc/mipsel-unknown-linux-gnu/3.4.4/cc1 -E =
-quiet -v =0A=
t.c -O2 -o t.iignoring nonexistent directory =0A=
"/usr/lib/gcc/mipsel-unknown-linux-gnu/3.4.4/../../../../mipsel-unknown-l=
inux-gnu/include"<BR>#include =0A=
"..." search starts here:<BR>#include &lt;...&gt; search starts =0A=
here:<BR>&nbsp;/usr/local/include<BR>&nbsp;/usr/lib/gcc/mipsel-unknown-li=
nux-gnu/3.4.4/include<BR>&nbsp;/usr/include<BR>End =0A=
of search =
list.<BR>&nbsp;/usr/libexec/gcc/mipsel-unknown-linux-gnu/3.4.4/cc1 =0A=
-fpreprocessed t.i -quiet -dumpbase t.c -auxbase-strip obj1.o -O2 =
-version -o =0A=
t.s<BR>GNU C version 3.4.4 =0A=
(mipsel-unknown-linux-gnu)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
compiled by GNU C version 3.4.4.<BR>GGC heuristics: --param =
ggc-min-expand=3D47 =0A=
--param =0A=
ggc-min-heapsize=3D31868<BR>&nbsp;/usr/lib/gcc/mipsel-unknown-linux-gnu/3=
.4.4/../../../../mipsel-unknown-linux-gnu/bin/as =0A=
-EL -O2 -no-mdebug -32 -v -KPIC -o obj1.o t.s<BR>GNU assembler version =
2.15 =0A=
(mipsel-unknown-linux-gnu) using BFD version 2.15<BR></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> Thiemo Seufer =0A=
[mailto:ths@networkno.de]<BR><B>Sent:</B> Tue 9/19/2006 11:05 =
AM<BR><B>To:</B> =0A=
Eric DeVolder<BR><B>Cc:</B> linux-mips@linux-mips.org<BR><B>Subject:</B> =
Re: =0A=
Differing results from cross and native compilers<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>Eric DeVolder wrote:<BR>[snip]<BR>&gt; I would have =
thought that =0A=
for this simple example I'd get identical<BR>&gt; results. For reasons I =
have =0A=
yet to figure out, the cross compiler is<BR>&gt; finding better =
optimizations =0A=
than the native, though both are the<BR>&gt; same gcc version. I checked =
the =0A=
specs files, and the two are identical<BR>&gt; other than the =
"cross_compile" =0A=
setting.<BR><BR>Have you checked (with -v) if the assembler gets the =
same =0A=
optimisations<BR>in both cases, and/or (with -save-temps) where in the =
compile =0A=
things<BR>start to diverge?<BR><BR><BR>Thiemo<BR></FONT></P></DIV>=0A=
=0A=
</BODY>=0A=
</HTML>
------_=_NextPart_001_01C6DC0C.BF680F2A--
