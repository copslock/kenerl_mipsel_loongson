Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA34667 for <linux-archive@neteng.engr.sgi.com>; Wed, 7 Apr 1999 10:43:15 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA97140
	for linux-list;
	Wed, 7 Apr 1999 10:41:34 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA22811
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 7 Apr 1999 10:41:32 -0700 (PDT)
	mail_from (matthias@fmc-container.mach.uni-karlsruhe.de)
Received: from mdaxp2.umassd.edu (MDAxp2.UMassD.Edu [134.88.120.67]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA00849
	for <linux@cthulhu.engr.sgi.com>; Wed, 7 Apr 1999 10:41:31 -0700 (PDT)
	mail_from (matthias@fmc-container.mach.uni-karlsruhe.de)
Received: from us08-568b-1.res.umassd.edu by umassd.edu (PMDF V5.1-12 #22746)
 with ESMTP id <01J9R56FFIZE8Y99KW@umassd.edu> for linux@cthulhu.engr.sgi.com;
 Wed, 7 Apr 1999 13:41:18 EST
Received: from matthias by us08-568b-1.res.umassd.edu with local
 (Exim 2.05 #1 (Debian)) id 10UwKT-0000Lw-00; Wed, 07 Apr 1999 13:41:33 -0400
Date: Wed, 07 Apr 1999 13:41:33 -0400
From: Matthias Kleinschmidt <mkleinschmidt@gmx.de>
Subject: Re: HAL2 driver 0.2
In-reply-to: <19990407122257.D19733@bun.falkenberg.se>; from Ulf Carlsson on
 Wed, Apr 07, 1999 at 12:22:57PM -0400
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Message-id: <19990407134133.A925@fmc-container.mach.uni-karlsruhe.de>
MIME-version: 1.0
X-Mailer: Mutt 0.93i
Content-type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-md5; boundary=CE+1k2dSO48ffgeK
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>
References: <19990406221641.A6206@bun.falkenberg.se>
 <19990407015956.A2584@fmc-container.mach.uni-karlsruhe.de>
 <19990407122257.D19733@bun.falkenberg.se>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 1999 at 12:22:57PM -0400, Ulf Carlsson wrote:
> Oops, sorry. I had compiled the modules with a kernel configured to set v=
ersion
> information on all symbols. I've uploaded a new version, this problem sho=
uld be
> solved now. Please download alsa-driver-0.3.0-pre5-2.mipseb.rpm instead.

I had version information activated in the first place. Now I compiled the
kernel without it and installed alsa...-pre5-2...  but I still have
unresolved modules.=20

insmod snd.o now gives me

snd.o: unresolved symbol register_sound_dsp_Rb255d4ae
snd.o: unresolved symbol register_sound_special_Rdf061e7e

If my kernel configuration would be helpful it can be found at
http://www-fs.mach.uni-karlsruhe.de/~matthias/.config

Matthias

--=20
Matthias Kleinschmidt
Cedar Dell 568B, Box 5398
UMass Dartmouth
285 Old Westport Rd.
North Dartmouth, MA 02747
Tel.:  +1 508 910 6851
email: matthias@fmc-container.mach.uni-karlsruhe.de

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3ia

iQCVAwUBNwuYzMXMHXe35ITFAQECSQQAiMwpRQdq63cgekF3nMAOaf8r13yoaDMf
6le8OpVf5/C5pa3hz+e5y7TdR3s1HWG0vR7P07mvNXS91M+NyTrjK1ODSDicykuB
wwfkt+QXgZaam1u2xh9zjloi9PSUINgQ7toDnytcDPndPH1qVCchTn407qb6SmB0
rPWGWyQIbqA=
=0g9a
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
