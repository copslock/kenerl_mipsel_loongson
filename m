Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Oct 2004 19:51:05 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:53535
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224929AbUJBSu7>; Sat, 2 Oct 2004 19:50:59 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CDoyA-0007f4-00
	for <linux-mips@linux-mips.org>; Sat, 02 Oct 2004 20:50:58 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CDoy9-00063G-00
	for <linux-mips@linux-mips.org>; Sat, 02 Oct 2004 20:50:57 +0200
Date: Sat, 2 Oct 2004 20:50:57 +0200
To: linux-mips@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
Message-ID: <20041002185057.GN21351@rembrandt.csv.ica.uni-stuttgart.de>
References: <4152D58B.608@longlandclan.hopto.org> <20040923154855.GA2550@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline
In-Reply-To: <20040923154855.GA2550@paradigm.rfc822.org>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Florian Lohoff wrote:
> On Thu, Sep 23, 2004 at 11:54:19PM +1000, Stuart Longland wrote:
> > 	Using a MIPS64 config (built using gas-abi=3Do32 as suggested by Kumba=
),
> > it doesn't even get that far:
>=20
> There is still a lot left broken - The attached patch fixes some obvious
> stuff with address space and mibs abi.
>=20
> Missing is a fix for ip22zilog.c which seems to be broken.=20
>=20
> With this fix the machines goes userspace (reverse engineered by sound
> of hard disk) but seems to die somewhere. Probably the same bug as seen
> on other archs - die on first fork.

The last problem happens only on r4000 and r4400, and occasionally
also shows up as "illegal instruction" or "unaligned access". It
turned out to be a broken TLB handler. I temporarily switched (for
32bit kernels) from except_vec0_r4000 to except_vec0_r45k_bvahwbug.
This may cause an avoidable performance loss, but at least it allows
my R4400SC-200 (V6.0) Indy to run current 2.6 CVS.


Thiemo

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAkFe+JEACgkQXNuq0tFCNaA85ACfQW7yDdPtv6QGYHdoGnvfzIGO
tngAoK7GzRVBjx4TsTaMEiwAhxnBOqJ5
=Zxyp
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
