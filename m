Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 21:39:41 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:54060 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011828AbcA0UjiQfY0N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 21:39:38 +0100
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1aOWsA-0003fr-6f; Wed, 27 Jan 2016 20:39:26 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1aOWs7-0004we-Em; Wed, 27 Jan 2016 12:39:23 -0800
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Huacai Chen <chenhc@lemote.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 184/268] MIPS: Loongson-3: Fix SMP_ASK_C0COUNT IPI handler
Date:   Wed, 27 Jan 2016 12:34:05 -0800
Message-Id: <1453926929-17663-185-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1453926929-17663-1-git-send-email-kamal@canonical.com>
References: <1453926929-17663-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

4.2.8-ckt3 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: Huacai Chen <chenhc@lemote.com>

commit 5754843225f78ac7cbe142a6899890a9733a5a5d upstream.

When Core-0 handle SMP_ASK_C0COUNT IPI, we should make other cores to
see the result as soon as possible (especially when Store-Fill-Buffer
is enabled). Otherwise, C0_Count syncronization makes no sense.

BTW, array is more suitable than per-cpu variable for syncronization,
and there is a corner case should be avoid: C0_Count of Core-0 can be
really 0.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12160/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/loongson64/loongson-3/smp.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index 1a4738a..509832a9 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -30,13 +30,13 @@
 #include "smp.h"
 
 DEFINE_PER_CPU(int, cpu_state);
-DEFINE_PER_CPU(uint32_t, core0_c0count);
 
 static void *ipi_set0_regs[16];
 static void *ipi_clear0_regs[16];
 static void *ipi_status0_regs[16];
 static void *ipi_en0_regs[16];
 static void *ipi_mailbox_buf[16];
+static uint32_t core0_c0count[NR_CPUS];
 
 /* read a 32bit value from ipi register */
 #define loongson3_ipi_read32(addr) readl(addr)
@@ -275,12 +275,14 @@ void loongson3_ipi_interrupt(struct pt_regs *regs)
 	if (action & SMP_ASK_C0COUNT) {
 		BUG_ON(cpu != 0);
 		c0count = read_c0_count();
-		for (i = 1; i < num_possible_cpus(); i++)
-			per_cpu(core0_c0count, i) = c0count;
+		c0count = c0count ? c0count : 1;
+		for (i = 1; i < nr_cpu_ids; i++)
+			core0_c0count[i] = c0count;
+		__wbflush(); /* Let others see the result ASAP */
 	}
 }
 
-#define MAX_LOOPS 1111
+#define MAX_LOOPS 800
 /*
  * SMP init and finish on secondary CPUs
  */
@@ -305,16 +307,20 @@ static void loongson3_init_secondary(void)
 		cpu_logical_map(cpu) / loongson_sysconf.cores_per_package;
 
 	i = 0;
-	__this_cpu_write(core0_c0count, 0);
+	core0_c0count[cpu] = 0;
 	loongson3_send_ipi_single(0, SMP_ASK_C0COUNT);
-	while (!__this_cpu_read(core0_c0count)) {
+	while (!core0_c0count[cpu]) {
 		i++;
 		cpu_relax();
 	}
 
 	if (i > MAX_LOOPS)
 		i = MAX_LOOPS;
-	initcount = __this_cpu_read(core0_c0count) + i;
+	if (cpu_data[cpu].package)
+		initcount = core0_c0count[cpu] + i;
+	else /* Local access is faster for loops */
+		initcount = core0_c0count[cpu] + i/2;
+
 	write_c0_count(initcount);
 }
 
-- 
1.9.1
