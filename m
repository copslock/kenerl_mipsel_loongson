Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2014 00:00:43 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:39817 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860049AbaF0WAERxn3D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Jun 2014 00:00:04 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id AE7435A70CD;
        Sat, 28 Jun 2014 00:59:57 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id YD5nAbfBI2YO; Sat, 28 Jun 2014 00:59:51 +0300 (EEST)
Received: from cooljazz.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 5D1895BC01F;
        Sat, 28 Jun 2014 00:59:55 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 4/4] MIPS: OCTEON: disable HOTPLUG_CPU if the bootloader version is incorrect
Date:   Sat, 28 Jun 2014 00:59:52 +0300
Message-Id: <1403906392-10650-5-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1403906392-10650-1-git-send-email-aaro.koskinen@iki.fi>
References: <1403906392-10650-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40886
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

Disable HOTPLUG_CPU functionality if the bootloader version is incorrect.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/smp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index ea96930..ecd903d 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -88,8 +88,10 @@ static void octeon_smp_hotplug_setup(void)
 		return;
 
 	labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
-	if (labi->labi_signature != LABI_SIGNATURE)
-		panic("The bootloader version on this board is incorrect.");
+	if (labi->labi_signature != LABI_SIGNATURE) {
+		pr_info("The bootloader on this board does not support HOTPLUG_CPU.");
+		return;
+	}
 
 	octeon_bootloader_entry_addr = labi->InitTLBStart_addr;
 #endif
@@ -132,7 +134,8 @@ static void octeon_smp_setup(void)
 	 * will assign CPU numbers for possible cores as well.	Cores
 	 * are always consecutively numberd from 0.
 	 */
-	for (id = 0; setup_max_cpus && id < num_cores && id < NR_CPUS; id++) {
+	for (id = 0; setup_max_cpus && octeon_bootloader_entry_addr &&
+		     id < num_cores && id < NR_CPUS; id++) {
 		if (!(core_mask & (1 << id))) {
 			set_cpu_possible(cpus, true);
 			__cpu_number_map[id] = cpus;
@@ -232,6 +235,9 @@ static int octeon_cpu_disable(void)
 	if (cpu == 0)
 		return -EBUSY;
 
+	if (!octeon_bootloader_entry_addr)
+		return -ENOTSUPP;
+
 	set_cpu_online(cpu, false);
 	cpu_clear(cpu, cpu_callin_map);
 	local_irq_disable();
-- 
2.0.0
