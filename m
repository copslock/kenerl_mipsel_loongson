Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 May 2004 18:37:08 +0100 (BST)
Received: from [IPv6:::ffff:81.187.251.134] ([IPv6:::ffff:81.187.251.134]:58897
	"EHLO getyour.pawsoff.org") by linux-mips.org with ESMTP
	id <S8225319AbUEPRhH>; Sun, 16 May 2004 18:37:07 +0100
Received: by getyour.pawsoff.org (Postfix, from userid 1000)
	id 40A9338212C; Sun, 16 May 2004 18:37:06 +0100 (BST)
Date: Sun, 16 May 2004 18:37:06 +0100
To: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
Message-ID: <20040516173706.GA14977@getyour.pawsoff.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
From: kieran@pawsoff.org (Kieran Fulke)
Return-Path: <kieran@pawsoff.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kieran@pawsoff.org
Precedence: bulk
X-list: linux-mips


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 16, 2004 at 07:21:43PM +0200, Johannes Stezenbach wrote:

>=20
> 100002 is just where note_interrupt() disables an unhandled irq, so
> maybe Kieran's report that the tulip card works was wrong?
>=20

interesting. the card pulled an ip address from dhcp happily enough, but i'=
ll see if it'll=20
pull data back and forth.=20

Kieran.

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAp6bBOWPbH1PXZ18RAjDwAJ4l+ksP1E0CP4BcNy1BcKaTPeqtTACbBPzv
qHFLN1yM7vTdwJEUWTtI/Ys=
=sCtL
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
