Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Feb 2003 22:48:36 +0000 (GMT)
Received: from noose.gt.owl.de ([IPv6:::ffff:62.52.19.4]:61964 "EHLO
	noose.gt.owl.de") by linux-mips.org with ESMTP id <S8225225AbTBKWsf>;
	Tue, 11 Feb 2003 22:48:35 +0000
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D97CC25E4D; Tue, 11 Feb 2003 23:48:33 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id EAA02B2AB; Tue, 11 Feb 2003 23:46:22 +0100 (CET)
Date: Tue, 11 Feb 2003 23:46:22 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: Guido Guenther <agx@gandalf.physik.uni-konstanz.de>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: porting arcboot
Message-ID: <20030211224622.GC1186@paradigm.rfc822.org>
References: <20030210034549.GA8408@pureza.melbourne.sgi.com> <20030210100319.GA30624@merry> <20030210223955.GF8408@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline
In-Reply-To: <20030210223955.GF8408@pureza.melbourne.sgi.com>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2003 at 09:39:55AM +1100, Andrew Clausen wrote:
>=20
> e2fsprogs looks like it resists cross-compiling also :(
>=20
> So, the obstacles are:
>  * e2fsprogs uses libc headers quite extensively, but there is no
> glibc available for mips64 (right?).  It also seems to make quite a
> few libc calls?  (How are you planning to deal with that?  Link
> against it statically?  What about syscalls?)
>  * e2fsprogs doesn't use autoconf/automake "properly".  It doesn't seem
> to support cross-compiling.  Adding cross-compile support looks
> somewhat non-trivial, since it builds it's own tools to compile itself.
> (A fancy sed replacement, for some reason?)
>  * there is no toolchain to build e2fsprogs on mips64 cleanly... need
> to do that objcopy business.  This means hacking the build process?

You dont need e2fsprogs - Just certain parts of the libe2fs which itself
just uses some very basic libc functions like malloc/free/str* which
we all have within arcboot. So you simple need to cross-compile the
libe2fs.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+SX0+Uaz2rXW+gJcRArIzAJ9z+iK377OzNujfAnEhj8HhijTiZgCeIgXp
VRl1Ayxazda6NSzD94Bz3xg=
=gRjv
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
