Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6KIckRw007743
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 20 Jul 2002 11:38:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6KIckeT007742
	for linux-mips-outgoing; Sat, 20 Jul 2002 11:38:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6KIcbRw007733
	for <linux-mips@oss.sgi.com>; Sat, 20 Jul 2002 11:38:37 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 0AB5B13585; Sat, 20 Jul 2002 20:39:20 +0200 (CEST)
Date: Sat, 20 Jul 2002 20:39:19 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: [uHOWTO] Booting a DECstation via MOP
Message-ID: <20020720183919.GV8891@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O6iH21V1A1PEFpM6"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--O6iH21V1A1PEFpM6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've needed several attempts to get my /200 booting. This box mainly has
the problem of not being capable of doing tftp, which is kind of a
problem (especially if you've not got a bootable hard disk drive handy).

So you need a mopd daemon and might attempt to try a 'apt-get install
mopd'. Don't do it, it's not worth waiting now bandwidth. Basically,
this mopd isn't capable of booting an ELF kernel (like ./linux/vmlinux),
but will only accelt a.out images (or proprietary DEC images) which
cannot be created in an easy manner (at least, *I* don't know how to do
it...).

Instead of apt-get'ing a mopd, go to
ftp://ftp.ds2.pg.gda.pl/pub/macro/mopd/ and download all of the files in
this directory (this will be mopd-2.5.3 at this moment plus several
patches. Extract the .tar.gz and apply all patches (you *may* need to
fix some .rej's depending on the order you apply these patches).

At least on my Alpha, I had to add '-DNOAOUT' to the CFLAGS in
=2E/mopd-2.5.3/Makefile to let it compile. For booting a Linux kernel,
this is not a problem. Compile it, start it (I started it as './mopd
-a'), place your ELF Linux kernel (this is what normally gets generated
in ./linux/vmlinux) in /tftpboot/mop/ and be happy.

MfG, JBG
--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--O6iH21V1A1PEFpM6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Oa5XHb1edYOZ4bsRAtqGAKCB3Evw65nTh34+AqNK+WLBOK5GSgCfREo/
TFDljAYeIii9HR9bqXzCcLE=
=FNeV
-----END PGP SIGNATURE-----

--O6iH21V1A1PEFpM6--
