Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0IMP2m11996
	for linux-mips-outgoing; Fri, 18 Jan 2002 14:25:02 -0800
Received: from ux3.sp.cs.cmu.edu (UX3.SP.CS.CMU.EDU [128.2.198.103])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0IMOuP11992
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 14:24:56 -0800
Received: from GS256.SP.CS.CMU.EDU by ux3.sp.cs.cmu.edu id aa04181;
          18 Jan 2002 16:24 EST
Subject: Re: thread-ready ABIs
From: Justin Carlson <justincarlson@cmu.edu>
To: drepper@redhat.com
Cc: linux-mips@oss.sgi.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-2fAJiySWyIN6gBSOSi2M"
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 18 Jan 2002 16:24:45 -0500
Message-Id: <1011389085.7765.69.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--=-2fAJiySWyIN6gBSOSi2M
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

For those of us who are slightly behind, could you give some brief
summary of what this thread register hullabaloo is about?  I hadn't been
following this thread, but a search of the archives makes it look like
it hasn't really been explained yet.

_Why_ do we need a general register which is read-only to userland?  Are
you trying to store thread-context information in a fast way?  Why does
this need to happen?

Depending on what the exact requirements are, I could see several ways
to free up a register:

We could, theoretically, free up k1 or k0 (but not both) at the expense
of some time in the stackframe setup at the userland/kernel boundary and
some time in the fast TLB handler.  This wouldn't be read-only from
userland, though, but is that really a hard requirement? =20

There is precedent for hijacking some CP0 registers for purposes other
than originally intended, e.g., the WATCH registers for holding the
kernel stack pointer.  I don't have a mips spec in front of me, though,
so I don't know if any CP0 registers are readable from userland: I seem
to remember that all mfc0 ops are priveleged at the instruction level,
not the register level, though.

-Justin

--=-2fAJiySWyIN6gBSOSi2M
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8SJKd47Lg4cGgb74RAvf6AKDAd7EKEAQIHYuguF68sEcX/0j4cwCgyRwh
HNEZEcjWNgS4q9VIZKgRQJc=
=3T0G
-----END PGP SIGNATURE-----

--=-2fAJiySWyIN6gBSOSi2M--
