Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NJjLc20131
	for linux-mips-outgoing; Wed, 23 May 2001 12:45:21 -0700
Received: from aeon.tvd.be (aeon.tvd.be [195.162.196.20])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NJjCF20126
	for <linux-mips@oss.sgi.com>; Wed, 23 May 2001 12:45:13 -0700
Received: from callisto.of.borg (cable-195-162-217-46.upc.chello.be [195.162.217.46])
	by aeon.tvd.be (8.9.3/8.9.3/RELAY-1.1) with ESMTP id VAA06296;
	Wed, 23 May 2001 21:44:55 +0200 (MET DST)
Received: from localhost (geert@localhost)
	by callisto.of.borg (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id VAA20178;
	Wed, 23 May 2001 21:42:59 +0200
X-Authentication-Warning: callisto.of.borg: geert owned process doing -bs
Date: Wed, 23 May 2001 21:42:59 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>,
   Linux/PPC on APUS development <linux-apus-devel@lists.sourceforge.net>
Subject: wd33c93 cleanup
Message-ID: <Pine.LNX.4.05.10105232129530.20057-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

	Hi guys,

This is something that has been on my TODO list since a while...

Currently wd33c93_regs is a struct containing ugly #ifdef's to add padding,
depending on the target you compile for. This has the nasty side-effect that
you can no longer compile one kernel that supports both Amiga and MVME147
systems and has working wd33c93 SCSI.

Since the wd33c93 has only 2 registers, there's no real need for a complex
struct containing the registers, so I replaced it by a struct with two pointers
to the registers. Hence no more hardware-specific stuff in wd33c93.h.

Affected systems:
  - Amiga A3000 SCSI
  - Amiga A2091/A590 SCSI
  - Various Amiga GVP boards containing `GVP Series II'-compatible SCSI
  - Motorola MVME147 SCSI
  - SGI Indy/Indigo2 SCSI

Apart from a simple compile test for the Amiga-related drivers, the patch is
untested (my sole wd33c93 equipped system is still waiting for the completion
of the port of uClinux to the Amiga 500 :-) But of course all feedback is
welcome!

diff -u --recursive --exclude-from=/home/geert/diff-excludes-linux --new-file linux-m68k-2.4.4/drivers/scsi/a2091.c wd33c93-2.4.4/drivers/scsi/a2091.c
--- linux-m68k-2.4.4/drivers/scsi/a2091.c	Tue Nov 28 02:57:34 2000
+++ wd33c93-2.4.4/drivers/scsi/a2091.c	Wed May 23 08:13:56 2001
@@ -190,6 +190,7 @@
     struct Scsi_Host *instance;
     unsigned long address;
     struct zorro_dev *z = NULL;
+    wd33c93_regs regs;
 
     if (!MACH_IS_AMIGA || called)
 	return 0;
@@ -215,8 +216,9 @@
 	instance->irq = IRQ_AMIGA_PORTS;
 	instance->unique_id = z->slotaddr;
 	DMA(instance)->DAWR = DAWR_A2091;
-	wd33c93_init(instance, (wd33c93_regs *)&(DMA(instance)->SASR),
-		     dma_setup, dma_stop, WD33C93_FS_8_10);
+	regs.SASR = &(DMA(instance)->SASR);
+	regs.SCMD = &(DMA(instance)->SCMD);
+	wd33c93_init(instance, regs, dma_setup, dma_stop, WD33C93_FS_8_10);
 	if (num_a2091++ == 0) {
 	    first_instance = instance;
 	    a2091_template = instance->hostt;
diff -u --recursive --exclude-from=/home/geert/diff-excludes-linux --new-file linux-m68k-2.4.4/drivers/scsi/a3000.c wd33c93-2.4.4/drivers/scsi/a3000.c
--- linux-m68k-2.4.4/drivers/scsi/a3000.c	Mon Apr 30 13:46:14 2001
+++ wd33c93-2.4.4/drivers/scsi/a3000.c	Wed May 23 08:14:54 2001
@@ -171,6 +171,8 @@
 
 int __init a3000_detect(Scsi_Host_Template *tpnt)
 {
+    wd33c93_regs regs;
+
     if  (!MACH_IS_AMIGA || !AMIGAHW_PRESENT(A3000_SCSI))
 	return 0;
     if (!request_mem_region(0xDD0000, 256, "wd33c93"))
@@ -186,8 +188,9 @@
     a3000_host->base = ZTWO_VADDR(0xDD0000);
     a3000_host->irq = IRQ_AMIGA_PORTS;
     DMA(a3000_host)->DAWR = DAWR_A3000;
-    wd33c93_init(a3000_host, (wd33c93_regs *)&(DMA(a3000_host)->SASR),
-		 dma_setup, dma_stop, WD33C93_FS_12_15);
+    regs.SASR = &(DMA(a3000_host)->SASR);
+    regs.SCMD = &(DMA(a3000_host)->SCMD);
+    wd33c93_init(a3000_host, regs, dma_setup, dma_stop, WD33C93_FS_12_15);
     if (request_irq(IRQ_AMIGA_PORTS, a3000_intr, SA_SHIRQ, "A3000 SCSI",
 		    a3000_intr))
         goto fail_irq;
diff -u --recursive --exclude-from=/home/geert/diff-excludes-linux --new-file linux-m68k-2.4.4/drivers/scsi/gvp11.c wd33c93-2.4.4/drivers/scsi/gvp11.c
--- linux-m68k-2.4.4/drivers/scsi/gvp11.c	Tue Nov 28 02:57:34 2000
+++ wd33c93-2.4.4/drivers/scsi/gvp11.c	Wed May 23 08:13:56 2001
@@ -186,6 +186,7 @@
     unsigned int epc;
     struct zorro_dev *z = NULL;
     unsigned int default_dma_xfer_mask;
+    wd33c93_regs regs;
 #ifdef CHECK_WD33C93
     volatile unsigned char *sasr_3393, *scmd_3393;
     unsigned char save_sasr;
@@ -329,12 +330,11 @@
 	/*
 	 * Check for 14MHz SCSI clock
 	 */
-	if (epc & GVP_SCSICLKMASK)
-		wd33c93_init(instance, (wd33c93_regs *)&(DMA(instance)->SASR),
-			     dma_setup, dma_stop, WD33C93_FS_8_10);
-	else
-		wd33c93_init(instance, (wd33c93_regs *)&(DMA(instance)->SASR),
-			     dma_setup, dma_stop, WD33C93_FS_12_15);
+	regs.SASR = &(DMA(instance)->SASR);
+	regs.SCMD = &(DMA(instance)->SCMD);
+	wd33c93_init(instance, regs, dma_setup, dma_stop,
+		     (epc & GVP_SCSICLKMASK) ? WD33C93_FS_8_10
+					     : WD33C93_FS_12_15);
 
 	if (num_gvp11++ == 0) {
 		first_instance = instance;
diff -u --recursive --exclude-from=/home/geert/diff-excludes-linux --new-file linux-m68k-2.4.4/drivers/scsi/mvme147.c wd33c93-2.4.4/drivers/scsi/mvme147.c
--- linux-m68k-2.4.4/drivers/scsi/mvme147.c	Mon Feb 26 09:02:13 2001
+++ wd33c93-2.4.4/drivers/scsi/mvme147.c	Wed May 23 08:13:56 2001
@@ -65,6 +65,7 @@
 int mvme147_detect(Scsi_Host_Template *tpnt)
 {
     static unsigned char called = 0;
+    wd33c93_regs regs;
 
     if (!MACH_IS_MVME147 || called)
 	return 0;
@@ -79,8 +80,9 @@
 
     mvme147_host->base = 0xfffe4000;
     mvme147_host->irq = MVME147_IRQ_SCSI_PORT;
-    wd33c93_init(mvme147_host, (wd33c93_regs *)0xfffe4000,
-		 dma_setup, dma_stop, WD33C93_FS_8_10);
+    regs.SASR = (volatile unsigned char *)0xfffe4000;
+    regs.SCMD = (volatile unsigned char *)0xfffe4001;
+    wd33c93_init(mvme147_host, regs, dma_setup, dma_stop, WD33C93_FS_8_10);
 
     if (request_irq(MVME147_IRQ_SCSI_PORT, mvme147_intr, 0, "MVME147 SCSI PORT", mvme147_intr))
 	    goto err_unregister;
diff -u --recursive --exclude-from=/home/geert/diff-excludes-linux --new-file linux-m68k-2.4.4/drivers/scsi/sgiwd93.c wd33c93-2.4.4/drivers/scsi/sgiwd93.c
--- linux-m68k-2.4.4/drivers/scsi/sgiwd93.c	Sun Nov 12 04:01:11 2000
+++ wd33c93-2.4.4/drivers/scsi/sgiwd93.c	Wed May 23 08:13:56 2001
@@ -43,22 +43,23 @@
 struct Scsi_Host *sgiwd93_host1 = NULL;
 
 /* Wuff wuff, wuff, wd33c93.c, wuff wuff, object oriented, bow wow. */
-static inline void write_wd33c93_count(wd33c93_regs *regp, unsigned long value)
+static inline void write_wd33c93_count(const wd33c93_regs regs,
+				       unsigned long value)
 {
-	regp->SASR = WD_TRANSFER_COUNT_MSB;
-	regp->SCMD = ((value >> 16) & 0xff);
-	regp->SCMD = ((value >>  8) & 0xff);
-	regp->SCMD = ((value >>  0) & 0xff);
+	*regs.SASR = WD_TRANSFER_COUNT_MSB;
+	*regs.SCMD = ((value >> 16) & 0xff);
+	*regs.SCMD = ((value >>  8) & 0xff);
+	*regs.SCMD = ((value >>  0) & 0xff);
 }
 
-static inline unsigned long read_wd33c93_count(wd33c93_regs *regp)
+static inline unsigned long read_wd33c93_count(const wd33c93_regs regs)
 {
 	unsigned long value;
 
-	regp->SASR = WD_TRANSFER_COUNT_MSB;
-	value =  ((regp->SCMD & 0xff) << 16);
-	value |= ((regp->SCMD & 0xff) <<  8);
-	value |= ((regp->SCMD & 0xff) <<  0);
+	*regs.SASR = WD_TRANSFER_COUNT_MSB;
+	value =  (*regs.SCMD << 16);
+	value |= (*regs.SCMD <<  8);
+	value |= (*regs.SCMD <<  0);
 	return value;
 }
 
@@ -99,7 +100,7 @@
 static int dma_setup(Scsi_Cmnd *cmd, int datainp)
 {
 	struct WD33C93_hostdata *hdata = (struct WD33C93_hostdata *)cmd->host->hostdata;
-	wd33c93_regs *regp = hdata->regp;
+	const wd33c93_regs regs = hdata->regs;
 	struct hpc3_scsiregs *hregs = (struct hpc3_scsiregs *) cmd->host->base;
 	struct hpc_chunk *hcp = (struct hpc_chunk *) hdata->dma_bounce_buffer;
 
@@ -128,7 +129,7 @@
 		printk(">tlen<%d>", totlen);
 #endif
 		hdata->dma_bounce_len = totlen; /* a trick... */
-		write_wd33c93_count(regp, totlen);
+		write_wd33c93_count(regs, totlen);
 	} else {
 		/* Non-scattered dma. */
 #ifdef DEBUG_DMA
@@ -144,7 +145,7 @@
 		if (cmd->SCp.ptr == NULL)
 			return 1;
 		fill_hpc_entries (&hcp, cmd->SCp.ptr,cmd->SCp.this_residual);
-		write_wd33c93_count(regp, cmd->SCp.this_residual);
+		write_wd33c93_count(regs, cmd->SCp.this_residual);
 	}
 
 	/* To make sure, if we trip an HPC bug, that we transfer
@@ -171,7 +172,7 @@
 		     int status)
 {
 	struct WD33C93_hostdata *hdata = (struct WD33C93_hostdata *)instance->hostdata;
-	wd33c93_regs *regp = hdata->regp;
+	const wd33c93_regs regs = hdata->regs;
 	struct hpc3_scsiregs *hregs;
 
 	if (!SCpnt)
@@ -198,7 +199,7 @@
 
 		/* Yep, we were doing the scatterlist thang. */
 		totlen = hdata->dma_bounce_len;
-		wd93_residual = read_wd33c93_count(regp);
+		wd93_residual = read_wd33c93_count(regs);
 		transferred = totlen - wd93_residual;
 
 #ifdef DEBUG_DMA
@@ -268,6 +269,7 @@
 	struct WD33C93_hostdata *hdata;
 	struct WD33C93_hostdata *hdata1;
 	uchar *buf;
+	wd33c93_regs regs;
 	
 	if(called)
 		return 0; /* Should bitch on the console about this... */
@@ -284,8 +286,9 @@
 	init_hpc_chain(buf);
 	dma_cache_wback_inv((unsigned long) buf, PAGE_SIZE);
 	/* HPC_SCSI_REG0 | 0x03 | KSEG1 */
-	wd33c93_init(sgiwd93_host, (wd33c93_regs *) 0xbfbc0003,
-		     dma_setup, dma_stop, WD33C93_FS_16_20);
+	regs.SASR = (volatile unsigned char *)0xbfbc0003;
+	regs.SCMD = (volatile unsigned char *)0xbfbc0007;
+	wd33c93_init(sgiwd93_host, regs, dma_setup, dma_stop, WD33C93_FS_16_20);
 
 	hdata = (struct WD33C93_hostdata *)sgiwd93_host->hostdata;
 	hdata->no_sync = 0;
@@ -305,8 +308,10 @@
 			init_hpc_chain(buf);
 			dma_cache_wback_inv((unsigned long) buf, PAGE_SIZE);
 			/* HPC_SCSI_REG1 | 0x03 | KSEG1 */
-			wd33c93_init(sgiwd93_host1, (wd33c93_regs *) 0xbfbc8003,
-				     dma_setup, dma_stop, WD33C93_FS_16_20);
+			regs.SASR = (volatile unsigned char *)0xbfbc8003;
+			regs.SCMD = (volatile unsigned char *)0xbfbc8007;
+			wd33c93_init(sgiwd93_host1, regs, dma_setup, dma_stop,
+				     WD33C93_FS_16_20);
 	
 			hdata1 = (struct WD33C93_hostdata *)sgiwd93_host1->hostdata;
 			hdata1->no_sync = 0;
diff -u --recursive --exclude-from=/home/geert/diff-excludes-linux --new-file linux-m68k-2.4.4/drivers/scsi/wd33c93.c wd33c93-2.4.4/drivers/scsi/wd33c93.c
--- linux-m68k-2.4.4/drivers/scsi/wd33c93.c	Tue Dec  5 21:43:48 2000
+++ wd33c93-2.4.4/drivers/scsi/wd33c93.c	Wed May 23 09:33:03 2001
@@ -175,71 +175,72 @@
 
 
 
-static inline uchar read_wd33c93(wd33c93_regs *regp,uchar reg_num)
+static inline uchar read_wd33c93(const wd33c93_regs regs, uchar reg_num)
 {
-   regp->SASR = reg_num;
+   *regs.SASR = reg_num;
    mb();
-   return(regp->SCMD);
+   return(*regs.SCMD);
 }
 
 
-#define READ_AUX_STAT() (regp->SASR)
+#define READ_AUX_STAT() (*regs.SASR)
 
 
-static inline void write_wd33c93(wd33c93_regs *regp,uchar reg_num, uchar value)
+static inline void write_wd33c93(const wd33c93_regs regs, uchar reg_num,
+				 uchar value)
 {
-   regp->SASR = reg_num;
+   *regs.SASR = reg_num;
    mb();
-   regp->SCMD = value;
+   *regs.SCMD = value;
    mb();
 }
 
 
-static inline void write_wd33c93_cmd(wd33c93_regs *regp, uchar cmd)
+static inline void write_wd33c93_cmd(const wd33c93_regs regs, uchar cmd)
 {
-   regp->SASR = WD_COMMAND;
+   *regs.SASR = WD_COMMAND;
    mb();
-   regp->SCMD = cmd;
+   *regs.SCMD = cmd;
    mb();
 }
 
 
-static inline uchar read_1_byte(wd33c93_regs *regp)
+static inline uchar read_1_byte(const wd33c93_regs regs)
 {
 uchar asr;
 uchar x = 0;
 
-   write_wd33c93(regp, WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_POLLED);
-   write_wd33c93_cmd(regp, WD_CMD_TRANS_INFO|0x80);
+   write_wd33c93(regs, WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_POLLED);
+   write_wd33c93_cmd(regs, WD_CMD_TRANS_INFO|0x80);
    do {
       asr = READ_AUX_STAT();
       if (asr & ASR_DBR)
-         x = read_wd33c93(regp, WD_DATA);
+         x = read_wd33c93(regs, WD_DATA);
       } while (!(asr & ASR_INT));
    return x;
 }
 
 
-static void write_wd33c93_count(wd33c93_regs *regp,unsigned long value)
+static void write_wd33c93_count(const wd33c93_regs regs, unsigned long value)
 {
-   regp->SASR = WD_TRANSFER_COUNT_MSB;
+   *regs.SASR = WD_TRANSFER_COUNT_MSB;
    mb();
-   regp->SCMD = value >> 16;
-   regp->SCMD = value >> 8;
-   regp->SCMD = value;
+   *regs.SCMD = value >> 16;
+   *regs.SCMD = value >> 8;
+   *regs.SCMD = value;
    mb();
 }
 
 
-static unsigned long read_wd33c93_count(wd33c93_regs *regp)
+static unsigned long read_wd33c93_count(const wd33c93_regs regs)
 {
 unsigned long value;
 
-   regp->SASR = WD_TRANSFER_COUNT_MSB;
+   *regs.SASR = WD_TRANSFER_COUNT_MSB;
    mb();
-   value = regp->SCMD << 16;
-   value |= regp->SCMD << 8;
-   value |= regp->SCMD;
+   value = *regs.SCMD << 16;
+   value |= *regs.SCMD << 8;
+   value |= *regs.SCMD;
    mb();
    return value;
 }
@@ -423,14 +424,11 @@
  */
 static void wd33c93_execute (struct Scsi_Host *instance)
 {
-struct WD33C93_hostdata *hostdata;
-wd33c93_regs *regp;
+struct WD33C93_hostdata *hostdata = (struct WD33C93_hostdata *)instance->hostdata;
+const wd33c93_regs regs = hostdata->regs;
 Scsi_Cmnd *cmd, *prev;
 int i;
 
-   hostdata = (struct WD33C93_hostdata *)instance->hostdata;
-   regp = hostdata->regp;
-
 DB(DB_EXECUTE,printk("EX("))
 
    if (hostdata->selecting || hostdata->connected) {
@@ -479,9 +477,9 @@
     */
 
    if (is_dir_out(cmd))
-      write_wd33c93(regp, WD_DESTINATION_ID, cmd->target);
+      write_wd33c93(regs, WD_DESTINATION_ID, cmd->target);
    else
-      write_wd33c93(regp, WD_DESTINATION_ID, cmd->target | DSTID_DPD);
+      write_wd33c93(regs, WD_DESTINATION_ID, cmd->target | DSTID_DPD);
 
 /* Now we need to figure out whether or not this command is a good
  * candidate for disconnect/reselect. We guess to the best of our
@@ -537,10 +535,10 @@
 
 no:
 
-   write_wd33c93(regp, WD_SOURCE_ID, ((cmd->SCp.phase)?SRCID_ER:0));
+   write_wd33c93(regs, WD_SOURCE_ID, ((cmd->SCp.phase)?SRCID_ER:0));
 
-   write_wd33c93(regp, WD_TARGET_LUN, cmd->lun);
-   write_wd33c93(regp,WD_SYNCHRONOUS_TRANSFER,hostdata->sync_xfer[cmd->target]);
+   write_wd33c93(regs, WD_TARGET_LUN, cmd->lun);
+   write_wd33c93(regs, WD_SYNCHRONOUS_TRANSFER,hostdata->sync_xfer[cmd->target]);
    hostdata->busy[cmd->target] |= (1 << cmd->lun);
 
    if ((hostdata->level2 == L2_NONE) ||
@@ -571,8 +569,8 @@
       if (hostdata->sync_stat[cmd->target] == SS_UNSET)
             hostdata->sync_stat[cmd->target] = SS_FIRST;
       hostdata->state = S_SELECTING;
-      write_wd33c93_count(regp,0); /* guarantee a DATA_PHASE interrupt */
-      write_wd33c93_cmd(regp, WD_CMD_SEL_ATN);
+      write_wd33c93_count(regs, 0); /* guarantee a DATA_PHASE interrupt */
+      write_wd33c93_cmd(regs, WD_CMD_SEL_ATN);
       }
 
    else {
@@ -586,15 +584,15 @@
           */
 
       hostdata->connected = cmd;
-      write_wd33c93(regp, WD_COMMAND_PHASE, 0);
+      write_wd33c93(regs, WD_COMMAND_PHASE, 0);
 
    /* copy command_descriptor_block into WD chip
     * (take advantage of auto-incrementing)
     */
 
-      regp->SASR = WD_CDB_1;
+      *regs.SASR = WD_CDB_1;
       for (i=0; i<cmd->cmd_len; i++)
-         regp->SCMD = cmd->cmnd[i];
+         *regs.SCMD = cmd->cmnd[i];
 
    /* The wd33c93 only knows about Group 0, 1, and 5 commands when
     * it's doing a 'select-and-transfer'. To be safe, we write the
@@ -602,7 +600,7 @@
     * way there won't be problems with vendor-unique, audio, etc.
     */
 
-      write_wd33c93(regp, WD_OWN_ID, cmd->cmd_len);
+      write_wd33c93(regs, WD_OWN_ID, cmd->cmd_len);
 
    /* When doing a non-disconnect command with DMA, we can save
     * ourselves a DATA phase interrupt later by setting everything
@@ -612,18 +610,18 @@
       if ((cmd->SCp.phase == 0) && (hostdata->no_dma == 0)) {
          if (hostdata->dma_setup(cmd,
                      (is_dir_out(cmd))?DATA_OUT_DIR:DATA_IN_DIR))
-            write_wd33c93_count(regp,0); /* guarantee a DATA_PHASE interrupt */
+            write_wd33c93_count(regs, 0); /* guarantee a DATA_PHASE interrupt */
          else {
-            write_wd33c93_count(regp, cmd->SCp.this_residual);
-            write_wd33c93(regp,WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_DMA);
+            write_wd33c93_count(regs, cmd->SCp.this_residual);
+            write_wd33c93(regs, WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_DMA);
             hostdata->dma = D_DMA_RUNNING;
             }
          }
       else
-         write_wd33c93_count(regp,0); /* guarantee a DATA_PHASE interrupt */
+         write_wd33c93_count(regs, 0); /* guarantee a DATA_PHASE interrupt */
 
       hostdata->state = S_RUNNING_LEVEL2;
-      write_wd33c93_cmd(regp, WD_CMD_SEL_ATN_XFER);
+      write_wd33c93_cmd(regs, WD_CMD_SEL_ATN_XFER);
       }
 
    /*
@@ -638,28 +636,28 @@
 
 
 
-static void transfer_pio(wd33c93_regs *regp, uchar *buf, int cnt,
-                  int data_in_dir, struct WD33C93_hostdata *hostdata)
+static void transfer_pio(const wd33c93_regs regs, uchar *buf, int cnt,
+			 int data_in_dir, struct WD33C93_hostdata *hostdata)
 {
 uchar asr;
 
 DB(DB_TRANSFER,printk("(%p,%d,%s:",buf,cnt,data_in_dir?"in":"out"))
 
-   write_wd33c93(regp, WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_POLLED);
-   write_wd33c93_count(regp,cnt);
-   write_wd33c93_cmd(regp, WD_CMD_TRANS_INFO);
+   write_wd33c93(regs, WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_POLLED);
+   write_wd33c93_count(regs, cnt);
+   write_wd33c93_cmd(regs, WD_CMD_TRANS_INFO);
    if (data_in_dir) {
       do {
          asr = READ_AUX_STAT();
          if (asr & ASR_DBR)
-            *buf++ = read_wd33c93(regp, WD_DATA);
+            *buf++ = read_wd33c93(regs, WD_DATA);
          } while (!(asr & ASR_INT));
       }
    else {
       do {
          asr = READ_AUX_STAT();
          if (asr & ASR_DBR)
-            write_wd33c93(regp, WD_DATA, *buf++);
+            write_wd33c93(regs, WD_DATA, *buf++);
          } while (!(asr & ASR_INT));
       }
 
@@ -674,7 +672,8 @@
 
 
 
-static void transfer_bytes(wd33c93_regs *regp, Scsi_Cmnd *cmd, int data_in_dir)
+static void transfer_bytes(const wd33c93_regs regs, Scsi_Cmnd *cmd,
+			   int data_in_dir)
 {
 struct WD33C93_hostdata *hostdata;
 unsigned long length;
@@ -696,7 +695,7 @@
       cmd->SCp.ptr = cmd->SCp.buffer->address;
       }
 
-   write_wd33c93(regp,WD_SYNCHRONOUS_TRANSFER,hostdata->sync_xfer[cmd->target]);
+   write_wd33c93(regs, WD_SYNCHRONOUS_TRANSFER,hostdata->sync_xfer[cmd->target]);
 
 /* 'hostdata->no_dma' is TRUE if we don't even want to try DMA.
  * Update 'this_residual' and 'ptr' after 'transfer_pio()' returns.
@@ -714,10 +713,10 @@
 #ifdef PROC_STATISTICS
       hostdata->pio_cnt++;
 #endif
-      transfer_pio(regp, (uchar *)cmd->SCp.ptr, cmd->SCp.this_residual,
+      transfer_pio(regs, (uchar *)cmd->SCp.ptr, cmd->SCp.this_residual,
                          data_in_dir, hostdata);
       length = cmd->SCp.this_residual;
-      cmd->SCp.this_residual = read_wd33c93_count(regp);
+      cmd->SCp.this_residual = read_wd33c93_count(regs);
       cmd->SCp.ptr += (length - cmd->SCp.this_residual);
       }
 
@@ -734,17 +733,17 @@
 #ifdef PROC_STATISTICS
       hostdata->dma_cnt++;
 #endif
-      write_wd33c93(regp, WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_DMA);
-      write_wd33c93_count(regp,cmd->SCp.this_residual);
+      write_wd33c93(regs, WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_DMA);
+      write_wd33c93_count(regs, cmd->SCp.this_residual);
 
       if ((hostdata->level2 >= L2_DATA) ||
           (hostdata->level2 == L2_BASIC && cmd->SCp.phase == 0)) {
-         write_wd33c93(regp, WD_COMMAND_PHASE, 0x45);
-         write_wd33c93_cmd(regp, WD_CMD_SEL_ATN_XFER);
+         write_wd33c93(regs, WD_COMMAND_PHASE, 0x45);
+         write_wd33c93_cmd(regs, WD_CMD_SEL_ATN_XFER);
          hostdata->state = S_RUNNING_LEVEL2;
          }
       else
-         write_wd33c93_cmd(regp, WD_CMD_TRANS_INFO);
+         write_wd33c93_cmd(regs, WD_CMD_TRANS_INFO);
 
       hostdata->dma = D_DMA_RUNNING;
       }
@@ -754,15 +753,12 @@
 
 void wd33c93_intr (struct Scsi_Host *instance)
 {
-struct WD33C93_hostdata *hostdata;
+struct WD33C93_hostdata *hostdata = (struct WD33C93_hostdata *)instance->hostdata;
+const wd33c93_regs regs = hostdata->regs;
 Scsi_Cmnd *patch, *cmd;
-wd33c93_regs *regp;
 uchar asr, sr, phs, id, lun, *ucp, msg;
 unsigned long length, flags;
 
-   hostdata = (struct WD33C93_hostdata *)instance->hostdata;
-   regp = hostdata->regp;
-
    asr = READ_AUX_STAT();
    if (!(asr & ASR_INT) || (asr & ASR_BSY))
       return;
@@ -774,8 +770,8 @@
 #endif
 
    cmd = (Scsi_Cmnd *)hostdata->connected;   /* assume we're connected */
-   sr = read_wd33c93(regp, WD_SCSI_STATUS);  /* clear the interrupt */
-   phs = read_wd33c93(regp, WD_COMMAND_PHASE);
+   sr = read_wd33c93(regs, WD_SCSI_STATUS);  /* clear the interrupt */
+   phs = read_wd33c93(regs, WD_COMMAND_PHASE);
 
 DB(DB_INTR,printk("{%02x:%02x-",asr,sr))
 
@@ -799,7 +795,7 @@
       hostdata->dma_stop(cmd->host, cmd, 1);
       hostdata->dma = D_DMA_OFF;
       length = cmd->SCp.this_residual;
-      cmd->SCp.this_residual = read_wd33c93_count(regp);
+      cmd->SCp.this_residual = read_wd33c93_count(regs);
       cmd->SCp.ptr += (length - cmd->SCp.this_residual);
 DB(DB_TRANSFER,printk("%p/%d]",cmd->SCp.ptr,cmd->SCp.this_residual))
       }
@@ -894,7 +890,7 @@
       case CSR_UNEXP    |PHS_DATA_IN:
       case CSR_SRV_REQ  |PHS_DATA_IN:
 DB(DB_INTR,printk("IN-%d.%d",cmd->SCp.this_residual,cmd->SCp.buffers_residual))
-         transfer_bytes(regp, cmd, DATA_IN_DIR);
+         transfer_bytes(regs, cmd, DATA_IN_DIR);
          if (hostdata->state != S_RUNNING_LEVEL2)
             hostdata->state = S_CONNECTED;
          break;
@@ -904,7 +900,7 @@
       case CSR_UNEXP    |PHS_DATA_OUT:
       case CSR_SRV_REQ  |PHS_DATA_OUT:
 DB(DB_INTR,printk("OUT-%d.%d",cmd->SCp.this_residual,cmd->SCp.buffers_residual))
-         transfer_bytes(regp, cmd, DATA_OUT_DIR);
+         transfer_bytes(regs, cmd, DATA_OUT_DIR);
          if (hostdata->state != S_RUNNING_LEVEL2)
             hostdata->state = S_CONNECTED;
          break;
@@ -916,7 +912,7 @@
       case CSR_UNEXP    |PHS_COMMAND:
       case CSR_SRV_REQ  |PHS_COMMAND:
 DB(DB_INTR,printk("CMND-%02x,%ld",cmd->cmnd[0],cmd->pid))
-         transfer_pio(regp, cmd->cmnd, cmd->cmd_len, DATA_OUT_DIR, hostdata);
+         transfer_pio(regs, cmd->cmnd, cmd->cmd_len, DATA_OUT_DIR, hostdata);
          hostdata->state = S_CONNECTED;
          break;
 
@@ -926,13 +922,13 @@
       case CSR_SRV_REQ  |PHS_STATUS:
 DB(DB_INTR,printk("STATUS="))
 
-         cmd->SCp.Status = read_1_byte(regp);
+         cmd->SCp.Status = read_1_byte(regs);
 DB(DB_INTR,printk("%02x",cmd->SCp.Status))
          if (hostdata->level2 >= L2_BASIC) {
-            sr = read_wd33c93(regp, WD_SCSI_STATUS);  /* clear interrupt */
+            sr = read_wd33c93(regs, WD_SCSI_STATUS);  /* clear interrupt */
             hostdata->state = S_RUNNING_LEVEL2;
-            write_wd33c93(regp, WD_COMMAND_PHASE, 0x50);
-            write_wd33c93_cmd(regp, WD_CMD_SEL_ATN_XFER);
+            write_wd33c93(regs, WD_COMMAND_PHASE, 0x50);
+            write_wd33c93_cmd(regs, WD_CMD_SEL_ATN_XFER);
             }
          else {
             hostdata->state = S_CONNECTED;
@@ -945,8 +941,8 @@
       case CSR_SRV_REQ  |PHS_MESS_IN:
 DB(DB_INTR,printk("MSG_IN="))
 
-         msg = read_1_byte(regp);
-         sr = read_wd33c93(regp, WD_SCSI_STATUS);  /* clear interrupt */
+         msg = read_1_byte(regs);
+         sr = read_wd33c93(regs, WD_SCSI_STATUS);  /* clear interrupt */
 
          hostdata->incoming_msg[hostdata->incoming_ptr] = msg;
          if (hostdata->incoming_msg[0] == EXTENDED_MESSAGE)
@@ -959,25 +955,25 @@
 
             case COMMAND_COMPLETE:
 DB(DB_INTR,printk("CCMP-%ld",cmd->pid))
-               write_wd33c93_cmd(regp,WD_CMD_NEGATE_ACK);
+               write_wd33c93_cmd(regs, WD_CMD_NEGATE_ACK);
                hostdata->state = S_PRE_CMP_DISC;
                break;
 
             case SAVE_POINTERS:
 DB(DB_INTR,printk("SDP"))
-               write_wd33c93_cmd(regp,WD_CMD_NEGATE_ACK);
+               write_wd33c93_cmd(regs, WD_CMD_NEGATE_ACK);
                hostdata->state = S_CONNECTED;
                break;
 
             case RESTORE_POINTERS:
 DB(DB_INTR,printk("RDP"))
                if (hostdata->level2 >= L2_BASIC) {
-                  write_wd33c93(regp, WD_COMMAND_PHASE, 0x45);
-                  write_wd33c93_cmd(regp, WD_CMD_SEL_ATN_XFER);
+                  write_wd33c93(regs, WD_COMMAND_PHASE, 0x45);
+                  write_wd33c93_cmd(regs, WD_CMD_SEL_ATN_XFER);
                   hostdata->state = S_RUNNING_LEVEL2;
                   }
                else {
-                  write_wd33c93_cmd(regp, WD_CMD_NEGATE_ACK);
+                  write_wd33c93_cmd(regs, WD_CMD_NEGATE_ACK);
                   hostdata->state = S_CONNECTED;
                   }
                break;
@@ -985,7 +981,7 @@
             case DISCONNECT:
 DB(DB_INTR,printk("DIS"))
                cmd->device->disconnect = 1;
-               write_wd33c93_cmd(regp,WD_CMD_NEGATE_ACK);
+               write_wd33c93_cmd(regs, WD_CMD_NEGATE_ACK);
                hostdata->state = S_PRE_TMP_DISC;
                break;
 
@@ -996,7 +992,7 @@
 #endif
                if (hostdata->sync_stat[cmd->target] == SS_WAITING)
                   hostdata->sync_stat[cmd->target] = SS_SET;
-               write_wd33c93_cmd(regp,WD_CMD_NEGATE_ACK);
+               write_wd33c93_cmd(regs, WD_CMD_NEGATE_ACK);
                hostdata->state = S_CONNECTED;
                break;
 
@@ -1027,7 +1023,7 @@
  * specifically ask for sync transfers, we won't do any.
  */
 
-                           write_wd33c93_cmd(regp,WD_CMD_ASSERT_ATN); /* want MESS_OUT */
+                           write_wd33c93_cmd(regs, WD_CMD_ASSERT_ATN); /* want MESS_OUT */
                            hostdata->outgoing_msg[0] = EXTENDED_MESSAGE;
                            hostdata->outgoing_msg[1] = 3;
                            hostdata->outgoing_msg[2] = EXTENDED_SDTR;
@@ -1044,26 +1040,26 @@
 printk("sync_xfer=%02x",hostdata->sync_xfer[cmd->target]);
 #endif
                         hostdata->sync_stat[cmd->target] = SS_SET;
-                        write_wd33c93_cmd(regp,WD_CMD_NEGATE_ACK);
+                        write_wd33c93_cmd(regs, WD_CMD_NEGATE_ACK);
                         hostdata->state = S_CONNECTED;
                         break;
                      case EXTENDED_WDTR:
-                        write_wd33c93_cmd(regp,WD_CMD_ASSERT_ATN); /* want MESS_OUT */
+                        write_wd33c93_cmd(regs, WD_CMD_ASSERT_ATN); /* want MESS_OUT */
                         printk("sending WDTR ");
                         hostdata->outgoing_msg[0] = EXTENDED_MESSAGE;
                         hostdata->outgoing_msg[1] = 2;
                         hostdata->outgoing_msg[2] = EXTENDED_WDTR;
                         hostdata->outgoing_msg[3] = 0;   /* 8 bit transfer width */
                         hostdata->outgoing_len = 4;
-                        write_wd33c93_cmd(regp,WD_CMD_NEGATE_ACK);
+                        write_wd33c93_cmd(regs, WD_CMD_NEGATE_ACK);
                         hostdata->state = S_CONNECTED;
                         break;
                      default:
-                        write_wd33c93_cmd(regp,WD_CMD_ASSERT_ATN); /* want MESS_OUT */
+                        write_wd33c93_cmd(regs, WD_CMD_ASSERT_ATN); /* want MESS_OUT */
                         printk("Rejecting Unknown Extended Message(%02x). ",ucp[2]);
                         hostdata->outgoing_msg[0] = MESSAGE_REJECT;
                         hostdata->outgoing_len = 1;
-                        write_wd33c93_cmd(regp,WD_CMD_NEGATE_ACK);
+                        write_wd33c93_cmd(regs, WD_CMD_NEGATE_ACK);
                         hostdata->state = S_CONNECTED;
                         break;
                      }
@@ -1074,17 +1070,17 @@
 
                else {
                   hostdata->incoming_ptr++;
-                  write_wd33c93_cmd(regp,WD_CMD_NEGATE_ACK);
+                  write_wd33c93_cmd(regs, WD_CMD_NEGATE_ACK);
                   hostdata->state = S_CONNECTED;
                   }
                break;
 
             default:
                printk("Rejecting Unknown Message(%02x) ",msg);
-               write_wd33c93_cmd(regp,WD_CMD_ASSERT_ATN); /* want MESS_OUT */
+               write_wd33c93_cmd(regs, WD_CMD_ASSERT_ATN); /* want MESS_OUT */
                hostdata->outgoing_msg[0] = MESSAGE_REJECT;
                hostdata->outgoing_len = 1;
-               write_wd33c93_cmd(regp,WD_CMD_NEGATE_ACK);
+               write_wd33c93_cmd(regs, WD_CMD_NEGATE_ACK);
                hostdata->state = S_CONNECTED;
             }
          restore_flags(flags);
@@ -1099,11 +1095,11 @@
  * have been turned off for the command that just completed.
  */
 
-         write_wd33c93(regp,WD_SOURCE_ID, SRCID_ER);
+         write_wd33c93(regs, WD_SOURCE_ID, SRCID_ER);
          if (phs == 0x60) {
 DB(DB_INTR,printk("SX-DONE-%ld",cmd->pid))
             cmd->SCp.Message = COMMAND_COMPLETE;
-            lun = read_wd33c93(regp, WD_TARGET_LUN);
+            lun = read_wd33c93(regs, WD_TARGET_LUN);
 DB(DB_INTR,printk(":%d.%d",cmd->SCp.Status,lun))
             hostdata->connected = NULL;
             hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
@@ -1133,8 +1129,8 @@
       case CSR_SDP:
 DB(DB_INTR,printk("SDP"))
             hostdata->state = S_RUNNING_LEVEL2;
-            write_wd33c93(regp, WD_COMMAND_PHASE, 0x41);
-            write_wd33c93_cmd(regp, WD_CMD_SEL_ATN_XFER);
+            write_wd33c93(regs, WD_COMMAND_PHASE, 0x41);
+            write_wd33c93_cmd(regs, WD_CMD_SEL_ATN_XFER);
          break;
 
 
@@ -1160,7 +1156,7 @@
             hostdata->outgoing_len = 1;
             hostdata->outgoing_msg[0] = NOP;
             }
-         transfer_pio(regp, hostdata->outgoing_msg, hostdata->outgoing_len,
+         transfer_pio(regs, hostdata->outgoing_msg, hostdata->outgoing_len,
                             DATA_OUT_DIR, hostdata);
 DB(DB_INTR,printk("%02x",hostdata->outgoing_msg[0]))
          hostdata->outgoing_len = 0;
@@ -1182,7 +1178,7 @@
  * have been turned off for the command that just completed.
  */
 
-         write_wd33c93(regp,WD_SOURCE_ID, SRCID_ER);
+         write_wd33c93(regs, WD_SOURCE_ID, SRCID_ER);
          if (cmd == NULL) {
             printk(" - Already disconnected! ");
             hostdata->state = S_UNCONNECTED;
@@ -1213,7 +1209,7 @@
  * have been turned off for the command that just completed.
  */
 
-         write_wd33c93(regp,WD_SOURCE_ID, SRCID_ER);
+         write_wd33c93(regs, WD_SOURCE_ID, SRCID_ER);
 DB(DB_INTR,printk("DISC-%ld",cmd->pid))
          if (cmd == NULL) {
             printk(" - Already disconnected! ");
@@ -1298,7 +1294,7 @@
 
    /* OK - find out which device reselected us. */
 
-         id = read_wd33c93(regp, WD_SOURCE_ID);
+         id = read_wd33c93(regs, WD_SOURCE_ID);
          id &= SRCID_MASK;
 
    /* and extract the lun from the ID message. (Note that we don't
@@ -1307,9 +1303,9 @@
     */
 
          if (sr == CSR_RESEL_AM) {
-            lun = read_wd33c93(regp, WD_DATA);
+            lun = read_wd33c93(regs, WD_DATA);
             if (hostdata->level2 < L2_RESELECT)
-               write_wd33c93_cmd(regp,WD_CMD_NEGATE_ACK);
+               write_wd33c93_cmd(regs, WD_CMD_NEGATE_ACK);
             lun &= 7;
          }
          else {
@@ -1325,12 +1321,12 @@
             }
             else {
                /* Verify this is a change to MSG_IN and read the message */
-               sr = read_wd33c93(regp, WD_SCSI_STATUS);
+               sr = read_wd33c93(regs, WD_SCSI_STATUS);
                if (sr == (CSR_ABORT   | PHS_MESS_IN) ||
                    sr == (CSR_UNEXP   | PHS_MESS_IN) ||
                    sr == (CSR_SRV_REQ | PHS_MESS_IN)) {
                   /* Got MSG_IN, grab target LUN */
-                  lun = read_1_byte(regp);
+                  lun = read_1_byte(regs);
                   /* Now we expect a 'paused with ACK asserted' int.. */
                   asr = READ_AUX_STAT();
                   if (!(asr & ASR_INT)) {
@@ -1340,12 +1336,12 @@
                         printk("wd33c93: No int after LUN on RESEL (%02x)\n",
                               asr);
                   }
-                  sr = read_wd33c93(regp, WD_SCSI_STATUS);
+                  sr = read_wd33c93(regs, WD_SCSI_STATUS);
                   if (sr != CSR_MSGIN)
                      printk("wd33c93: Not paused with ACK on RESEL (%02x)\n",
                            sr);
                   lun &= 7;
-                  write_wd33c93_cmd(regp,WD_CMD_NEGATE_ACK);
+                  write_wd33c93_cmd(regs, WD_CMD_NEGATE_ACK);
                }
                else {
                   printk("wd33c93: Not MSG_IN on reselect (%02x)\n", sr);
@@ -1386,13 +1382,13 @@
     */
 
          if (is_dir_out(cmd))
-            write_wd33c93(regp, WD_DESTINATION_ID, cmd->target);
+            write_wd33c93(regs, WD_DESTINATION_ID, cmd->target);
          else
-            write_wd33c93(regp, WD_DESTINATION_ID, cmd->target | DSTID_DPD);
+            write_wd33c93(regs, WD_DESTINATION_ID, cmd->target | DSTID_DPD);
          if (hostdata->level2 >= L2_RESELECT) {
-            write_wd33c93_count(regp, 0);  /* we want a DATA_PHASE interrupt */
-            write_wd33c93(regp, WD_COMMAND_PHASE, 0x45);
-            write_wd33c93_cmd(regp, WD_CMD_SEL_ATN_XFER);
+            write_wd33c93_count(regs, 0);  /* we want a DATA_PHASE interrupt */
+            write_wd33c93(regs, WD_COMMAND_PHASE, 0x45);
+            write_wd33c93_cmd(regs, WD_CMD_SEL_ATN_XFER);
             hostdata->state = S_RUNNING_LEVEL2;
             }
          else
@@ -1413,36 +1409,33 @@
 
 static void reset_wd33c93(struct Scsi_Host *instance)
 {
-struct WD33C93_hostdata *hostdata;
-wd33c93_regs *regp;
+struct WD33C93_hostdata *hostdata = (struct WD33C93_hostdata *)instance->hostdata;
+const wd33c93_regs regs = hostdata->regs;
 uchar sr;
 
-   hostdata = (struct WD33C93_hostdata *)instance->hostdata;
-   regp = hostdata->regp;
-
-   write_wd33c93(regp, WD_OWN_ID, OWNID_EAF | OWNID_RAF |
+   write_wd33c93(regs, WD_OWN_ID, OWNID_EAF | OWNID_RAF |
                  instance->this_id | hostdata->clock_freq);
-   write_wd33c93(regp, WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_POLLED);
-   write_wd33c93(regp, WD_SYNCHRONOUS_TRANSFER,
+   write_wd33c93(regs, WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_POLLED);
+   write_wd33c93(regs, WD_SYNCHRONOUS_TRANSFER,
                  calc_sync_xfer(hostdata->default_sx_per/4,DEFAULT_SX_OFF));
-   write_wd33c93(regp, WD_COMMAND, WD_CMD_RESET);
+   write_wd33c93(regs, WD_COMMAND, WD_CMD_RESET);
 #ifdef CONFIG_MVME147_SCSI
    udelay(25); /* The old wd33c93 on MVME147 needs this, at least */
 #endif
 
    while (!(READ_AUX_STAT() & ASR_INT))
       ;
-   sr = read_wd33c93(regp, WD_SCSI_STATUS);
+   sr = read_wd33c93(regs, WD_SCSI_STATUS);
 
-   hostdata->microcode = read_wd33c93(regp, WD_CDB_1);
+   hostdata->microcode = read_wd33c93(regs, WD_CDB_1);
    if (sr == 0x00)
       hostdata->chip = C_WD33C93;
    else if (sr == 0x01) {
-      write_wd33c93(regp, WD_QUEUE_TAG, 0xa5);  /* any random number */
-      sr = read_wd33c93(regp, WD_QUEUE_TAG);
+      write_wd33c93(regs, WD_QUEUE_TAG, 0xa5);  /* any random number */
+      sr = read_wd33c93(regs, WD_QUEUE_TAG);
       if (sr == 0xa5) {
          hostdata->chip = C_WD33C93B;
-         write_wd33c93(regp, WD_QUEUE_TAG, 0);
+         write_wd33c93(regs, WD_QUEUE_TAG, 0);
          }
       else
          hostdata->chip = C_WD33C93A;
@@ -1450,8 +1443,8 @@
    else
       hostdata->chip = C_UNKNOWN_CHIP;
 
-   write_wd33c93(regp, WD_TIMEOUT_PERIOD, TIMEOUT_PERIOD_VALUE);
-   write_wd33c93(regp, WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_POLLED);
+   write_wd33c93(regs, WD_TIMEOUT_PERIOD, TIMEOUT_PERIOD_VALUE);
+   write_wd33c93(regs, WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_POLLED);
 }
 
 
@@ -1495,14 +1488,14 @@
 {
 struct Scsi_Host *instance;
 struct WD33C93_hostdata *hostdata;
-wd33c93_regs *regp;
+wd33c93_regs regs;
 Scsi_Cmnd *tmp, *prev;
 
    disable_irq(cmd->host->irq);
 
    instance = cmd->host;
    hostdata = (struct WD33C93_hostdata *)instance->hostdata;
-   regp = hostdata->regp;
+   regs = hostdata->regs;
 
 /*
  * Case 1 : If the command hasn't been issued yet, we simply remove it
@@ -1554,8 +1547,8 @@
          }
 
       printk("sending wd33c93 ABORT command - ");
-      write_wd33c93(regp, WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_POLLED);
-      write_wd33c93_cmd(regp, WD_CMD_ABORT);
+      write_wd33c93(regs, WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_POLLED);
+      write_wd33c93_cmd(regs, WD_CMD_ABORT);
 
 /* Now we have to attempt to flush out the FIFO... */
 
@@ -1564,11 +1557,11 @@
       do {
          asr = READ_AUX_STAT();
          if (asr & ASR_DBR)
-            read_wd33c93(regp, WD_DATA);
+            read_wd33c93(regs, WD_DATA);
          } while (!(asr & ASR_INT) && timeout-- > 0);
-      sr = read_wd33c93(regp, WD_SCSI_STATUS);
+      sr = read_wd33c93(regs, WD_SCSI_STATUS);
       printk("asr=%02x, sr=%02x, %ld bytes un-transferred (timeout=%ld) - ",
-             asr, sr, read_wd33c93_count(regp), timeout);
+             asr, sr, read_wd33c93_count(regs), timeout);
 
    /*
     * Abort command processed.
@@ -1577,13 +1570,13 @@
     */
 
       printk("sending wd33c93 DISCONNECT command - ");
-      write_wd33c93_cmd(regp, WD_CMD_DISCONNECT);
+      write_wd33c93_cmd(regs, WD_CMD_DISCONNECT);
 
       timeout = 1000000;
       asr = READ_AUX_STAT();
       while ((asr & ASR_CIP) && timeout-- > 0)
          asr = READ_AUX_STAT();
-      sr = read_wd33c93(regp, WD_SCSI_STATUS);
+      sr = read_wd33c93(regs, WD_SCSI_STATUS);
       printk("asr=%02x, sr=%02x.",asr,sr);
 
       hostdata->busy[cmd->target] &= ~(1 << cmd->lun);
@@ -1733,8 +1726,8 @@
 
 
 
-void wd33c93_init (struct Scsi_Host *instance, wd33c93_regs *regs,
-         dma_setup_t setup, dma_stop_t stop, int clock_freq)
+void wd33c93_init(struct Scsi_Host *instance, const wd33c93_regs regs,
+		  dma_setup_t setup, dma_stop_t stop, int clock_freq)
 {
 struct WD33C93_hostdata *hostdata;
 int i;
@@ -1747,7 +1740,7 @@
 
    hostdata = (struct WD33C93_hostdata *)instance->hostdata;
 
-   hostdata->regp = regs;
+   hostdata->regs = regs;
    hostdata->clock_freq = clock_freq;
    hostdata->dma_setup = setup;
    hostdata->dma_stop = stop;
diff -u --recursive --exclude-from=/home/geert/diff-excludes-linux --new-file linux-m68k-2.4.4/drivers/scsi/wd33c93.h wd33c93-2.4.4/drivers/scsi/wd33c93.h
--- linux-m68k-2.4.4/drivers/scsi/wd33c93.h	Tue Nov 28 02:57:34 2000
+++ wd33c93-2.4.4/drivers/scsi/wd33c93.h	Wed May 23 08:13:56 2001
@@ -189,14 +189,8 @@
 
    /* This is what the 3393 chip looks like to us */
 typedef struct {
-   volatile unsigned char   SASR;
-#if !defined(CONFIG_MVME147_SCSI)
-   char                     pad;
-#endif
-#ifdef CONFIG_SGI_IP22
-   char                     pad2,pad3;
-#endif
-   volatile unsigned char   SCMD;
+   volatile unsigned char  *SASR;
+   volatile unsigned char  *SCMD;
 } wd33c93_regs;
 
 
@@ -225,7 +219,7 @@
 
 struct WD33C93_hostdata {
     struct Scsi_Host *next;
-    wd33c93_regs     *regp;
+    wd33c93_regs     regs;
     uchar            clock_freq;
     uchar            chip;             /* what kind of wd33c93? */
     uchar            microcode;        /* microcode rev */
@@ -336,7 +330,7 @@
 #define PR_STOP      1<<7
 
 
-void wd33c93_init (struct Scsi_Host *instance, wd33c93_regs *regs,
+void wd33c93_init (struct Scsi_Host *instance, const wd33c93_regs regs,
          dma_setup_t setup, dma_stop_t stop, int clock_freq);
 int wd33c93_abort (Scsi_Cmnd *cmd);
 int wd33c93_queuecommand (Scsi_Cmnd *cmd, void (*done)(Scsi_Cmnd *));

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
