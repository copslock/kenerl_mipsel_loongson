Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1OKi2L05237
	for linux-mips-outgoing; Sun, 24 Feb 2002 12:44:02 -0800
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1OKhv905233
	for <linux-mips@oss.sgi.com>; Sun, 24 Feb 2002 12:43:57 -0800
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 7ACF4A056; Sun, 24 Feb 2002 20:43:54 +0100 (CET)
Date: Sun, 24 Feb 2002 20:43:54 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: Re: Problem with delo
Message-ID: <20020224204354.C18596@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20020222191734.B15503@lug-owl.de> <20020223191126.GA18791@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <20020223191126.GA18791@paradigm.rfc822.org>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2002-02-23 20:11:26 +0100, Florian Lohoff <flo@rfc822.org>
wrote in message <20020223191126.GA18791@paradigm.rfc822.org>:
> On Fri, Feb 22, 2002 at 07:17:34PM +0100, Jan-Benedict Glaw wrote:
> > extfs_open returned Unknown ext2 error(2133571404)
> > Couldnt fetch config.file /etc/delo.conf
>=20
> Hmmm - looks strange ...

=46rom my understanding, the stage-2 part is loaded by a known block
list, but the kernel is then fetched with the help of the e2fs lib.
Delo contains an own version of this lib. Does it work with the
current ext2 code? ...or is there maybe a Problem with only supporting
the "old" ext2 code (from 2.0.x time)? I'll test this as soon as I've
again placed the box on a desk.

MfG, JBG
PS: Windowmaker is running fine on it, but the keyboard mapping is
a bit wrong when running X11. There's no space on the space key:-(

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjx5QnkACgkQHb1edYOZ4bv90QCeMQK36Dtx3o6EGEDZjzB9mZlt
1ooAn1S/oITuVT74ul7IrGnEAtPKyYEA
=skmb
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
