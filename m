Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBDHelS12657
	for linux-mips-outgoing; Thu, 13 Dec 2001 09:40:47 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBDHefo12654
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 09:40:41 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 90AA6838; Thu, 13 Dec 2001 17:40:30 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 9E3FA44AF; Thu, 13 Dec 2001 17:39:53 +0100 (CET)
Date: Thu, 13 Dec 2001 17:39:53 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: [PATCH] /proc/cpuinfo endianess (autoconf dependencie)
Message-ID: <20011213163953.GB23023@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Something like this should be needed for current kernel to make
autoconf happy ...


Index: arch/mips/kernel/proc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/arch/mips/kernel/proc.c,v
retrieving revision 1.27.2.3
diff -u -r1.27.2.3 proc.c
--- arch/mips/kernel/proc.c	2001/12/12 13:45:58	1.27.2.3
+++ arch/mips/kernel/proc.c	2001/12/13 17:39:19
@@ -51,6 +51,11 @@
 	seq_printf(m, "BogoMIPS\t\t: %lu.%02lu\n",
 	              loops_per_jiffy / (500000/HZ),
 	              (loops_per_jiffy / (5000/HZ)) % 100);
+#ifdef __MIBSEB__
+	seq_printf(m, "byteorder\t\t: big endian\n");
+#else
+	seq_printf(m, "byteorder\t\t: little endian\n");
+#endif
 	seq_printf(m, "wait instruction\t: %s\n", cpu_wait ? "yes" : "no");
 	seq_printf(m, "microsecond timers\t: %s\n",
 	              (mips_cpu.options & MIPS_CPU_COUNTER) ? "yes" : "no");

Flo		=20
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8GNnZUaz2rXW+gJcRAu3HAJ9CfctELPucTSS5jofXXogkv5zV4QCgwaKp
Wv1q7TajBvn9sJMdfM/i1go=
=cfxx
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
