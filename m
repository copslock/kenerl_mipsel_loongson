Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jul 2004 16:04:20 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:47584 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225002AbUGPPEQ>; Fri, 16 Jul 2004 16:04:16 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 392844B7F9; Fri, 16 Jul 2004 17:04:15 +0200 (CEST)
Date: Fri, 16 Jul 2004 17:04:15 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: Help with MOP network boot install on DECstation 5000/240
Message-ID: <20040716150414.GB2019@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com> <20040710100412.GA23624@linux-mips.org> <00ba01c46823$3729b200$0deca8c0@Ulysses> <20040713003317.GA26715@linux-mips.org> <000701c468ae$141c3e50$0a9913ac@swift> <20040713080320.GC18841@lug-owl.de> <000e01c4696f$f65cf4f0$0a9913ac@swift> <20040714124318.GQ2019@lug-owl.de> <000c01c46b42$fd6f9b60$0a9913ac@swift>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8QTINAT9I+GWM3JK"
Content-Disposition: inline
In-Reply-To: <000c01c46b42$fd6f9b60$0a9913ac@swift>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--8QTINAT9I+GWM3JK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-07-16 22:41:01 +0800, Collin Baillie <collin@xorotude.com>
wrote in message <000c01c46b42$fd6f9b60$0a9913ac@swift>:
> > > > Maybe you'd try Debian's install image?
> > > Maybe, but on a _shared_ 31.2k dialup link, it takes a while to
> download...
> > It's only a couple of megabytes, not a number of CD images.
>=20
> Ok, I found a 4.5MB boot.img file which is supposed to be the netboot deb=
ian
> installer for r3k-kn03 mipsel. mopd doesn't seem to like it's a.out-ness.
> mopchk gives (I named it DEBIAN.SYS for the purpose of mop booting):
>=20
> Checking: DEBIAN.SYS
> Some failure in GetAOutFileInfo
>=20
> Does mopd work with a.out files? I read somewhere it doesn't. Is this the

Depends on your mopd:) There are several mopds around...

> install image you speak of? There doesn't seem to be a cd-rom version. I

Most probably.

> really have difficulties with Debian's site. Any help you guys could offer
> me would be appreciated.

Use a proper mopd like that one from Maciej (he replied earlier in this
thread, containing an URL for it.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--8QTINAT9I+GWM3JK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA9+5uHb1edYOZ4bsRAhh2AJ401VrEjaCluRY+rlPiSyR4AgIA/QCfcF+j
VjpDQt97pTAa7P7Y0hIGAK0=
=Lgbp
-----END PGP SIGNATURE-----

--8QTINAT9I+GWM3JK--
