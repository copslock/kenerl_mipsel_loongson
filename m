Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2003 18:53:42 +0000 (GMT)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:21124 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225362AbTJ1Sxi>; Tue, 28 Oct 2003 18:53:38 +0000
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id F14444A807; Tue, 28 Oct 2003 19:53:33 +0100 (CET)
Date: Tue, 28 Oct 2003 19:53:33 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: Unresolved symbols
Message-ID: <20031028185333.GV12395@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <Pine.GSO.4.44.0310281308450.20592-100000@ares.mmc.atmel.com> <3F9EB61F.8010906@avtrex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oXXuwmZolLKlWh2N"
Content-Disposition: inline
In-Reply-To: <3F9EB61F.8010906@avtrex.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--oXXuwmZolLKlWh2N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-28 10:31:59 -0800, David Daney <ddaney@avtrex.com>
wrote in message <3F9EB61F.8010906@avtrex.com>:
> David Kesselring wrote:
>=20
> >I've been unabled to track down these errors. I think it's because I don=
't
> >understand how some of the linux h files are used by an independently
> >compiled kernel module. Why is "extern __inline__" used in a file like
> >atomic.h.
> >If any of you have any pointers on the following errors, I'd appreciate
> >your comments.
> >/lib/modules/2.4.22/kernel/net/pcifvnet.o: unresolved symbol
> >atomic_sub_return
> >/lib/modules/2.4.22/kernel/net/pcifvnet.o: unresolved symbol __udelay
> >/lib/modules/2.4.22/kernel/net/pcifvnet.o: unresolved symbol atomic_add
> >/lib/modules/2.4.22/kernel/net/pcifvnet.o: unresolved symbol strcpy
> >/lib/modules/2.4.22/kernel/net/pcifvnet.o: unresolved symbol atomic_sub
> Often if you don't compile with optimization turned on you get things=20
> like this.  You have to compile with optimization set high enough to get=
=20
> inlining enabled.

Right. Once again, if you compile modules outside the kernel, please:

	Use exactly the GCC parameters that are used by in-kernel-tree
			compiled modules!

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--oXXuwmZolLKlWh2N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/nrstHb1edYOZ4bsRAsIbAJ9xtaF1pFfUaWghdnQ//c5LdlK/iQCfZhPY
8ocpYF/Om/tOwEIOvQgKrm0=
=VJaG
-----END PGP SIGNATURE-----

--oXXuwmZolLKlWh2N--
