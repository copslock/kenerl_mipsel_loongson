Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB304GB10718
	for linux-mips-outgoing; Sun, 2 Dec 2001 16:04:16 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB304Ao10715
	for <linux-mips@oss.sgi.com>; Sun, 2 Dec 2001 16:04:11 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 8F879875; Mon,  3 Dec 2001 00:04:02 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 7010244CD; Mon,  3 Dec 2001 00:03:38 +0100 (CET)
Date: Mon, 3 Dec 2001 00:03:38 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: 2.4.16 success on Decstation 5000/150
Message-ID: <20011203000338.A30090@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
the current cvs (as of a couple hours ago) works without additional
patches on my Decstation 5000/150 like a charm:

record:/lib/modules/2.4.16# uname -a
Linux record.rfc822.org 2.4.16 #2 Sun Dec 2 22:24:58 CET 2001 mips
unknown
record:/lib/modules/2.4.16# cat /proc/cpuinfo=20
processor		: 0
cpu model		: R4000SC V3.0  FPU V0.0
BogoMIPS		: 50.52
wait instruction	: no
microsecond timers	: yes
extra interrupt vector	: no
hardware watchpoint	: yes
VCED exceptions		: 10036
VCEI exceptions		: 65122

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8CrNJUaz2rXW+gJcRAi6WAKCotXcsKT/JXFt6HwQGfzXnLorNTACZAQkx
MkEVnr6SbRJDqxCApIYwCjQ=
=Tmwm
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
