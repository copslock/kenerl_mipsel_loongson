Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Aug 2012 18:03:26 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:42842 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903528Ab2HDQBt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 4 Aug 2012 18:01:49 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id F01B823C0096;
        Sat,  4 Aug 2012 18:01:42 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v3 3/4] MIPS: ath79: select HAVE_CLK
Date:   Sat,  4 Aug 2012 18:01:26 +0200
Message-Id: <1344096087-25044-4-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1344096087-25044-1-git-send-email-juhosg@openwrt.org>
References: <1344096087-25044-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 34057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

It is needed in order to get rid of the following errors:

arch/mips/ath79/clock.c:353:13: error: redefinition of 'clk_get'
include/linux/clk.h:281:27: note: previous definition of 'clk_get' was here
arch/mips/ath79/clock.c:377:5: error: redefinition of 'clk_enable'
include/linux/clk.h:295:19: note: previous definition of 'clk_enable' was here
arch/mips/ath79/clock.c:383:6: error: redefinition of 'clk_disable'
include/linux/clk.h:300:20: note: previous definition of 'clk_disable' was here
arch/mips/ath79/clock.c:388:15: error: redefinition of 'clk_get_rate'
include/linux/clk.h:302:29: note: previous definition of 'clk_get_rate' was here
arch/mips/ath79/clock.c:394:6: error: redefinition of 'clk_put'
include/linux/clk.h:291:20: note: previous definition of 'clk_put' was here

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 566ce2d..88a8c73 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -89,6 +89,7 @@ config ATH79
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
+	select HAVE_CLK
 	select IRQ_CPU
 	select MIPS_MACHINE
 	select SYS_HAS_CPU_MIPS32_R2
-- 
1.7.10
