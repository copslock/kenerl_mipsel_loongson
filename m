Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Feb 2004 21:05:11 +0000 (GMT)
Received: from noose.gt.owl.de ([IPv6:::ffff:62.52.19.4]:2832 "EHLO
	noose.gt.owl.de") by linux-mips.org with ESMTP id <S8225279AbUBQVFF>;
	Tue, 17 Feb 2004 21:05:05 +0000
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 93DCD25DAE; Tue, 17 Feb 2004 22:05:04 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id D129A13831C; Tue, 17 Feb 2004 22:04:31 +0100 (CET)
Date: Tue, 17 Feb 2004 22:04:31 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@linux-mips.org
Subject: CONFIG_MIPS_RTC for lasat
Message-ID: <20040217210431.GC11511@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Return-Path: <flo@paradigm.rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
it makes sense to set CONFIG_MIPS_RTC in defconfig for lasat as the
board specific get/set_ are implemented:

retrieving revision 1.1.2.37
diff -u -r1.1.2.37 defconfig-lasat
--- arch/mips/defconfig-lasat	11 Feb 2004 15:43:26 -0000	1.1.2.37
+++ arch/mips/defconfig-lasat	17 Feb 2004 21:02:47 -0000
@@ -615,7 +615,7 @@
 # CONFIG_AMD_PM768 is not set
 # CONFIG_NVRAM is not set
 # CONFIG_RTC is not set
-# CONFIG_MIPS_RTC is not set
+CONFIG_MIPS_RTC=3Dy
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAMoHfUaz2rXW+gJcRAiqFAKCfNWlH1isfJtD0Yj74D9+LU0Xj8ACfTpHO
uLfDHaCD9h8x44wrVgB4grE=
=colK
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
