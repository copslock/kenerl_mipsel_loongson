Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2003 19:51:18 +0000 (GMT)
Received: from noose.gt.owl.de ([IPv6:::ffff:62.52.19.4]:8715 "EHLO
	noose.gt.owl.de") by linux-mips.org with ESMTP id <S8225458AbTKLTvH>;
	Wed, 12 Nov 2003 19:51:07 +0000
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 9E5F425E42; Wed, 12 Nov 2003 20:51:05 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id B994F13806A; Wed, 12 Nov 2003 19:29:56 +0100 (CET)
Date: Wed, 12 Nov 2003 19:29:56 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@linux-mips.org
Subject: lasat mqpro reboots on "heavy" disk i/o
Message-ID: <20031112182956.GA6456@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Return-Path: <flo@paradigm.rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i just updated one of the Lasat mqpro to the latest CVS version as it
was reported that the current kernel (a bit older) reboots on diskio.

I am now running todays CVS version (2.4.22) which still reboots under
heavy disk i/o. I would guess that this is a hardware problem=20
as the machine moved to a different location before the problem seemed
to have appeared first.

Does anyone have a clue ?

Flo
PS: heavy disk i/o caused by a scp of some kernel modules into the
machine
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/snwkUaz2rXW+gJcRArQlAKChe5pVR0JyIu5w4TNyVhjdp6QslQCglSGi
GDvn3gbkyNYnSt6oa0+GpHo=
=1DB1
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
