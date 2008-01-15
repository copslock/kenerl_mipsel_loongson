Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 15:26:55 +0000 (GMT)
Received: from spider.morgul.net ([128.30.28.25]:47081 "EHLO spider.morgul.net")
	by ftp.linux-mips.org with ESMTP id S20037212AbYAOP0q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 15 Jan 2008 15:26:46 +0000
Received: from frodo by spider.morgul.net with local (Exim 4.63)
	(envelope-from <frodo@morgul.net>)
	id 1JEnga-0001mR-Oh; Tue, 15 Jan 2008 10:26:44 -0500
Date:	Tue, 15 Jan 2008 10:26:44 -0500
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: memory related kernel bug on cobalt raq2
Message-ID: <20080115152644.GP3899@morgul.net>
References: <20080114153114.GN3899@morgul.net> <20080115153225.1ee724c8.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vDEbda84Uy/oId5W"
Content-Disposition: inline
In-Reply-To: <20080115153225.1ee724c8.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Noah Meyerhans <frodo@morgul.net>
Return-Path: <frodo@morgul.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frodo@morgul.net
Precedence: bulk
X-list: linux-mips


--vDEbda84Uy/oId5W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2008 at 03:32:25PM +0900, Yoichi Yuasa wrote:
> On Mon, 14 Jan 2008 10:31:14 -0500
> Noah Meyerhans <frodo@morgul.net> wrote:
>=20
> > Hi all.  I know this has come up in the past, but in case it's helpful,=
 I
> > figured I'd report that the kernel bug previously reported at (at least)
> > http://www.linux-mips.org/archives/linux-mips/2007-10/msg00093.html is =
still
> > present in current git kernels (more recently observed in
> > 2.6.24-rc7-raq2-gaeb7040e-dirty).  Here's the kernel output:
>=20
> Do you use swap on your raq2?
>=20

Yes, I have 256 MB RAM and 500 MB swap.

noah


--vDEbda84Uy/oId5W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHjNC0YrVLjBFATsMRAnOdAJsGAr75pkXdpxyYtnavE+ngZaXqnQCeN1M7
Y9/wGbvGwftzXCmVcYCrmkQ=
=L1Av
-----END PGP SIGNATURE-----

--vDEbda84Uy/oId5W--
