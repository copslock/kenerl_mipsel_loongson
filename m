Received:  by oss.sgi.com id <S553785AbRASIdJ>;
	Fri, 19 Jan 2001 00:33:09 -0800
Received: from hood.tvd.be ([195.162.196.21]:58219 "EHLO hood.tvd.be")
	by oss.sgi.com with ESMTP id <S553722AbRASIcv>;
	Fri, 19 Jan 2001 00:32:51 -0800
Received: from callisto.of.borg (cable-195-162-216-133.upc.chello.be [195.162.216.133])
	by hood.tvd.be (8.9.3/8.9.3/RELAY-1.1) with ESMTP id JAA08260;
	Fri, 19 Jan 2001 09:32:47 +0100 (MET)
Received: from localhost (geert@localhost)
	by callisto.of.borg (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id JAA27368;
	Fri, 19 Jan 2001 09:31:54 +0100
X-Authentication-Warning: callisto.of.borg: geert owned process doing -bs
Date:   Fri, 19 Jan 2001 09:31:54 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linux/MIPS Development <linux-mips@oss.sgi.com>
cc:     Rasmus Andersen <rasmus@jaquet.dk>
Subject: [PATCH] make drivers/scsi/dec_esp.c check request_irq return code
 (240p3) (fwd)
Message-ID: <Pine.LNX.4.05.10101190931310.27117-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

---------- Forwarded message ----------
Date: Wed, 17 Jan 2001 23:18:52 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] make drivers/scsi/dec_esp.c check request_irq return code
    (240p3)

Hi.

(I have not been able to find a maintainer for this code.)

This patch makes drivers/scsi/dec_esp.c check the return code of
request_irq. It applies cleanly against 240p3 and ac9.

In the search_tc_slot loop I made it continue the search on failure
for one slot. Would this be correct?

Please comment.


--- linux-ac9/drivers/scsi/dec_esp.c.org	Sun Jan 14 20:03:50 2001
+++ linux-ac9/drivers/scsi/dec_esp.c	Wed Jan 17 22:52:52 2001
@@ -87,7 +87,7 @@
 unsigned char scsi_pmaz_dma_buff_used[ESP_NCMD];
 unsigned char scsi_cur_buff = 1;	/* Leave space for command buffer */
 __u32 esp_virt_buffer;
-int scsi_current_length = 0;
+int scsi_current_length;
 
 volatile unsigned char cmd_buffer[16];
 volatile unsigned char pmaz_cmd_buffer[16];
@@ -181,10 +181,13 @@
 		esp->esp_command_dvma = (__u32) KSEG1ADDR((volatile unsigned char *) cmd_buffer);
 	
 		esp->irq = SCSI_INT;
-	request_irq(esp->irq, esp_intr, SA_INTERRUPT, "NCR 53C94 SCSI",
-	            NULL);
-		request_irq(SCSI_DMA_INT, scsi_dma_int, SA_INTERRUPT, "JUNKIO SCSI DMA",
-			    NULL);
+		if (request_irq(esp->irq, esp_intr, SA_INTERRUPT, 
+				"NCR 53C94 SCSI", NULL))
+			goto err_dealloc;
+		if (request_irq(SCSI_DMA_INT, scsi_dma_int, SA_INTERRUPT, 
+				"JUNKIO SCSI DMA", NULL))
+			goto err_free_irq;
+			
 
 	esp->scsi_id = 7;
 		
@@ -257,7 +260,12 @@
 			esp->dma_mmu_release_scsi_sgl = 0;
 			esp->dma_advance_sg = 0;
 
-			request_irq(esp->irq, esp_intr, SA_INTERRUPT, "PMAZ_AA", NULL);
+			if (request_irq(esp->irq, esp_intr, SA_INTERRUPT, 
+					 "PMAZ_AA", NULL)) {
+				esp_deallocate(esp);
+				release_tc_card(slot);
+				continue;
+			}
 			esp->scsi_id = 7;
 			esp->diff = 0;
 			esp_initialize(esp);
@@ -267,10 +275,16 @@
 
 	if(nesps) {
 		printk("ESP: Total of %d ESP hosts found, %d actually in use.\n", nesps, esps_in_use);
-	esps_running = esps_in_use;
-	return esps_in_use;
-	} else
-    return 0;
+		esps_running = esps_in_use;
+		return esps_in_use;
+	}
+	return 0;
+
+ err_free_irq:
+	free_irq(esp->irq, esp_intr);
+ err_dealloc:
+	esp_deallocate(esp);
+	return 0;
 }
 
 /************************************************************* DMA Functions */
@@ -524,4 +538,4 @@
 	    (char *) KSEG0ADDR((sp->request_buffer));
 }
 
-#endif
\ No newline at end of file
+#endif

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

``When the president does it, that means that it is not illegal.''
             --Richard M. Nixon, TV interview with David Frost, 1977 May 4
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
