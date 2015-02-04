Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 16:22:51 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32022 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012467AbbBDPWdlCVZY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 16:22:33 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EAC2621EE813F;
        Wed,  4 Feb 2015 15:22:24 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 4 Feb 2015 15:22:27 +0000
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 4 Feb 2015 15:22:27 +0000
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Zubair.Kakakhel@imgtec.com>,
        <gregkh@linuxfoundation.org>, <mturquette@linaro.org>,
        <sboyd@codeaurora.org>, <ralf@linux-mips.org>, <jslaby@suse.cz>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <lars@metafoo.de>,
        <paul.burton@imgtec.com>
Subject: [PATCH_V2 02/34] MIPS: jz4740: require & include DT
Date:   Wed, 4 Feb 2015 15:21:31 +0000
Message-ID: <1423063323-19419-3-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.89]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

From: Paul Burton <paul.burton@imgtec.com>

Require a DT for jz4740 based systems, and add a stub one for the
qi_lb60 (Ben NanoNote) board. Devices will be migrated to being probed
via this DT over time.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/Kconfig              |  2 ++
 arch/mips/boot/dts/Makefile    |  1 +
 arch/mips/boot/dts/jz4740.dtsi |  5 +++++
 arch/mips/boot/dts/qi_lb60.dts |  7 +++++++
 arch/mips/jz4740/setup.c       | 19 +++++++++++++++++++
 5 files changed, 34 insertions(+)
 create mode 100644 arch/mips/boot/dts/jz4740.dtsi
 create mode 100644 arch/mips/boot/dts/qi_lb60.dts

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3289969..99d50cd 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -288,6 +288,8 @@ config MACH_JZ4740
 	select SYS_HAS_EARLY_PRINTK
 	select HAVE_CLK
 	select GENERIC_IRQ_CHIP
+	select BUILTIN_DTB
+	select USE_OF
 
 config LANTIQ
 	bool "Lantiq based platforms"
diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 4f49fa4..a1127f3 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -9,6 +9,7 @@ dtb-$(CONFIG_DTB_RT2880_EVAL)		+= rt2880_eval.dtb
 dtb-$(CONFIG_DTB_RT305X_EVAL)		+= rt3052_eval.dtb
 dtb-$(CONFIG_DTB_RT3883_EVAL)		+= rt3883_eval.dtb
 dtb-$(CONFIG_DTB_MT7620A_EVAL)		+= mt7620a_eval.dtb
+dtb-$(CONFIG_JZ4740_QI_LB60)		+= qi_lb60.dtb
 dtb-$(CONFIG_MIPS_SEAD3)		+= sead3.dtb
 
 obj-y		+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
diff --git a/arch/mips/boot/dts/jz4740.dtsi b/arch/mips/boot/dts/jz4740.dtsi
new file mode 100644
index 0000000..c538691f
--- /dev/null
+++ b/arch/mips/boot/dts/jz4740.dtsi
@@ -0,0 +1,5 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "ingenic,jz4740";
+};
diff --git a/arch/mips/boot/dts/qi_lb60.dts b/arch/mips/boot/dts/qi_lb60.dts
new file mode 100644
index 0000000..0c0f639
--- /dev/null
+++ b/arch/mips/boot/dts/qi_lb60.dts
@@ -0,0 +1,7 @@
+/dts-v1/;
+
+#include "jz4740.dtsi"
+
+/ {
+	compatible = "qi,lb60", "ingenic,jz4740";
+};
diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index ef796f9..d6bb7a3 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -17,8 +17,11 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
 
 #include <asm/bootinfo.h>
+#include <asm/prom.h>
 
 #include <asm/mach-jz4740/base.h>
 
@@ -53,8 +56,24 @@ void __init plat_mem_setup(void)
 {
 	jz4740_reset_init();
 	jz4740_detect_mem();
+	__dt_setup_arch(__dtb_start);
 }
 
+void __init device_tree_init(void)
+{
+	if (!initial_boot_params)
+		return;
+
+	unflatten_and_copy_device_tree();
+}
+
+static int __init populate_machine(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	return 0;
+}
+arch_initcall(populate_machine);
+
 const char *get_system_type(void)
 {
 	return "JZ4740";
-- 
1.9.1
