Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBDFPBB06661
	for linux-mips-outgoing; Thu, 13 Dec 2001 07:25:11 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBDFOro06630;
	Thu, 13 Dec 2001 07:24:53 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id C1430854; Thu, 13 Dec 2001 15:24:42 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 78A6544AC; Thu, 13 Dec 2001 15:21:17 +0100 (CET)
Date: Thu, 13 Dec 2001 15:21:17 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com
Subject: [PATCH] wback cache handling "optimized" in sgiwd93.c
Message-ID: <20011213142117.GA12503@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i again took a look at the sgiwd93.c wback cache handling - I found some
space for improvement and cleanup:


- init_hpc_chain has to flush to memory anyways - Add an
  dma_cache_wback_inv and delete from callers (Also a duplicate one
  reported a couple of months back) This one is inlined and only used
  in sgiwd93_detect which is __init)

- fill_hpc_chain used to hit "dma_cache_wback_inv" for the area it=20
  sets up the hpc chains. This is not need in case of read as we only
  would need to invalidate. Moved this to "dma_setup" and made the
  decision to hit dma_cache_wback_inv or dma_cache_inv depending
  on dma direction.

I am running this patch now with success. It should improve read
performance as we dont hit writeback on soon to be overwritten pages.
I havent done performance analysis with bonnie etc.


Index: drivers/scsi/sgiwd93.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/drivers/scsi/sgiwd93.c,v
retrieving revision 1.28.2.1
diff -u -r1.28.2.1 sgiwd93.c
--- drivers/scsi/sgiwd93.c	2001/12/11 18:11:33	1.28.2.1
+++ drivers/scsi/sgiwd93.c	2001/12/13 15:15:45
@@ -4,10 +4,13 @@
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
  *		 1999 Andrew R. Baker (andrewb@uab.edu)
  *		      - Support for 2nd SCSI controller on Indigo2
+ *		 2001 Florian Lohoff (flo@rfc822.org)
+ *		      - Delete HPC scatter gather (Read corruption on=20
+ *		        multiple disks)
+ *		      - Cleanup wback cache handling
  *=20
  * (In all truth, Jed Schimmel wrote all this code.)
  *
- * $Id: sgiwd93.c,v 1.19 2000/02/04 07:40:47 ralf Exp $
  */
 #include <linux/init.h>
 #include <linux/types.h>
@@ -85,7 +88,6 @@
 	unsigned long physaddr;
 	unsigned long count;
 =09
-	dma_cache_wback_inv((unsigned long)addr,len);
 	physaddr =3D PHYSADDR(addr);
 	while (len) {
 		/*
@@ -104,7 +106,6 @@
 static int dma_setup(Scsi_Cmnd *cmd, int datainp)
 {
 	struct WD33C93_hostdata *hdata =3D (struct WD33C93_hostdata *)cmd->host->=
hostdata;
-	const wd33c93_regs regs =3D hdata->regs;
 	struct hpc3_scsiregs *hregs =3D (struct hpc3_scsiregs *) cmd->host->base;
 	struct hpc_chunk *hcp =3D (struct hpc_chunk *) hdata->dma_bounce_buffer;
=20
@@ -124,6 +125,7 @@
 	 */
 	if (cmd->SCp.ptr =3D=3D NULL)
 		return 1;
+
 	fill_hpc_entries (&hcp, cmd->SCp.ptr,cmd->SCp.this_residual);
=20
 	/* To make sure, if we trip an HPC bug, that we transfer
@@ -139,10 +141,14 @@
=20
 	/* Start up the HPC. */
 	hregs->ndptr =3D PHYSADDR(hdata->dma_bounce_buffer);
-	if(datainp)
+	if(datainp) {
+		dma_cache_wback_inv((unsigned long) cmd->SCp.ptr, cmd->SCp.this_residual=
);
 		hregs->ctrl =3D (HPC3_SCTRL_ACTIVE);
-	else
+	} else {
+		dma_cache_inv((unsigned long) cmd->SCp.ptr, cmd->SCp.this_residual);
 		hregs->ctrl =3D (HPC3_SCTRL_ACTIVE | HPC3_SCTRL_DIR);
+	}
+
 	return 0;
 }
=20
@@ -150,7 +156,6 @@
 		     int status)
 {
 	struct WD33C93_hostdata *hdata =3D (struct WD33C93_hostdata *)instance->h=
ostdata;
-	const wd33c93_regs regp =3D hdata->regs;
 	struct hpc3_scsiregs *hregs;
=20
 	if (!SCpnt)
@@ -199,6 +204,9 @@
 	};
 	hcp--;
 	hcp->desc.pnext =3D PHYSADDR(buf);
+
+	/* Force flush to memory */
+	dma_cache_wback_inv((unsigned long) buf, PAGE_SIZE);
 }
=20
 int __init sgiwd93_detect(Scsi_Host_Template *SGIblows)
@@ -229,7 +237,6 @@
 		return 0;
 	}
 	init_hpc_chain(buf);
-	dma_cache_wback_inv((unsigned long) buf, PAGE_SIZE);
=20
 	regs.SASR =3D KSEG1ADDR (0x1fbc0003); /* HPC_SCSI_REG0 | 0x03 | KSEG1 */
 	regs.SCMD =3D KSEG1ADDR (0x1fbc0007);
@@ -264,7 +271,6 @@
 				return 1; /* We registered host0 so return success*/
 			}
 			init_hpc_chain(buf);
-			dma_cache_wback_inv((unsigned long) buf, PAGE_SIZE);
=20
 			/* HPC_SCSI_REG1 | 0x03 | KSEG1 */
 			regs.SASR =3D KSEG1ADDR(0x1fbc8003);
@@ -275,7 +281,6 @@
 			hdata1 =3D (struct WD33C93_hostdata *)sgiwd93_host1->hostdata;
 			hdata1->no_sync =3D 0;
 			hdata1->dma_bounce_buffer =3D (uchar *) (KSEG1ADDR(buf));
-			dma_cache_wback_inv((unsigned long) buf, PAGE_SIZE);
 =09
 			if (request_irq(SGI_WD93_1_IRQ, sgiwd93_intr, 0, "SGI WD93", (void *) s=
giwd93_host1)) {
 				printk(KERN_WARNING "sgiwd93: Could not allocate irq %d (for host1).\n=
", SGI_WD93_1_IRQ);
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8GLldUaz2rXW+gJcRAvqQAKDgY/TER2kWz+yPqdxUT5F7CoF7bwCgrNf9
mhR40H5MstA3yBw/2lgi/6Y=
=UKoF
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
