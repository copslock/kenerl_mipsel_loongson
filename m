Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAR12mW30995
	for linux-mips-outgoing; Mon, 26 Nov 2001 17:02:48 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAR12fo30983
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 17:02:41 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 0937984F; Tue, 27 Nov 2001 01:02:35 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A36233F45; Tue, 27 Nov 2001 00:32:28 +0100 (CET)
Date: Tue, 27 Nov 2001 00:32:28 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: [PATCH] arc_setup_console obsolete ?
Message-ID: <20011127003228.A21296@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



This doesnt exist anywhere else - I would consider this history ?



diff -u -r1.9 init.c
--- arch/mips/arc/init.c	2001/01/27 04:34:10	1.9
+++ arch/mips/arc/init.c	2001/11/27 00:31:47
@@ -23,8 +23,6 @@
=20
 extern void prom_testtree(void);
=20
-extern void arc_setup_console(void);
-
 void __init prom_init(int argc, char **argv, char **envp, int *prom_vec)
 {
 	struct linux_promblock *pb;
@@ -35,19 +33,6 @@
 	prom_argv =3D argv;
 	prom_envp =3D envp;
=20
-#if 0
-	/* arc_printf should not use prom_printf as soon as we free
-	 * the prom buffers - This horribly breaks on Indys with framebuffer
-	 * as it simply stops after initialising swap - On the Indigo2 serial
-	 * console you will get A LOT illegal instructions - Only enable
-	 * this for early init crashes - This also brings up artefacts of
-	 * printing everything twice on serial console and on GFX Console
-	 * this has the effect of having the prom printing everything
-	 * in the small rectangle and the kernel printing around.
-	 */
-
-	arc_setup_console();
-#endif
 	if (pb->magic !=3D 0x53435241) {
 		prom_printf("Aieee, bad prom vector magic %08lx\n", pb->magic);
 		while(1)

--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8AtEMUaz2rXW+gJcRAmoGAJ0UECxwljztnUeNhQEab5my/vM4XQCgm2dx
cPCgLcrVITkcYWTTK4M+0Uw=
=DPNy
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
