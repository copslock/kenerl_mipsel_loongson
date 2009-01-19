Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2009 22:43:30 +0000 (GMT)
Received: from orbit.nwl.cc ([91.121.169.95]:58849 "EHLO mail.nwl.cc")
	by ftp.linux-mips.org with ESMTP id S21366174AbZASWnK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2009 22:43:10 +0000
Received: from base (localhost [127.0.0.1])
	by mail.nwl.cc (Postfix) with ESMTP id EAA84400E123;
	Mon, 19 Jan 2009 23:43:04 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Linux-Mips List <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org, florian@openwrt.org
Subject: [PATCH 5/5] MIPS: rb532: simplify dev3 init
Date:	Mon, 19 Jan 2009 23:42:54 +0100
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <1232404974-18497-4-git-send-email-n0-1@freewrt.org>
References: <1232404974-18497-1-git-send-email-n0-1@freewrt.org>
 <1232404974-18497-2-git-send-email-n0-1@freewrt.org>
 <1232404974-18497-3-git-send-email-n0-1@freewrt.org>
 <1232404974-18497-4-git-send-email-n0-1@freewrt.org>
Message-Id: <20090119224304.EAA84400E123@mail.nwl.cc>
Return-Path: <n0-1@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

As rb532_dev3_ctl_res is not used by any platform device, it can be
dropped when not used for holding the physical address of the device 3
controller.
Also a size of one byte should suffice when ioremapping the physical
address mentioned above, as only a single byte is being read from and
written to it.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/rb532/devices.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 1a0209e..4a5f05b 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -63,13 +63,6 @@ unsigned char get_latch_u5(void)
 }
 EXPORT_SYMBOL(get_latch_u5);
 
-static struct resource rb532_dev3_ctl_res[] = {
-	{
-		.name	= "dev3_ctl",
-		.flags	= IORESOURCE_MEM,
-	}
-};
-
 static struct resource korina_dev0_res[] = {
 	{
 		.name = "korina_regs",
@@ -342,11 +335,8 @@ static int __init plat_setup_devices(void)
 	nand_slot0_res[0].start = readl(IDT434_REG_BASE + DEV2BASE);
 	nand_slot0_res[0].end = nand_slot0_res[0].start + 0x1000;
 
-	/* Read the third (multi purpose) resources from the DC */
-	rb532_dev3_ctl_res[0].start = readl(IDT434_REG_BASE + DEV3BASE);
-	rb532_dev3_ctl_res[0].end = rb532_dev3_ctl_res[0].start + 0x1000;
-
-	dev3.base = ioremap_nocache(rb532_dev3_ctl_res[0].start, 0x1000);
+	/* Read and map device controller 3 */
+	dev3.base = ioremap_nocache(readl(IDT434_REG_BASE + DEV3BASE), 1);
 
 	if (!dev3.base) {
 		printk(KERN_ERR "rb532: cannot remap device controller 3\n");
-- 
1.5.6.4
