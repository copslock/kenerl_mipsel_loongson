Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1M9sKd27153
	for linux-mips-outgoing; Fri, 22 Feb 2002 01:54:20 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1M9sF927150
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 01:54:15 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id E6DE6866; Fri, 22 Feb 2002 09:53:49 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
	id 024BC1A2C8; Fri, 22 Feb 2002 09:52:12 +0100 (CET)
Date: Fri, 22 Feb 2002 09:52:12 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Wayne Gowcher <wgowcher@yahoo.com>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: pthread support in mipsel-linux
Message-ID: <20020222085212.GB21544@paradigm.rfc822.org>
References: <20020221102503.A28936@lucon.org> <20020221184558.33231.qmail@web11906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <20020221184558.33231.qmail@web11906.mail.yahoo.com>
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2002 at 10:45:58AM -0800, Wayne Gowcher wrote:
> It seems like getting pthread support for mips1 could
> be a lengthy and involved process.
>=20
> So I was wondering has anyone out there used pthreads
> for with mips1 with any of the redhat distributions on
> sgi ?

Its just the matter of ll/sc support - There are also some=20
"mips2" which lack ll/sc. There is some kernel emulation for ll/sc and
also SYSMIPS(MIPS_ATOMIC_SET) which should be enough to get pthreads
working on mips1.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8dga8Uaz2rXW+gJcRAiVJAKCi9LxMWEir/x18dCaO00FIe8i6egCg4L0i
O9SzEGnwWIRmfvPzJWr/Ws0=
=nkzU
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
