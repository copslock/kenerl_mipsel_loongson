Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id WAA12690 for <linux-archive@neteng.engr.sgi.com>; Mon, 18 Jan 1999 22:34:13 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id WAA03882
	for linux-list;
	Mon, 18 Jan 1999 22:33:30 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA98779
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 18 Jan 1999 22:33:28 -0800 (PST)
	mail_from (matthias@fmc-container.mach.uni-karlsruhe.de)
Received: from mdaxp1.umassd.edu (MDAxp1.UMassD.Edu [134.88.120.66]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id WAA02374
	for <linux@cthulhu.engr.sgi.com>; Mon, 18 Jan 1999 22:33:27 -0800 (PST)
	mail_from (matthias@fmc-container.mach.uni-karlsruhe.de)
Received: from us08-568b-1.res.umassd.edu by umassd.edu (PMDF V5.1-12 #22746)
 with ESMTP id <01J6PH116PV68Y5HAY@umassd.edu> for linux@cthulhu.engr.sgi.com;
 Tue, 19 Jan 1999 01:33:25 EST
Received: from matthias by us08-568b-1.res.umassd.edu with local
 (Exim 1.92 #1 (Debian)) id 102Uif-0002Qv-00; Tue, 19 Jan 1999 01:32:57 -0500
Date: Tue, 19 Jan 1999 01:32:57 -0500
From: Matthias Kleinschmidt <mkleinschmidt@gmx.de>
Subject: Re: compiling kernel
In-reply-to: 
 <Pine.LNX.3.96.990118145622.30635J-100000@lager.engsoc.carleton.ca>; from Alex
 deVries on Mon, Jan 18, 1999 at 02:59:01PM -0500
To: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Message-id: <19990119013257.A9273@fmc-container.mach.uni-karlsruhe.de>
MIME-version: 1.0
X-Mailer: Mutt 0.93i
Content-type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-md5; boundary=wac7ysb48OaltWcw
Mail-Followup-To: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
References: <19990118143114.A988@fmc-container.mach.uni-karlsruhe.de>
 <Pine.LNX.3.96.990118145622.30635J-100000@lager.engsoc.carleton.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 18, 1999 at 02:59:01PM -0500, Alex deVries wrote:
> This is usually because you didn't remove the "-N" in arch/mips/Makefile
> or similiar. It's in the FAQ, but I keep forgetting that myself.

Thank you. That helped. I read about this a few weeks ago but since I was
far away from compiling a kernel back then I did not remember it.

> My problem is when I build the kernel, I get nothing at all.  I get the
> first line, something like:
>=20
> 115360+19600+3136+334528+42744d+4248+6368 entry: 0x89fa8840              =
                                                            =20
>=20
> then a blank line, then a total hang, mouse and keybaord included.

Looks like the console output is going to a serial line. Can you connect
over the network.
I do not have a keyboard, mouse and monitor. I get the console output to
the serial line.
Right now I get the output to my terminal but I can't get a login prompt.
However I can connect over the network.

Regards
 Matthias
=20
--=20
Matthias Kleinschmidt
Cedar Dell 568B, Box 5398
UMass Dartmouth
285 Old Westport Rd.
North Dartmouth, MA 02747
email: matthias@fmc-container.mach.uni-karlsruhe.de

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3ia

iQCVAwUBNqQnGMXMHXe35ITFAQEPugP+Pe4BmbaBvSDWd7GghT15oxVbYIticrKq
S6kLDuZwktdXpFi+N6HsgyRgaYXbDHPDJ4ZrkMjtT3Y2bsmrdlpnswX97YF7JZQe
Acb2WI5SqYKzi340W4bXKpJz8PK61B9908sckfPQ+AKDpgh0AjQgs/0tvgnmuRuv
pNwl3lzy+0U=
=iu9g
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
