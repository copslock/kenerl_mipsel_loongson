Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2003 08:59:25 +0000 (GMT)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:50354 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225373AbTKMI7N>; Thu, 13 Nov 2003 08:59:13 +0000
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 6579E4B456; Thu, 13 Nov 2003 09:59:09 +0100 (CET)
Date: Thu, 13 Nov 2003 09:59:08 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Patch for ALI15x3 - Linux-MIPS kernel 2.4.22-rc3
Message-ID: <20031113085908.GV17497@lug-owl.de>
Mail-Followup-To: Linux-MIPS <linux-mips@linux-mips.org>
References: <1068684992.13276.17.camel@dhcp23.swansea.linux.org.uk> <JCELLCFDJLFKPOBFKGFNEENFCHAA.jack.miller@pioneer-pdt.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="32KBALpRDK42x9o9"
Content-Disposition: inline
In-Reply-To: <JCELLCFDJLFKPOBFKGFNEENFCHAA.jack.miller@pioneer-pdt.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--32KBALpRDK42x9o9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-11-12 17:13:53 -0800, Jack Miller <jack.miller@pioneer-pdt.com>
wrote in message <JCELLCFDJLFKPOBFKGFNEENFCHAA.jack.miller@pioneer-pdt.com>:
>   Alan,
>     I am not so sure of that.  If you look at ide-disk.c:__ide_do_rw_disk=
(),
> there is a local variable assignment statement:
>=20
>   u8 lba48 =3D (drive->addressing =3D 1) ? 1 : 0;
                                 ^^^

Explode. Now, lba48 would _always_ be 1.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--32KBALpRDK42x9o9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/s0fcHb1edYOZ4bsRAgVcAJ9NKlBambfYInuCATuRKSVs6/J5oQCcD1ll
vSOzicsoASnk2gLBmn+w6TM=
=dEC5
-----END PGP SIGNATURE-----

--32KBALpRDK42x9o9--
