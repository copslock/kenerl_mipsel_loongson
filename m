Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAR2uqH03186
	for linux-mips-outgoing; Mon, 26 Nov 2001 18:56:52 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAR2uko03182
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 18:56:46 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 8A68C853; Tue, 27 Nov 2001 02:56:40 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 18CE93F45; Tue, 27 Nov 2001 02:56:22 +0100 (CET)
Date: Tue, 27 Nov 2001 02:56:22 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: Decstation /150 kernel (cvs) problems
Message-ID: <20011127025622.D28037@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
it seems the current cvs kernel does not work on my /150 - Does anyone
have similar expiriences ? It simply reboots for me ...

>>boot 3/rz0 2/linux.test
delo V0.7 Copyright 2000 Florian Lohoff <flo@rfc822.org>
Loading /etc/delo.conf .. ok
Loading /boot/vmlinux-2.4.14 ................ ok

KN04 V2.1k    (PC: 0x80148b9c, SP: 0x8043fef0)
delo V0.7 Copyright 2000 Florian Lohoff <flo@rfc822.org>
Loading /etc/delo.conf .. ok
Loading /boot/vmlinux .................... ok
This DECstation is a DS5000/1xx
Loading R4000 MMU routines.
CPU revision is: 00000430
Primary instruction cache 8kb, linesize 16 bytes.                          =
   =20
[...]


repeat:~# cat /proc/cpuinfo
cpu                     : MIPS
cpu model               : R4000SC V3.0
system type             : Digital DECstation 5000/1xx
BogoMIPS                : 49.68
byteorder               : little endian
unaligned accesses      : 0
wait instruction        : no
microsecond timers      : no
extra interrupt vector  : no
hardware watchpoint     : yes
VCED exceptions         : 6565
VCEI exceptions         : 11303


Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8AvLFUaz2rXW+gJcRAsqAAJwONYFW8NguSki9YXmt30FaLJg0xgCePslD
kLZWZuk0/u/xuKYOqpGAnNE=
=tJmR
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
