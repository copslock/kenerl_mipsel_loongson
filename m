Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2007 13:47:32 +0100 (BST)
Received: from [203.94.56.252] ([203.94.56.252]:61711 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S20025375AbXIGMrT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Sep 2007 13:47:19 +0100
Received: (qmail 20325 invoked from network); 7 Sep 2007 12:47:08 -0000
Received: from unknown (HELO ?10.0.0.7?) (10.0.0.7)
  by www.longlandclan.hopto.org with ESMTPS (DHE-RSA-AES256-SHA encrypted); 7 Sep 2007 12:47:08 -0000
Message-ID: <46E14957.7010004@gentoo.org>
Date:	Fri, 07 Sep 2007 22:51:35 +1000
From:	Stuart Longland <redhatter@gentoo.org>
User-Agent: Thunderbird 2.0.0.0 (X11/20070512)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Processor cores for FPGAs... any recommendations?
X-Enigmail-Version: 0.95.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/%7Eredhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enig66BF654A9F4FACE933495587"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig66BF654A9F4FACE933495587
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all...
	This isn't completely on-topic for this list, but I figured I'd ask
here since many of you do FPGA development on a daily basis -- some with
MIPS processor cores, or other embedded CPUs.

	This semester at university, I'm in a group working to produce a
FPGA-based device -- likely some NTP-synced alarm clock that scrolls
reminder messages.

	We've been looking around on OpenCores.org, and noticed the Plasma[1]
MIPS-1 processor core.  We're also looking at JOP[2] and OpenRISC[3],
but I'm liking the look of the Plasma core, since I'm already familiar
with MIPS machines[4].

	We've got use of a NIOS-2 Development kit[5], which is based on an
Altera Cyclone-II FPGA.  It's hoped we can just load another processor
core instead of the NIOS-2 softcore to drive the whole kit... Or would
we be better served getting another development board?  (Or just using
the NIOS-2 softcore?)

	Just wondering what peoples' experiences have been using this processor
core with Linux and/or =B5Clinux?  Are there other processor cores I coul=
d
load onto a FPGA that people would recommend?
--=20
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
=2E . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.

Footnotes:
1. http://www.opencores.org/projects.cgi/web/mips/overview
2. http://www.opencores.org/projects.cgi/web/jop
3. http://www.opencores.org/projects.cgi/web/or1k
4. Although I'm very much a beginner ... my point is I don't know the
others _at all_ ... well, I know Java, but not JOP.
5. http://www.altera.com/products/devkits/altera/kit-Nios-2c35.html


--------------enig66BF654A9F4FACE933495587
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG4UlYuarJ1mMmSrkRCqj+AJ4yhiuzBzWX4cdkLbDC1d3Qy9JiEwCdGqsM
NtEY5XDCZyNofExS24r2wss=
=w1pw
-----END PGP SIGNATURE-----

--------------enig66BF654A9F4FACE933495587--
