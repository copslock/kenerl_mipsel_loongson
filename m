Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jan 2003 21:47:19 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:9158 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225280AbTATVrS>; Mon, 20 Jan 2003 21:47:18 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA12617
	for <linux-mips@linux-mips.org>; Mon, 20 Jan 2003 22:47:29 +0100 (MET)
Date: Mon, 20 Jan 2003 22:47:29 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-mips@linux-mips.org
Subject: [CFT] DECstation SCSI driver clean-ups
Message-ID: <Pine.GSO.3.96.1030120172610.4801E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 Testing of the dec_esp.c driver in a 64-bit environment (thanks, Karsten
and Thiemo) uncovered a few incorrect assumptions present in the code
leading to kernel crashes or misoperation.  I decided it's the right
moment to clean the driver up a bit.  Thus I rewrote iomem handling
consistently, adopted the unified I/O ASIC interface, added appropriate
SSR locking and fixed iomem coherency handling.  There are minor fixes
scattered through the code as well. 

 I'm going to commit the changes in a few days, but having no SCSI devices
attached to my DECstations, I cannot test the code at all.  I'd prefer to
avoid a non-working driver in the CVS, so I would appreciate if someone
with a suitable setup could test the new code.  A patch follows.

 The single PMAZ-A limitation of the driver still applies, but it should
be fairly easy to relax in the next step.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.20-20030112-dec_esp-ioasic-5
diff -up --recursive --new-file linux-mips-2.4.20-20030112.macro/arch/mips/dec/setup.c linux-mips-2.4.20-20030112/arch/mips/dec/setup.c
--- linux-mips-2.4.20-20030112.macro/arch/mips/dec/setup.c	2002-12-17 03:56:40.000000000 +0000
+++ linux-mips-2.4.20-20030112/arch/mips/dec/setup.c	2003-01-17 01:04:16.000000000 +0000
@@ -16,6 +16,7 @@
 #include <linux/console.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #include <asm/cpu.h>
@@ -46,6 +47,8 @@ extern void dec_intr_halt(int irq, void 
 
 extern asmlinkage void decstation_handle_int(void);
 
+spinlock_t ioasic_ssr_lock;
+
 volatile u32 *ioasic_base;
 unsigned long dec_kn_slot_size;
 
diff -up --recursive --new-file linux-mips-2.4.20-20030112.macro/drivers/net/declance.c linux-mips-2.4.20-20030112/drivers/net/declance.c
--- linux-mips-2.4.20-20030112.macro/drivers/net/declance.c	2002-07-25 02:58:09.000000000 +0000
+++ linux-mips-2.4.20-20030112/drivers/net/declance.c	2003-01-17 01:10:59.000000000 +0000
@@ -52,6 +52,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 
@@ -787,15 +788,23 @@ static int lance_open(struct net_device 
 		return -EAGAIN;
 	}
 	if (lp->dma_irq >= 0) {
+		unsigned long flags;
+
 		if (request_irq(lp->dma_irq, &lance_dma_merr_int, 0,
 				"lance error", dev)) {
 			free_irq(dev->irq, dev);
 			printk("lance: Can't get DMA IRQ %d\n", lp->dma_irq);
 			return -EAGAIN;
 		}
+
+		spin_lock_irqsave(&ioasic_ssr_lock, flags);
+
+		fast_mb();
 		/* Enable I/O ASIC LANCE DMA.  */
-		fast_wmb();
 		ioasic_write(SSR, ioasic_read(SSR) | LANCE_DMA_EN);
+
+		fast_mb();
+		spin_unlock_irqrestore(&ioasic_ssr_lock, flags);
 	}
 
 	status = init_restart_lance(lp);
@@ -821,9 +830,17 @@ static int lance_close(struct net_device
 	writereg(&ll->rdp, LE_C0_STOP);
 
 	if (lp->dma_irq >= 0) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&ioasic_ssr_lock, flags);
+
+		fast_mb();
 		/* Disable I/O ASIC LANCE DMA.  */
 		ioasic_write(SSR, ioasic_read(SSR) & ~LANCE_DMA_EN);
+
 		fast_iob();
+		spin_unlock_irqrestore(&ioasic_ssr_lock, flags);
+
 		free_irq(lp->dma_irq, dev);
 	}
 	free_irq(dev->irq, dev);
diff -up --recursive --new-file linux-mips-2.4.20-20030112.macro/drivers/scsi/dec_esp.c linux-mips-2.4.20-20030112/drivers/scsi/dec_esp.c
--- linux-mips-2.4.20-20030112.macro/drivers/scsi/dec_esp.c	2002-12-04 03:57:01.000000000 +0000
+++ linux-mips-2.4.20-20030112/drivers/scsi/dec_esp.c	2003-01-17 16:04:20.000000000 +0000
@@ -17,6 +17,8 @@
  *            data.
  * 20001005	- Initialization fixes for 2.4.0-test9
  * 			  Florian Lohoff <flo@rfc822.org>
+ *
+ *	Copyright (C) 2002, 2003  Maciej W. Rozycki
  */
 
 #include <linux/kernel.h>
@@ -26,54 +28,48 @@
 #include <linux/slab.h>
 #include <linux/blk.h>
 #include <linux/proc_fs.h>
+#include <linux/spinlock.h>
 #include <linux/stat.h>
 
-#include "scsi.h"
-#include "hosts.h"
-#include "NCR53C9x.h"
-#include "dec_esp.h"
-
-#include <asm/irq.h>
 #include <asm/dma.h>
-
+#include <asm/irq.h>
 #include <asm/pgtable.h>
+#include <asm/system.h>
 
-#include <asm/dec/tc.h>
 #include <asm/dec/interrupts.h>
+#include <asm/dec/ioasic.h>
 #include <asm/dec/ioasic_addrs.h>
 #include <asm/dec/ioasic_ints.h>
 #include <asm/dec/machtype.h>
+#include <asm/dec/tc.h>
+
+#include "scsi.h"
+#include "hosts.h"
+#include "NCR53C9x.h"
+#include "dec_esp.h"
 
-#include <asm/system.h>
 
-/*
- * Once upon a time the pmaz code used to be working but
- * it hasn't been maintained for quite some time.
- * It isn't working anymore but I'll leave here as a
- * starting point. #define this an be prepared for tons
- * of warnings and errors :)
- */
 static int  dma_bytes_sent(struct NCR_ESP *esp, int fifo_count);
 static void dma_drain(struct NCR_ESP *esp);
 static int  dma_can_transfer(struct NCR_ESP *esp, Scsi_Cmnd * sp);
 static void dma_dump_state(struct NCR_ESP *esp);
-static void dma_init_read(struct NCR_ESP *esp, __u32 vaddress, int length);
-static void dma_init_write(struct NCR_ESP *esp, __u32 vaddress, int length);
+static void dma_init_read(struct NCR_ESP *esp, u32 vaddress, int length);
+static void dma_init_write(struct NCR_ESP *esp, u32 vaddress, int length);
 static void dma_ints_off(struct NCR_ESP *esp);
 static void dma_ints_on(struct NCR_ESP *esp);
 static int  dma_irq_p(struct NCR_ESP *esp);
 static int  dma_ports_p(struct NCR_ESP *esp);
-static void dma_setup(struct NCR_ESP *esp, __u32 addr, int count, int write);
+static void dma_setup(struct NCR_ESP *esp, u32 addr, int count, int write);
 static void dma_mmu_get_scsi_one(struct NCR_ESP *esp, Scsi_Cmnd * sp);
 static void dma_mmu_get_scsi_sgl(struct NCR_ESP *esp, Scsi_Cmnd * sp);
 static void dma_advance_sg(Scsi_Cmnd * sp);
 
 static void pmaz_dma_drain(struct NCR_ESP *esp);
-static void pmaz_dma_init_read(struct NCR_ESP *esp, __u32 vaddress, int length);
-static void pmaz_dma_init_write(struct NCR_ESP *esp, __u32 vaddress, int length);
+static void pmaz_dma_init_read(struct NCR_ESP *esp, u32 vaddress, int length);
+static void pmaz_dma_init_write(struct NCR_ESP *esp, u32 vaddress, int length);
 static void pmaz_dma_ints_off(struct NCR_ESP *esp);
 static void pmaz_dma_ints_on(struct NCR_ESP *esp);
-static void pmaz_dma_setup(struct NCR_ESP *esp, __u32 addr, int count, int write);
+static void pmaz_dma_setup(struct NCR_ESP *esp, u32 addr, int count, int write);
 static void pmaz_dma_mmu_get_scsi_one(struct NCR_ESP *esp, Scsi_Cmnd * sp);
 
 #define TC_ESP_RAM_SIZE 0x20000
@@ -84,7 +80,7 @@ static void pmaz_dma_mmu_get_scsi_one(st
 #define TC_ESP_DMAR_WRITE 0x80000000
 #define TC_ESP_DMA_ADDR(x) ((unsigned)(x) & TC_ESP_DMAR_MASK)
 
-__u32 esp_virt_buffer;
+u32 esp_virt_buffer;
 int scsi_current_length;
 
 volatile unsigned char cmd_buffer[16];
@@ -94,13 +90,6 @@ volatile unsigned char pmaz_cmd_buffer[1
 				 * via PIO.
 				 */
 
-volatile unsigned long *scsi_dma_ptr;
-volatile unsigned long *scsi_next_ptr;
-volatile unsigned long *scsi_scr;
-volatile unsigned long *ioasic_ssr;
-volatile unsigned long *scsi_sdr0;
-volatile unsigned long *scsi_sdr1;
-
 static void scsi_dma_merr_int(int, void *, struct pt_regs *);
 static void scsi_dma_err_int(int, void *, struct pt_regs *);
 static void scsi_dma_int(int, void *, struct pt_regs *);
@@ -121,13 +110,6 @@ int dec_esp_detect(Scsi_Host_Template * 
 		esp_dev = 0;
 		esp = esp_allocate(tpnt, (void *) esp_dev);
 
-		scsi_dma_ptr = (unsigned long *) (system_base + IOCTL + SCSI_DMA_P);
-		scsi_next_ptr = (unsigned long *) (system_base + IOCTL + SCSI_DMA_BP);
-		scsi_scr = (unsigned long *) (system_base + IOCTL + SCSI_SCR);
-		ioasic_ssr = (unsigned long *) (system_base + IOCTL + SSR);
-		scsi_sdr0 = (unsigned long *) (system_base + IOCTL + SCSI_SDR0);
-		scsi_sdr1 = (unsigned long *) (system_base + IOCTL + SCSI_SDR1);
-
 		/* Do command transfer with programmed I/O */
 		esp->do_pio_cmds = 1;
 
@@ -174,7 +156,7 @@ int dec_esp_detect(Scsi_Host_Template * 
 		esp->esp_command = (volatile unsigned char *) cmd_buffer;
 
 		/* get virtual dma address for command buffer */
-		esp->esp_command_dvma = (__u32) KSEG1ADDR((volatile unsigned char *) cmd_buffer);
+		esp->esp_command_dvma = virt_to_phys(cmd_buffer);
 
 		esp->irq = dec_interrupt[DEC_IRQ_ASC];
 
@@ -213,7 +195,7 @@ int dec_esp_detect(Scsi_Host_Template * 
 			mem_start = get_tc_base_addr(slot);
 
 			/* Store base addr into esp struct */
-			esp->slot = mem_start;
+			esp->slot = PHYSADDR(mem_start);
 
 			esp->dregs = 0;
 			esp->eregs = (struct ESP_regs *) (mem_start + DEC_SCSI_SREG);
@@ -223,7 +205,7 @@ int dec_esp_detect(Scsi_Host_Template * 
 			esp->esp_command = (volatile unsigned char *) pmaz_cmd_buffer;
 
 			/* get virtual dma address for command buffer */
-			esp->esp_command_dvma = (__u32) KSEG0ADDR((volatile unsigned char *) pmaz_cmd_buffer);
+			esp->esp_command_dvma = virt_to_phys(pmaz_cmd_buffer);
 
 			esp->cfreq = get_tc_speed();
 
@@ -303,40 +285,53 @@ static void scsi_dma_err_int(int irq, vo
 
 static void scsi_dma_int(int irq, void *dev_id, struct pt_regs *regs)
 {
+	u32 scsi_next_ptr;
+
+	scsi_next_ptr = ioasic_read(SCSI_DMA_P);
+
 	/* next page */
-	*scsi_next_ptr = ((*scsi_dma_ptr + PAGE_SIZE) & PAGE_MASK) << 3;
+	scsi_next_ptr = (((scsi_next_ptr >> 3) + PAGE_SIZE) & PAGE_MASK) << 3;
+	ioasic_write(SCSI_DMA_BP, scsi_next_ptr);
 	fast_iob();
 }
 
 static int dma_bytes_sent(struct NCR_ESP *esp, int fifo_count)
 {
-    return fifo_count;
+	return fifo_count;
 }
 
 static void dma_drain(struct NCR_ESP *esp)
 {
-	unsigned long nw = *scsi_scr;
-	unsigned short *p = (unsigned short *)KSEG1ADDR((*scsi_dma_ptr) >> 3);
+	u32 nw, data0, data1, scsi_data_ptr;
+	u16 *p;
+
+	nw = ioasic_read(SCSI_SCR);
 
-    /*
+	/*
 	 * Is there something in the dma buffers left?
-     */
+	 */
 	if (nw) {
+		scsi_data_ptr = ioasic_read(SCSI_DMA_P) >> 3;
+		p = phys_to_virt(scsi_data_ptr);
 		switch (nw) {
 		case 1:
-			*p = (unsigned short) *scsi_sdr0;
+			data0 = ioasic_read(SCSI_SDR0);
+			p[0] = data0 & 0xffff;
 			break;
 		case 2:
-			*p++ = (unsigned short) (*scsi_sdr0);
-			*p = (unsigned short) ((*scsi_sdr0) >> 16);
+			data0 = ioasic_read(SCSI_SDR0);
+			p[0] = data0 & 0xffff;
+			p[1] = (data0 >> 16) & 0xffff;
 			break;
 		case 3:
-			*p++ = (unsigned short) (*scsi_sdr0);
-			*p++ = (unsigned short) ((*scsi_sdr0) >> 16);
-			*p = (unsigned short) (*scsi_sdr1);
+			data0 = ioasic_read(SCSI_SDR0);
+			data1 = ioasic_read(SCSI_SDR1);
+			p[0] = data0 & 0xffff;
+			p[1] = (data0 >> 16) & 0xffff;
+			p[2] = data1 & 0xffff;
 			break;
 		default:
-			printk("Strange: %d words in dma buffer left\n", (int) nw);
+			printk("Strange: %d words in dma buffer left\n", nw);
 			break;
 		}
 	}
@@ -351,38 +346,72 @@ static void dma_dump_state(struct NCR_ES
 {
 }
 
-static void dma_init_read(struct NCR_ESP *esp, __u32 vaddress, int length)
+static void dma_init_read(struct NCR_ESP *esp, u32 vaddress, int length)
 {
+	u32 scsi_next_ptr, ioasic_ssr;
+	unsigned long flags;
+
 	if (vaddress & 3)
 		panic("dec_esp.c: unable to handle partial word transfers, yet...");
 
 	dma_cache_wback_inv((unsigned long) phys_to_virt(vaddress), length);
 
-	*ioasic_ssr &= ~SCSI_DMA_EN;
-	*scsi_scr = 0;
-	*scsi_dma_ptr = vaddress << 3;
+	spin_lock_irqsave(&ioasic_ssr_lock, flags);
+
+	fast_mb();
+	ioasic_ssr = ioasic_read(SSR);
+
+	ioasic_ssr &= ~SCSI_DMA_EN;
+	ioasic_write(SSR, ioasic_ssr);
+
+	fast_wmb();
+	ioasic_write(SCSI_SCR, 0);
+	ioasic_write(SCSI_DMA_P, vaddress << 3);
 
 	/* prepare for next page */
-	*scsi_next_ptr = ((vaddress + PAGE_SIZE) & PAGE_MASK) << 3;
-	*ioasic_ssr |= (SCSI_DMA_DIR | SCSI_DMA_EN);
+	scsi_next_ptr = ((vaddress + PAGE_SIZE) & PAGE_MASK) << 3;
+	ioasic_write(SCSI_DMA_BP, scsi_next_ptr);
+
+	ioasic_ssr |= (SCSI_DMA_DIR | SCSI_DMA_EN);
+	fast_wmb();
+	ioasic_write(SSR, ioasic_ssr);
+
 	fast_iob();
+	spin_unlock_irqrestore(&ioasic_ssr_lock, flags);
 }
 
-static void dma_init_write(struct NCR_ESP *esp, __u32 vaddress, int length)
+static void dma_init_write(struct NCR_ESP *esp, u32 vaddress, int length)
 {
+	u32 scsi_next_ptr, ioasic_ssr;
+	unsigned long flags;
+
 	if (vaddress & 3)
 		panic("dec_esp.c: unable to handle partial word transfers, yet...");
 
 	dma_cache_wback_inv((unsigned long) phys_to_virt(vaddress), length);
 
-	*ioasic_ssr &= ~(SCSI_DMA_DIR | SCSI_DMA_EN);
-	*scsi_scr = 0;
-	*scsi_dma_ptr = vaddress << 3;
+	spin_lock_irqsave(&ioasic_ssr_lock, flags);
+
+	fast_mb();
+	ioasic_ssr = ioasic_read(SSR);
+
+	ioasic_ssr &= ~(SCSI_DMA_DIR | SCSI_DMA_EN);
+	ioasic_write(SSR, ioasic_ssr);
+
+	fast_wmb();
+	ioasic_write(SCSI_SCR, 0);
+	ioasic_write(SCSI_DMA_P, vaddress << 3);
 
 	/* prepare for next page */
-	*scsi_next_ptr = ((vaddress + PAGE_SIZE) & PAGE_MASK) << 3;
-	*ioasic_ssr |= SCSI_DMA_EN;
+	scsi_next_ptr = ((vaddress + PAGE_SIZE) & PAGE_MASK) << 3;
+	ioasic_write(SCSI_DMA_BP, scsi_next_ptr);
+
+	ioasic_ssr |= SCSI_DMA_EN;
+	fast_wmb();
+	ioasic_write(SSR, ioasic_ssr);
+
 	fast_iob();
+	spin_unlock_irqrestore(&ioasic_ssr_lock, flags);
 }
 
 static void dma_ints_off(struct NCR_ESP *esp)
@@ -397,36 +426,32 @@ static void dma_ints_on(struct NCR_ESP *
 
 static int dma_irq_p(struct NCR_ESP *esp)
 {
-    return (esp->eregs->esp_status & ESP_STAT_INTR);
+	return (esp->eregs->esp_status & ESP_STAT_INTR);
 }
 
 static int dma_ports_p(struct NCR_ESP *esp)
 {
-/*
- * FIXME: what's this good for?
- */
+	/*
+	 * FIXME: what's this good for?
+	 */
 	return 1;
 }
 
-static void dma_setup(struct NCR_ESP *esp, __u32 addr, int count, int write)
+static void dma_setup(struct NCR_ESP *esp, u32 addr, int count, int write)
 {
-    /*
-     * On the Sparc, DMA_ST_WRITE means "move data from device to memory"
-     * so when (write) is true, it actually means READ!
-     */
-	if (write) {
-	dma_init_read(esp, addr, count);
-    } else {
-	dma_init_write(esp, addr, count);
-    }
+	/*
+	 * DMA_ST_WRITE means "move data from device to memory"
+	 * so when (write) is true, it actually means READ!
+	 */
+	if (write)
+		dma_init_read(esp, addr, count);
+	else
+		dma_init_write(esp, addr, count);
 }
 
-/*
- * These aren't used yet
- */
 static void dma_mmu_get_scsi_one(struct NCR_ESP *esp, Scsi_Cmnd * sp)
 {
-	sp->SCp.ptr = (char *)PHYSADDR(sp->SCp.buffer);
+	sp->SCp.ptr = (char *)virt_to_phys(sp->request_buffer);
 }
 
 static void dma_mmu_get_scsi_sgl(struct NCR_ESP *esp, Scsi_Cmnd * sp)
@@ -435,32 +460,33 @@ static void dma_mmu_get_scsi_sgl(struct 
 	struct scatterlist *sg = sp->SCp.buffer;
 
 	while (sz >= 0) {
-		sg[sz].dma_address = PHYSADDR(sg[sz].address);
+		sg[sz].dma_address = virt_to_phys(sg[sz].address);
 		sz--;
 	}
-	sp->SCp.ptr = (char *) ((unsigned long) sp->SCp.buffer->dma_address);
+	sp->SCp.ptr = (char *)(sp->SCp.buffer->dma_address);
 }
 
 static void dma_advance_sg(Scsi_Cmnd * sp)
 {
-	sp->SCp.ptr = (char *) ((unsigned long) sp->SCp.buffer->dma_address);
+	sp->SCp.ptr = (char *)(sp->SCp.buffer->dma_address);
 }
 
 static void pmaz_dma_drain(struct NCR_ESP *esp)
 {
-	memcpy((void *) (KSEG0ADDR(esp_virt_buffer)),
-		(void *) ( esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE),
+	memcpy(phys_to_virt(esp_virt_buffer),
+		(void *)KSEG1ADDR(esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE),
 		scsi_current_length);
 }
 
-static void pmaz_dma_init_read(struct NCR_ESP *esp, __u32 vaddress, int length)
+static void pmaz_dma_init_read(struct NCR_ESP *esp, u32 vaddress, int length)
 {
-	volatile int *dmareg = (volatile int *) (esp->slot + DEC_SCSI_DMAREG);
+	volatile u32 *dmareg =
+		(volatile u32 *)KSEG1ADDR(esp->slot + DEC_SCSI_DMAREG);
 
 	if (length > ESP_TGT_DMA_SIZE)
 		length = ESP_TGT_DMA_SIZE;
 
-	*dmareg = TC_ESP_DMA_ADDR(esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE);
+	*dmareg = TC_ESP_DMA_ADDR(ESP_TGT_DMA_SIZE);
 
 	iob();
 
@@ -468,15 +494,16 @@ static void pmaz_dma_init_read(struct NC
 	scsi_current_length = length;
 }
 
-static void pmaz_dma_init_write(struct NCR_ESP *esp, __u32 vaddress, int length)
+static void pmaz_dma_init_write(struct NCR_ESP *esp, u32 vaddress, int length)
 {
-	volatile int *dmareg = (volatile int *) ( esp->slot + DEC_SCSI_DMAREG );
+	volatile u32 *dmareg =
+		(volatile u32 *)KSEG1ADDR(esp->slot + DEC_SCSI_DMAREG);
 
-	memcpy((void *)(esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE),
-	       (void *)KSEG0ADDR(vaddress), length);
+	memcpy((void *)KSEG1ADDR(esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE),
+	       phys_to_virt(vaddress), length);
 
-	*dmareg = TC_ESP_DMAR_WRITE |
-		TC_ESP_DMA_ADDR(esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE);
+	wmb();
+	*dmareg = TC_ESP_DMAR_WRITE | TC_ESP_DMA_ADDR(ESP_TGT_DMA_SIZE);
 
 	iob();
 }
@@ -489,20 +516,19 @@ static void pmaz_dma_ints_on(struct NCR_
 {
 }
 
-static void pmaz_dma_setup(struct NCR_ESP *esp, __u32 addr, int count, int write)
+static void pmaz_dma_setup(struct NCR_ESP *esp, u32 addr, int count, int write)
 {
 	/*
-	 * On the Sparc, DMA_ST_WRITE means "move data from device to memory"
+	 * DMA_ST_WRITE means "move data from device to memory"
 	 * so when (write) is true, it actually means READ!
 	 */
-	if (write) {
+	if (write)
 		pmaz_dma_init_read(esp, addr, count);
-	} else {
+	else
 		pmaz_dma_init_write(esp, addr, count);
-	}
 }
 
 static void pmaz_dma_mmu_get_scsi_one(struct NCR_ESP *esp, Scsi_Cmnd * sp)
 {
-	sp->SCp.ptr = (char *)KSEG0ADDR((sp->request_buffer));
+	sp->SCp.ptr = (char *)virt_to_phys(sp->request_buffer);
 }
diff -up --recursive --new-file linux-mips-2.4.20-20030112.macro/include/asm-mips/dec/ioasic.h linux-mips-2.4.20-20030112/include/asm-mips/dec/ioasic.h
--- linux-mips-2.4.20-20030112.macro/include/asm-mips/dec/ioasic.h	2003-01-16 01:13:18.000000000 +0000
+++ linux-mips-2.4.20-20030112/include/asm-mips/dec/ioasic.h	2003-01-17 00:59:53.000000000 +0000
@@ -3,7 +3,7 @@
  *
  *	DEC I/O ASIC access operations.
  *
- *	Copyright (C) 2000, 2002  Maciej W. Rozycki
+ *	Copyright (C) 2000, 2002, 2003  Maciej W. Rozycki
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -14,8 +14,11 @@
 #ifndef __ASM_DEC_IOASIC_H
 #define __ASM_DEC_IOASIC_H
 
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
+extern spinlock_t ioasic_ssr_lock;
+
 extern volatile u32 *ioasic_base;
 
 static inline void ioasic_write(unsigned int reg, u32 v)
diff -up --recursive --new-file linux-mips-2.4.20-20030112.macro/include/asm-mips64/dec/ioasic.h linux-mips-2.4.20-20030112/include/asm-mips64/dec/ioasic.h
--- linux-mips-2.4.20-20030112.macro/include/asm-mips64/dec/ioasic.h	2002-05-14 02:57:37.000000000 +0000
+++ linux-mips-2.4.20-20030112/include/asm-mips64/dec/ioasic.h	2003-01-17 00:59:53.000000000 +0000
@@ -3,7 +3,7 @@
  *
  *	DEC I/O ASIC access operations.
  *
- *	Copyright (C) 2000, 2002  Maciej W. Rozycki
+ *	Copyright (C) 2000, 2002, 2003  Maciej W. Rozycki
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -14,8 +14,11 @@
 #ifndef __ASM_DEC_IOASIC_H
 #define __ASM_DEC_IOASIC_H
 
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
+extern spinlock_t ioasic_ssr_lock;
+
 extern volatile u32 *ioasic_base;
 
 static inline void ioasic_write(unsigned int reg, u32 v)
