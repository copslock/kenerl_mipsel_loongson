Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Sep 2015 18:27:08 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:53289 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012207AbbILQ0p0bp-i (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Sep 2015 18:26:45 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 0778B28C131;
        Sat, 12 Sep 2015 18:25:31 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-016-160.088.073.pools.vodafone-ip.de [88.73.16.160])
        by arrakis.dune.hu (Postfix) with ESMTPSA id EBE5828C12E;
        Sat, 12 Sep 2015 18:25:18 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        Ganesan Ramalingam <ganesanr@broadcom.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>
Subject: [PATCH 2/3] MIPS: make the kernel arguments from dtb available
Date:   Sat, 12 Sep 2015 18:26:13 +0200
Message-Id: <1442075174-30414-3-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1442075174-30414-1-git-send-email-jogo@openwrt.org>
References: <1442075174-30414-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Similar to how arm allows using selecting between bootloader arguments,
dtb arguments and both, allow to select them on mips. But since we have
less control over the place of the dtb do not modify it but instead use
the boot_command_line for merging them.

The default is "use bootloader arguments" to keep the current behaviour
as default.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/Kconfig        | 16 ++++++++++++++++
 arch/mips/kernel/setup.c | 24 +++++++++++++++++-------
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 10fcd93..3753437 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2728,6 +2728,22 @@ choice
 		  if you don't intend to always append a DTB.
 endchoice
 
+choice
+	prompt "Kernel command line type" if !CMDLINE_OVERRIDE
+	default MIPS_CMDLINE_FROM_BOOTLOADER
+
+	config MIPS_CMDLINE_FROM_DTB
+		depends on USE_OF
+		bool "Dtb kernel arguments if available"
+
+	config MIPS_CMDLINE_DTB_EXTEND
+		depends on USE_OF
+		bool "Extend dtb kernel arguments with bootloader arguments"
+
+	config MIPS_CMDLINE_FROM_BOOTLOADER
+		bool "Bootloader kernel arguments if available"
+endchoice
+
 endmenu
 
 config LOCKDEP_SUPPORT
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 35b8316..2f33bbf 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -608,6 +608,10 @@ static void __init request_crashkernel(struct resource *res)
 }
 #endif /* !defined(CONFIG_KEXEC)  */
 
+#define USE_PROM_CMDLINE	IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER)
+#define USE_DTB_CMDLINE		IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_DTB)
+#define EXTEND_WITH_PROM	IS_ENABLED(CONFIG_MIPS_CMDLINE_EXTEND)
+
 static void __init arch_mem_init(char **cmdline_p)
 {
 	struct memblock_region *reg;
@@ -632,18 +636,24 @@ static void __init arch_mem_init(char **cmdline_p)
 	pr_info("Determined physical RAM map:\n");
 	print_memory_map();
 
-#ifdef CONFIG_CMDLINE_BOOL
-#ifdef CONFIG_CMDLINE_OVERRIDE
+#if defined(CONFIG_CMDLINE_BOOL) && defined(CONFIG_CMDLINE_OVERRIDE)
 	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 #else
+	if ((USE_PROM_CMDLINE && arcs_cmdline[0]) ||
+	    (USE_DTB_CMDLINE && !boot_command_line[0]))
+		strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
+
+	if (EXTEND_WITH_PROM && arcs_cmdline[0]) {
+		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+		strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
+	}
+
+#if defined(CONFIG_CMDLINE_BOOL)
 	if (builtin_cmdline[0]) {
-		strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
-		strlcat(arcs_cmdline, builtin_cmdline, COMMAND_LINE_SIZE);
+		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+		strlcat(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 	}
-	strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
 #endif
-#else
-	strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
 #endif
 	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 
-- 
2.1.4
