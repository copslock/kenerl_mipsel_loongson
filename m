Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jul 2004 16:16:15 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:12992 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8226108AbUGFPQJ>; Tue, 6 Jul 2004 16:16:09 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 5B5D04B7A6; Tue,  6 Jul 2004 17:16:07 +0200 (CEST)
Date: Tue, 6 Jul 2004 17:16:07 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: bootimage for RM300E ?
Message-ID: <20040706151607.GH18841@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <03b101c46351$96679c90$0200000a@ALEC> <1089123113.40eab32979315@www.x-mail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HywGgDAwzDJj9z7S"
Content-Disposition: inline
In-Reply-To: <1089123113.40eab32979315@www.x-mail.net>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--HywGgDAwzDJj9z7S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-07-06 07:11:53 -0800, Thomas Kunze <thomas.kunze@xmail.net>
wrote in message <1089123113.40eab32979315@www.x-mail.net>:
> Quoting Alexander Voropay <a.voropay@vmb-service.ru>:
> > 1) Install a bigendian toolchain at the x86 host box and recompile the
> > Linux kernel.
> > P.5  http://howto.linux-mips.org/mips-howto.html
>=20
> ok i downloaded toolchain.=20
> which kernel should i use? that one from kernel.org or from linux-mips.or=
g ?

linux-mips.org, current CVS checkout. However, I can't tell you if
you're better off using HEAD or the linux_2_4 branch (probably HEAD,
though...).

> what should be done next, after create a kernel ?=20
> what do i need to create a bootimage for the RM300 ?
> how must this bootimage looks like ?
> any howto's ?

Try to feed the kernel image either as ELF or ECOFF via network. The
first step is to make the machine actually *accept* the image (let alone
properly executing it).

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--HywGgDAwzDJj9z7S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA6sI2Hb1edYOZ4bsRAnBjAJ4iskogMpzzJwom4cJK17EjYPQP+ACfaGUS
h4vo1ntdtoPVim4VHUusgqE=
=0H9n
-----END PGP SIGNATURE-----

--HywGgDAwzDJj9z7S--
