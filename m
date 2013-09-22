Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Sep 2013 22:58:56 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36667 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818702Ab3IVU6ud0hZQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Sep 2013 22:58:50 +0200
Date:   Sun, 22 Sep 2013 21:58:50 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [MIPS] DEC: whitespace cleanup
Message-ID: <alpine.LFD.2.03.1309151721020.2176@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Commit 7034228792cc561e79ff8600f02884bd4c80e287 [MIPS: Whitespace 
cleanup.] did a lot of good and a little damage.  Revert the damage.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

 Please apply (as obvious).

 Maciej

linux-dec-tab.patch
Index: linux/arch/mips/dec/int-handler.S
===================================================================
--- linux.orig/arch/mips/dec/int-handler.S
+++ linux/arch/mips/dec/int-handler.S
@@ -118,7 +118,7 @@
  *	       7	FPU/R4k timer
  *
  * We handle the IRQ according to _our_ priority (see setup.c),
- * then we just return.	 If multiple IRQs are pending then we will
+ * then we just return.  If multiple IRQs are pending then we will
  * just take another exception, big deal.
  */
 		.align	5
@@ -146,7 +146,7 @@
 		/*
 		 * Find irq with highest priority
 		 */
-		 PTR_LA t1,cpu_mask_nr_tbl
+		 PTR_LA	t1,cpu_mask_nr_tbl
 1:		lw	t2,(t1)
 		nop
 		and	t2,t0
@@ -195,7 +195,7 @@
 		/*
 		 * Find irq with highest priority
 		 */
-		 PTR_LA t1,asic_mask_nr_tbl
+		 PTR_LA	t1,asic_mask_nr_tbl
 2:		lw	t2,(t1)
 		nop
 		and	t2,t0
@@ -221,7 +221,7 @@
 		FEXPORT(cpu_all_int)		# HALT, timers, software junk
 		li	a0,DEC_CPU_IRQ_BASE
 		srl	t0,CAUSEB_IP
-		li	t1,CAUSEF_IP>>CAUSEB_IP # mask
+		li	t1,CAUSEF_IP>>CAUSEB_IP	# mask
 		b	1f
 		 li	t2,4			# nr of bits / 2
 
Index: linux/arch/mips/dec/prom/call_o32.S
===================================================================
--- linux.orig/arch/mips/dec/prom/call_o32.S
+++ linux/arch/mips/dec/prom/call_o32.S
@@ -14,7 +14,7 @@
 
 /* Maximum number of arguments supported.  Must be even!  */
 #define O32_ARGC	32
-/* Number of static registers we save.	*/
+/* Number of static registers we save.  */
 #define O32_STATC	11
 /* Frame size for both of the above.  */
 #define O32_FRAMESZ	(4 * O32_ARGC + SZREG * O32_STATC)
Index: linux/arch/mips/dec/prom/init.c
===================================================================
--- linux.orig/arch/mips/dec/prom/init.c
+++ linux/arch/mips/dec/prom/init.c
@@ -103,7 +103,7 @@ void __init prom_init(void)
 	if (prom_is_rex(magic))
 		rex_clear_cache();
 
-	/* Register the early console.	*/
+	/* Register the early console.  */
 	register_prom_console();
 
 	/* Were we compiled with the right CPU option? */
Index: linux/arch/mips/dec/prom/memory.c
===================================================================
--- linux.orig/arch/mips/dec/prom/memory.c
+++ linux/arch/mips/dec/prom/memory.c
@@ -22,7 +22,7 @@ volatile unsigned long mem_err;		/* So w
 
 /*
  * Probe memory in 4MB chunks, waiting for an error to tell us we've fallen
- * off the end of real memory.	Only suitable for the 2100/3100's (PMAX).
+ * off the end of real memory.  Only suitable for the 2100/3100's (PMAX).
  */
 
 #define CHUNK_SIZE 0x400000
Index: linux/arch/mips/dec/setup.c
===================================================================
--- linux.orig/arch/mips/dec/setup.c
+++ linux/arch/mips/dec/setup.c
@@ -65,7 +65,7 @@ EXPORT_SYMBOL(ioasic_base);
 /*
  * IRQ routing and priority tables.  Priorites are set as follows:
  *
- *		KN01	KN230	KN02	KN02-BA KN02-CA KN03
+ *		KN01	KN230	KN02	KN02-BA	KN02-CA	KN03
  *
  * MEMORY	CPU	CPU	CPU	ASIC	CPU	CPU
  * RTC		CPU	CPU	CPU	ASIC	CPU	CPU
@@ -413,7 +413,7 @@ static void __init dec_init_kn02(void)
 
 /*
  * Machine-specific initialisation for KN02-BA, aka DS5000/1xx
- * (xx = 20, 25, 33), aka 3min.	 Also applies to KN04(-BA), aka
+ * (xx = 20, 25, 33), aka 3min.  Also applies to KN04(-BA), aka
  * DS5000/150, aka 4min.
  */
 static int kn02ba_interrupt[DEC_NR_INTS] __initdata = {
Index: linux/arch/mips/include/asm/dec/ioasic_addrs.h
===================================================================
--- linux.orig/arch/mips/include/asm/dec/ioasic_addrs.h
+++ linux/arch/mips/include/asm/dec/ioasic_addrs.h
@@ -40,7 +40,7 @@
 #define IOASIC_FLOPPY	(11*IOASIC_SLOT_SIZE)	/* FDC (maxine) */
 #define IOASIC_SCSI	(12*IOASIC_SLOT_SIZE)	/* ASC SCSI */
 #define IOASIC_FDC_DMA	(13*IOASIC_SLOT_SIZE)	/* FDC DMA (maxine) */
-#define IOASIC_SCSI_DMA (14*IOASIC_SLOT_SIZE)	/* ??? */
+#define IOASIC_SCSI_DMA	(14*IOASIC_SLOT_SIZE)	/* ??? */
 #define IOASIC_RES_15	(15*IOASIC_SLOT_SIZE)	/* unused? */
 
 
Index: linux/arch/mips/include/asm/dec/kn01.h
===================================================================
--- linux.orig/arch/mips/include/asm/dec/kn01.h
+++ linux/arch/mips/include/asm/dec/kn01.h
@@ -57,12 +57,12 @@
 /*
  * System Control & Status Register bits.
  */
-#define KN01_CSR_MNFMOD		(1<<15) /* MNFMOD manufacturing jumper */
-#define KN01_CSR_STATUS		(1<<14) /* self-test result status output */
-#define KN01_CSR_PARDIS		(1<<13) /* parity error disable */
-#define KN01_CSR_CRSRTST	(1<<12) /* PCC test output */
-#define KN01_CSR_MONO		(1<<11) /* mono/color fb SIMM installed */
-#define KN01_CSR_MEMERR		(1<<10) /* write timeout error status & ack*/
+#define KN01_CSR_MNFMOD		(1<<15)	/* MNFMOD manufacturing jumper */
+#define KN01_CSR_STATUS		(1<<14)	/* self-test result status output */
+#define KN01_CSR_PARDIS		(1<<13)	/* parity error disable */
+#define KN01_CSR_CRSRTST	(1<<12)	/* PCC test output */
+#define KN01_CSR_MONO		(1<<11)	/* mono/color fb SIMM installed */
+#define KN01_CSR_MEMERR		(1<<10)	/* write timeout error status & ack*/
 #define KN01_CSR_VINT		(1<<9)	/* PCC area detect #2 status & ack */
 #define KN01_CSR_TXDIS		(1<<8)	/* DZ11 transmit disable */
 #define KN01_CSR_VBGTRG		(1<<2)	/* blue DAC voltage over green (r/o) */
Index: linux/arch/mips/include/asm/dec/kn02ca.h
===================================================================
--- linux.orig/arch/mips/include/asm/dec/kn02ca.h
+++ linux/arch/mips/include/asm/dec/kn02ca.h
@@ -68,7 +68,7 @@
 #define KN03CA_IO_SSR_ISDN_RST	(1<<12)		/* ~ISDN (Am79C30A) reset */
 
 #define KN03CA_IO_SSR_FLOPPY_RST (1<<7)		/* ~FDC (82077) reset */
-#define KN03CA_IO_SSR_VIDEO_RST (1<<6)		/* ~framebuffer reset */
+#define KN03CA_IO_SSR_VIDEO_RST	(1<<6)		/* ~framebuffer reset */
 #define KN03CA_IO_SSR_AB_RST	(1<<5)		/* ACCESS.bus reset */
 #define KN03CA_IO_SSR_RES_4	(1<<4)		/* unused */
 #define KN03CA_IO_SSR_RES_3	(1<<4)		/* unused */
Index: linux/arch/mips/include/asm/dec/prom.h
===================================================================
--- linux.orig/arch/mips/include/asm/dec/prom.h
+++ linux/arch/mips/include/asm/dec/prom.h
@@ -49,7 +49,7 @@
 
 #ifdef CONFIG_64BIT
 
-#define prom_is_rex(magic)	1	/* KN04 and KN05 are REX PROMs.	 */
+#define prom_is_rex(magic)	1	/* KN04 and KN05 are REX PROMs.  */
 
 #else /* !CONFIG_64BIT */
 
