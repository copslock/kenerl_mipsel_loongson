Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA55761 for <linux-archive@neteng.engr.sgi.com>; Wed, 7 Apr 1999 14:17:08 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA27926
	for linux-list;
	Wed, 7 Apr 1999 14:15:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA87348
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 7 Apr 1999 14:15:28 -0700 (PDT)
	mail_from (matthias@fmc-container.mach.uni-karlsruhe.de)
Received: from mdaxp2.umassd.edu (MDAxp2.UMassD.Edu [134.88.120.67]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA04410
	for <linux@cthulhu.engr.sgi.com>; Wed, 7 Apr 1999 14:15:27 -0700 (PDT)
	mail_from (matthias@fmc-container.mach.uni-karlsruhe.de)
Received: from us08-568b-1.res.umassd.edu by umassd.edu (PMDF V5.1-12 #22746)
 with ESMTP id <01J9RCNUON1I8X04WB@umassd.edu> for linux@cthulhu.engr.sgi.com;
 Wed, 7 Apr 1999 17:15:24 EST
Received: from matthias by us08-568b-1.res.umassd.edu with local
 (Exim 2.05 #1 (Debian)) id 10Uzfe-0001GU-00; Wed, 07 Apr 1999 17:15:38 -0400
Date: Wed, 07 Apr 1999 17:15:38 -0400
From: Matthias Kleinschmidt <mkleinschmidt@gmx.de>
Subject: Re: HAL2 driver 0.2
In-reply-to: <19990407202731.A1042@bun.falkenberg.se>; from Ulf Carlsson on
 Wed, Apr 07, 1999 at 08:27:31PM +0200
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Message-id: <19990407171538.A3751@fmc-container.mach.uni-karlsruhe.de>
MIME-version: 1.0
X-Mailer: Mutt 0.93i
Content-type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-md5; boundary="pWyiEgJYm5f9v55/"
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>
References: <19990406221641.A6206@bun.falkenberg.se>
 <19990407015956.A2584@fmc-container.mach.uni-karlsruhe.de>
 <19990407122257.D19733@bun.falkenberg.se>
 <19990407134133.A925@fmc-container.mach.uni-karlsruhe.de>
 <19990407202731.A1042@bun.falkenberg.se>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 1999 at 08:27:31PM +0200, Ulf Carlsson wrote:
> It looks like the rest of the symbols in the kernel are resolved. Maybe y=
ou
> forgot to rebuild the modules or to install them when you built them?

Ok, I apologize. I forgot to rebuild soundcore.o. Now I can load the
modules. But the order in your HOWTO is wrong. I had to load snd-timer
before snd-pcm1. Playing wavs and mpegs works as well after building the
ALSA devices.
Great job!
=20
> Anyhow, in the meanwhile you may build your own driver package. There sho=
uldn't
> be any problem if you have a kernel installed in /usr/src/linux, just get=
 the
> source package of the drivers instead an execute:
>=20
> rpm --rebuild alsa-driver-0.3.0-pre5-2.src.rpm=20

Unfortunately that did not work. Maybe because all files in that package
have timestamps Jan xx 2000?
=20
> (Please have a bit patiance, you're the first tester)

No problem. I'm only trying to help.
=20
Matthias

--=20
Matthias Kleinschmidt
Cedar Dell 568B, Box 5398
UMass Dartmouth
285 Old Westport Rd.
North Dartmouth, MA 02747
Tel.:  +1 508 910 6851
email: matthias@fmc-container.mach.uni-karlsruhe.de

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3ia

iQCVAwUBNwvK+sXMHXe35ITFAQGC1QP+LXgHspf7dYSv4siKcqfvQj5DoSdDuQQr
ZdnId/dcte2k9lITgjwk4o0ridGbDa22OgFin7hLBpSYZ3N01sJuWUy6ET8/QmOT
BTeM4aZ/sVNL9pM1IwignQ2sym3s+2+/JV2QEZiiYAshaOvqSy9Lg8rBKDYNZfHX
2+am9ryQgwA=
=3iJd
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
