Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jun 2005 14:20:58 +0100 (BST)
Received: from hydra.gt.owl.de ([IPv6:::ffff:195.71.99.218]:30127 "EHLO
	hydra.gt.owl.de") by linux-mips.org with ESMTP id <S8225352AbVFYNUg>;
	Sat, 25 Jun 2005 14:20:36 +0100
Received: by hydra.gt.owl.de (Postfix, from userid 104)
	id 5CD8B199471; Sat, 25 Jun 2005 15:19:48 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 9D24C138010; Sat, 25 Jun 2005 15:19:39 +0200 (CEST)
Date:	Sat, 25 Jun 2005 15:19:38 +0200
From:	Florian Lohoff <flo@rfc822.org>
To:	linux-mips@linux-mips.org
Subject: [patch] blast_scache nop for sc cpus without scache
Message-ID: <20050625131938.GA7669@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
Organization: rfc822 - pure communication
X-SpiderMe: mh-200506251430@listme.rfc822.org
User-Agent: Mutt/1.5.9i
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Index: arch/mips/mm/c-r4k.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /scratch/local/linux-mips-cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.108
diff -u -p -r1.108 c-r4k.c
--- arch/mips/mm/c-r4k.c	25 Apr 2005 16:36:23 -0000	1.108
+++ arch/mips/mm/c-r4k.c	25 Jun 2005 13:15:55 -0000
@@ -225,6 +225,8 @@ static inline void r4k_blast_icache_setu
=20
 static void (* r4k_blast_scache_page)(unsigned long addr);
=20
+static void blast_scache_page_nop(unsigned long page) {}
+
 static inline void r4k_blast_scache_page_setup(void)
 {
 	unsigned long sc_lsize =3D cpu_scache_line_size();
@@ -237,10 +239,14 @@ static inline void r4k_blast_scache_page
 		r4k_blast_scache_page =3D blast_scache64_page;
 	else if (sc_lsize =3D=3D 128)
 		r4k_blast_scache_page =3D blast_scache128_page;
+	else
+		r4k_blast_scache_page =3D blast_scache_page_nop;
 }
=20
 static void (* r4k_blast_scache_page_indexed)(unsigned long addr);
=20
+static void blast_scache_page_indexed_nop(unsigned long page) {}
+
 static inline void r4k_blast_scache_page_indexed_setup(void)
 {
 	unsigned long sc_lsize =3D cpu_scache_line_size();
@@ -253,10 +259,14 @@ static inline void r4k_blast_scache_page
 		r4k_blast_scache_page_indexed =3D blast_scache64_page_indexed;
 	else if (sc_lsize =3D=3D 128)
 		r4k_blast_scache_page_indexed =3D blast_scache128_page_indexed;
+	else=20
+		r4k_blast_scache_page_indexed =3D blast_scache_page_indexed_nop;
 }
=20
 static void (* r4k_blast_scache)(void);
=20
+static void blast_scache_nop(void ) {}
+
 static inline void r4k_blast_scache_setup(void)
 {
 	unsigned long sc_lsize =3D cpu_scache_line_size();
@@ -269,6 +279,8 @@ static inline void r4k_blast_scache_setu
 		r4k_blast_scache =3D blast_scache64;
 	else if (sc_lsize =3D=3D 128)
 		r4k_blast_scache =3D blast_scache128;
+	else=20
+		r4k_blast_scache =3D blast_scache_nop;
 }
=20
 /*

--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCvVnqUaz2rXW+gJcRAhf3AJ9qmjaRrUmzsq6XDO8A9dIzoTOUqwCfWIYq
lVp9oldmagksirSH9vfZNG4=
=OVQO
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
