Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2003 07:52:23 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:65029 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225244AbTFDGwU>; Wed, 4 Jun 2003 07:52:20 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 9064E4AB9E; Wed,  4 Jun 2003 08:52:17 +0200 (CEST)
Date: Wed, 4 Jun 2003 08:52:16 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: [PATCH] vmlinux.lds.S
Message-ID: <20030604065216.GN30457@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20030604042037.GD7624@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GEn4szYucjS2InE7"
Content-Disposition: inline
In-Reply-To: <20030604042037.GD7624@gateway.total-knowledge.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--GEn4szYucjS2InE7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-06-03 21:20:38 -0700, ilya@theIlya.com <ilya@theIlya.com>
wrote in message <20030604042037.GD7624@gateway.total-knowledge.com>:
> Without this generated image is weired, and cannot be loaded.
>=20
> Index: arch/mips64/vmlinux.lds.S
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /home/cvs/linux/arch/mips64/vmlinux.lds.S,v
> retrieving revision 1.11
> diff -u -r1.11 vmlinux.lds.S
> --- arch/mips64/vmlinux.lds.S   3 Jun 2003 17:04:11 -0000       1.11
> +++ arch/mips64/vmlinux.lds.S   4 Jun 2003 04:18:05 -0000
> @@ -46,6 +46,7 @@
>    __kallsyms : { *(__kallsyms) }
>    __stop___kallsyms =3D .;
> =20
> +  RODATA
>    . =3D ALIGN(64);
> =20
>    /* writeable */


This is for 2.5.x? Maybe that's even what prevents my Indy to boot
(using a 32bit kernel). I'll test that tonight;)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--GEn4szYucjS2InE7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+3ZcgHb1edYOZ4bsRAtWCAJ0d2R1X5hmrHhfm26eekjg9pDT5DQCeOIwD
+XsLYozv7PrHgEbp2j522SE=
=z/tK
-----END PGP SIGNATURE-----

--GEn4szYucjS2InE7--
