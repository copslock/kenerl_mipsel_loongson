Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBAL8rK15855
	for linux-mips-outgoing; Mon, 10 Dec 2001 13:08:53 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBAL8Yo15850
	for <linux-mips@oss.sgi.com>; Mon, 10 Dec 2001 13:08:35 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 982D27F5; Mon, 10 Dec 2001 21:08:23 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id EE59148FD; Mon, 10 Dec 2001 21:07:57 +0100 (CET)
Date: Mon, 10 Dec 2001 21:07:57 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Cc: klaus@mgnet.de, agx@sigxcpu.org
Subject: [PATCH] sgiwd93.c fix for multiple disks
Message-ID: <20011210200757.GA25722@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
the attached patch fixes part of the DMA problems we see with multiple
disks and the sgiwd93.c with DISCONNECTs. Klaus patch formerly just
disabled all DMA replacing it with PIO which is a major performance hit.

This patch simply deletes all the HPC Scatter/Gather stuff thus we will
see a couple more interrupts due to all segments beeing transferred
individually. The transfer itself still happens with the HPC DMA thus
the performance impact will not be that large. I am running a test right
now but it seems the error is gone.

This also touches the wd33c93.c generic part which brings us closer to
mainstream as these to lines are a difference between the sgi/mips tree
and the mainline kernel as we would need this kind of modification if
we would do the scatter-gather DMA.


Index: sgiwd93.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/drivers/scsi/sgiwd93.c,v
retrieving revision 1.28
diff -u -r1.28 sgiwd93.c
--- sgiwd93.c	2001/11/06 07:56:05	1.28
+++ sgiwd93.c	2001/12/10 20:06:01
@@ -115,42 +115,16 @@
=20
 	hdata->dma_dir =3D datainp;
=20
-	if(cmd->SCp.buffers_residual) {
-		struct scatterlist *slp =3D cmd->SCp.buffer;
-		int i, totlen =3D 0;
-
-#ifdef DEBUG_DMA
-		printk("SCLIST<");
-#endif
-		for(i =3D 0; i <=3D cmd->SCp.buffers_residual; i++) {
-#ifdef DEBUG_DMA
-			printk("[%p,%d]", slp[i].address, slp[i].length);
-#endif
-			fill_hpc_entries (&hcp, slp[i].address, slp[i].length);
-			totlen +=3D slp[i].length;
-		}
-#ifdef DEBUG_DMA
-		printk(">tlen<%d>", totlen);
-#endif
-		hdata->dma_bounce_len =3D totlen; /* a trick... */
-		write_wd33c93_count(regs, totlen);
-	} else {
-		/* Non-scattered dma. */
-#ifdef DEBUG_DMA
-		printk("ONEBUF<%p,%d>", cmd->SCp.ptr, cmd->SCp.this_residual);
-#endif
-		/*
-		 * wd33c93 shouldn't pass us bogus dma_setups, but
-		 * it does:-( The other wd33c93 drivers deal with
-		 * it the same way (which isn't that obvious).
-		 * IMHO a better fix would be, not to do these
-		 * dma setups in the first place
-		 */
-		if (cmd->SCp.ptr =3D=3D NULL)
-			return 1;
-		fill_hpc_entries (&hcp, cmd->SCp.ptr,cmd->SCp.this_residual);
-		write_wd33c93_count(regs, cmd->SCp.this_residual);
-	}
+	/*
+	 * wd33c93 shouldn't pass us bogus dma_setups, but
+	 * it does:-( The other wd33c93 drivers deal with
+	 * it the same way (which isn't that obvious).
+	 * IMHO a better fix would be, not to do these
+	 * dma setups in the first place
+	 */
+	if (cmd->SCp.ptr =3D=3D NULL)
+		return 1;
+	fill_hpc_entries (&hcp, cmd->SCp.ptr,cmd->SCp.this_residual);
=20
 	/* To make sure, if we trip an HPC bug, that we transfer
 	 * every single byte, we tag on an extra zero length dma
@@ -196,44 +170,6 @@
 	}
 	hregs->ctrl =3D 0;
=20
-	/* See how far we got and update scatterlist state if necessary. */
-	if(SCpnt->SCp.buffers_residual) {
-		struct scatterlist *slp =3D SCpnt->SCp.buffer;
-		int totlen, wd93_residual, transferred, i;
-
-		/* Yep, we were doing the scatterlist thang. */
-		totlen =3D hdata->dma_bounce_len;
-		wd93_residual =3D read_wd33c93_count(regp);
-		transferred =3D totlen - wd93_residual;
-
-#ifdef DEBUG_DMA
-		printk("tlen<%d>resid<%d>transf<%d> ",
-		       totlen, wd93_residual, transferred);
-#endif
-
-		/* Avoid long winded partial-transfer search for common case. */
-		if(transferred !=3D totlen) {
-			/* This is the nut case. */
-#ifdef DEBUG_DMA
-			printk("Jed was here...");
-#endif
-			for(i =3D 0; i <=3D SCpnt->SCp.buffers_residual; i++) {
-				if(slp[i].length >=3D transferred)
-					break;
-				transferred -=3D slp[i].length;
-			}
-		} else {
-			/* This is the common case. */
-#ifdef DEBUG_DMA
-			printk("did it all...");
-#endif
-			i =3D SCpnt->SCp.buffers_residual;
-		}
-		SCpnt->SCp.buffer =3D &slp[i];
-		SCpnt->SCp.buffers_residual =3D SCpnt->SCp.buffers_residual - i;
-		SCpnt->SCp.ptr =3D (char *) slp[i].address;
-		SCpnt->SCp.this_residual =3D slp[i].length;
-	}
 #ifdef DEBUG_DMA
 	printk("\n");
 #endif
Index: wd33c93.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/drivers/scsi/wd33c93.c,v
retrieving revision 1.19
diff -u -r1.19 wd33c93.c
--- wd33c93.c	2001/11/06 07:56:05	1.19
+++ wd33c93.c	2001/12/10 20:06:01
@@ -612,6 +612,7 @@
                      (is_dir_out(cmd))?DATA_OUT_DIR:DATA_IN_DIR))
             write_wd33c93_count(regs, 0); /* guarantee a DATA_PHASE interr=
upt */
          else {
+            write_wd33c93_count(regs, cmd->SCp.this_residual);
             write_wd33c93(regs, WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_DMA=
);
             hostdata->dma =3D D_DMA_RUNNING;
             }
@@ -733,6 +734,7 @@
       hostdata->dma_cnt++;
 #endif
       write_wd33c93(regs, WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_DMA);
+      write_wd33c93_count(regs, cmd->SCp.this_residual);
=20
       if ((hostdata->level2 >=3D L2_DATA) ||
           (hostdata->level2 =3D=3D L2_BASIC && cmd->SCp.phase =3D=3D 0)) {

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8FRYdUaz2rXW+gJcRAmVNAKCcO0G8PeOunfM7RaMNQAkytLfyLwCfVeK/
djg0UcMGNPP0j5KNt/BF5y0=
=Pcy2
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
