Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2004 06:42:56 +0000 (GMT)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:947 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225245AbUAGGmW>; Wed, 7 Jan 2004 06:42:22 +0000
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 0F0FD4B492; Wed,  7 Jan 2004 07:42:18 +0100 (CET)
Date: Wed, 7 Jan 2004 07:42:18 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux-Mips <linux-mips@linux-mips.org>
Subject: Re: What toolchain for vr4181
Message-ID: <20040107064218.GJ14285@lug-owl.de>
Mail-Followup-To: Linux-Mips <linux-mips@linux-mips.org>
References: <Pine.GSO.4.21.0310091320000.7430-100000@waterleaf.sonytel.be> <Pine.GSO.4.21.0312282120390.2325-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qhD8kUEc5MK9MdKG"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0312282120390.2325-100000@waterleaf.sonytel.be>
X-Operating-System: Linux mail 2.4.18
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--qhD8kUEc5MK9MdKG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-12-28 21:30:17 +0100, Geert Uytterhoeven <geert@linux-m68k.org>
wrote in message <Pine.GSO.4.21.0312282120390.2325-100000@waterleaf.sonytel=
=2Ebe>:
> BTW, I'd still really like to have some scripts so I can install (from bi=
nary
> or from sources) Debian binaries in my home dir on a Red Hat or Solaris b=
ox.
> Wishful thinking?

Well, 'dpkg-deb -x' does the unpacking, which should be enough for most
of the simple packages. But I can't just come up with a "general"
solution except...

Hmmm. Maybe you can use debootstrap for this purpose.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--qhD8kUEc5MK9MdKG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+6pKHb1edYOZ4bsRAtdJAJ98Ywh1UEUl+DNItd5K+h4zHpp+DQCfd7CW
KaTlZkIswPExH2c2fdH2/n8=
=3hGa
-----END PGP SIGNATURE-----

--qhD8kUEc5MK9MdKG--
