Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6IGcJRw002962
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Jul 2002 09:38:19 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6IGcJXG002961
	for linux-mips-outgoing; Thu, 18 Jul 2002 09:38:19 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6IGc6Rw002952
	for <linux-mips@oss.sgi.com>; Thu, 18 Jul 2002 09:38:07 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA19405;
	Thu, 18 Jul 2002 18:39:10 +0200 (MET DST)
Date: Thu, 18 Jul 2002 18:39:09 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
cc: linux-mips@oss.sgi.com
Subject: Re: DECStation: Support for PMAZ-AA TC SCSI card?
In-Reply-To: <200207181519.RAA18230@sparta.research.kpn.com>
Message-ID: <Pine.GSO.3.96.1020718173747.14993E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Karel,

> I have a 5000/200 running fine with the same kernel (the one without
> your patch). Or did you mean WITH your patch? The only problem

 If it works without the patch, it will also do with it.

> is that delo can't handle the different prom in the /200, so that
> system has to boot over the network, but can use the local disks just fine.

 OK, more writeback fixes.  Please get the following patches: 

- patch-mips-2.4.18-20020530-mb-wb-8.gz,

- patch-mips-2.4.18-20020625-wbflush-7.gz

from 'ftp://ftp.ds2.pg.gda.pl/pub/macro/linux/' and replace the hack I
sent you yesterday with the following real fix.  After applying the three
patches you need to rebuild the kernel from scratch, i.e. do `make
oldconfig dep clean boot modules' as the two above patches modify the
kernel's configuration.

 Please report if this works or not. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.19-rc1-20020717-dec_esp-test-1
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020717.macro/drivers/scsi/dec_esp.c linux-mips-2.4.19-rc1-20020717/drivers/scsi/dec_esp.c
--- linux-mips-2.4.19-rc1-20020717.macro/drivers/scsi/dec_esp.c	2002-04-10 02:58:49.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020717/drivers/scsi/dec_esp.c	2002-07-18 16:33:22.000000000 +0000
@@ -492,6 +492,8 @@ static void pmaz_dma_init_read(struct NC
 
 	*dmareg = TC_ESP_DMA_ADDR(esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE);
 
+	iob();
+
 	esp_virt_buffer = vaddress;
 	scsi_current_length = length;
 }
@@ -506,6 +508,7 @@ static void pmaz_dma_init_write(struct N
 	*dmareg = TC_ESP_DMAR_WRITE | 
 		TC_ESP_DMA_ADDR(esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE);
 
+	iob();
 }
 
 static void pmaz_dma_ints_off(struct NCR_ESP *esp)
