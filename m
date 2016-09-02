Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 17:10:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11191 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992087AbcIBPKmmhFOf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 17:10:42 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 72F3897ECDD7E;
        Fri,  2 Sep 2016 16:10:23 +0100 (IST)
Received: from localhost (10.100.200.40) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Sep
 2016 16:10:25 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] MIPS: Malta: Cleanup DMA coherence #ifdefs
Date:   Fri, 2 Sep 2016 16:10:06 +0100
Message-ID: <20160902151006.4257-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.40]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

DMA coherence is not user-selectable in Kconfig, and Malta selects
CONFIG_DMA_MAYBE_COHERENT which in turn selects CONFIG_DMA_NONCOHERENT.
Remove #ifdefs on CONFIG_DMA_COHERENT which is not set for Malta. This
removes a significant amount of code from bonito_quirks_setup(), but the
code is duplicated in plat_enable_iocoherency() anyway so we lose
nothing but duplication.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/mti-malta/malta-setup.c | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index ec5b216..e573402 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -141,12 +141,6 @@ static int __init plat_enable_iocoherency(void)
 
 static void __init plat_setup_iocoherency(void)
 {
-#ifdef CONFIG_DMA_NONCOHERENT
-	/*
-	 * Kernel has been configured with software coherency
-	 * but we might choose to turn it off and use hardware
-	 * coherency instead.
-	 */
 	if (plat_enable_iocoherency()) {
 		if (coherentio == 0)
 			pr_info("Hardware DMA cache coherency disabled\n");
@@ -158,10 +152,6 @@ static void __init plat_setup_iocoherency(void)
 		else
 			pr_info("Software DMA cache coherency enabled\n");
 	}
-#else
-	if (!plat_enable_iocoherency())
-		panic("Hardware DMA cache coherency not supported!");
-#endif
 }
 
 static void __init pci_clock_check(void)
@@ -223,29 +213,6 @@ static void __init bonito_quirks_setup(void)
 		pr_info("Enabled Bonito debug mode\n");
 	} else
 		BONITO_BONGENCFG &= ~BONITO_BONGENCFG_DEBUGMODE;
-
-#ifdef CONFIG_DMA_COHERENT
-	if (BONITO_PCICACHECTRL & BONITO_PCICACHECTRL_CPUCOH_PRES) {
-		BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_CPUCOH_EN;
-		pr_info("Enabled Bonito CPU coherency\n");
-
-		argptr = fw_getcmdline();
-		if (strstr(argptr, "iobcuncached")) {
-			BONITO_PCICACHECTRL &= ~BONITO_PCICACHECTRL_IOBCCOH_EN;
-			BONITO_PCIMEMBASECFG = BONITO_PCIMEMBASECFG &
-				~(BONITO_PCIMEMBASECFG_MEMBASE0_CACHED |
-					BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
-			pr_info("Disabled Bonito IOBC coherency\n");
-		} else {
-			BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_IOBCCOH_EN;
-			BONITO_PCIMEMBASECFG |=
-				(BONITO_PCIMEMBASECFG_MEMBASE0_CACHED |
-					BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
-			pr_info("Enabled Bonito IOBC coherency\n");
-		}
-	} else
-		panic("Hardware DMA cache coherency not supported");
-#endif
 }
 
 void __init *plat_get_fdt(void)
@@ -276,11 +243,6 @@ void __init plat_mem_setup(void)
 	 */
 	enable_dma(4);
 
-#ifdef CONFIG_DMA_COHERENT
-	if (mips_revision_sconid != MIPS_REVISION_SCON_BONITO)
-		panic("Hardware DMA cache coherency not supported");
-#endif
-
 	if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO)
 		bonito_quirks_setup();
 
-- 
2.9.3
