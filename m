Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBE3aqr11982
	for linux-mips-outgoing; Thu, 13 Dec 2001 19:36:52 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBE3ado11954
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 19:36:40 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 3C32D83D; Fri, 14 Dec 2001 03:36:29 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 1445B41FC; Fri, 14 Dec 2001 03:35:46 +0100 (CET)
Date: Fri, 14 Dec 2001 03:35:46 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: [PATCH] use Hit_invalidate in dma_cache_inv / fix sgiwd93.c
Message-ID: <20011214023545.GB25759@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Here is a short patch for actually letting dma_cache_inv use=20
invalidate. As it might happen if we are not cache-line aligned
we need to flush the non-aligned start and end. To take that decision
might actually take longer than just flush it thus we simply do it.
This would make the case for size<=3Ddc_lsize slower by the factor
of a cache_flush on a non-dirty line. I would consider this the
non common case because using DMA for something <=3D dc_lsize is also
a not very optimal decision.

Currently i am unsure about interlocking/timing on 2 cache instructions on
the same cache line and i have no documentation at hand. Probably=20
its better to put the flush_dcache behind the while loop. I would
be happy to hear comments on this.

I am currently running my test again although it might be as Ralf
pointed out that this only might lead to problems on devices like
tape streamers. If anyone has a streamer handy i would be happy
to hear experiences.

If i would have known how to interpret HPC3 documentation you would not
have to apply the other attached patch - But as life goes i was able
to detect my own disability by filesystem corruption :)


Index: arch/mips/mm/c-r4k.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.3
diff -u -r1.3 c-r4k.c
--- arch/mips/mm/c-r4k.c	2001/11/30 13:28:06	1.3
+++ arch/mips/mm/c-r4k.c	2001/12/14 02:20:20
@@ -1211,9 +1211,14 @@
=20
 		a =3D addr & ~(dc_lsize - 1);
 		end =3D (addr + size) & ~(dc_lsize - 1);
-		while (1) {
-			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
-			if (a =3D=3D end) break;
+
+		flush_dcache_line(a);		/* Hit_Writeback_Inv_D */
+		flush_dcache_line(end);
+
+		a+=3Ddc_lsize;
+
+		while (a<end) {
+			invalidate_dcache_line(a); /* Hit_Invalidate_D */
 			a +=3D dc_lsize;
 		}
 		__restore_flags(flags);
@@ -1234,9 +1239,14 @@
=20
 	a =3D addr & ~(sc_lsize - 1);
 	end =3D (addr + size) & ~(sc_lsize - 1);
-	while (1) {
-		flush_scache_line(a); /* Hit_Writeback_Inv_SD */
-		if (a =3D=3D end) break;
+
+	flush_scache_line(a);			/* Hit_Writeback_Inv_SD */
+	flush_scache_line(end);
+
+	a+=3Dsc_lsize;
+
+	while (a<end) {
+		invalidate_scache_line(a);	/* Hit_Invalidate_SD */
 		a +=3D sc_lsize;
 	}
 }





Index: drivers/scsi/sgiwd93.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/drivers/scsi/sgiwd93.c,v
retrieving revision 1.28.2.2
diff -u -r1.28.2.2 sgiwd93.c
--- drivers/scsi/sgiwd93.c	2001/12/13 20:08:36	1.28.2.2
+++ drivers/scsi/sgiwd93.c	2001/12/14 03:33:36
@@ -142,10 +142,10 @@
 	/* Start up the HPC. */
 	hregs->ndptr =3D PHYSADDR(hdata->dma_bounce_buffer);
 	if(datainp) {
-		dma_cache_wback_inv((unsigned long) cmd->SCp.ptr, cmd->SCp.this_residual=
);
+		dma_cache_inv((unsigned long) cmd->SCp.ptr, cmd->SCp.this_residual);
 		hregs->ctrl =3D (HPC3_SCTRL_ACTIVE);
 	} else {
-		dma_cache_inv((unsigned long) cmd->SCp.ptr, cmd->SCp.this_residual);
+		dma_cache_wback_inv((unsigned long) cmd->SCp.ptr, cmd->SCp.this_residual=
);
 		hregs->ctrl =3D (HPC3_SCTRL_ACTIVE | HPC3_SCTRL_DIR);
 	}
=20
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8GWWBUaz2rXW+gJcRApz5AJ9o5R84jFaRC8l5RCU7KL50/GUjMwCdEuQM
KRqruMT6TkhfqSx9Zb0L7PM=
=f3Pm
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
