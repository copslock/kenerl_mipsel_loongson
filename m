Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g18M4mr11612
	for linux-mips-outgoing; Fri, 8 Feb 2002 14:04:48 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g18M4gA11609
	for <linux-mips@oss.sgi.com>; Fri, 8 Feb 2002 14:04:42 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 2F92284B; Fri,  8 Feb 2002 23:04:22 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 61B8F4162; Fri,  8 Feb 2002 22:58:51 +0100 (CET)
Date: Fri, 8 Feb 2002 22:58:51 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: gdb disassemble bug
Message-ID: <20020208215851.GA18416@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
while debugging arcboot and some interesting crashes related to caching
etc i found a disassemble bug in gdb=20

0x88166b58 <probe_scache+188>:	mtc0	zero,gp
0x88166b5c <probe_scache+192>:	nop
0x88166b60 <probe_scache+196>:	mtc0	zero,sp
0x88166b64 <probe_scache+200>:	nop

mtc0/mfc0 do not address cpu registers but CP0 registers. The decoding
as "gp" or "sp" is not correct. These are "TagLo" and "TagHi".

If somebody has an idea why the kernel crashes when writing to
TagHi - Speak up ... This only seems to happen sometimes not always.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8ZEobUaz2rXW+gJcRAqOBAKDAWzd1m5if/pBuuxQIwTsg0IqMmgCgmiB+
4/jAlCVlpDoUnYy9s259UIM=
=nn3I
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
