Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2003 22:41:03 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:56078 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225239AbTEHVlB>; Thu, 8 May 2003 22:41:01 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 62C654AB98; Thu,  8 May 2003 23:40:57 +0200 (CEST)
Date: Thu, 8 May 2003 23:40:57 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board
Message-ID: <20030508214057.GW27494@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <BAY1-F17fJpbi7Phnzi00006011@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0fs/EiH13ppNklOL"
Content-Disposition: inline
In-Reply-To: <BAY1-F17fJpbi7Phnzi00006011@hotmail.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--0fs/EiH13ppNklOL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-05-08 10:02:54 -0700, Michael Anburaj <michaelanburaj@hotmail.=
com>
wrote in message <BAY1-F17fJpbi7Phnzi00006011@hotmail.com>:
> Hi JBG,
>=20
> The MIPS box (Atlas running YAMON) has a fixed IP address assigned by me.=
=20
> TFTP boot works fine. But this IP is held within the boot monitor program=
=20
> (YAMON).
>=20
> YAMON> set
[...]

That doesn't help you. This is yamon, it's not Linux:)

> Apart from the dynamic IP address assignment methods....
> Suggest me a method to communicate this value to the RAM resident Linux=
=20
> kernel. Or can I assign a fixed IP addredd by passing it as a parameter=
=20

Look at ./linux/net/ipv4/ipconfig.c

> when the linux kernel boots up? If so what is the syntax & please point m=
e=20

Yes.

> to the document that has this info. about passed parameter when booting t=
he=20

The source file is the document, syntax is described there, too.

> kernel.

Please answer under old emails, not above them.

HTH, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--0fs/EiH13ppNklOL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+us7pHb1edYOZ4bsRAut5AKCMN/pjF4/c5+dhg69PtmK76uQpzQCeLvz8
s9qUhSo6JFEI5YlBKqdECLg=
=cLea
-----END PGP SIGNATURE-----

--0fs/EiH13ppNklOL--
