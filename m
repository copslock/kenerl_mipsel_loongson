Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Sep 2002 04:00:38 +0200 (CEST)
Received: from noose.gt.owl.de ([62.52.19.4]:24069 "HELO noose.gt.owl.de")
	by linux-mips.org with SMTP id <S1122961AbSI1CAh>;
	Sat, 28 Sep 2002 04:00:37 +0200
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 999FF874; Sat, 28 Sep 2002 04:00:30 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 457EA3717F; Sat, 28 Sep 2002 03:59:47 +0200 (CEST)
Date: Sat, 28 Sep 2002 03:59:47 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH] dec_esp.c repair mmu_sglist breakage
Message-ID: <20020928015947.GE7706@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
through the whole issue of the mmu_sglist confusion and the broken
reimplantation of mmu_sglist the dec_esp broke. Here is a fix
to really remove the mmu_sglist and use scatterlist instead. With
this the Decstation on this desk at least finds its partitions
again and does not crash.

I vote for removal of the struct mmu_sglist as at least it now
breaks on compile time and not confusion at runtime.

Flo


Index: drivers/scsi/dec_esp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/drivers/scsi/dec_esp.c,v
retrieving revision 1.10.2.3
diff -u -r1.10.2.3 dec_esp.c
--- drivers/scsi/dec_esp.c	23 Aug 2002 09:49:51 -0000	1.10.2.3
+++ drivers/scsi/dec_esp.c	28 Sep 2002 01:57:16 -0000
@@ -443,13 +443,13 @@
=20
 static void dma_mmu_get_scsi_sgl(struct NCR_ESP *esp, Scsi_Cmnd * sp)
 {
-    int sz =3D sp->SCp.buffers_residual;
-    struct mmu_sglist *sg =3D (struct mmu_sglist *) sp->SCp.buffer;
+	int sz =3D sp->SCp.buffers_residual;
+	struct scatterlist *sg =3D sp->SCp.buffer;
=20
-    while (sz >=3D 0) {
-		sg[sz].dvma_addr =3D PHYSADDR(sg[sz].addr);
-	sz--;
-    }
+	while (sz >=3D 0) {
+		sg[sz].dma_address =3D PHYSADDR(sg[sz].address);
+		sz--;
+	}
 	sp->SCp.ptr =3D (char *) ((unsigned long) sp->SCp.buffer->dma_address);
 }
=20
Index: include/asm-mips/scatterlist.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/include/asm-mips/scatterlist.h,v
retrieving revision 1.4.2.3
diff -u -r1.4.2.3 scatterlist.h
--- include/asm-mips/scatterlist.h	23 Aug 2002 09:50:00 -0000	1.4.2.3
+++ include/asm-mips/scatterlist.h	28 Sep 2002 01:57:16 -0000
@@ -10,13 +10,6 @@
 	unsigned int length;
 };
=20
-struct mmu_sglist {
-	char *addr;
-	char *__dont_touch;
-	unsigned int len;
-	dma_addr_t dvma_addr;
-};
-
 #define ISA_DMA_THRESHOLD (0x00ffffff)
=20
 #endif /* __ASM_SCATTERLIST_H */


--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9lQ0TUaz2rXW+gJcRAnqWAKC1EaCQjU1YW4UARbtstA5vhExPXACdFqXQ
IzlvwvEoW6KLuRuvs28qTpI=
=jwL+
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
