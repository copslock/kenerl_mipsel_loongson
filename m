Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2014 12:01:25 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:58800 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817546AbaFDKBXA0SL9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Jun 2014 12:01:23 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1Ws80W-0006Na-00; Wed, 04 Jun 2014 12:01:20 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id A7F3B1D01A; Wed,  4 Jun 2014 12:00:37 +0200 (CEST)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] SGI-IP22/28: Improve GIO support
To:     linux-mips@linux-mips.org,
cc:     ralf@linux-mips.org
Message-Id: <20140604100037.A7F3B1D01A@solo.franken.de>
Date:   Wed,  4 Jun 2014 12:00:37 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
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

- added interrupt support for GIO devices
- improved detection of GIO cards on Indigo2
- added more known GIO cards

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/include/asm/gio_device.h |    4 ++--
 arch/mips/include/asm/sgi/ip22.h   |    2 ++
 arch/mips/sgi-ip22/ip22-gio.c      |   42 ++++++++++++++++++++++++------------
 arch/mips/sgi-ip22/ip22-int.c      |    7 +++++-
 4 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/gio_device.h b/arch/mips/include/asm/gio_device.h
index 0878701..4be1a57 100644
--- a/arch/mips/include/asm/gio_device.h
+++ b/arch/mips/include/asm/gio_device.h
@@ -50,7 +50,7 @@ static inline void gio_device_free(struct gio_device *dev)
 extern int gio_register_driver(struct gio_driver *);
 extern void gio_unregister_driver(struct gio_driver *);
 
-#define gio_get_drvdata(_dev)	     drv_get_drvdata(&(_dev)->dev)
-#define gio_set_drvdata(_dev, data)  drv_set_drvdata(&(_dev)->dev, (data))
+#define gio_get_drvdata(_dev)	     dev_get_drvdata(&(_dev)->dev)
+#define gio_set_drvdata(_dev, data)  dev_set_drvdata(&(_dev)->dev, (data))
 
 extern void gio_set_master(struct gio_device *);
diff --git a/arch/mips/include/asm/sgi/ip22.h b/arch/mips/include/asm/sgi/ip22.h
index 8db1a35..87ec9ea 100644
--- a/arch/mips/include/asm/sgi/ip22.h
+++ b/arch/mips/include/asm/sgi/ip22.h
@@ -69,6 +69,8 @@
 #define SGI_EISA_IRQ	SGINT_LOCAL2 + 3	/* EISA interrupts */
 #define SGI_KEYBD_IRQ	SGINT_LOCAL2 + 4	/* keyboard */
 #define SGI_SERIAL_IRQ	SGINT_LOCAL2 + 5	/* onboard serial */
+#define SGI_GIOEXP0_IRQ	(SGINT_LOCAL2 + 6)	/* Indy GIO EXP0 */
+#define SGI_GIOEXP1_IRQ	(SGINT_LOCAL2 + 7)	/* Indy GIO EXP1 */
 
 #define ip22_is_fullhouse()	(sgioc->sysid & SGIOC_SYSID_FULLHOUSE)
 
diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
index ab0e379..8e52446 100644
--- a/arch/mips/sgi-ip22/ip22-gio.c
+++ b/arch/mips/sgi-ip22/ip22-gio.c
@@ -19,6 +19,9 @@ static struct {
 } gio_name_table[] = {
 	{ .name = "SGI Impact", .id = 0x10 },
 	{ .name = "Phobos G160", .id = 0x35 },
+	{ .name = "Phobos G130", .id = 0x36 },
+	{ .name = "Phobos G100", .id = 0x37 },
+	{ .name = "Set Engineering GFE", .id = 0x38 },
 	/* fake IDs */
 	{ .name = "SGI Newport", .id = 0x7e },
 	{ .name = "SGI GR2/GR3", .id = 0x7f },
@@ -293,7 +296,16 @@ static int ip22_gio_id(unsigned long addr, u32 *res)
 		 * data matches
 		 */
 		ptr8 = (void *)CKSEG1ADDR(addr + 3);
-		get_dbe(tmp8, ptr8);
+		if (get_dbe(tmp8, ptr8)) {
+			/*
+			 * 32bit access worked, but 8bit doesn't
+			 * so we don't see phantom reads on
+			 * a pipelined bus, but a real card which
+			 * doesn't support 8 bit reads
+			 */
+			*res = tmp32;
+			return 1;
+		}
 		ptr16 = (void *)CKSEG1ADDR(addr + 2);
 		get_dbe(tmp16, ptr16);
 		if (tmp8 == (tmp16 & 0xff) &&
@@ -324,7 +336,7 @@ static int ip22_is_gr2(unsigned long addr)
 }
 
 
-static void ip22_check_gio(int slotno, unsigned long addr)
+static void ip22_check_gio(int slotno, unsigned long addr, int irq)
 {
 	const char *name = "Unknown";
 	struct gio_device *gio_dev;
@@ -338,9 +350,9 @@ static void ip22_check_gio(int slotno, unsigned long addr)
 	else {
 		if (!ip22_gio_id(addr, &tmp)) {
 			/*
-			 * no GIO signature at start address of slot, but
-			 * Newport doesn't have one, so let's check usea
-			 * status register
+			 * no GIO signature at start address of slot
+			 * since Newport doesn't have one, we check if
+			 * user status register is readable
 			 */
 			if (ip22_gio_id(addr + NEWPORT_USTATUS_OFFS, &tmp))
 				tmp = 0x7e;
@@ -369,6 +381,7 @@ static void ip22_check_gio(int slotno, unsigned long addr)
 		gio_dev->resource.start = addr;
 		gio_dev->resource.end = addr + 0x3fffff;
 		gio_dev->resource.flags = IORESOURCE_MEM;
+		gio_dev->irq = irq;
 		dev_set_name(&gio_dev->dev, "%d", slotno);
 		gio_device_register(gio_dev);
 	} else
@@ -408,16 +421,17 @@ int __init ip22_gio_init(void)
 		request_resource(&iomem_resource, &gio_bus_resource);
 		printk(KERN_INFO "GIO: Probing bus...\n");
 
-		if (ip22_is_fullhouse() ||
-		    !get_dbe(pbdma, (unsigned int *)&hpc3c1->pbdma[1])) {
-			/* Indigo2 and ChallengeS */
-			ip22_check_gio(0, GIO_SLOT_GFX_BASE);
-			ip22_check_gio(1, GIO_SLOT_EXP0_BASE);
+		if (ip22_is_fullhouse()) {
+			/* Indigo2 */
+			ip22_check_gio(0, GIO_SLOT_GFX_BASE, SGI_GIO_1_IRQ);
+			ip22_check_gio(1, GIO_SLOT_EXP0_BASE, SGI_GIO_1_IRQ);
 		} else {
-			/* Indy */
-			ip22_check_gio(0, GIO_SLOT_GFX_BASE);
-			ip22_check_gio(1, GIO_SLOT_EXP0_BASE);
-			ip22_check_gio(2, GIO_SLOT_EXP1_BASE);
+			/* Indy/Challenge S */
+			if (get_dbe(pbdma, (unsigned int *)&hpc3c1->pbdma[1]))
+				ip22_check_gio(0, GIO_SLOT_GFX_BASE,
+					       SGI_GIO_0_IRQ);
+			ip22_check_gio(1, GIO_SLOT_EXP0_BASE, SGI_GIOEXP0_IRQ);
+			ip22_check_gio(2, GIO_SLOT_EXP1_BASE, SGI_GIOEXP1_IRQ);
 		}
 	} else
 		device_unregister(&gio_bus);
diff --git a/arch/mips/sgi-ip22/ip22-int.c b/arch/mips/sgi-ip22/ip22-int.c
index 58b40ae..c66889f 100644
--- a/arch/mips/sgi-ip22/ip22-int.c
+++ b/arch/mips/sgi-ip22/ip22-int.c
@@ -119,9 +119,14 @@ static void indy_local0_irqdispatch(void)
 	} else
 		irq = lc0msk_to_irqnr[mask];
 
-	/* if irq == 0, then the interrupt has already been cleared */
+	/*
+	 * workaround for INT2 bug; if irq == 0, INT2 has seen a fifo full
+	 * irq, but failed to latch it into status register
+	 */
 	if (irq)
 		do_IRQ(irq);
+	else
+		do_IRQ(SGINT_LOCAL0 + 0);
 }
 
 static void indy_local1_irqdispatch(void)
