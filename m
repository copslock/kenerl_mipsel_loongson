Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2007 05:56:33 +0100 (BST)
Received: from [203.94.56.252] ([203.94.56.252]:23677 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S20023424AbXH1E4V (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Aug 2007 05:56:21 +0100
Received: (qmail 28321 invoked from network); 28 Aug 2007 04:55:10 -0000
Received: from unknown (HELO ?10.0.0.7?) (10.0.0.7)
  by www.longlandclan.hopto.org with ESMTPS (DHE-RSA-AES256-SHA encrypted); 28 Aug 2007 04:55:10 -0000
Message-ID: <46D3ABA1.4070907@gentoo.org>
Date:	Tue, 28 Aug 2007 14:59:13 +1000
From:	Stuart Longland <redhatter@gentoo.org>
User-Agent: Thunderbird 2.0.0.0 (X11/20070512)
MIME-Version: 1.0
To:	"J. Scott Kasten" <jscottkasten@yahoo.com>
CC:	linux-mips@linux-mips.org
Subject: Re: IP32 RM5200 CPU modules... PROM requirements?
References: <46CFF67B.9050101@gentoo.org> <Pine.SGI.4.60.0708252042140.4891@zeus.tetracon-eng.net>
In-Reply-To: <Pine.SGI.4.60.0708252042140.4891@zeus.tetracon-eng.net>
X-Enigmail-Version: 0.95.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/%7Eredhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enig91C2036BA717C7294573FE82"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig91C2036BA717C7294573FE82
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

J. Scott Kasten wrote:
>=20
> Do you still have a bootable IRIX image for your O2?  If so, kick into
> swmgr and look to see if it lists the O2 prom update package as
> installed. I don't think it is part of the default install, but is on
> the overlays. Once you have that on the box, use swmgr to list the file=
s
> in the package and locate any docs, man pages, etc...
>=20
> RM5200 is a specific kernel target for the linux builds.
>=20
> -S-

Hi,
	Unfortuantely, no... I did have IRIX on the HDD when I first got the
box last year, that was the first thing to go when I installed Linux.  I
managed to download IRIX 6.5.30 off SGI's website, but I still lack the
foundation CD packages.

	I've figured out how to netboot IRIX off a Linux server (just grab sw
and miniroot/unix.IP32 off the first overlay CD and stuff them on a
convenient TFTP server) and even install things.  However, I get loads
of conflicts in the "inst" utility, and the end result is a system
lacking just about every core component of IRIX.

	I'd be nice if SGI just released a bare-iron IRIX install that *just*
had flashinst for this purpose... but fat chance of that happening.
(Heck, even releasing tarballs of the Foundation CDs would be nice...
hint hint SGI?)

	I've looked around on NekoChan's forums (as suggested by Regan Russel
privately), most of the people there installed IRIX 6.5 straight away,
and thus probably never will face this issue since their PROMs will be
updated automatically during this installation process.  For the purpose
of the archives (and anyone else who may strike this issue), the message
I get is this when the RM5200 CPU is installed:

> Not supported CPU type. PRid<impl>=3D0x28
>=20
> PANIC: assertion failure (IMPOSSIBLE) in file cache_mi.c at line 203

Regards,
--=20
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
=2E . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.


--------------enig91C2036BA717C7294573FE82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG06umuarJ1mMmSrkRCorVAJ0Xe7ztpjauDHshuyKFEAfUVytGRQCfeMcL
qWPqEuDX0XZ1qrX0mIrS4AE=
=S97J
-----END PGP SIGNATURE-----

--------------enig91C2036BA717C7294573FE82--
