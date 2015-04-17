Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 16:25:28 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:49015 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27025745AbbDQOZVSlLIK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Apr 2015 16:25:21 +0200
Received: from localhost.localdomain (unknown [85.177.206.240])
        (Authenticated sender: albeu)
        by smtp2-g21.free.fr (Postfix) with ESMTPA id 599C14B023C;
        Fri, 17 Apr 2015 16:22:27 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] MIPS: ath79: Add basic device tree support
Date:   Fri, 17 Apr 2015 16:24:17 +0200
Message-Id: <1429280669-2986-3-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429280669-2986-1-git-send-email-albeu@free.fr>
References: <1429280669-2986-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Add the bare minimum to load a device tree.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/Kconfig           |  1 +
 arch/mips/ath79/Kconfig     | 10 ++++++++++
 arch/mips/ath79/machtypes.h |  1 +
 arch/mips/ath79/setup.c     | 27 ++++++++++++++++++++++++++-
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cc7f262..1fa7f2f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -129,6 +129,7 @@ config ATH79
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_MIPS16
 	select SYS_SUPPORTS_ZBOOT
+	select USE_OF
 	help
 	  Support for the Atheros AR71XX/AR724X/AR913X SoCs.
 
diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index dfc6020..1d38c6a 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -71,6 +71,16 @@ config ATH79_MACH_UBNT_XM
 	  Say 'Y' here if you want your kernel to support the
 	  Ubiquiti Networks XM (rev 1.0) board.
 
+choice
+	prompt "Builtin devicetree selection"
+	default DTB_ATH79_NONE
+	help
+	  Select the devicetree.
+
+	config DTB_ATH79_NONE
+		bool "None"
+endchoice
+
 endmenu
 
 config SOC_AR71XX
diff --git a/arch/mips/ath79/machtypes.h b/arch/mips/ath79/machtypes.h
index 2625405..a13db3d 100644
--- a/arch/mips/ath79/machtypes.h
+++ b/arch/mips/ath79/machtypes.h
@@ -15,6 +15,7 @@
 #include <asm/mips_machine.h>
 
 enum ath79_mach_type {
+	ATH79_MACH_GENERIC_OF = -1,	/* Device tree board */
 	ATH79_MACH_GENERIC = 0,
 	ATH79_MACH_AP121,		/* Atheros AP121 reference board */
 	ATH79_MACH_AP136_010,		/* Atheros AP136-010 reference board */
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 74f1af7..01a644f 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -17,12 +17,16 @@
 #include <linux/bootmem.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/of_platform.h>
+#include <linux/of_fdt.h>
 
 #include <asm/bootinfo.h>
 #include <asm/idle.h>
 #include <asm/time.h>		/* for mips_hpt_frequency */
 #include <asm/reboot.h>		/* for _machine_{restart,halt} */
 #include <asm/mips_machine.h>
+#include <asm/prom.h>
+#include <asm/fw/fw.h>
 
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
@@ -194,8 +198,19 @@ unsigned int get_c0_compare_int(void)
 
 void __init plat_mem_setup(void)
 {
+	unsigned long fdt_start;
+
 	set_io_port_base(KSEG1);
 
+	/* Get the position of the FDT passed by the bootloader */
+	fdt_start = fw_getenvl("fdt_start");
+	if (fdt_start)
+		__dt_setup_arch((void *)KSEG0ADDR(fdt_start));
+#ifdef CONFIG_BUILTIN_DTB
+	else
+		__dt_setup_arch(__dtb_start);
+#endif
+
 	ath79_reset_base = ioremap_nocache(AR71XX_RESET_BASE,
 					   AR71XX_RESET_SIZE);
 	ath79_pll_base = ioremap_nocache(AR71XX_PLL_BASE,
@@ -203,7 +218,8 @@ void __init plat_mem_setup(void)
 	ath79_ddr_ctrl_init();
 
 	ath79_detect_sys_type();
-	detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
+	if (mips_machtype != ATH79_MACH_GENERIC_OF)
+		detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
 
 	_machine_restart = ath79_restart;
 	_machine_halt = ath79_halt;
@@ -235,6 +251,10 @@ void __init plat_time_init(void)
 
 static int __init ath79_setup(void)
 {
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	if  (mips_machtype == ATH79_MACH_GENERIC_OF)
+		return 0;
+
 	ath79_gpio_init();
 	ath79_register_uart();
 	ath79_register_wdt();
@@ -246,6 +266,11 @@ static int __init ath79_setup(void)
 
 arch_initcall(ath79_setup);
 
+void __init device_tree_init(void)
+{
+	unflatten_and_copy_device_tree();
+}
+
 static void __init ath79_generic_init(void)
 {
 	/* Nothing to do */
-- 
2.0.0
