Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1MJHmw17810
	for linux-mips-outgoing; Fri, 22 Feb 2002 11:17:48 -0800
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1MJHc917807
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 11:17:39 -0800
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 840FAA1CB; Fri, 22 Feb 2002 19:17:34 +0100 (CET)
Date: Fri, 22 Feb 2002 19:17:34 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: Problem with delo
Message-ID: <20020222191734.B15503@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've just installed delo on my /125, but it doesn't boot the kernel.
It *seems* (to me) that it successfully load it's second stage, but
second stage bootloader failed to load /etc/delo.conf. Layout is
like this:

	/dev/sda1	Small Linux/ext2 partition containing
			nothing
	/dev/sda2	Large Linux/ext2 partition containing
			the / filesystem (including /boot
			directory)
	/dev/sda3	Linux swap

My delo.conf looks like this:
	label=3Dlinux
		image=3D/boot/vmlinux
		append=3D"root=3D/dev/sda2 init=3D/bin/bash"

I recompiled delo with -DDEBUG and now, I'm getting this bootup
message:


>> boot 3/rz1 2/linux
delo V0.7 Copyright 2000 Florian Lohoff <flo@rfc822.org>
callv addr a0002f88
clo: 0 boot
clo: 1 3/rz1
clo: 2 2/linux
Getting partition info
Partition '2' 2
bootread returned 512
DOS disklabel found
 1  0 83       62    98146
 2  0 83    98208  5665374
delo_open: called
delo_open: bootinit returned 0
delo_set_blksize: called 1024
delo_read_blk: called for 98210 count 1024 to 805402f8
delo_set_blksize: called 4096
delo_read_blk: called for 98216 count 4096 to 805406f8
delo_read_blk: called for 98240 count 4096 to 80542710
delo_read_blk: called for 102264 count 4096 to 805416f8
delo_read_blk: called for 3506112 count 4096 to 80542710
delo_read_blk: called for 364520 count 4096 to 805416f8
delo_read_blk: called for 364528 count 4096 to 805416f8
delo_read_blk: called for 364536 count 4096 to 805416f8
delo_read_blk: called for 156648 count 4096 to 805416f8
readfile: ext2fs_namei_follow returned 2133571404
extfs_open returned Unknown ext2 error(2133571404)
Couldnt fetch config.file /etc/delo.conf

I'm not exactly familiar with delo's code. Flo, do you have a hint?

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjx2iz0ACgkQHb1edYOZ4bt/4QCgh1vjD9m+1wFD4eLz0lRzcISD
E2EAnR7pb23/HKLuqVs8eUXWlxtM9yKN
=Yh7R
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
