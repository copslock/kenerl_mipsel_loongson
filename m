Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id JAA136143; Sat, 9 Aug 1997 09:12:52 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA04558 for linux-list; Sat, 9 Aug 1997 09:12:30 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA04548 for <linux@cthulhu.engr.sgi.com>; Sat, 9 Aug 1997 09:12:27 -0700
Received: from odin.waw.com (ns1.waw.com [194.51.88.250]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA11810
	for <linux@cthulhu.engr.sgi.com>; Sat, 9 Aug 1997 09:12:16 -0700
	env-from (vincent@waw.com)
Received: from odin.waw.com (vincent@mail.waw.com [194.51.88.252]) by odin.waw.com (8.7.3/8.7.3/waw) with SMTP id SAA23028 for <linux@cthulhu.engr.sgi.com>; Sat, 9 Aug 1997 18:16:02 +0100
Date: Sat, 9 Aug 1997 18:16:02 +0100 (GMT+0100)
From: Vincent Renardias <vincent@waw.com>
To: linux@cthulhu.engr.sgi.com
In-Reply-To: <199708090123.DAA28961@informatik.uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.970809175116.19882B-100000@odin.waw.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


	Hello,

	I've just joined this ML, and I'm trying to contribute to the
Linux/SGI development. Since I'm not too good at kernel hacking, I've
tough about working on porting the userland part (I have some experience
with this part since I've been a Debian developper for a while and
initiated the Debian/PowerPC port).
	By now I don't have access to any SGI hardware, but i've been able
to build some packages with the crossdev (i486-linux) packages from
ftp.linux.sgi.com.

	So here are my questions:

1/ Which are the 'most wanted' packages not yet recompiled/ported to
Linux/SGI? I've looked at the RPMs available RPM list, and some important
packages seem unavailable yet. (sed,tar,perl come to mind).

2/ While using the crossdev gcc, several times I got complains about a
file 'sgidefs.h' missing (from
/usr/local/lib/gcc-lib/mips-linux/2.7.2/include/va-mips.h, line 41). 
Commenting the '#include' file made the compile work, but I not sure it's
the right fix. 

3/ Can any1 confirm/correct the following values for GNU/autoconf:
ac_cv_c_bigendian=no
ac_cv_c_char_unsigned=no
ac_cv_sizeof_long=4
ac_cv_sizeof_int=4

	Cordialement,

--
-     ** Linux **         +-------------------+             ** WAW **     -
-  vincent@debian.org     | RENARDIAS Vincent |          vincent@waw.com  -
-  Debian/GNU Linux       +-------------------+      http://www.waw.com/  -
-  http://www.debian.org/           |            WAW  (33) 4 91 81 21 45  -
---------------------------------------------------------------------------
