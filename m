Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2004 09:03:06 +0100 (BST)
Received: from noose.gt.owl.de ([IPv6:::ffff:62.52.19.4]:22283 "EHLO
	noose.gt.owl.de") by linux-mips.org with ESMTP id <S8225305AbUDWIDE>;
	Fri, 23 Apr 2004 09:03:04 +0100
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 9DF3C25DE5; Fri, 23 Apr 2004 10:02:58 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 0C56D25C2C9; Fri, 23 Apr 2004 10:02:48 +0200 (CEST)
Date: Fri, 23 Apr 2004 10:02:48 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@linux-mips.org
Subject: MC Parity Error
Message-ID: <20040423080247.GC5814@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
success report for the MC Bus Error handler :)

Apr 19 23:17:32 resume kernel: MC Bus Error
Apr 19 23:17:32 resume kernel: CPU error 0x380<RD PAR > @ 0x0f4c6308
Apr 19 23:17:32 resume kernel: Instruction bus error, epc =3D=3D 2accf310, =
ra =3D=3D 2accf2c8

I guess i have bad memory. The interesting point is that the machine
continued to run for another 2 days. Shouldnt a memory error halt the
machine ?

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAiM2nUaz2rXW+gJcRAuEuAKCWKw8QZ7m1z/wNMOCcHuIaaXfN9gCg13k8
l4K8WfxDBfmNX1GCVVTf/2g=
=bXuP
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
