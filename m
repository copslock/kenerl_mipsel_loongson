Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1PArZe05329
	for linux-mips-outgoing; Mon, 25 Feb 2002 02:53:35 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1PArS905295
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 02:53:29 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id DEAB57FA; Mon, 25 Feb 2002 10:53:03 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
	id 98A661A3AC; Mon, 25 Feb 2002 10:51:11 +0100 (CET)
Date: Mon, 25 Feb 2002 10:51:11 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: Problem with delo
Message-ID: <20020225095111.GB16992@paradigm.rfc822.org>
References: <20020222191734.B15503@lug-owl.de> <20020223191126.GA18791@paradigm.rfc822.org> <20020224204354.C18596@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <20020224204354.C18596@lug-owl.de>
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 24, 2002 at 08:43:54PM +0100, Jan-Benedict Glaw wrote:
> From my understanding, the stage-2 part is loaded by a known block
> list, but the kernel is then fetched with the help of the e2fs lib.

Which is in the first 512 byte of the DISK

> Delo contains an own version of this lib. Does it work with the
> current ext2 code? ...or is there maybe a Problem with only supporting
> the "old" ext2 code (from 2.0.x time)? I'll test this as soon as I've
> again placed the box on a desk.

Nope - The lib should be quiet recent - My guess was that either you
have a /boot partition and delo trys to follow an interpartition symlink
(Which it cant)

Delo needs a major cleanup - The ELF loader needs to be fully rewritten=20
which i already did in Konstanz (Untestet - Unfinished).

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8egkPUaz2rXW+gJcRAhnkAKDiuaX7rHolMyON+BeQWXNvkZBhFwCeOPZi
rgRRj1PF1/1jle5zDJv0Rto=
=Y6j2
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
