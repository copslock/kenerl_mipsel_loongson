Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Mar 2015 19:06:02 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:48454 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014123AbbC1SGBdj-sx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Mar 2015 19:06:01 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 2812D5A701E;
        Sat, 28 Mar 2015 20:05:51 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id fF4JD4JpNDAK; Sat, 28 Mar 2015 20:05:46 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 0A2395BC018;
        Sat, 28 Mar 2015 20:05:57 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Wim Van Sebroeck <wim@iguana.be>,
        David Daney <david.daney@cavium.com>,
        linux-watchdog@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/3] watchdog: octeon: fix some trivial coding style issues
Date:   Sat, 28 Mar 2015 20:05:39 +0200
Message-Id: <1427565940-22951-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi>
References: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46574
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

Fix some trivial coding style issues to reduce noise from static analyzers.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/watchdog/octeon-wdt-main.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 9aa5121..728840c 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -105,10 +105,10 @@ MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-static u32 __initdata nmi_stage1_insns[64];
+static u32 nmi_stage1_insns[64] __initdata;
 /* We need one branch and therefore one relocation per target label. */
-static struct uasm_label __initdata labels[5];
-static struct uasm_reloc __initdata relocs[5];
+static struct uasm_label labels[5] __initdata;
+static struct uasm_reloc relocs[5] __initdata;
 
 enum lable_id {
 	label_enter_bootloader = 1
@@ -217,7 +217,8 @@ static void __init octeon_wdt_build_stage1(void)
 	pr_debug("\t.set pop\n");
 
 	if (len > 32)
-		panic("NMI stage 1 handler exceeds 32 instructions, was %d\n", len);
+		panic("NMI stage 1 handler exceeds 32 instructions, was %d\n",
+		      len);
 }
 
 static int cpu2core(int cpu)
@@ -293,6 +294,7 @@ static void octeon_wdt_write_hex(u64 value, int digits)
 {
 	int d;
 	int v;
+
 	for (d = 0; d < digits; d++) {
 		v = (value >> ((digits - d - 1) * 4)) & 0xf;
 		if (v >= 10)
@@ -302,7 +304,7 @@ static void octeon_wdt_write_hex(u64 value, int digits)
 	}
 }
 
-const char *reg_name[] = {
+static const char *reg_name[] = {
 	"$0", "at", "v0", "v1", "a0", "a1", "a2", "a3",
 	"a4", "a5", "a6", "a7", "t0", "t1", "t2", "t3",
 	"s0", "s1", "s2", "s3", "s4", "s5", "s6", "s7",
@@ -456,6 +458,7 @@ static int octeon_wdt_ping(struct watchdog_device __always_unused *wdog)
 		    !cpumask_test_cpu(cpu, &irq_enabled_cpus)) {
 			/* We have to enable the irq */
 			int irq = OCTEON_IRQ_WDOG0 + coreid;
+
 			enable_irq(irq);
 			cpumask_set_cpu(cpu, &irq_enabled_cpus);
 		}
@@ -573,7 +576,8 @@ static int __init octeon_wdt_init(void)
 	max_timeout_sec = 6;
 	do {
 		max_timeout_sec--;
-		timeout_cnt = ((octeon_get_io_clock_rate() >> 8) * max_timeout_sec) >> 8;
+		timeout_cnt = ((octeon_get_io_clock_rate() >> 8) *
+			      max_timeout_sec) >> 8;
 	} while (timeout_cnt > 65535);
 
 	BUG_ON(timeout_cnt == 0);
-- 
2.2.0
