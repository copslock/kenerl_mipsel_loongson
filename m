Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 18:39:20 +0100 (BST)
Received: from [IPv6:::ffff:81.187.251.134] ([IPv6:::ffff:81.187.251.134]:7434
	"EHLO getyour.pawsoff.org") by linux-mips.org with ESMTP
	id <S8225787AbUERRjT>; Tue, 18 May 2004 18:39:19 +0100
Received: by getyour.pawsoff.org (Postfix, from userid 1000)
	id B948E38212C; Tue, 18 May 2004 18:39:16 +0100 (BST)
Date: Tue, 18 May 2004 18:39:16 +0100
To: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
Message-ID: <20040518173916.GA29006@getyour.pawsoff.org>
References: <20040513183059.GA25743@getyour.pawsoff.org> <20040518073439.GA6818@skeleton-jack>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20040518073439.GA6818@skeleton-jack>
User-Agent: Mutt/1.5.6i
From: kieran@pawsoff.org (Kieran Fulke)
Return-Path: <kieran@pawsoff.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kieran@pawsoff.org
Precedence: bulk
X-list: linux-mips


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 18, 2004 at 08:34:39AM +0100, Peter Horton wrote:

>=20
> Not quite so esoteric :-)
>=20
> Try changing COBALT_QUBE_SLOT_IRQ from 23 to 9 in
> include/asm/cobalt/cobalt.h.
>=20

that looks embarrassingly simple. building a new kernel now. if only=20
these things were a bit zippier ...

Kieran.

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqkpEOWPbH1PXZ18RAmxxAJ9I6YT2p0mNRW5KAuvy+iDQAKU1VACfTskr
12C2w857ak6+lDM6Nq6k3D8=
=h7S1
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
