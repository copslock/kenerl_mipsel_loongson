Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2002 05:15:48 +0100 (CET)
Received: from 12-234-207-60.client.attbi.com ([12.234.207.60]:12430 "HELO
	gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S1122118AbSKNEPr>; Thu, 14 Nov 2002 05:15:47 +0100
Received: (qmail 10822 invoked by uid 502); 14 Nov 2002 04:15:39 -0000
Date: Wed, 13 Nov 2002 20:15:38 -0800
From: ilya@theIlya.com
To: linux-mips@linux-mips.org
Subject: Re: explain to me how this works...
Message-ID: <20021114041538.GB5986@gateway.total-knowledge.com>
References: <20021005095335.B4079@lucon.org> <20021113174200.A2874@wumpus.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v0AS7uCPPFvPHUfF"
Content-Disposition: inline
In-Reply-To: <20021113174200.A2874@wumpus.internal.keyresearch.com>
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--v0AS7uCPPFvPHUfF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

see arch/mips64/kernel/linux32.c

On Wed, Nov 13, 2002 at 05:42:00PM -0800, Greg Lindahl wrote:
> I have a 64-bit kernel and O32 userland.
>=20
> I notice that arping gets confused because the syscall socket() is
> returning 4183 instead of a reasonable value like 3... if strace()
> isn't lying to me.
>=20
> How do I debug this? The O32 userland calls through the socketcall()
> syscall. It looks OK.
>=20
> greg
>=20
>=20
>=20

--v0AS7uCPPFvPHUfF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE90yNq84S94bALfyURAj5EAKDbPqxZXcEhLOjgLkxMv4zWmd3LSACdGimC
gBhrWAg9L8iMcRybNPWI2YY=
=cHNe
-----END PGP SIGNATURE-----

--v0AS7uCPPFvPHUfF--
