Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jul 2004 11:45:58 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:12221 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8226057AbUGFKpy>; Tue, 6 Jul 2004 11:45:54 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id C88D74B7A9; Tue,  6 Jul 2004 12:45:52 +0200 (CEST)
Date: Tue, 6 Jul 2004 12:45:52 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: Linux on SNI RM300E ?
Message-ID: <20040706104552.GX18841@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <03a001c46342$84ce7210$0200000a@ALEC> <1089110477.40ea81cd8e976@www.x-mail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vJ/whQCgo58Oj3Wa"
Content-Disposition: inline
In-Reply-To: <1089110477.40ea81cd8e976@www.x-mail.net>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--vJ/whQCgo58Oj3Wa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-07-06 03:41:17 -0800, Thomas Kunze <thomas.kunze@xmail.net>
wrote in message <1089110477.40ea81cd8e976@www.x-mail.net>:
> >  Do you have an originas OS (SINIX ?) supplied with this server ?
> > Try a `file` GNU utility:
> > $ file <ANY_BINARIES_FROM_THE_ORIGINAL_OS>
> > or
> > $ file <KERNEL_IMAGE_FROM_THE_ORIGINAL_OS>
> >=20
> >  Some modern loaders requires ELF binaries (not COFF) so you should
> > know a full binary file format to load (ELF/COFF/little/bigendian).
>=20
> yepp, sinix reliant 5.44 is installed and boots up. BUT, i have no login =
no password.
> and the previous owner can't remember any login or password. also, i don'=
t have any
> orig. CD's for the RM300E. it seems that the machine is running in bigend=
ian mode.

I don't know what filesystem Sinix used, maybe you can rip off the
disks and attach them to any other Linux box. Possibly you can mount the
filesystem(s), but even if not, you can use a hex editor to zero out
root's password on the raw disk :-)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--vJ/whQCgo58Oj3Wa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA6oLgHb1edYOZ4bsRAo+lAJ9jG7niGvjY6i72pfihNvqiL9KpVACgi/58
XBXLh5qY5LKmpetNZviaj9k=
=8YMb
-----END PGP SIGNATURE-----

--vJ/whQCgo58Oj3Wa--
