Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Aug 2007 10:27:43 +0100 (BST)
Received: from [203.94.56.252] ([203.94.56.252]:39296 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S20025071AbXHYJ1d (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 25 Aug 2007 10:27:33 +0100
Received: (qmail 13748 invoked from network); 25 Aug 2007 09:26:23 -0000
Received: from unknown (HELO ?10.0.0.7?) (10.0.0.7)
  by www.longlandclan.hopto.org with ESMTPS (DHE-RSA-AES256-SHA encrypted); 25 Aug 2007 09:26:23 -0000
Message-ID: <46CFF67B.9050101@gentoo.org>
Date:	Sat, 25 Aug 2007 19:29:31 +1000
From:	Stuart Longland <redhatter@gentoo.org>
User-Agent: Thunderbird 2.0.0.0 (X11/20070512)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: IP32 RM5200 CPU modules... PROM requirements?
X-Enigmail-Version: 0.95.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/%7Eredhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enig0626FA025259865272CC3530"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0626FA025259865272CC3530
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All...
	This isn't so much a Linux/MIPS related question, but rather an SGI
one, anyway.

	I've recently purchased an RM5200 CPU module for my O2 (which presently
runs a 180MHz R5000).  I powered down the box, pulled the system board
out, and swapped the CPU modules over.

	Upon doing this, I get a "Unsupported CPU type" message on serial
console, and the box refuses to start.  I figure this is because my PROM
is too old to support the RM5200.  Does anyone have any pointers
regarding how one upgrades the PROM?  (I still have both CPU modules.)
Or am I up for a newer system board in order to benefit from the new CPU?=


	Also, once I have the CPU going ... do I need to do anything special
kernel-wise, or will my existing R5000 kernel work?

Regards,
--=20
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
=2E . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.


--------------enig0626FA025259865272CC3530
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGz/Z/uarJ1mMmSrkRCgmzAKCOeuh6F+HbdbsT0iyO4xYf75xzSQCbBQH8
CY7fczO+s2Q4+9jrmWLmS0c=
=dtpW
-----END PGP SIGNATURE-----

--------------enig0626FA025259865272CC3530--
