Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Sep 2002 10:40:37 +0200 (CEST)
Received: from dvmwest.gt.owl.de ([62.52.24.140]:59663 "EHLO dvmwest.gt.owl.de")
	by linux-mips.org with ESMTP id <S1121744AbSI2Ikg>;
	Sun, 29 Sep 2002 10:40:36 +0200
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id E0FD813376; Sun, 29 Sep 2002 10:40:29 +0200 (CEST)
Date: Sun, 29 Sep 2002 10:40:29 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: R4600 status?
Message-ID: <20020929084029.GJ30466@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <Pine.LNX.4.44.0209282228160.30409-100000@alpha.bocc.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mhOzvPhkurUs4vA9"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209282228160.30409-100000@alpha.bocc.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--mhOzvPhkurUs4vA9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2002-09-28 22:30:56 +0200, Jochen Friedrich <jochen@scram.de>
wrote in message <Pine.LNX.4.44.0209282228160.30409-100000@alpha.bocc.de>:
> Hi,
>=20
> i tried to boot the current (unstable) Debian kernel (2.4.18-r4k-ip22) and
> get the infamous hangs on my Indy at various stages, but very early,
> during boot.
>=20
> ARCH: SGI-IP22
> PROMLIB: ARC firmware Version 1 Revision 10
> CPU: MIPS-R4600 FPU<MIPS-R4600FPC> ICACHE DCACHE
> CPU revision is: 00002010

That's V1.7

> Does this machine suffer from the V1.7 problems, as well? Where can i find
> the current patch?

I've send out some patches some time ago, search for them in list
archives. However, I was told that this CPU is quite broken, and that it
is more-or-less unacceptable to import the changes I send around. When
I'm a bit more experienced with this special MIPS CPU, I'll probably go
and implement it in the way Maciej told... For now, try the old patch,
or fetch a new CPU:-)

MfG, JBG

--=20
   - Eine Freie Meinung in einem Freien Kopf f=FCr
   - einen Freien Staat voll Freier B=FCrger
   						Gegen Zensur im Internet
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--mhOzvPhkurUs4vA9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9lrx9Hb1edYOZ4bsRAn8YAKCBrLNz2f9ayPg7oZ/HlxplmPr3HgCfcVRB
Jg0m5aM+czPE3fh2XrKkeXc=
=BhSG
-----END PGP SIGNATURE-----

--mhOzvPhkurUs4vA9--
