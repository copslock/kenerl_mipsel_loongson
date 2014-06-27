Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2014 00:01:01 +0200 (CEST)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:38851 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860050AbaF0WAEkbRxq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Jun 2014 00:00:04 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id D960456F85A;
        Sat, 28 Jun 2014 01:00:01 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id oP1j5FhkHivp; Sat, 28 Jun 2014 00:59:55 +0300 (EEST)
Received: from cooljazz.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 30A915BC01C;
        Sat, 28 Jun 2014 00:59:55 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v2 2/4] MIPS: OCTEON: watchdog: don't jump to bootloader without entry address
Date:   Sat, 28 Jun 2014 00:59:50 +0300
Message-Id: <1403906392-10650-3-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1403906392-10650-1-git-send-email-aaro.koskinen@iki.fi>
References: <1403906392-10650-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40887
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

If CONFIG_HOTPLUG_CPU is set, the driver thinks bootloader entry
address is configured and we should jump there. However, this is
not necessarily true if the kernel is booted on a system
with older/incompatible bootloader.

Add dynamic checks for the bootloader entry address.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/octeon-wdt-main.c | 62 +++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 4baf2d7..8453531 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -145,35 +145,39 @@ static void __init octeon_wdt_build_stage1(void)
 
 	uasm_i_mfc0(&p, K0, C0_STATUS);
 #ifdef CONFIG_HOTPLUG_CPU
-	uasm_il_bbit0(&p, &r, K0, ilog2(ST0_NMI), label_enter_bootloader);
+	if (octeon_bootloader_entry_addr)
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
+	if (octeon_bootloader_entry_addr) {
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
+	if (octeon_bootloader_entry_addr) {
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
