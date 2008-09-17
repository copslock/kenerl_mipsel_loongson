Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2008 16:13:56 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:30954 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20250287AbYIQPNq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2008 16:13:46 +0100
Received: from localhost (p3101-ipad302funabasi.chiba.ocn.ne.jp [123.217.141.101])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 53C9EB70C; Thu, 18 Sep 2008 00:13:41 +0900 (JST)
Date:	Thu, 18 Sep 2008 00:13:58 +0900 (JST)
Message-Id: <20080918.001358.08318211.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com
Subject: [PATCH 2/2] TXx9: Add TX4939 ATA support (v2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Received-SPF: none (mfgw220.ocn.ad.jp: 213.58.128.207 is neither permitted
 nor denied by domain of linux-mips.org) client-ip=213.58.128.207;
 envelope-from=linux-mips-bounce@linux-mips.org; helo=ftp.linux-mips.org;
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add a helper routine to register tx4939ide driver and use it on
RBTX4939 board.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch is against linux-next 20080916.

Changes since v1:
* Use static resource arrays and platform_device array.

 arch/mips/txx9/generic/setup_tx4939.c |   46 +++++++++++++++++++++++++++++++++
 arch/mips/txx9/rbtx4939/setup.c       |    1 +
 include/asm-mips/txx9/tx4939.h        |    1 +
 3 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic/setup_tx4939.c
index f14a497..6c0049a 100644
--- a/arch/mips/txx9/generic/setup_tx4939.c
+++ b/arch/mips/txx9/generic/setup_tx4939.c
@@ -20,6 +20,7 @@
 #include <linux/param.h>
 #include <linux/ptrace.h>
 #include <linux/mtd/physmap.h>
+#include <linux/platform_device.h>
 #include <asm/bootinfo.h>
 #include <asm/reboot.h>
 #include <asm/traps.h>
@@ -389,6 +390,51 @@ void __init tx4939_mtd_init(int ch)
 	txx9_physmap_flash_init(ch, start, size, &pdata);
 }
 
+#define TX4939_ATA_REG_PHYS(ch) (TX4939_ATA_REG(ch) & 0xfffffffffULL)
+void __init tx4939_ata_init(void)
+{
+	static struct resource ata0_res[] = {
+		{
+			.start = TX4939_ATA_REG_PHYS(0),
+			.end = TX4939_ATA_REG_PHYS(0) + 0x1000 - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = TXX9_IRQ_BASE + TX4939_IR_ATA(0),
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+	static struct resource ata1_res[] = {
+		{
+			.start = TX4939_ATA_REG_PHYS(1),
+			.end = TX4939_ATA_REG_PHYS(1) + 0x1000 - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = TXX9_IRQ_BASE + TX4939_IR_ATA(1),
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+	static struct platform_device ata0_dev = {
+		.name = "tx4939ide",
+		.id = 0,
+		.num_resources = ARRAY_SIZE(ata0_res),
+		.resource = ata0_res,
+	};
+	static struct platform_device ata1_dev = {
+		.name = "tx4939ide",
+		.id = 1,
+		.num_resources = ARRAY_SIZE(ata1_res),
+		.resource = ata1_res,
+	};
+	__u64 pcfg = __raw_readq(&tx4939_ccfgptr->pcfg);
+
+	if (pcfg & TX4939_PCFG_ATA0MODE)
+		platform_device_register(&ata0_dev);
+	if ((pcfg & (TX4939_PCFG_ATA1MODE |
+		     TX4939_PCFG_ET1MODE |
+		     TX4939_PCFG_ET0MODE)) == TX4939_PCFG_ATA1MODE)
+		platform_device_register(&ata1_dev);
+}
+
 static void __init tx4939_stop_unused_modules(void)
 {
 	__u64 pcfg, rst = 0, ckd = 0;
diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index 277864d..9855d7b 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -264,6 +264,7 @@ static void __init rbtx4939_device_init(void)
 #endif
 	rbtx4939_led_setup();
 	tx4939_wdt_init();
+	tx4939_ata_init();
 }
 
 static void __init rbtx4939_setup(void)
diff --git a/include/asm-mips/txx9/tx4939.h b/include/asm-mips/txx9/tx4939.h
index 7ce2dff..88badb4 100644
--- a/include/asm-mips/txx9/tx4939.h
+++ b/include/asm-mips/txx9/tx4939.h
@@ -540,5 +540,6 @@ void tx4939_setup_pcierr_irq(void);
 void tx4939_irq_init(void);
 int tx4939_irq(void);
 void tx4939_mtd_init(int ch);
+void tx4939_ata_init(void);
 
 #endif /* __ASM_TXX9_TX4939_H */
-- 
1.5.6.3
