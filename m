Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0ULk0o23401
	for linux-mips-outgoing; Wed, 30 Jan 2002 13:46:00 -0800
Received: from ux3.sp.cs.cmu.edu (UX3.SP.CS.CMU.EDU [128.2.198.103])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0ULjtd23397
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 13:45:55 -0800
Received: from GS256.SP.CS.CMU.EDU ([128.2.199.27]) by ux3.sp.cs.cmu.edu
          id aa22895; 30 Jan 2002 15:44 EST
Subject: RE: Does Linux invalidate TLB entries?
From: Justin Carlson <justincarlson@cmu.edu>
To: Matthew Dharm <mdharm@momenco.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIOECICFAA.mdharm@momenco.com>
References: <NEBBLJGMNKKEEMNLHGAIOECICFAA.mdharm@momenco.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-k4TPAgXG0fufB1r17+Lp"
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 30 Jan 2002 15:44:37 -0500
Message-Id: <1012423478.2356.9.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--=-k4TPAgXG0fufB1r17+Lp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-01-30 at 14:33, Matthew Dharm wrote:
> Damn.  The entire line of processors from the RM7000 to the 7000A,
> 7000B, 7061A, and 7065A all have a bug which involves invalid TLB
> entries.
>=20
> I've sent the errata to Ralf only for review.  Basically, under
> certain circumstances the processor will take the "TLB refill"
> exception vector instead of the "TLB invalid" vector.

What's the behavior if the invalid entry is not fixed up and we replay
the offending instruction?  If there's a guarantee that it won't take
the wrong vector repeatedly, then this would be trivial to fix (and may
not need one at all for correctness).

-Justin


--=-k4TPAgXG0fufB1r17+Lp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8WFs147Lg4cGgb74RAmLgAKCcuBd71rIQ0Z8h9O5ecxFEnqR2iwCcDDOh
L7cQZAoExR2v+/G7KDdENrQ=
=p7Cf
-----END PGP SIGNATURE-----

--=-k4TPAgXG0fufB1r17+Lp--
