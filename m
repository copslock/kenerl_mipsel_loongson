Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2003 21:33:15 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:37648 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225252AbTFDUdN>; Wed, 4 Jun 2003 21:33:13 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 9A4124AB90; Wed,  4 Jun 2003 22:33:10 +0200 (CEST)
Date: Wed, 4 Jun 2003 22:33:10 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: [PATCH] vmlinux.lds.S
Message-ID: <20030604203310.GS30457@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20030604042037.GD7624@gateway.total-knowledge.com> <20030604065216.GN30457@lug-owl.de> <20030604150025.GE7624@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uNvczuo8OWfsyO2w"
Content-Disposition: inline
In-Reply-To: <20030604150025.GE7624@gateway.total-knowledge.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--uNvczuo8OWfsyO2w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-06-04 08:00:25 -0700, ilya@theIlya.com <ilya@theIlya.com>
wrote in message <20030604150025.GE7624@gateway.total-knowledge.com>:
> Yeap, this is for 2.5.59
> Not anything earlier.
> Without this patch PROM will tell you there is not enough memory to load =
the image.

My machine simply freezed. Looking at a tcpdump, I saw an error code
wich evaluates to "ELF allocation exceeded" - sounds pretty much like
your error...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--uNvczuo8OWfsyO2w
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD4DBQE+3leGHb1edYOZ4bsRArJRAJiXGeaUKGYDG0csN0dnmlb5sbgtAJ9C2vrP
Jwk5bW89/L50nWqK/9r4bA==
=1cE9
-----END PGP SIGNATURE-----

--uNvczuo8OWfsyO2w--
