Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA9LEEN18532
	for linux-mips-outgoing; Fri, 9 Nov 2001 13:14:14 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA9LE9018528
	for <linux-mips@oss.sgi.com>; Fri, 9 Nov 2001 13:14:10 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id E2CFA7FA; Fri,  9 Nov 2001 22:14:08 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 1D4F546BC; Fri,  9 Nov 2001 13:13:34 -0800 (PST)
Date: Fri, 9 Nov 2001 13:13:34 -0800
From: Florian Lohoff <flo@rfc822.org>
To: Steven Liu <stevenliu@psdc.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Which usrland packages should be built for swapon, hostname,and grep?
Message-ID: <20011109131334.E8243@paradigm.rfc822.org>
References: <84CE342693F11946B9F54B18C1AB837B14AE21@ex2k.pcs.psdc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Content-Disposition: inline
In-Reply-To: <84CE342693F11946B9F54B18C1AB837B14AE21@ex2k.pcs.psdc.com>
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 09, 2001 at 12:16:11PM -0800, Steven Liu wrote:
> Hi All:
>=20
> I am porting linux to mips r3000 now and need to build the following
> files for the target board:
>     /sbin/swapon,
>    /bin/hostname,
>    /bin/mount,
>    /bin/grep.
> Which usrland packages should I use for the above files?
>=20

A whole userland has been built with debian - You can get it on
the next debian mirror beeing found on www.debian.org.

One problem though might be that you need to fix "sysmips(MIPS_ATOMIC_SET)"
in the kernel to actually run the binarys (glibc 2.2).

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE77Eb9Uaz2rXW+gJcRAqwdAJ4lH3HtWa6oYJ4vEGudKtou7HdD9ACglXhT
VUkQKl8c2IChWQ5fnAwj76Y=
=yiUe
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--
