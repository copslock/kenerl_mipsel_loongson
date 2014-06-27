Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2014 00:00:25 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:39812 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860048AbaF0WACvoXs1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Jun 2014 00:00:02 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 932195A70C2;
        Sat, 28 Jun 2014 00:59:56 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id HF0fRQ3Mopf0; Sat, 28 Jun 2014 00:59:50 +0300 (EEST)
Received: from cooljazz.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 1C2D05BC01B;
        Sat, 28 Jun 2014 00:59:55 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 1/4] MIPS: OCTEON: SMP: delete redundant check
Date:   Sat, 28 Jun 2014 00:59:49 +0300
Message-Id: <1403906392-10650-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1403906392-10650-1-git-send-email-aaro.koskinen@iki.fi>
References: <1403906392-10650-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40885
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
Acked-by: David Daney <david.daney@cavium.com>
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
