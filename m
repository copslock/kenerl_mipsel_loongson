Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA14416; Wed, 3 Jul 1996 17:27:39 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA10041 for linux-list; Thu, 4 Jul 1996 00:27:35 GMT
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [155.11.228.1]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA10007 for <linux@engr.sgi.com>; Wed, 3 Jul 1996 17:27:24 -0700
Received: from windy.wellington.sgi.com by soyuz.wellington.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/940406.SGI)
	for <linux@engr> id MAA03745; Thu, 4 Jul 1996 12:26:57 +1200
Received: (alambie@localhost) by windy.wellington.sgi.com (950413.SGI.8.6.12/8.6.9) id MAA01564 for linux@engr; Thu, 4 Jul 1996 12:26:56 +1200
From: "Alistair Lambie" <alambie@wellington.sgi.com>
Message-Id: <9607041226.ZM1562@windy.wellington.sgi.com>
Date: Thu, 4 Jul 1996 12:26:56 +0000
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: (Fwd) Libraries uploaded
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

David,

Looks like the new GNU libc stuff needs a newer kernel.  Do you have any plans
to roll to a later one in the near future?

Cheers, Alistair


--- Forwarded mail from Systemkennung Linux <linux@mailhost.uni-koblenz.de>

From: Systemkennung Linux <linux@mailhost.uni-koblenz.de>
Subject: Libraries uploaded
To: linux-mips@fnet.fr, linuxmips@palladium.corp.sgi.com
Date: Wed, 3 Jul 1996 15:45:53 +0200 (MET DST)
Reply-To: Systemkennung Linux <linux@mailhost.uni-koblenz.de>

-----BEGIN PGP SIGNED MESSAGE-----

Hi all,

I've uploaded the first shared library binaries for Linux/MIPS to ftp.fnet.fr
where they'll appear in /linux-mips/ as soon as someone has moved them online.
The binaries are based on GNU libc snapshot 960619.

In order to use these libraries you also have to:

 - Run Linux/MIPS kernel version 2.0.1 or newer.  I'll upload this one rsn.

 - Install new binutils and GCC.  These are yet unreleased; I'll release the
   patches rsn.  This is necessary even if you link your programs static only
   because on MIPS even the static archives contain PIC code which the current
   binutils can't handle.

The dynamic linker clearly still has alpha status; expect to see all sorts of
bugs.  The little endian binaries are those that I use on my system.  I
provide the big endian binaries untested and in the hope that they'll be
usefull.

  Ralf

e015d5d14cd2d9d38c30a01eafc6628f  mips-linuxelf/libc-960619-2.tar.gz
c23155bfbb0a62a119cc2ffae9d54b50  mipsel-linuxelf/libc-960619-2.tar.gz

-----BEGIN PGP SIGNATURE-----
Version: 2.6.2

iQCVAgUBMdp5jUckbl6vezDBAQFqQgP/Vla+a6jK9D5A6xReNq2jTwI0HZdaAI1U
qKQIfq2Q7sSOau4liKpxSTsIg92MG5nmKy4k1lJNAWW0sUwsWFs+JBN1/h7kggcb
2CufsNMju0K5le257ykGe5BmVK27tNzC/SibAU8LVfV2+AehBN+VTdZAAbxWxsnn
7vvgro2IXCg=
=uDU6
-----END PGP SIGNATURE-----


---End of forwarded mail from Systemkennung Linux
<linux@mailhost.uni-koblenz.de>


-- 
Alistair Lambie					    alambie@wellington.sgi.com
Silicon Graphics New Zealand				  SGI Voicemail: 56791
Level 5, Walsh Wrightson Tower,				    Ph: +64-4-802 1455
94-96 Dixon St, Wellington, NZ			  	   Fax: +64-4-802 1459
