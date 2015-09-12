Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Sep 2015 18:27:24 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:53294 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011669AbbILQ0u6BoYi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Sep 2015 18:26:50 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id B4A4428C088;
        Sat, 12 Sep 2015 18:25:37 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-016-160.088.073.pools.vodafone-ip.de [88.73.16.160])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 2AFBD28C134;
        Sat, 12 Sep 2015 18:25:20 +0200 (CEST)
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
Subject: [PATCH 3/3] MIPS: make MIPS_CMDLINE_DTB default
Date:   Sat, 12 Sep 2015 18:26:14 +0200
Message-Id: <1442075174-30414-4-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1442075174-30414-1-git-send-email-jogo@openwrt.org>
References: <1442075174-30414-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49175
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

Seval of-enabled machines (bmips, lantiq, xlp, pistachio, ralink) copied
the arguments from dtb to arcs_command_line to prevent the kernel from
overwriting them.

Since there is now an option to keep the dtb arguments, default to the
new option remove the "backup" to arcs_command_line in case of USE_OF is
enabled, except for those platforms that still take the bootloader
arguments or do not use any at all.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/Kconfig           | 3 +++
 arch/mips/bmips/setup.c     | 1 -
 arch/mips/lantiq/prom.c     | 2 --
 arch/mips/netlogic/xlp/dt.c | 1 -
 arch/mips/pistachio/init.c  | 1 -
 arch/mips/ralink/of.c       | 2 --
 6 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3753437..703142b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2730,6 +2730,9 @@ endchoice
 
 choice
 	prompt "Kernel command line type" if !CMDLINE_OVERRIDE
+	default MIPS_CMDLINE_FROM_DTB if USE_OF && !ATh79 && !MACH_INGENIC && \
+					 !MIPS_MALTA && !MIPS_SEAD3 && \
+					 !CAVIUM_OCTEON_SOC
 	default MIPS_CMDLINE_FROM_BOOTLOADER
 
 	config MIPS_CMDLINE_FROM_DTB
diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 526ec27..5b16d29 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -157,7 +157,6 @@ void __init plat_mem_setup(void)
 		panic("no dtb found");
 
 	__dt_setup_arch(dtb);
-	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 
 	for (q = bmips_quirk_list; q->quirk_fn; q++) {
 		if (of_flat_dt_is_compatible(of_get_flat_dt_root(),
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 0db099e..297bcaa 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -77,8 +77,6 @@ void __init plat_mem_setup(void)
 	 * parsed resulting in our memory appearing
 	 */
 	__dt_setup_arch(__dtb_start);
-
-	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 }
 
 void __init device_tree_init(void)
diff --git a/arch/mips/netlogic/xlp/dt.c b/arch/mips/netlogic/xlp/dt.c
index a625bdb..856a6e6 100644
--- a/arch/mips/netlogic/xlp/dt.c
+++ b/arch/mips/netlogic/xlp/dt.c
@@ -87,7 +87,6 @@ void __init *xlp_dt_init(void *fdtp)
 void __init xlp_early_init_devtree(void)
 {
 	__dt_setup_arch(xlp_fdt_blob);
-	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 }
 
 void __init device_tree_init(void)
diff --git a/arch/mips/pistachio/init.c b/arch/mips/pistachio/init.c
index 8bd8ebb..96ba2cc 100644
--- a/arch/mips/pistachio/init.c
+++ b/arch/mips/pistachio/init.c
@@ -58,7 +58,6 @@ void __init plat_mem_setup(void)
 		panic("Device-tree not present");
 
 	__dt_setup_arch((void *)fw_arg1);
-	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 
 	plat_setup_iocoherency();
 }
diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index 0d30dcd..f9eda5d 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -74,8 +74,6 @@ void __init plat_mem_setup(void)
 	 */
 	__dt_setup_arch(__dtb_start);
 
-	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-
 	of_scan_flat_dt(early_init_dt_find_memory, NULL);
 	if (memory_dtb)
 		of_scan_flat_dt(early_init_dt_scan_memory, NULL);
-- 
2.1.4
