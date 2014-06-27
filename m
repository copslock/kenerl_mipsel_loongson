Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2014 00:01:19 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:43824 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859959AbaF0WACaH18l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Jun 2014 00:00:02 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id DA25619C019;
        Sat, 28 Jun 2014 01:00:01 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id 3butGfu7JChA; Sat, 28 Jun 2014 00:59:55 +0300 (EEST)
Received: from cooljazz.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 481CA5BC01E;
        Sat, 28 Jun 2014 00:59:55 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 3/4] MIPS: OCTEON: support disabling HOTPLUG_CPU run-time
Date:   Sat, 28 Jun 2014 00:59:51 +0300
Message-Id: <1403906392-10650-4-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1403906392-10650-1-git-send-email-aaro.koskinen@iki.fi>
References: <1403906392-10650-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40888
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

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/smp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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
-- 
2.0.0
