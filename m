Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Nov 2002 14:07:00 +0100 (CET)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:47275 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122123AbSKUNHA>; Thu, 21 Nov 2002 14:07:00 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA26094
	for <linux-mips@linux-mips.org>; Thu, 21 Nov 2002 14:07:21 +0100 (MET)
Date: Thu, 21 Nov 2002 14:07:20 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-mips@linux-mips.org
Subject: [RFT] DEC SCSI driver clean-up
Message-ID: <Pine.GSO.3.96.1021121134955.24541B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 Following is a patch that removes SCp.have_data_in references -- the
member is initialized by the NCR53C9x.c core and by the dec_esp.c
front-end, but used by neither.  I believe it's some leftover cruft from
the days there were no front-ends -- it's actually used by esp.c.  There
are a few less significant clean-ups here and there as well. 

 I want to apply the patch to the CVS, but I have no means to test it with
a SCSI device -- I could only verify after the change the driver works
well enough to detect the absence of devices in my systems.  I would
appreciate if someone with a real SCSI setup could test these changes
before I apply them.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.20-pre6-20021106-mips64-dec_esp-2
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021106.macro/drivers/scsi/NCR53C9x.c linux-mips-2.4.20-pre6-20021106/drivers/scsi/NCR53C9x.c
--- linux-mips-2.4.20-pre6-20021106.macro/drivers/scsi/NCR53C9x.c	2002-09-12 03:20:28.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021106/drivers/scsi/NCR53C9x.c	2002-10-22 23:02:09.000000000 +0000
@@ -917,7 +917,7 @@ static void esp_get_dmabufs(struct NCR_E
 		if (esp->dma_mmu_get_scsi_one)
 			esp->dma_mmu_get_scsi_one(esp, sp);
 		else
-			sp->SCp.have_data_in = (int) sp->SCp.ptr =
+			sp->SCp.ptr =
 				(char *) virt_to_phys(sp->request_buffer);
 	} else {
 		sp->SCp.buffer = (struct scatterlist *) sp->buffer;
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021106.macro/drivers/scsi/dec_esp.c linux-mips-2.4.20-pre6-20021106/drivers/scsi/dec_esp.c
--- linux-mips-2.4.20-pre6-20021106.macro/drivers/scsi/dec_esp.c	2002-10-02 17:22:42.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021106/drivers/scsi/dec_esp.c	2002-10-22 23:49:24.000000000 +0000
@@ -323,7 +323,7 @@ static int dma_bytes_sent(struct NCR_ESP
 static void dma_drain(struct NCR_ESP *esp)
 {
 	unsigned long nw = *scsi_scr;
-	unsigned short *p = KSEG1ADDR((unsigned short *) ((*scsi_dma_ptr) >> 3));
+	unsigned short *p = (unsigned short *)KSEG1ADDR((*scsi_dma_ptr) >> 3);
 
     /*
 	 * Is there something in the dma buffers left?
@@ -437,8 +437,7 @@ static void dma_setup(struct NCR_ESP *es
  */
 static void dma_mmu_get_scsi_one(struct NCR_ESP *esp, Scsi_Cmnd * sp)
 {
-	sp->SCp.have_data_in = PHYSADDR(sp->SCp.buffer);
-	sp->SCp.ptr = (char *) ((unsigned long) sp->SCp.have_data_in);
+	sp->SCp.ptr = (char *)PHYSADDR(sp->SCp.buffer);
 }
 
 static void dma_mmu_get_scsi_sgl(struct NCR_ESP *esp, Scsi_Cmnd * sp)
@@ -484,8 +483,8 @@ static void pmaz_dma_init_write(struct N
 {
 	volatile int *dmareg = (volatile int *) ( esp->slot + DEC_SCSI_DMAREG );
 
-	memcpy((void *) (esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE),
-			KSEG0ADDR((void *) vaddress), length);
+	memcpy((void *)(esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE),
+	       (void *)KSEG0ADDR(vaddress), length);
 
 	*dmareg = TC_ESP_DMAR_WRITE |
 		TC_ESP_DMA_ADDR(esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE);
@@ -516,7 +515,5 @@ static void pmaz_dma_setup(struct NCR_ES
 
 static void pmaz_dma_mmu_get_scsi_one(struct NCR_ESP *esp, Scsi_Cmnd * sp)
 {
-	sp->SCp.have_data_in = (int) sp->SCp.ptr =
-	    (char *) KSEG0ADDR((sp->request_buffer));
+	sp->SCp.ptr = (char *)KSEG0ADDR((sp->request_buffer));
 }
-
