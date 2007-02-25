Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Feb 2007 14:36:05 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:30878 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038992AbXBYOgE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Feb 2007 14:36:04 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1PEZxK5014511
	for <linux-mips@linux-mips.org>; Sun, 25 Feb 2007 14:35:59 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1PEZwtG014510
	for linux-mips@linux-mips.org; Sun, 25 Feb 2007 14:35:58 GMT
Date:	Sun, 25 Feb 2007 14:35:58 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Testing needed: Support for 2nd ethernet port of Challenge S
Message-ID: <20070225143558.GA14175@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Below patch adds support to the second ethernet port of the Challenge S.
It basically is a forward port of what already exists on the linux-2.4
branch as commit 5eb7a832f4777aa1f994f32da59f58bfc49d39a6 since September
2005 but I'd prefer if somebody would give it some testing before I
send this one upstream.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/net/sgiseeq.c b/drivers/net/sgiseeq.c
index a833e7f..0a82b4c 100644
--- a/drivers/net/sgiseeq.c
+++ b/drivers/net/sgiseeq.c
@@ -27,8 +27,10 @@
 #include <asm/byteorder.h>
 #include <asm/io.h>
 #include <asm/system.h>
+#include <asm/paccess.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <asm/sgi/mc.h>
 #include <asm/sgi/hpc3.h>
 #include <asm/sgi/ip22.h>
 #include <asm/sgialib.h>
@@ -636,7 +638,7 @@ static inline void setup_rx_ring(struct sgiseeq_rx_desc *buf, int nbufs)
 
 #define ALIGNED(x)  ((((unsigned long)(x)) + 0xf) & ~(0xf))
 
-static int sgiseeq_init(struct hpc3_regs* hpcregs, int irq)
+static int sgiseeq_init(struct hpc3_regs* hpcregs, int irq, int has_eeprom)
 {
 	struct sgiseeq_init_block *sr;
 	struct sgiseeq_private *sp;
@@ -662,7 +664,9 @@ static int sgiseeq_init(struct hpc3_regs* hpcregs, int irq)
 
 #define EADDR_NVOFS     250
 	for (i = 0; i < 3; i++) {
-		unsigned short tmp = ip22_nvram_read(EADDR_NVOFS / 2 + i);
+		unsigned short tmp = has_eeprom ?
+			ip22_eeprom_read(&hpcregs->eeprom, EADDR_NVOFS / 2+i) :
+			ip22_nvram_read(EADDR_NVOFS / 2+i);
 
 		dev->dev_addr[2 * i]     = tmp >> 8;
 		dev->dev_addr[2 * i + 1] = tmp & 0xff;
@@ -695,6 +699,11 @@ static int sgiseeq_init(struct hpc3_regs* hpcregs, int irq)
 	sp->hregs->dconfig = HPC3_EDCFG_FIRQ | HPC3_EDCFG_FEOP |
 			     HPC3_EDCFG_FRXDC | HPC3_EDCFG_PTO | 0x026;
 
+	/* Setup PIO and DMA transfer timing */
+	sp->hregs->pconfig = 0x161;
+	sp->hregs->dconfig = HPC3_EDCFG_FIRQ | HPC3_EDCFG_FEOP |
+			     HPC3_EDCFG_FRXDC | HPC3_EDCFG_PTO | 0x026;
+
 	/* Reset the chip. */
 	hpc3_eth_reset(sp->hregs);
 
@@ -741,8 +750,23 @@ err_out:
 
 static int __init sgiseeq_probe(void)
 {
+	unsigned int tmp, ret1, ret2 = 0;
+
 	/* On board adapter on 1st HPC is always present */
-	return sgiseeq_init(hpc3c0, SGI_ENET_IRQ);
+	ret1 = sgiseeq_init(hpc3c0, SGI_ENET_IRQ, 0);
+	/* Let's see if second HPC is there */
+	if (!(ip22_is_fullhouse()) &&
+	    get_dbe(tmp, (unsigned int *)&hpc3c1->pbdma[1]) == 0) {
+		sgimc->giopar |= SGIMC_GIOPAR_MASTEREXP1 |
+				 SGIMC_GIOPAR_EXP164 |
+				 SGIMC_GIOPAR_HPC264;
+		hpc3c1->pbus_piocfg[0][0] = 0x3ffff;
+		/* interrupt/config register on Challenge S Mezz board */
+		hpc3c1->pbus_extregs[0][0] = 0x30;
+		ret2 = sgiseeq_init(hpc3c1, SGI_GIO_0_IRQ, 1);
+	}
+
+	return (ret1 & ret2) ? ret1 : 0;
 }
 
 static void __exit sgiseeq_exit(void)
