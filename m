Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAR25i202153
	for linux-mips-outgoing; Mon, 26 Nov 2001 18:05:44 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAR25Zo02144
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 18:05:35 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 8704A853; Tue, 27 Nov 2001 02:05:29 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 9EE0E3F45; Tue, 27 Nov 2001 02:04:00 +0100 (CET)
Date: Tue, 27 Nov 2001 02:04:00 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: [PATCH] mips/mm/c-r4k.c NONCOHERENT compile fix
Message-ID: <20011127020400.A28037@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
this is needed for the NONCOHERENT stuff ...



diff -u -r1.1 c-r4k.c
--- arch/mips/mm/c-r4k.c	2001/10/23 01:02:46	1.1
+++ arch/mips/mm/c-r4k.c	2001/11/27 02:02:19
@@ -1141,6 +1141,7 @@
 	flush_cache_all();
 }
=20
+#ifdef CONFIG_NONCOHERENT_IO
 /*
  * Writeback and invalidate the primary cache dcache before DMA.
  *
@@ -1247,6 +1248,8 @@
 	panic("r4k_dma_cache called - should not happen.\n");
 }
=20
+#endif /* CONFIG_NONCOHERENT_IO */
+
 /*
  * While we're protected against bad userland addresses we don't care
  * very much about what happens in that case.  Usually a segmentation
@@ -1436,9 +1439,14 @@
=20
 	_flush_icache_page =3D r4k_flush_icache_page_p;
=20
+#ifdef CONFIG_NONCOHERENT_IO
+
 	_dma_cache_wback_inv =3D r4k_dma_cache_wback_inv_pc;
 	_dma_cache_wback =3D r4k_dma_cache_wback;
 	_dma_cache_inv =3D r4k_dma_cache_inv_pc;
+
+#endif
+
 }
=20
 static void __init setup_scache_funcs(void)
@@ -1519,9 +1527,15 @@
 	}
 	___flush_cache_all =3D _flush_cache_all;
 	_flush_icache_page =3D r4k_flush_icache_page_s;
+
+#ifdef CONFIG_NONCOHERENT_IO
+
 	_dma_cache_wback_inv =3D r4k_dma_cache_wback_inv_sc;
 	_dma_cache_wback =3D r4k_dma_cache_wback;
 	_dma_cache_inv =3D r4k_dma_cache_inv_sc;
+
+#endif /* CONFIG_NONCOHERENT_IO */
+
 }
=20
 typedef int (*probe_func_t)(unsigned long);



Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8AuaAUaz2rXW+gJcRAq+mAKCbibBiXMx8Y+l38R+k+SY2i2uozACgnLT3
lTHXmMFnRhDwqrhoRgcWLKI=
=2zPL
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
