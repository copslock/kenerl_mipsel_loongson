Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBDI7Wd14693
	for linux-mips-outgoing; Thu, 13 Dec 2001 10:07:32 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBDI7Ro14682
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 10:07:27 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id F32E584A; Thu, 13 Dec 2001 18:07:16 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 04FAF44AF; Thu, 13 Dec 2001 18:05:22 +0100 (CET)
Date: Thu, 13 Dec 2001 18:05:22 +0100
From: Florian Lohoff <flo@rfc822.org>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] /proc/cpuinfo endianess (autoconf dependencie)
Message-ID: <20011213170522.GC25296@paradigm.rfc822.org>
References: <20011213163953.GB23023@paradigm.rfc822.org> <06c701c183f7$d23eb410$5601010a@prefect>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <06c701c183f7$d23eb410$5601010a@prefect>
User-Agent: Mutt/1.3.24i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2001 at 12:01:34PM -0500, Bradley D. LaRonde wrote:
> For autoconf?  Why need to ask the kernel?  Aren't there other very simple
> ways of determining build endianness in userspace?
>=20

Ah - Here is the responsible autoconf bit from config.guess:

   mips:Linux:*:*)
       case `sed -n '/^byte/s/^.*: \(.*\) endian/\1/p' < /proc/cpuinfo` in
         big)    echo mips-unknown-linux-gnu && exit 0 ;;
         little) echo mipsel-unknown-linux-gnu && exit 0 ;;
       esac

This has already been discussed and probably even fixed in autoconf
upstream ...

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8GN/SUaz2rXW+gJcRAmwCAKCGBSI6bvsVsTFbB+PA5CUl3D2SeQCg0IhQ
Ic/7lJheJPfoVXBaRf6LQHA=
=gZC0
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
