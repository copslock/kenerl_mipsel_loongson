Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2014 22:07:07 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:58486 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860005AbaFPUGrjnN14 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jun 2014 22:06:47 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 32DF721B964;
        Mon, 16 Jun 2014 23:06:47 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id ciUoPrh-aAZK; Mon, 16 Jun 2014 23:06:40 +0300 (EEST)
Received: from cooljazz.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id 8AA705BC006;
        Mon, 16 Jun 2014 23:06:40 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 2/3] MIPS: OCTEON: support disabling HOTPLUG_CPU run-time
Date:   Mon, 16 Jun 2014 23:06:29 +0300
Message-Id: <1402949190-28182-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1402949190-28182-1-git-send-email-aaro.koskinen@iki.fi>
References: <1402949190-28182-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

If nosmp kernel option given, we can assume HOTPLUG_CPU is disabled.
This is needed in order to be able to run the same kernel binary on
single core OCTEONs with older/incompatible bootloaders.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-watchdog@vger.kernel.org
---
 arch/mips/cavium-octeon/smp.c      |  5 ++-
 drivers/watchdog/octeon-wdt-main.c | 62 +++++++++++++++++++++-----------------
 2 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 2c8d156..ea96930 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -84,6 +84,9 @@ static void octeon_smp_hotplug_setup(void)
 #ifdef CONFIG_HOTPLUG_CPU
 	struct linux_app_boot_info *labi;
 
+	if (!setup_max_cpus)
+		return;
+
 	labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
 	if (labi->labi_signature != LABI_SIGNATURE)
 		panic("The bootloader version on this board is incorrect.");
@@ -129,7 +132,7 @@ static void octeon_smp_setup(void)
 	 * will assign CPU numbers for possible cores as well.	Cores
 	 * are always consecutively numberd from 0.
 	 */
-	for (id = 0; id < num_cores && id < NR_CPUS; id++) {
+	for (id = 0; setup_max_cpus && id < num_cores && id < NR_CPUS; id++) {
 		if (!(core_mask & (1 << id))) {
 			set_cpu_possible(cpus, true);
 			__cpu_number_map[id] = cpus;
diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 4baf2d7..c5aee12 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -145,35 +145,39 @@ static void __init octeon_wdt_build_stage1(void)
 
 	uasm_i_mfc0(&p, K0, C0_STATUS);
 #ifdef CONFIG_HOTPLUG_CPU
-	uasm_il_bbit0(&p, &r, K0, ilog2(ST0_NMI), label_enter_bootloader);
+	if (setup_max_cpus)
+		uasm_il_bbit0(&p, &r, K0, ilog2(ST0_NMI),
+			      label_enter_bootloader);
 #endif
 	/* Force 64-bit addressing enabled */
 	uasm_i_ori(&p, K0, K0, ST0_UX | ST0_SX | ST0_KX);
 	uasm_i_mtc0(&p, K0, C0_STATUS);
 
 #ifdef CONFIG_HOTPLUG_CPU
-	uasm_i_mfc0(&p, K0, C0_EBASE);
-	/* Coreid number in K0 */
-	uasm_i_andi(&p, K0, K0, 0xf);
-	/* 8 * coreid in bits 16-31 */
-	uasm_i_dsll_safe(&p, K0, K0, 3 + 16);
-	uasm_i_ori(&p, K0, K0, 0x8001);
-	uasm_i_dsll_safe(&p, K0, K0, 16);
-	uasm_i_ori(&p, K0, K0, 0x0700);
-	uasm_i_drotr_safe(&p, K0, K0, 32);
-	/*
-	 * Should result in: 0x8001,0700,0000,8*coreid which is
-	 * CVMX_CIU_WDOGX(coreid) - 0x0500
-	 *
-	 * Now ld K0, CVMX_CIU_WDOGX(coreid)
-	 */
-	uasm_i_ld(&p, K0, 0x500, K0);
-	/*
-	 * If bit one set handle the NMI as a watchdog event.
-	 * otherwise transfer control to bootloader.
-	 */
-	uasm_il_bbit0(&p, &r, K0, 1, label_enter_bootloader);
-	uasm_i_nop(&p);
+	if (setup_max_cpus) {
+		uasm_i_mfc0(&p, K0, C0_EBASE);
+		/* Coreid number in K0 */
+		uasm_i_andi(&p, K0, K0, 0xf);
+		/* 8 * coreid in bits 16-31 */
+		uasm_i_dsll_safe(&p, K0, K0, 3 + 16);
+		uasm_i_ori(&p, K0, K0, 0x8001);
+		uasm_i_dsll_safe(&p, K0, K0, 16);
+		uasm_i_ori(&p, K0, K0, 0x0700);
+		uasm_i_drotr_safe(&p, K0, K0, 32);
+		/*
+		 * Should result in: 0x8001,0700,0000,8*coreid which is
+		 * CVMX_CIU_WDOGX(coreid) - 0x0500
+		 *
+		 * Now ld K0, CVMX_CIU_WDOGX(coreid)
+		 */
+		uasm_i_ld(&p, K0, 0x500, K0);
+		/*
+		 * If bit one set handle the NMI as a watchdog event.
+		 * otherwise transfer control to bootloader.
+		 */
+		uasm_il_bbit0(&p, &r, K0, 1, label_enter_bootloader);
+		uasm_i_nop(&p);
+	}
 #endif
 
 	/* Clear Dcache so cvmseg works right. */
@@ -194,11 +198,13 @@ static void __init octeon_wdt_build_stage1(void)
 	uasm_i_dmfc0(&p, K0, C0_DESAVE);
 
 #ifdef CONFIG_HOTPLUG_CPU
-	uasm_build_label(&l, p, label_enter_bootloader);
-	/* Jump to the bootloader and restore K0 */
-	UASM_i_LA(&p, K0, (long)octeon_bootloader_entry_addr);
-	uasm_i_jr(&p, K0);
-	uasm_i_dmfc0(&p, K0, C0_DESAVE);
+	if (setup_max_cpus) {
+		uasm_build_label(&l, p, label_enter_bootloader);
+		/* Jump to the bootloader and restore K0 */
+		UASM_i_LA(&p, K0, (long)octeon_bootloader_entry_addr);
+		uasm_i_jr(&p, K0);
+		uasm_i_dmfc0(&p, K0, C0_DESAVE);
+	}
 #endif
 	uasm_resolve_relocs(relocs, labels);
 
-- 
2.0.0
