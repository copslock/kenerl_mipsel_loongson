Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA64392 for <linux-archive@neteng.engr.sgi.com>; Sat, 12 Sep 1998 15:49:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA52335
	for linux-list;
	Sat, 12 Sep 1998 15:49:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA40977
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 12 Sep 1998 15:49:12 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA09508
	for <linux@cthulhu.engr.sgi.com>; Sat, 12 Sep 1998 15:49:10 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zHyTU-0027pSC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 13 Sep 1998 00:49:00 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zHyTO-002PBLC; Sun, 13 Sep 98 00:48 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA02192;
	Sun, 13 Sep 1998 00:38:02 +0200
Message-ID: <19980913003802.06252@alpha.franken.de>
Date: Sun, 13 Sep 1998 00:38:02 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux@cthulhu.engr.sgi.com
Subject: SCSI problem solved
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Right now I'm doing some stress test with my Indy (dd from DAT and untaring
a tar file from one disk to another at the same time). And it hasn't crashed.
Below is the patch I'm using. If it works for others too, I'll check it in.

Thomas.

Index: sgiwd93.c
===================================================================
RCS file: /var/mips/linus/cvs/linux/drivers/scsi/sgiwd93.c,v
retrieving revision 1.8
diff -u -r1.8 sgiwd93.c
--- sgiwd93.c	1998/08/25 09:18:49	1.8
+++ sgiwd93.c	1998/09/12 22:32:01
@@ -77,7 +77,7 @@
 
 static int dma_setup(Scsi_Cmnd *cmd, int datainp)
 {
-	struct WD33C93_hostdata *hdata = CMDHOSTDATA(cmd);
+	struct WD33C93_hostdata *hdata = (struct WD33C93_hostdata *)cmd->host->hostdata;
 	wd33c93_regs *regp = hdata->regp;
 	struct hpc3_scsiregs *hregs = (struct hpc3_scsiregs *) cmd->host->base;
 	struct hpc_chunk *hcp = (struct hpc_chunk *) hdata->dma_bounce_buffer;
@@ -89,14 +89,14 @@
 
 	hdata->dma_dir = datainp;
 
-	if(cmd->use_sg) {
+	if(cmd->SCp.buffers_residual) {
 		struct scatterlist *slp = cmd->SCp.buffer;
 		int i, totlen = 0;
 
 #ifdef DEBUG_DMA
 		printk("SCLIST<");
 #endif
-		for(i = 0; i <= (cmd->use_sg - 1); i++, hcp++) {
+		for(i = 0; i <= cmd->SCp.buffers_residual; i++, hcp++) {
 #ifdef DEBUG_DMA
 			printk("[%p,%d]", slp[i].address, slp[i].length);
 #endif
@@ -146,7 +146,7 @@
 static void dma_stop(struct Scsi_Host *instance, Scsi_Cmnd *SCpnt,
 		     int status)
 {
-	struct WD33C93_hostdata *hdata = INSTHOSTDATA(instance);
+	struct WD33C93_hostdata *hdata = (struct WD33C93_hostdata *)instance->hostdata;
 	wd33c93_regs *regp = hdata->regp;
 	struct hpc3_scsiregs *hregs = (struct hpc3_scsiregs *) SCpnt->host->base;
 
@@ -163,7 +163,7 @@
 	hregs->ctrl = 0;
 
 	/* See how far we got and update scatterlist state if necessary. */
-	if(SCpnt->use_sg) {
+	if(SCpnt->SCp.buffers_residual) {
 		struct scatterlist *slp = SCpnt->SCp.buffer;
 		int totlen, wd93_residual, transferred, i;
 
@@ -183,7 +183,7 @@
 #ifdef DEBUG_DMA
 			printk("Jed was here...");
 #endif
-			for(i = 0; i <= (SCpnt->use_sg - 1); i++) {
+			for(i = 0; i <= SCpnt->SCp.buffers_residual; i++) {
 				if(slp[i].length >= transferred)
 					break;
 				transferred -= slp[i].length;
@@ -193,10 +193,10 @@
 #ifdef DEBUG_DMA
 			printk("did it all...");
 #endif
-			i = (SCpnt->use_sg - 1);
+			i = SCpnt->SCp.buffers_residual;
 		}
 		SCpnt->SCp.buffer = &slp[i];
-		SCpnt->SCp.buffers_residual = (SCpnt->use_sg - 1 - i);
+		SCpnt->SCp.buffers_residual = SCpnt->SCp.buffers_residual - i;
 		SCpnt->SCp.ptr = (char *) slp[i].address;
 		SCpnt->SCp.this_residual = slp[i].length;
 	}
@@ -244,7 +244,7 @@
 	wd33c93_init(sgiwd93_host, (wd33c93_regs *) 0xbfbc0003,
 		     dma_setup, dma_stop, WD33C93_FS_16_20);
 
-	hdata = INSTHOSTDATA(sgiwd93_host);
+	hdata = (struct WD33C93_hostdata *)sgiwd93_host->hostdata;
 	hdata->no_sync = 0;
 	hdata->dma_bounce_buffer = (uchar *) (KSEG1ADDR(buf));
 	dma_cache_wback_inv((unsigned long) buf, PAGE_SIZE);

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
