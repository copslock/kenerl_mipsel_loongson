Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Jul 2015 14:43:20 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:46964 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011220AbbGSMnTG1E0t (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 Jul 2015 14:43:19 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 78DBB289CB3;
        Sun, 19 Jul 2015 14:42:51 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-024-154.088.073.pools.vodafone-ip.de [88.73.24.154])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 49759284668;
        Sun, 19 Jul 2015 14:42:46 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org, devicetree@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh@kernel.org>,
        Grant Likely <grant.likely@linaro.org>
Subject: [PATCH] MIPS: fix build with CONFIG_OF=y for non OF-enabled targets
Date:   Sun, 19 Jul 2015 14:42:49 +0200
Message-Id: <1437309769-8382-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.1.4
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48348
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

Commit 01306aeadd75 ("MIPS: prepare for user enabling of CONFIG_OF")
changed the guards in asm/prom.h from CONFIG_OF to CONFIG_USE_OF, but
missed the actual function declarations in kernel/prom.c, which have
additional dependencies.

Fixes the following build error:

  CC      arch/mips/kernel/prom.o
arch/mips/kernel/prom.c: In function '__dt_setup_arch':
arch/mips/kernel/prom.c:54:2: error: implicit declaration of function 'early_init_dt_scan' [-Werror=implicit-function-declaration]
  if (!early_init_dt_scan(bph))
  ^

Fixes: 01306aeadd75 ("MIPS: prepare for user enabling of CONFIG_OF")
Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/kernel/prom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index b130033..5fcec30 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -38,7 +38,7 @@ char *mips_get_machine_name(void)
 	return mips_machine_name;
 }
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_USE_OF
 void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 {
 	return add_memory_region(base, size, BOOT_MEM_RAM);
-- 
2.1.4
