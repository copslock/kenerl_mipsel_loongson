Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0UMnos25409
	for linux-mips-outgoing; Wed, 30 Jan 2002 14:49:50 -0800
Received: from ux3.sp.cs.cmu.edu (UX3.SP.CS.CMU.EDU [128.2.198.103])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0UMnjd25405
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 14:49:45 -0800
Received: from GS256.SP.CS.CMU.EDU ([128.2.199.27]) by ux3.sp.cs.cmu.edu
          id aa23722; 30 Jan 2002 16:49 EST
Subject: RE: Does Linux invalidate TLB entries?
From: Justin Carlson <justincarlson@cmu.edu>
To: Matthew Dharm <mdharm@momenco.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIOECKCFAA.mdharm@momenco.com>
References: <NEBBLJGMNKKEEMNLHGAIOECKCFAA.mdharm@momenco.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-iVNs0ZbwdUGw2DF1COWP"
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 30 Jan 2002 16:49:18 -0500
Message-Id: <1012427358.2436.13.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--=-iVNs0ZbwdUGw2DF1COWP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-01-30 at 16:23, Matthew Dharm wrote:
> The errata, unfortunately, doen't say.
>=20
> It does say that the suggested workaround is to use the TLBP operation
> to look for a matching but invalid entry, and then branch to the
> invalid handler if necessary.
>=20
> It also says that the CP0 Cause, EPC, BadVaddr and ENHI will wold the
> values for the dstream TLB exception.  In other words, it's all set up
> for the invalid exception, but it jumps to the refill exception
> instead.

Looking at the linux side a bit closer, I don't think this can ever hit
us.  All the MIPS variants (that I'm familiar with) only use invalid TLB
entries to flush the TLB, and in that case they set up the entries to be
in KSEG0. =20

The only way to trigger an invalid TLB op, then, is to try to do a load
from a proper range in KSEG0 after a flush; in that case the right thing
for the processor to do not a TLB invalid exception anyways, as there is
no TLB-based translation required.  We'd still segfault and die as a
user process, of course, since you can't touch KSEG0, but that's good
and proper.

Anyone else see another case that would be a problem for us?

-Justin


--=-iVNs0ZbwdUGw2DF1COWP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8WGpe47Lg4cGgb74RAj/LAJ9+2zqJ1l7DESYYf39UtVI7tQ+GfgCgyXps
mhq42ZntdUQK1INcX8a0UmI=
=bEU4
-----END PGP SIGNATURE-----

--=-iVNs0ZbwdUGw2DF1COWP--
