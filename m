Received:  by oss.sgi.com id <S553841AbRASIe7>;
	Fri, 19 Jan 2001 00:34:59 -0800
Received: from aeon.tvd.be ([195.162.196.20]:50043 "EHLO aeon.tvd.be")
	by oss.sgi.com with ESMTP id <S553739AbRASIen>;
	Fri, 19 Jan 2001 00:34:43 -0800
Received: from callisto.of.borg (cable-195-162-216-133.upc.chello.be [195.162.216.133])
	by aeon.tvd.be (8.9.3/8.9.3/RELAY-1.1) with ESMTP id JAA10259;
	Fri, 19 Jan 2001 09:34:35 +0100 (MET)
Received: from localhost (geert@localhost)
	by callisto.of.borg (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id JAA27405;
	Fri, 19 Jan 2001 09:33:42 +0100
X-Authentication-Warning: callisto.of.borg: geert owned process doing -bs
Date:   Fri, 19 Jan 2001 09:33:41 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linux/MIPS Development <linux-mips@oss.sgi.com>
cc:     Rasmus Andersen <rasmus@jaquet.dk>
Subject: [PATCH] make drivers/scsi/sgiwd93.c check some more return codes
 (240p3) (fwd)
Message-ID: <Pine.LNX.4.05.10101190933270.27117-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

---------- Forwarded message ----------
Date: Wed, 17 Jan 2001 23:26:53 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: andrewb@uab.edu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make drivers/scsi/sgiwd93.c check some more return codes
    (240p3)

Hi.

The following patch makes drivers/scsi/sgiwd93.c check the return code
from request_irq and get_free_pages. It also removes a line already done
a bit higher up (the dma_cache_wback_inv one).

Please comment.



--- linux-ac9/drivers/scsi/sgiwd93.c.org	Sun Jan 14 21:33:29 2001
+++ linux-ac9/drivers/scsi/sgiwd93.c	Sun Jan 14 22:57:46 2001
@@ -281,6 +281,11 @@
 	sgiwd93_host->irq = SGI_WD93_0_IRQ;
 
 	buf = (uchar *) get_free_page(GFP_KERNEL);
+	if (!buf) {
+		printk(KERN_WARNING "sgiwd93: Could not allocate memory for host0 buffer.\n");
+		scsi_unregister(sgiwd93_host);
+		return 0;
+	}
 	init_hpc_chain(buf);
 	dma_cache_wback_inv((unsigned long) buf, PAGE_SIZE);
 	/* HPC_SCSI_REG0 | 0x03 | KSEG1 */
@@ -290,9 +295,14 @@
 	hdata = (struct WD33C93_hostdata *)sgiwd93_host->hostdata;
 	hdata->no_sync = 0;
 	hdata->dma_bounce_buffer = (uchar *) (KSEG1ADDR(buf));
-	dma_cache_wback_inv((unsigned long) buf, PAGE_SIZE);
 
-	request_irq(SGI_WD93_0_IRQ, sgiwd93_intr, 0, "SGI WD93", (void *) sgiwd93_host);
+	if (request_irq(SGI_WD93_0_IRQ, sgiwd93_intr, 0, "SGI WD93", (void *) sgiwd93_host)) {
+		printk(KERN_WARNING "sgiwd93: Could not register IRQ %d (for host 0).\n", sgiwd93_intr);
+		wd33c93_release();
+		free_page(buf);
+		scsi_unregister(sgiwd93_host);
+		return 0;
+	}
         /* set up second controller on the Indigo2 */
 	if(!sgi_guiness) {
 		sgiwd93_host1 = scsi_register(SGIblows, sizeof(struct WD33C93_hostdata));
@@ -302,6 +312,12 @@
 			sgiwd93_host1->irq = SGI_WD93_1_IRQ;
 	
 			buf = (uchar *) get_free_page(GFP_KERNEL);
+			if (!buf) {
+				printk(KERN_WARNING "sgiwd93: Could not allocate memory for host1 buffer.\n");
+				scsi_unregister(sgiwd93_host1);
+				called = 1;
+				return 1; /* We registered host0 so return success*/
+			}
 			init_hpc_chain(buf);
 			dma_cache_wback_inv((unsigned long) buf, PAGE_SIZE);
 			/* HPC_SCSI_REG1 | 0x03 | KSEG1 */
@@ -313,7 +329,13 @@
 			hdata1->dma_bounce_buffer = (uchar *) (KSEG1ADDR(buf));
 			dma_cache_wback_inv((unsigned long) buf, PAGE_SIZE);
 	
-			request_irq(SGI_WD93_1_IRQ, sgiwd93_intr, 0, "SGI WD93", (void *) sgiwd93_host1);
+			if (request_irq(SGI_WD93_1_IRQ, sgiwd93_intr, 0, "SGI WD93", (void *) sgiwd93_host1)) {
+				printk(KERN_WARNING "sgiwd93: Could not allocate irq %d (for host1).\n", sgiwd93_intr);
+				wd33c93_release();
+				free_page(buf);
+				scsi_unregister(sgiwd93_host1);
+				/* Fall through since host0 registered OK */
+			}
 		}
 	}
 	

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Smoking kills. If you're killed, you've lost a very important part of your
life.  -Brooke Shields, during an interview to become spokesperson for a
federal anti-smoking campaign.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
