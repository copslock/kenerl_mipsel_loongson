Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA97441 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Apr 1999 21:48:57 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA45070
	for linux-list;
	Wed, 14 Apr 1999 21:48:11 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA51056
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 14 Apr 1999 21:48:09 -0700 (PDT)
	mail_from (matthias@fmc-container.mach.uni-karlsruhe.de)
Received: from mdaxp2.umassd.edu (MDAxp2.UMassD.Edu [134.88.120.67]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA01631
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Apr 1999 21:48:09 -0700 (PDT)
	mail_from (matthias@fmc-container.mach.uni-karlsruhe.de)
Received: from us08-568b-1.res.umassd.edu by umassd.edu (PMDF V5.1-12 #22746)
 with ESMTP id <01JA1KIJ37P48YAOXO@umassd.edu> for linux@cthulhu.engr.sgi.com;
 Thu, 15 Apr 1999 00:48:05 EST
Received: from matthias by us08-568b-1.res.umassd.edu with local
 (Exim 2.05 #1 (Debian)) id 10Xe4i-0000jY-00; Thu, 15 Apr 1999 00:48:28 -0400
Date: Thu, 15 Apr 1999 00:48:28 -0400
From: Matthias Kleinschmidt <mkleinschmidt@gmx.de>
Subject: Re: kernel compilation problem
In-reply-to: <371568F3.FA1E916A@foo.tho.org>; from Charles Lepple on Thu,
 Apr 15, 1999 at 04:20:04AM +0000
To: linux@cthulhu.engr.sgi.com
Message-id: <19990415004828.A2772@fmc-container.mach.uni-karlsruhe.de>
MIME-version: 1.0
X-Mailer: Mutt 0.93i
Content-type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-md5; boundary="J/dobhs11T7y2rNN"
Mail-Followup-To: linux@cthulhu.engr.sgi.com
References: <371568F3.FA1E916A@foo.tho.org>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 15, 1999 at 04:20:04AM +0000, Charles Lepple wrote:
> While configuring the kernel (2.2.5 from ftp.kernel.org), I get the
> following message:

You have to get the kernel from cvs:

export CVSROOT=3D":pserver:cvs@linus.linux.sgi.com:/cvs"
cvs login (cvs as password)
cvs -z3 checkout linux

The config is a little tricky. Look at
ftp.linux.sgi.com/pub/linux/mips/test/vmlinux-indy-990212.conf
as example

> And when I try 'make zImage', it bombs compiling init/main.c

"make zImage" doesn't work. Try "make vmlinux".

Matthias

--=20
Matthias Kleinschmidt
Cedar Dell 568B, Box 5398
UMass Dartmouth
285 Old Westport Rd.
North Dartmouth, MA 02747
Tel.:  +1 508 910 6851
email: matthias@fmc-container.mach.uni-karlsruhe.de

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3ia

iQCVAwUBNxVvm8XMHXe35ITFAQGwjAP/dgjb4KgSCwPj2dKVspadSJMOsWmCfYyj
iINnEjxJVK10kIQghgo4hhAMicBi8bXnmdVhoqXh8fnZM41Sm7h7rD9cf+cOQcqI
6eTz2aLA56u+54F73WB0l6/o1uVoUXKoCBN8kh8j++pV+aMe1NTUkGVfN/Abxf/W
8JB54n0C3tE=
=5Trj
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
