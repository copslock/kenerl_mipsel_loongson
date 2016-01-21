Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 14:05:44 +0100 (CET)
Received: from smtpbgau2.qq.com ([54.206.34.216]:45131 "EHLO smtpbgau2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009614AbcAUNFm3Rixu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jan 2016 14:05:42 +0100
X-QQ-mid: bizesmtp15t1453381520t789t13
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 21 Jan 2016 21:04:54 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK70B00A0000000
X-QQ-FEAT: 6dXuswn9i1Wrv+QVta/meS8vLkkMIJOFzPweKlTzQfwOqU6lLUdKD2Z3IJb+e
        mtFDZZ5bl77tHr2zC7EIKDQwizDTKD3EKysYG9yYu4ozVhuZIdYbqXscAhNHqRcTvyVoyIU
        cUFxZzyFmTP8xSIObRm/8zUwo5ajBAYWy5iKMOnFcHVIab8OK20dxv6s0iCav2xdUJ/skJl
        lQfnfMN3Sxt01P/0cInKKwO1Z/giFljrUnII9vYEnewCyJ7ZAKhTIXqnsmwTeJGQcLM0AEo
        PUwVv6r47Osh9SglVbPKXv6TA=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, <stable@vger.kernel.org>
Subject: [PATCH V2 3/6] MIPS: Loongson-3: Fix SMP_ASK_C0COUNT IPI handler
Date:   Thu, 21 Jan 2016 21:09:49 +0800
Message-Id: <1453381793-8357-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1453381793-8357-1-git-send-email-chenhc@lemote.com>
References: <1453381793-8357-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

When Core-0 handle SMP_ASK_C0COUNT IPI, we should make other cores to
see the result as soon as possible (especially when Store-Fill-Buffer
is enabled). Otherwise, C0_Count syncronization makes no sense.

BTW, array is more suitable than per-cpu variable for syncronization,
and there is a corner case should be avoid: C0_Count of Core-0 can be
really 0.

Cc: <stable@vger.kernel.org>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
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
2.4.6
