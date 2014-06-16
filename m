Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2014 22:06:49 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:58482 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859971AbaFPUGqp3M4s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jun 2014 22:06:46 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 27FAF21B947;
        Mon, 16 Jun 2014 23:06:44 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id Bv1p01ufGrof; Mon, 16 Jun 2014 23:06:37 +0300 (EEST)
Received: from cooljazz.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id 7EF125BC009;
        Mon, 16 Jun 2014 23:06:37 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/3] MIPS: OCTEON: SMP: delete redundant check
Date:   Mon, 16 Jun 2014 23:06:28 +0300
Message-Id: <1402949190-28182-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.0.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40530
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

The same check is already done earlier in octeon_smp_hotplug_setup().

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/smp.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index a7b3ae1..2c8d156 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -192,14 +192,6 @@ static void octeon_init_secondary(void)
  */
 void octeon_prepare_cpus(unsigned int max_cpus)
 {
-#ifdef CONFIG_HOTPLUG_CPU
-	struct linux_app_boot_info *labi;
-
-	labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
-
-	if (labi->labi_signature != LABI_SIGNATURE)
-		panic("The bootloader version on this board is incorrect.");
-#endif
 	/*
 	 * Only the low order mailbox bits are used for IPIs, leave
 	 * the other bits alone.
-- 
2.0.0
