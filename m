Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6HDToRw023551
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Jul 2002 06:29:50 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6HDTo7b023550
	for linux-mips-outgoing; Wed, 17 Jul 2002 06:29:50 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6HDTZRw023541
	for <linux-mips@oss.sgi.com>; Wed, 17 Jul 2002 06:29:39 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA20711;
	Wed, 17 Jul 2002 15:35:04 +0200 (MET DST)
Date: Wed, 17 Jul 2002 15:35:04 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
cc: linux-mips@oss.sgi.com
Subject: Re: DECStation: Support for PMAZ-AA TC SCSI card? 
In-Reply-To: <200207171216.OAA00433@sparta.research.kpn.com>
Message-ID: <Pine.GSO.3.96.1020717141827.13355G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Karel,

> What do you mean by a mixed system?

 Both a PMAZ-A and an I/O ASIC-based controller.  They differ.

> I also have a 5000/200 system. Would it be interesting to put the
> PMAZ-AA into that system, and see how it behaves?

 Well, the /200's onboard HBA is identical to a PMAZ-A.  You don't need to
rearrange hardware, although you may, just to be sure -- if the /200
works, then the problem is almost surely related to write posting
implemented on the KN05 module which we currently don't handle (it's
worked around in the driver in the I/O ASIC-related functions via an ugly
hack). 

 Just in case I am right, please check if the following hack helps with
your PMAZ-A in your /260. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.19-rc1-20020717-dec_esp-test-0
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020717.macro/drivers/scsi/dec_esp.c linux-mips-2.4.19-rc1-20020717/drivers/scsi/dec_esp.c
--- linux-mips-2.4.19-rc1-20020717.macro/drivers/scsi/dec_esp.c	2002-04-10 02:58:49.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020717/drivers/scsi/dec_esp.c	2002-07-17 13:24:59.000000000 +0000
@@ -486,12 +486,15 @@ static void pmaz_dma_drain(struct NCR_ES
 static void pmaz_dma_init_read(struct NCR_ESP *esp, __u32 vaddress, int length)
 {
 	volatile int *dmareg = (volatile int *) (esp->slot + DEC_SCSI_DMAREG);
+	volatile unsigned int *dummy = (volatile unsigned int *)KSEG1;
 
 	if (length > ESP_TGT_DMA_SIZE)
 		length = ESP_TGT_DMA_SIZE;
 
 	*dmareg = TC_ESP_DMA_ADDR(esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE);
 
+	*dummy;
+
 	esp_virt_buffer = vaddress;
 	scsi_current_length = length;
 }
@@ -499,6 +502,7 @@ static void pmaz_dma_init_read(struct NC
 static void pmaz_dma_init_write(struct NCR_ESP *esp, __u32 vaddress, int length)
 {
 	volatile int *dmareg = (volatile int *) ( esp->slot + DEC_SCSI_DMAREG );
+	volatile unsigned int *dummy = (volatile unsigned int *)KSEG1;
 
 	memcpy((void *) (esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE),
 			KSEG0ADDR((void *) vaddress), length);
@@ -506,6 +510,7 @@ static void pmaz_dma_init_write(struct N
 	*dmareg = TC_ESP_DMAR_WRITE | 
 		TC_ESP_DMA_ADDR(esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE);
 
+	*dummy;
 }
 
 static void pmaz_dma_ints_off(struct NCR_ESP *esp)
