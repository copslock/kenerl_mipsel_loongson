Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA09541 for <linux-archive@neteng.engr.sgi.com>; Fri, 9 Apr 1999 13:57:39 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA40441
	for linux-list;
	Fri, 9 Apr 1999 13:56:28 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA67091
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 9 Apr 1999 13:56:26 -0700 (PDT)
	mail_from (matthias@fmc-container.mach.uni-karlsruhe.de)
Received: from mdaxp1.umassd.edu (MDAxp1.UMassD.Edu [134.88.120.66]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA06065
	for <linux@cthulhu.engr.sgi.com>; Fri, 9 Apr 1999 13:56:25 -0700 (PDT)
	mail_from (matthias@fmc-container.mach.uni-karlsruhe.de)
Received: from us08-568b-1.res.umassd.edu by umassd.edu (PMDF V5.1-12 #22746)
 with ESMTP id <01J9U4KUPJIO8YD7S3@umassd.edu> for linux@cthulhu.engr.sgi.com;
 Fri, 9 Apr 1999 16:56:17 EST
Received: from matthias by us08-568b-1.res.umassd.edu with local
 (Exim 2.05 #1 (Debian)) id 10ViKK-0000x7-00; Fri, 09 Apr 1999 16:56:36 -0400
Date: Fri, 09 Apr 1999 16:56:36 -0400
From: Matthias Kleinschmidt <mkleinschmidt@gmx.de>
Subject: Parallel Port
In-reply-to: <19990409211720.A2015@alpha.franken.de>; from Thomas Bogendoerfer
 on Fri, Apr 09, 1999 at 09:17:20PM +0200
To: linux@cthulhu.engr.sgi.com
Message-id: <19990409165636.A3251@fmc-container.mach.uni-karlsruhe.de>
MIME-version: 1.0
X-Mailer: Mutt 0.93i
Content-type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-md5; boundary=cWoXeonUoKmBZSoM
Mail-Followup-To: linux@cthulhu.engr.sgi.com
References: <19990408223436.A2491@alpha.franken.de>
 <19990408215230.A4951@fmc-container.mach.uni-karlsruhe.de>
 <19990409211720.A2015@alpha.franken.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 09, 1999 at 09:17:20PM +0200, Thomas Bogendoerfer wrote:
> > What about parallel port support? Or am I just unable to find it?
>=20
> who needs it ? These days every sane printer has a ethernet built in or
> is attached to a 386sx Linux box as print server:-) And scanners
> shouldn't be connected to printer ports. But a parallel port driver
> isn't a major deal (as long as it is a _printer_ port) and could be
> done by nearly everbody during a evening hacking session:-)

I would like to have printer support for my Indy because I can't find an
ethernet port on my $140 printer :-) and I would like to connect it to my
Indy rather than to my laptop (so I don't have to plug the printer in and
out every time I take my laptop with me).
And it may be true that nearly everybody (who has the documentation) could
write a driver but I don't have the documentation and I never wrote a device
driver. If it is really that easy it schould not be much work for one of the
Indy kernel hackers.

Matthias

--=20
Matthias Kleinschmidt
Cedar Dell 568B, Box 5398
UMass Dartmouth
285 Old Westport Rd.
North Dartmouth, MA 02747
Tel.:  +1 508 910 6851
email: matthias@fmc-container.mach.uni-karlsruhe.de

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3ia

iQCVAwUBNw5pg8XMHXe35ITFAQEs+QP8DplMiUlOaDSsrwZqDVIhh2bOw/veGzJa
LfYoyQT/80uz40H3j4Z6Jo1fl2kr+bH7Jyn/+55Jx0ovWxq9lsAti7G9hbTabYRE
k4pGe3Na/VVU23/oYBDp2h4ETBIBrLNDtR+IITI6jHwHA2fLLFn8CTv9v/xmsXaw
+hv8yAQOoBw=
=M7Ue
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
