Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2003 12:04:27 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:17365 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225466AbTJILEU>; Thu, 9 Oct 2003 12:04:20 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id BAB744B3E4; Thu,  9 Oct 2003 13:04:18 +0200 (CEST)
Date: Thu, 9 Oct 2003 13:04:18 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux-Mips <linux-mips@linux-mips.org>
Subject: Re: What toolchain for vr4181
Message-ID: <20031009110418.GO20846@lug-owl.de>
Mail-Followup-To: Linux-Mips <linux-mips@linux-mips.org>
References: <EIEHIDHKGJLNEPLOGOPOAEIGCFAA.jh@hansen-telecom.dk> <Pine.GSO.4.21.0310091030110.7086-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gWPeGsYce+mZStT1"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0310091030110.7086-100000@waterleaf.sonytel.be>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--gWPeGsYce+mZStT1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-10-09 10:30:57 +0200, Geert Uytterhoeven <geert@linux-m68k.org>
wrote in message <Pine.GSO.4.21.0310091030110.7086-100000@waterleaf.sonytel=
=2Ebe>:
> On Wed, 8 Oct 2003, [iso-8859-1] J=F8rg Ulrich Hansen wrote:
> >=20
> > Where is a good starting point for a toolchain that will build and work?
> > I would prefere to build it my self because at a later state I might bu=
ild
> > it under cygwin. But a prebuild does also have interest.
>=20
> At work we use plain binutils 2.13.2.1 and gcc 3.2.2, which we build ours=
elves
> (host is Solaris/SPARC).

Joined trees? Which configury? Unfortunately, toolchain questions are
quite FAQs, but there doesn't really exist _that_ good HOWTOs which
actually contain exactly helpful hints (eg. which versions and/or which
additional patches are needed).

If companies have some kind of scripts or the like they use, I'd really
love to see them published. That'd really help all those guys out
there:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--gWPeGsYce+mZStT1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/hUCyHb1edYOZ4bsRAoncAJ4hByM37k+Lo+cGoD99tsihz/KiVACfUFKu
6xOvkEANhndGcIastzmt4jE=
=utia
-----END PGP SIGNATURE-----

--gWPeGsYce+mZStT1--
