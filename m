Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9TIgBY00996
	for linux-mips-outgoing; Mon, 29 Oct 2001 10:42:11 -0800
Received: from straylight.cyberhqz.com (root@h24-76-98-250.vc.shawcable.net [24.76.98.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9TIg7000993
	for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 10:42:07 -0800
Received: (from rmurray@localhost)
	by straylight.cyberhqz.com (8.9.3/8.9.3/Debian 8.9.3-21) id KAA15694
	for linux-mips@oss.sgi.com; Mon, 29 Oct 2001 10:42:06 -0800
From: Ryan Murray <rmurray@cyberhqz.com>
Date: Mon, 29 Oct 2001 10:42:05 -0800
To: linux-mips@oss.sgi.com
Subject: Re: "relocation truncated to fit"
Message-ID: <20011029104205.J18529@cyberhqz.com>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <5.1.0.14.0.20011029204836.00a63170@192.168.1.5>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Content-Disposition: inline
In-Reply-To: <5.1.0.14.0.20011029204836.00a63170@192.168.1.5>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2001 at 09:08:10PM +0100, Peter Andersson wrote:
> Hi, i am trying to compile mozilla 0.9.5 on my indy running mips/redhat=
=20
> linux 7.0 and get hundreds of messages telling me "relocation truncated t=
o=20
> fit: R_MIPS_GOT16". Does anyone know how to get around this? I tried to a=
dd=20
> the ld flags -G O but without success.

0.9.5 should have a -Wa,-xgot section in the makefile for linux/mips, like
netbsd/mips has.  If it doesn't, you'll need to pull that change from cvs.

You'll also need to ensure that libgcc.a and libc_noshared.a are also built
with -Wa,-xgot

--=20
Ryan Murray, Debian Developer (rmurray@cyberhqz.com, rmurray@debian.org)
The opinions expressed here are my own.

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE73aL9N2Dbz/1mRasRAiI3AJ9seU/aWLVPJ5APF7iGN83HsLzU6QCdGro3
ultlllMudJMn9ePPFHIlAS8=
=XHJM
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--
