Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2008 16:01:01 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:969 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21921995AbYJTPA5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2008 16:00:57 +0100
Received: from localhost.localdomain (p5246-ipad210funabasi.chiba.ocn.ne.jp [58.88.124.246])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1A00EA7F6; Tue, 21 Oct 2008 00:00:53 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] RBTX4939: Add smc91x support
Date:	Tue, 21 Oct 2008 00:01:06 +0900
Message-Id: <1224514866-16205-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add smc91x platform device to RBTX4939 board and some hacks for big endian.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/include/asm/mach-tx49xx/mangle-port.h |   26 ++++++++++++++
 arch/mips/txx9/generic/setup.c                  |   15 ++++++++
 arch/mips/txx9/rbtx4939/setup.c                 |   43 +++++++++++++++++++++++
 3 files changed, 84 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-tx49xx/mangle-port.h

diff --git a/arch/mips/include/asm/mach-tx49xx/mangle-port.h b/arch/mips/include/asm/mach-tx49xx/mangle-port.h
new file mode 100644
index 0000000..5e6912f
--- /dev/null
+++ b/arch/mips/include/asm/mach-tx49xx/mangle-port.h
@@ -0,0 +1,26 @@
+#ifndef __ASM_MACH_TX49XX_MANGLE_PORT_H
+#define __ASM_MACH_TX49XX_MANGLE_PORT_H
+
+#define __swizzle_addr_b(port)	(port)
+#define __swizzle_addr_w(port)	(port)
+#define __swizzle_addr_l(port)	(port)
+#define __swizzle_addr_q(port)	(port)
+
+#define ioswabb(a, x)		(x)
+#define __mem_ioswabb(a, x)	(x)
+#if defined(CONFIG_TOSHIBA_RBTX4939) && \
+	(defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)) && \
+	defined(__BIG_ENDIAN)
+#define NEEDS_TXX9_IOSWABW
+extern u16 (*ioswabw)(volatile u16 *a, u16 x);
+extern u16 (*__mem_ioswabw)(volatile u16 *a, u16 x);
+#else
+#define ioswabw(a, x)		le16_to_cpu(x)
+#define __mem_ioswabw(a, x)	(x)
+#endif
+#define ioswabl(a, x)		le32_to_cpu(x)
+#define __mem_ioswabl(a, x)	(x)
+#define ioswabq(a, x)		le64_to_cpu(x)
+#define __mem_ioswabq(a, x)	(x)
+
+#endif /* __ASM_MACH_TX49XX_MANGLE_PORT_H */
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 5526375..18086c5 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -622,6 +622,21 @@ unsigned long (*__swizzle_addr_b)(unsigned long port) = __swizzle_addr_none;
 EXPORT_SYMBOL(__swizzle_addr_b);
 #endif
 
+#ifdef NEEDS_TXX9_IOSWABW
+static u16 ioswabw_default(volatile u16 *a, u16 x)
+{
+	return le16_to_cpu(x);
+}
+static u16 __mem_ioswabw_default(volatile u16 *a, u16 x)
+{
+	return x;
+}
+u16 (*ioswabw)(volatile u16 *a, u16 x) = ioswabw_default;
+EXPORT_SYMBOL(ioswabw);
+u16 (*__mem_ioswabw)(volatile u16 *a, u16 x) = __mem_ioswabw_default;
+EXPORT_SYMBOL(__mem_ioswabw);
+#endif
+
 void __init txx9_physmap_flash_init(int no, unsigned long addr,
 				    unsigned long size,
 				    const struct physmap_flash_data *pdata)
diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index 27d13ee..cfb4e4e 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -14,6 +14,8 @@
 #include <linux/types.h>
 #include <linux/platform_device.h>
 #include <linux/leds.h>
+#include <linux/interrupt.h>
+#include <linux/smc91x.h>
 #include <asm/reboot.h>
 #include <asm/txx9/generic.h>
 #include <asm/txx9/pci.h>
@@ -33,6 +35,21 @@ static void __init rbtx4939_time_init(void)
 	tx4939_time_init(0);
 }
 
+#if defined(__BIG_ENDIAN) && \
+	(defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE))
+#define HAVE_RBTX4939_IOSWAB
+#define IS_CE1_ADDR(addr) \
+	((((unsigned long)(addr) - IO_BASE) & 0xfff00000) == TXX9_CE(1))
+static u16 rbtx4939_ioswabw(volatile u16 *a, u16 x)
+{
+	return IS_CE1_ADDR(a) ? x : le16_to_cpu(x);
+}
+static u16 rbtx4939_mem_ioswabw(volatile u16 *a, u16 x)
+{
+	return !IS_CE1_ADDR(a) ? x : le16_to_cpu(x);
+}
+#endif /* __BIG_ENDIAN && CONFIG_SMC91X */
+
 static void __init rbtx4939_pci_setup(void)
 {
 #ifdef CONFIG_PCI
@@ -272,6 +289,22 @@ static void __init rbtx4939_arch_init(void)
 
 static void __init rbtx4939_device_init(void)
 {
+	unsigned long smc_addr = RBTX4939_ETHER_ADDR - IO_BASE;
+	struct resource smc_res[] = {
+		{
+			.start	= smc_addr,
+			.end	= smc_addr + 0x10 - 1,
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.start	= RBTX4939_IRQ_ETHER,
+			/* override default irq flag defined in smc91x.h */
+			.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_LOW,
+		},
+	};
+	struct smc91x_platdata smc_pdata = {
+		.flags = SMC91X_USE_16BIT,
+	};
+	struct platform_device *pdev;
 #if defined(CONFIG_TC35815) || defined(CONFIG_TC35815_MODULE)
 	int i, j;
 	unsigned char ethaddr[2][6];
@@ -293,6 +326,12 @@ static void __init rbtx4939_device_init(void)
 	}
 	tx4939_ethaddr_init(ethaddr[0], ethaddr[1]);
 #endif
+	pdev = platform_device_alloc("smc91x", -1);
+	if (!pdev ||
+	    platform_device_add_resources(pdev, smc_res, ARRAY_SIZE(smc_res)) ||
+	    platform_device_add_data(pdev, &smc_pdata, sizeof(smc_pdata)) ||
+	    platform_device_add(pdev))
+		platform_device_put(pdev);
 	rbtx4939_led_setup();
 	tx4939_wdt_init();
 	tx4939_ata_init();
@@ -309,6 +348,10 @@ static void __init rbtx4939_setup(void)
 	if (txx9_master_clock == 0)
 		txx9_master_clock = 20000000;
 	tx4939_setup();
+#ifdef HAVE_RBTX4939_IOSWAB
+	ioswabw = rbtx4939_ioswabw;
+	__mem_ioswabw = rbtx4939_mem_ioswabw;
+#endif
 
 	_machine_restart = rbtx4939_machine_restart;
 
-- 
1.5.6.3
