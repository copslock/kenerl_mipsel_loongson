Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA9KgJH17806
	for linux-mips-outgoing; Fri, 9 Nov 2001 12:42:19 -0800
Received: from ux3.sp.cs.cmu.edu (UX3.SP.CS.CMU.EDU [128.2.198.103])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA9KgE017803
	for <linux-mips@oss.sgi.com>; Fri, 9 Nov 2001 12:42:14 -0800
Received: from GS256.SP.CS.CMU.EDU by ux3.sp.cs.cmu.edu id aa25634;
          9 Nov 2001 15:41 EST
Subject: Re: Which usrland packages should be built for swapon, hostname,and
	grep?
From: Justin Carlson <justincarlson@cmu.edu>
To: Steven Liu <stevenliu@psdc.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <84CE342693F11946B9F54B18C1AB837B14AE21@ex2k.pcs.psdc.com>
References: <84CE342693F11946B9F54B18C1AB837B14AE21@ex2k.pcs.psdc.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-czYppOnrKYR0jYTBuCiV"
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 09 Nov 2001 15:41:49 -0500
Message-Id: <1005338510.8499.3.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--=-czYppOnrKYR0jYTBuCiV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2001-11-09 at 15:16, Steven Liu wrote:
> Hi All:
>=20
> I am porting linux to mips r3000 now and need to build the following
> files for the target board:

>    /bin/hostname,

In net-tools, here:

http://www.tazenda.demon.co.uk/phil/net-tools/

>    /bin/mount,
>     /sbin/swapon,

These are in util-linux, which can be found here:

ftp://ftp.win.tue.nl/pub/linux-local/utils/util-linux

>    /bin/grep.

This is a GNU utility, which can be found at any of the mirrors.  A good
one for the U.S. west coast is here:

ftp://gatekeeper.research.compaq.com/pub/GNU/grep

> Which usrland packages should I use for the above files?
>=20

In general, rpm -qf <program> on an rpm-based distro will often give you
a good idea as to what are the names of the source packages you want.
There's probably something similar for debian, but my debian-fu is weak.

-Justin


--=-czYppOnrKYR0jYTBuCiV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA77D+N47Lg4cGgb74RAuGiAJ9Swl+efUv2L90ysVRboArYsLX9/wCdGunj
LKo/N2jFWJtF95G5eHLogBA=
=YOD3
-----END PGP SIGNATURE-----

--=-czYppOnrKYR0jYTBuCiV--
