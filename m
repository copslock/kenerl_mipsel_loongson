Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2003 21:23:33 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:28649 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225517AbTJUUXb>; Tue, 21 Oct 2003 21:23:31 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 1B58C4B412; Tue, 21 Oct 2003 22:23:28 +0200 (CEST)
Date: Tue, 21 Oct 2003 22:23:28 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: LK201 keyboard
Message-ID: <20031021202328.GO20846@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20031021131033.GM20846@lug-owl.de> <Pine.GSO.3.96.1031021152207.23366D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MTwtopHACupLeWZO"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1031021152207.23366D-100000@delta.ds2.pg.gda.pl>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--MTwtopHACupLeWZO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-21 15:51:21 +0200, Maciej W. Rozycki <macro@ds2.pg.gda.pl>
wrote in message <Pine.GSO.3.96.1031021152207.23366D-100000@delta.ds2.pg.gd=
a.pl>:
> > However, the "Set Mode" command (to set the repeat mode for a block of
> > keys) doesn't work for me on a lk201. Using a lk401 instead, these
> > commands work. Every time I send a set-mode command, I get a Input Error
> > (from the keyboard) sent back...
>=20
>  Strange -- these work for me.

What the "old" lk driver uses is more-or-less what could be referred as
power-on configuration. Even if there are set mode commande - if they
were ignored, it would silently work as expected. Could you set all
groups to "DOWN_UP_MODE" and verify that it no longer works?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--MTwtopHACupLeWZO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/lZXAHb1edYOZ4bsRAm1BAJ9HLgOXTRgqssnkz7CRUNendEmMggCeNwp+
OZBsp67WWsNunItm0YuBNew=
=qxdG
-----END PGP SIGNATURE-----

--MTwtopHACupLeWZO--
