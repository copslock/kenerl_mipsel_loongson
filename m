Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4H7GYJ02465
	for linux-mips-outgoing; Thu, 17 May 2001 00:16:34 -0700
Received: from yes.home.krftech.com ([194.90.113.98])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4H7GTF02457
	for <linux-mips@oss.sgi.com>; Thu, 17 May 2001 00:16:30 -0700
Received: from athena.home.krftech.com (shay@athena.home.krftech.com [192.168.71.19])
	by yes.home.krftech.com (8.8.7/8.8.7) with SMTP id KAA08083
	for <linux-mips@oss.sgi.com>; Thu, 17 May 2001 10:16:16 +0300
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_FNXG32012ZGJ3O2J9DUL"
From: Shay Deloya <shay@jungo.com>
Reply-To: shay@jungo.com
Organization: Jungo Corp.
To: linux-mips@oss.sgi.com
Subject: Binutils 2.10 and Dynamic Loader
Date: Thu, 17 May 2001 10:18:51 +0300
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <0105171018510F.16854@athena.home.krftech.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--------------Boundary-00=_FNXG32012ZGJ3O2J9DUL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

I'm trying to use binutils 2.10 (BU) , and compiling x.c file that depend on
 libx.so file that I've created ( both files don't use glibc). The shared
 object has only two variables both initialized of type  int and char*
 ("Welcome").

When compiling the SO with BU 2.8 I see that the <data> section (see below) is
 created for the string with "pointing" to the <.rodata> section, loading the
 file with ld.so.1 makes the relocation OK , by adding the shared library
 address to this offset.

However , compiling the SO with BU 2.10 I see that the <data> section (see
 below) is created for the string without pointing to the <.rodata> section,
 and letting the loader to make 'complicated' relocation using the
 relocation table (elf header). Since rodata is a section , the dynamic
 loader ld.so.1 only adds the offset to that symbol , and there for the
 relocation is done in wrong way. Is it a problem of the 2.10 ld  , or a
 problem of the dynamic loader (libc.2.0.6) ?  does anyone had the same
 problem before ?

BTW , the  copile flags are : 
for the so : -Wl,-dynamic-linker,"/lib/ld.so.1" -nostdlib  -Wl,-e,main  
 	and the mips-linux-ld libx.o -share libx.so
and for the x.c : -nostdlib

Thanks , Shay

2.10
=====
000000005ffe0540 <.rodata>:
    5ffe0540:	57656c63 	0x57656c63
    5ffe0544:	6f6d6500 	0x6f6d6500
	...

0000000060020570 <.data>:
    60020570:	0000000a 	0xa
	...

from readelf on the .so file:

Relocation section '.rel.dyn' at offset 0x550 contains 3 entries:
  Offset    Info  Type            Symbol's Value  Symbol's Name
  00000000  00000 R_MIPS_NONE
  60020574  01f03 R_MIPS_REL32          60020570  num
  60020578  00703 R_MIPS_REL32          5ffe0540  .rodata


2.8
====

000000005ffe04d0 <.rodata>:
    5ffe04d0:	57656c63 	0x57656c63
    5ffe04d4:	6f6d6500 	0x6f6d6500
	...


0000000060020510 <.data>:
    60020510:	0000000a 	0xa
    60020518:	5ffe04d0 	0x5ffe04d0
    6002051c:	00000000 	nop

fro readelf on the .so file:

Relocation section '.rel.dyn' at offset 0x4e0 contains 3 entries:
  Offset    Info  Type            Symbol's Value  Symbol's Name
  00000000  00000 R_MIPS_NONE
  60020514  00003 R_MIPS_REL32
  60020518  00003 R_MIPS_REL32


--------------Boundary-00=_FNXG32012ZGJ3O2J9DUL
Content-Type: text/x-c;
  charset="iso-8859-1";
  name="x.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="x.c"

ZXh0ZXJuIGludCBudW07CmV4dGVybiBjaGFyICpteV9zdHI7IAoKaW50ICpsbnVtID0gJm51bTsK
Y2hhciAqdF9zdHIgPSAiIjsgCgppbnQgeG51bTsKaW50ICpweG51bTsKY2hhciAqeHN0cjsKY2hh
ciAqKnhwc3RyOwpjaGFyICp3X3N0ciA9ICJhYmMiOwppbnQgbWFpbigpCnsKICAgIHRfc3RyID0g
bXlfc3RyOwogICAgCiAgICB4c3RyID0gbXlfc3RyOwogICAgeG51bSA9IG51bTsKICAgIHhwc3Ry
ID0gJm15X3N0cjsKICAgIHB4bnVtID0gJm51bTsKICAgIHJldHVybiAwOwp9Cg==

--------------Boundary-00=_FNXG32012ZGJ3O2J9DUL
Content-Type: text/x-c;
  charset="iso-8859-1";
  name="libx.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="libx.c"

aW50IG51bSA9IDEwOwpjaGFyICogbXlfc3RyID0gIldlbGNvbWUiOwo=

--------------Boundary-00=_FNXG32012ZGJ3O2J9DUL--
