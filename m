Received:  by oss.sgi.com id <S305159AbPKBVvr>;
	Tue, 2 Nov 1999 13:51:47 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:42802 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbPKBVv0>; Tue, 2 Nov 1999 13:51:26 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id NAA06349
	for <linuxmips@oss.sgi.com>; Tue, 2 Nov 1999 13:56:56 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA43277
	for linux-list;
	Tue, 2 Nov 1999 13:27:44 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA43716
	for <linux@engr.sgi.com>;
	Tue, 2 Nov 1999 13:27:41 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from tower.ti.com (tower.ti.com [192.94.94.5]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA8231850
	for <linux@engr.sgi.com>; Tue, 2 Nov 1999 13:27:35 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from dlep4.itg.ti.com ([157.170.188.63])
	by tower.ti.com (8.9.3/8.9.3) with ESMTP id PAA17494
	for <linux@engr.sgi.com>; Tue, 2 Nov 1999 15:27:31 -0600 (CST)
Received: from jharrell_dt. (IDENT:jharrell@ppp-isbas99-136.itg.ti.com [192.168.134.136])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with SMTP id PAA11389
	for <linux@engr.sgi.com>; Tue, 2 Nov 1999 15:27:27 -0600 (CST)
From:   Jeff Harrell <jharrell@ti.com>
Date:   Tue, 02 Nov 1999 21:30:37 GMT
Message-ID: <19991102.21303700@jharrell_dt.>
Subject: SGI, MIPS, Hardhat Linux question...
To:     linux@cthulhu.engr.sgi.com
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.1; Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="------------=_4D4800DA40A80827CD08"
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

--------------=_4D4800DA40A80827CD08
Content-Description: filename="text1.txt"
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I am currently working on a project that is using a MIPS R4x00 core on a=
=20
single board computer and would like to leverage the work the SGI team=20
has done on the MIPS/Linux port.  I have downloaded the kernel source=20
code for Hardhat Linux  (kernel 2.1.100) and applied the patches (i.e., =
=20
kernel-2.1.100-sgi.patch and kernel-mips-link.patch).  I have also=20
downloaded Ralf Bachle's cross compiler tools (486-linux -> MIPS).  We=20
are using the little endian version of the tools.   I copied the kernel =

files to my home directory under the structure <my_home_dir>\work\linux =
=20
and applied the patches.  The patches applied properly.  I then did a=20
default configuration, following the file kernel-config.sgi as a=20
template.  I built the dependencies ( make CROSS_COMPILE=3Dmipsel-linux-=
=20
dep) and did not get any errors.  The problem seems to occur when I=20
attempt to build the compressed image, I enter the command:
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
make CROSS_COMPILE=3Dmipsel-linux- zImage
mipsel-linux-gcc -D__KERNEL__ -I/home/jharrell/work/linux/include=20
-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls=20
-fno-pic -g -mcpu=3Dr4600 -mips2 -pipe  -c -o init/main.o init/main.c
/home/jharrell/work/linux/include/asm/string.h: In function `bcopy':
In file included from=20
/home/jharrell/work/linux/include/linux/string.h:39,
                 from=20
/home/jharrell/work/linux/include/asm/termios.h:99,
                 from=20
/home/jharrell/work/linux/include/linux/termios.h:5,
                 from=20
/home/jharrell/work/linux/include/linux/tty.h:20,
                 from=20
/home/jharrell/work/linux/include/linux/sched.h:20,
                 from init/main.c:17:
/home/jharrell/work/linux/include/asm/string.h:134: warning: control=20
reaches end of non-void function
/home/jharrell/work/linux/include/linux/sched.h: In function `suser':
In file included from init/main.c:17:
/home/jharrell/work/linux/include/linux/sched.h:545: `current'=20
undeclared (first use this function)
/home/jharrell/work/linux/include/linux/sched.h:545: (Each undeclared=20
identifier is reported only once
/home/jharrell/work/linux/include/linux/sched.h:545: for each function=20
it appears in.)
/home/jharrell/work/linux/include/linux/sched.h: In function `fsuser':
/home/jharrell/work/linux/include/linux/sched.h:554: `current'=20
undeclared (first use this function)
/home/jharrell/work/linux/include/linux/sched.h: In function=20
`capable':
/home/jharrell/work/linux/include/linux/sched.h:572: `current'=20
undeclared (first use this function)
/home/jharrell/work/linux/include/linux/mm.h: In function=20
`expand_stack':
In file included from=20
/home/jharrell/work/linux/include/linux/slab.h:14,
                 from=20
/home/jharrell/work/linux/include/linux/malloc.h:4,
                 from=20
/home/jharrell/work/linux/include/linux/proc_fs.h:6,
                 from init/main.c:25:
/home/jharrell/work/linux/include/linux/mm.h:359: `current' undeclared=20
(first use this function)
make: *** [init/main.o] Error 1
Compilation exited abnormally with code 2 at Tue Nov  2 14:14:55
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -=20
- - - -

I checked the linkage in the linux/include directory and a link exists=20
between  asm and mips-asm.  For some reason it is not able to find the=20
files located in the include/asm directory,  I looked over the gcc man=20
page and read that if a  -I is used as a parameter to gcc, it should=20
be the first directory examined in the search patch.....It seems to=20
have problems with the #include <asm/current.h>.  Am I missing=20
something? Hmmm....

A second question I would like to ask is concerning the Hardhat=20
distribution,  Is this the best starting place to get an embedded=20
version of MIPS/Linux?  Is there a better distribution (i.e.=20
Cross-compilation tools, etc., that uses a more current version of the=20
kernel?)  Any information available would be greatly appreciated....

Thanks,
Jeff Harrell

Jeff Harrell (jharrell@ti.com)		work: (801) 984-0183
TI / Broadband Access Group






--------------=_4D4800DA40A80827CD08
Content-Description: filename="text1.html"
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
	<TITLE>SGI, MIPS, Hardhat Linux question...</TITLE>
	<META NAME=3D"GENERATOR" CONTENT=3D"StarOffice/5.1 (Linux)">
	<META NAME=3D"CREATED" CONTENT=3D"19991102;14000300">
	<META NAME=3D"CHANGEDBY" CONTENT=3D"Jeff Harrell">
	<META NAME=3D"CHANGED" CONTENT=3D"19991102;14303400">
</HEAD>
<BODY>
<P>I am currently working on a project that is using a MIPS R4x00 core
on a single board computer and would like to leverage the work the SGI
team has done on the MIPS/Linux port.  I have downloaded the kernel
source code for Hardhat Linux  (kernel 2.1.100) and applied the patches
(i.e.,  kernel-2.1.100-sgi.patch and kernel-mips-link.patch).  I have
also downloaded Ralf Bachle's cross compiler tools (486-linux -&gt;
MIPS).  We are using the little endian version of the tools.   I copied
the kernel files to my home directory under the structure
&lt;my_home_dir&gt;\work\linux  and applied the patches.  The patches
applied properly.  I then did a default configuration, following the
file kernel-config.sgi as a template.  I built the dependencies ( make
CROSS_COMPILE=3Dmipsel-linux- dep) and did not get any errors.  The
problem seems to occur when I attempt to build the compressed image, I
enter the command:</P>
<P STYLE=3D"margin-bottom: 0in">- - - - - - - - - - - - - - - - - - - - =
-
- - - - - - - - - - - - -</P>
<P STYLE=3D"margin-bottom: 0in">make CROSS_COMPILE=3Dmipsel-linux- zImag=
e</P>
<P STYLE=3D"margin-bottom: 0in">mipsel-linux-gcc -D__KERNEL__
-I/home/jharrell/work/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -g -mcpu=3Dr4600 -mips2=

-pipe  -c -o init/main.o init/main.c</P>
<P STYLE=3D"margin-bottom: 0in">/home/jharrell/work/linux/include/asm/st=
ring.h:
In function `bcopy':</P>
<P STYLE=3D"margin-bottom: 0in">In file included from
/home/jharrell/work/linux/include/linux/string.h:39,</P>
<P STYLE=3D"margin-bottom: 0in">                 from
/home/jharrell/work/linux/include/asm/termios.h:99,</P>
<P STYLE=3D"margin-bottom: 0in">                 from
/home/jharrell/work/linux/include/linux/termios.h:5,</P>
<P STYLE=3D"margin-bottom: 0in">                 from
/home/jharrell/work/linux/include/linux/tty.h:20,</P>
<P STYLE=3D"margin-bottom: 0in">                 from
/home/jharrell/work/linux/include/linux/sched.h:20,</P>
<P STYLE=3D"margin-bottom: 0in">                 from init/main.c:17:</P=
>
<P STYLE=3D"margin-bottom: 0in">/home/jharrell/work/linux/include/asm/st=
ring.h:134:
warning: control reaches end of non-void function</P>
<P STYLE=3D"margin-bottom: 0in">/home/jharrell/work/linux/include/linux/=
sched.h:
In function `suser':</P>
<P STYLE=3D"margin-bottom: 0in">In file included from init/main.c:17:</P=
>
<P STYLE=3D"margin-bottom: 0in">/home/jharrell/work/linux/include/linux/=
sched.h:545:
`current' undeclared (first use this function)</P>
<P STYLE=3D"margin-bottom: 0in">/home/jharrell/work/linux/include/linux/=
sched.h:545:
(Each undeclared identifier is reported only once</P>
<P STYLE=3D"margin-bottom: 0in">/home/jharrell/work/linux/include/linux/=
sched.h:545:
for each function it appears in.)</P>
<P STYLE=3D"margin-bottom: 0in">/home/jharrell/work/linux/include/linux/=
sched.h:
In function `fsuser':</P>
<P STYLE=3D"margin-bottom: 0in">/home/jharrell/work/linux/include/linux/=
sched.h:554:
`current' undeclared (first use this function)</P>
<P STYLE=3D"margin-bottom: 0in">/home/jharrell/work/linux/include/linux/=
sched.h:
In function `capable':</P>
<P STYLE=3D"margin-bottom: 0in">/home/jharrell/work/linux/include/linux/=
sched.h:572:
`current' undeclared (first use this function)</P>
<P STYLE=3D"margin-bottom: 0in">/home/jharrell/work/linux/include/linux/=
mm.h:
In function `expand_stack':</P>
<P STYLE=3D"margin-bottom: 0in">In file included from
/home/jharrell/work/linux/include/linux/slab.h:14,</P>
<P STYLE=3D"margin-bottom: 0in">                 from
/home/jharrell/work/linux/include/linux/malloc.h:4,</P>
<P STYLE=3D"margin-bottom: 0in">                 from
/home/jharrell/work/linux/include/linux/proc_fs.h:6,</P>
<P STYLE=3D"margin-bottom: 0in">                 from init/main.c:25:</P=
>
<P STYLE=3D"margin-bottom: 0in">/home/jharrell/work/linux/include/linux/=
mm.h:359:
`current' undeclared (first use this function)</P>
<P STYLE=3D"margin-bottom: 0in">make: *** [init/main.o] Error 1</P>
<P STYLE=3D"margin-bottom: 0in">Compilation exited abnormally with code =
2
at Tue Nov  2 14:14:55</P>
<P STYLE=3D"margin-bottom: 0in">- - - - - - - - - - - - - - - - - - - - =
-
- - - - - - - - - - - - - - - - - -</P>
<P STYLE=3D"margin-bottom: 0in"><BR>
</P>
<P STYLE=3D"margin-bottom: 0in">I checked the linkage in the
linux/include directory and a link exists between  asm and mips-asm.=20
For some reason it is not able to find the files located in the
include/asm directory,  I looked over the gcc man page and read that if
a  -I is used as a parameter to gcc, it should be the first directory
examined in the search patch.....It seems to have problems with the
#include &lt;asm/current.h&gt;.  Am I missing something? Hmmm....</P>
<P STYLE=3D"margin-bottom: 0in"><BR>
</P>
<P STYLE=3D"margin-bottom: 0in">A second question I would like to ask is=

concerning the Hardhat distribution,  Is this the best starting place
to get an embedded version of MIPS/Linux?  Is there a better
distribution (i.e. Cross-compilation tools, etc., that uses a more
current version of the kernel?)  Any information available would be
greatly appreciated....</P>
<P STYLE=3D"margin-bottom: 0in"><BR>
</P>
<P STYLE=3D"margin-bottom: 0in">Thanks,</P>
<P STYLE=3D"margin-bottom: 0in">Jeff Harrell</P>
<P STYLE=3D"margin-bottom: 0in; border-top: none; border-bottom: 1px sol=
id #000000; border-left: none; border-right: none; padding: 0.03in">
<BR>
</P>
<P STYLE=3D"margin-bottom: 0in">Jeff Harrell (<A HREF=3D"mailto:jharrell=
@ti.com">jharrell@ti.com</A>)		work:
(801) 984-0183</P>
<P STYLE=3D"margin-bottom: 0in; border-top: none; border-bottom: 1px sol=
id #000000; border-left: none; border-right: none; padding: 0.03in">
TI / Broadband Access Group</P>
<P STYLE=3D"margin-bottom: 0in"><BR>
</P>
<P STYLE=3D"margin-bottom: 0in"><BR>
</P>
<P STYLE=3D"margin-bottom: 0in"><BR>
</P>
<P STYLE=3D"margin-bottom: 0in"><BR>
</P>
</BODY>
</HTML>

--------------=_4D4800DA40A80827CD08--
