Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7G9X8Rw014324
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 16 Aug 2002 02:33:08 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7G9X8Uh014323
	for linux-mips-outgoing; Fri, 16 Aug 2002 02:33:08 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7G9WtRw014314
	for <linux-mips@oss.sgi.com>; Fri, 16 Aug 2002 02:32:56 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id A945D133EF; Fri, 16 Aug 2002 11:35:31 +0200 (CEST)
Date: Fri, 16 Aug 2002 11:35:31 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: [Q]: Was this chunk of a patch really intended?
Message-ID: <20020816093531.GG10730@lug-owl.de>
Mail-Followup-To: linux-mips mailing list <linux-mips@oss.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HKEL+t8MFpg/ASTE"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
X-Spam-Status: No, hits=-5.1 required=5.0 tests=SUBJ_ENDS_IN_Q_MARK,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--HKEL+t8MFpg/ASTE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm once again looking at R4k6 V1.7 support. Diffing out the patch which
removed V1.7 support, I find this chunk:
---------------------------------------------------------------------------
@@ -1010,14 +921,12 @@
                blast_dcache32_page_indexed(page);
        }
 out:
-       __restore_flags(flags);
 }

 static void r4k_flush_cache_page_d32i32_r4600(struct vm_area_struct *vma,
                                              unsigned long page)
 {     =20
        struct mm_struct *mm =3D vma->vm_mm;
-       unsigned long flags;
        pgd_t *pgdp;
        pmd_t *pmdp;
        pte_t *ptep;
@@ -1032,7 +941,6 @@
 #ifdef DEBUG_CACHE
        printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
-       __save_and_cli(flags);
        page &=3D PAGE_MASK;
        pgdp =3D pgd_offset(mm, page);
        pmdp =3D pmd_offset(pgdp, page);
@@ -1062,7 +970,6 @@
                blast_dcache32_page_indexed(page ^ dcache_waybit);
        }
 out:
-       __restore_flags(flags);
 }

 /* If the addresses passed to these routines are valid, they are
---------------------------------------------------------------------------

Depending on this function's name, I think this part of the patch is not
that shiny. I'd suspect to leave __save_and_cli()/__restore_flags() in
this function, or to rename the function, as it used for more than only
R4600:
--------------------------------------------------------------------------
        switch(mips_cpu.cputype) {
        case CPU_R4600:                 /* QED style two way caches? */
        case CPU_R4700:
        case CPU_R5000:
        case CPU_NEVADA:
                _flush_cache_page =3D r4k_flush_cache_page_d32i32_r4600;
        }
--------------------------------------------------------------------------

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--HKEL+t8MFpg/ASTE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9XMdjHb1edYOZ4bsRAtwmAJ9cx0eYsaSoEWFXPjHJi9naVBwVawCfVOtZ
8aHgp59G0bqCRmNwgI7h6Ac=
=o59m
-----END PGP SIGNATURE-----

--HKEL+t8MFpg/ASTE--
