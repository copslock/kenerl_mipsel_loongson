Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id SAA150788; Sat, 9 Aug 1997 18:53:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA00021 for linux-list; Sat, 9 Aug 1997 18:53:35 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA29994 for <linux@engr.sgi.com>; Sat, 9 Aug 1997 18:53:32 -0700
Received: from odin.waw.com (ns1.waw.com [194.51.88.250]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA22270
	for <linux@engr.sgi.com>; Sat, 9 Aug 1997 18:53:30 -0700
	env-from (vincent@waw.com)
Received: from odin.waw.com (vincent@mail.waw.com [194.51.88.252]) by odin.waw.com (8.7.3/8.7.3/waw) with SMTP id DAA08014; Sun, 10 Aug 1997 03:57:06 +0100
Date: Sun, 10 Aug 1997 03:57:06 +0100 (GMT+0100)
From: Vincent Renardias <vincent@waw.com>
Reply-To: Vincent Renardias <vincent@waw.com>
To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: your mail
In-Reply-To: <199708092112.XAA01472@informatik.uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.970810033007.7033A-100000@odin.waw.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Sat, 9 Aug 1997, Ralf Baechle wrote:

> > % mips-linux-gcc  -o pwgen pwgen.o -lm
> > /usr/local/mips-linux/lib/libc.a: could not read symbols: Archive has no
> > index; run ranlib to add one
> > 
> > running mips-linux-ranlib on the given file does not change anything.
> > (ie: still getting the same message)
> > 
> > Did I do anything wrong, or is this a problem in the Linux/SGI glibc?
> 
> No.  Looks as if your lib still isn't correctly installed.  If ranlib
> doesn't help, then your libc.a is probably corrupted into a zero lenght
> file.

You're right. (Not an empty file through, but somehow it got truncated to
~50 K). Reinstalling fixed it.

Here's the list of what I compiled so far:

file_3.20.1-6_mips.deb              gzip_1.2.4-15_mips.deb
debmake_3.3.11_mips.deb             grep_2.0-12_mips.deb
dpkg-dev_1.4.0.8_all.deb            makedev_1.6-16_mips.deb
dpkg_1.4.0.8_mips.deb               sysklogd_1.3-17_mips.deb
dpkg_1.4.0.8_mips.nondebbin.tar.gz  update_1.3-1_mips.deb
cpio_2.4.2-11_mips.deb              tar_1.12-1_mips.deb
patch_2.2-1_mips.deb                sed_2.05-15_mips.deb
flex_2.5.4a-1_mips.deb              findutils_4.1-23_mips.deb
bison_1.25-9_mips.deb               shellutils_1.16-4_mips.deb
diff_2.7-13_mips.deb                textutils_1.22-2_mips.deb
rpm_2.4.2-2_mips.deb                pwgen_1-8_mips.deb
adduser_3.6_all.deb

These packages are available from odin.waw.com/pub/linux (the pgp signed
checksums are in the changes/ subdirectory). I'd be glad if someone could
test a few of them and tell me if everything is okay.

Quick install instructions:
untar the file dpkg_1.4.0.8_mips.nondebbin.tar.gz at the root of your FS,
then install other packages with 'dpkg -i foo.deb'.

	Cordialement,

-- 
-     ** Linux **         +-------------------+             ** WAW **     -
-  vincent@debian.org     | RENARDIAS Vincent |          vincent@waw.com  -
-  Debian/GNU Linux       +-------------------+      http://www.waw.com/  -
-  http://www.debian.org/           |            WAW  (33) 4 91 81 21 45  -
---------------------------------------------------------------------------
