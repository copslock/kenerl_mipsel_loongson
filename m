Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g18Deui31505
	for linux-mips-outgoing; Fri, 8 Feb 2002 05:40:56 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g18DeZA31471;
	Fri, 8 Feb 2002 05:40:36 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 2A08D859; Fri,  8 Feb 2002 14:40:13 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 96FD03FB4; Fri,  8 Feb 2002 14:40:23 +0100 (CET)
Date: Fri, 8 Feb 2002 14:40:23 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com
Subject: [PATCH] /proc/cpuinfo endianess
Message-ID: <20020208134023.GB29298@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Again a LTPDS solution:


Index: arch/mips/kernel/proc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/arch/mips/kernel/proc.c,v
retrieving revision 1.27.2.6
diff -u -r1.27.2.6 proc.c
--- arch/mips/kernel/proc.c	2002/01/07 01:16:33	1.27.2.6
+++ arch/mips/kernel/proc.c	2002/02/08 13:37:18
@@ -97,6 +97,11 @@
 	seq_printf(m, "BogoMIPS\t\t: %lu.%02lu\n",
 	              loops_per_jiffy / (500000/HZ),
 	              (loops_per_jiffy / (5000/HZ)) % 100);
+#ifdef __MIPSEB__
+	seq_printf(m, "byteorder\t\t: big endian\n");
+#else
+	seq_printf(m, "byteorder\t\t: little endian\n");
+#endif
 	seq_printf(m, "wait instruction\t: %s\n", cpu_wait ? "yes" : "no");
 	seq_printf(m, "microsecond timers\t: %s\n",
 	              (mips_cpu.options & MIPS_CPU_COUNTER) ? "yes" : "no");


Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Y9VHUaz2rXW+gJcRAivqAKCgpv1mKbIZ7AxE747a6D2L4z8R0gCfeLRo
6Q1V4AihstNEHDD+imm0h1g=
=mtj2
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
