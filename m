Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id WAA04062 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Dec 1997 22:59:38 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA22963 for linux-list; Wed, 17 Dec 1997 22:58:15 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA22958 for <linux@engr.sgi.com>; Wed, 17 Dec 1997 22:58:13 -0800
Received: from kbtfw.kubota.co.jp (kbtfw.kubota.co.jp [133.253.102.202]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA17231
	for <linux@engr.sgi.com>; Wed, 17 Dec 1997 22:58:09 -0800
	env-from (tatsuya@na.kubota.co.jp)
Received: by kbtfw.kubota.co.jp; id PAA19110; Thu, 18 Dec 1997 15:57:28 +0900 (JST)
Received: from unknown(133.253.122.1) by kbtfw.kubota.co.jp via smap (3.2)
	id xma019049; Thu, 18 Dec 97 15:57:04 +0900
Received: from nagoya.na.kubota.co.jp by kbtmx.eto.kubota.co.jp (8.8.5+2.7Wbeta5/3.3W9-97112516) with ESMTP
	id PAA26292; Thu, 18 Dec 1997 15:57:00 +0900 (JST)
Received: from katana.na.kubota.co.jp (katana.na.kubota.co.jp [133.253.116.199]) by nagoya.na.kubota.co.jp (8.7.4+2.6Wbeta6/3.4W4-03/20/96) with ESMTP id PAA13514; Thu, 18 Dec 1997 15:54:29 +0900 (JST)
Received: from localhost (localhost [127.0.0.1])
	by katana.na.kubota.co.jp (8.8.8/3.6Wbeta7-971117) with ESMTP id GAA17062;
	Thu, 18 Dec 1997 06:54:28 GMT
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com,
        linux-mips@vger.rutgers.edu
Subject: Please tell me about How to start Linux/MIPS on Magnum4000.
X-Mailer: Mew version 1.92.4 on XEmacs 20.3 (Vatican City)
Mime-Version: 1.0
X-Face-Version: X-Face utility v1.2.9 - "Strawberry Fields Forever"
X-Face: 7i9VD[%efn--h~!0Z<f;D]wdbB>3:KC{oUeq)8FWU<42{]%@#^acK1fs\\6TUBGRocwpkO(
 LhobI1)FDcE6S_8e1Ega2?Mhgd`Efo4X!QZ+=lL#JZ\^VXZ=li'#WYP{I#6t_J'[gGr!w]bVR73j[p
 Q?g7_Y~STbZsHV&^;v2j]1jhM"VJ-^_y~5>7m.rEslEZpf3>4{?{v]ZAg$U`q)&|"Zl-s']/.J09+'
 0I|Tu&bC&bg
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <19971218155427N.tatsuya@na.kubota.co.jp>
Date: Thu, 18 Dec 1997 15:54:27 +0900 (JST)
From: Tatsuya Nakamura <tatsuya@na.kubota.co.jp>
X-Dispatcher: imput version 971024
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hello.

I'm interested in Linux/MIPS.
and I want to use Linux/MIPS.

I got the MIPS Magnum 4000 SC-50 a few weeks ago.
Now I try to start of Linux/MIPS on my Magnum, but couldn't it.

Please help me.

First, I got the milo-0.27.tar.gz, linux-2_1_36_tar.gz, 
from ftp.fnet.fr/linux-mips/src.

And got the cross development tools binutils-2_7-4_tar.gz,
gcc-2_7_2-5_tar.gz, float_h.gz, 
from ftp.fnet.fr/linux-mips/crossdev/mips-sgi-irix6.2/mipsel-linux.
(Now I use Indy with IRIX 6.2)

Install the cross development tools, make the vmlinux(zImage),
and copy the "milo" and "pandora"(binary in the milo-0.27.tar.gz)
and "zImage" to floppy.

When I started the milo(type a:\milo in "Run a Program"),
appear this message:


Linux/MIPS ARC Bootstrap Loader 0.27
Copyright (C) Waldorf Electronics and others 1994, 1995, 1996

Launching Kernel...


and system was stop.

Please tell me the next step.

with best Regards.

+-------------------------------------------+
| KGT Inc,. Nagoya Service Center           |
| Tatsuya Nakamura  tatsuya@na.kubota.co.jp |
+-------------------------------------------+
