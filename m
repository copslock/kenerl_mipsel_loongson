Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2018 19:57:09 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:33134 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993874AbeFVR47l8VpO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jun 2018 19:56:59 +0200
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx27.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Fri, 22 Jun 2018 17:56:53 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Fri, 22
 Jun 2018 10:55:50 -0700
Received: from pburton-laptop.mipstec.com (10.20.2.29) by
 mipsdag02.mipstec.com (10.20.40.47) with Microsoft SMTP Server id 15.1.1415.2
 via Frontend Transport; Fri, 22 Jun 2018 10:55:50 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 3/3] MIPS: Annotate cpu_wait implementations with __cpuidle
Date:   Fri, 22 Jun 2018 10:55:47 -0700
Message-ID: <20180622175547.17716-4-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622175547.17716-1-paul.burton@mips.com>
References: <20180622175547.17716-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1529690209-637137-2582-149103-2
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194338
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: linux-mips@linux-mips.org,chenhc@lemote.com,ralf@linux-mips.org,jhogan@kernel.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Annotate cpu_wait implementations using the __cpuidle macro which
places these functions in the .cpuidle.text section. This allows
cpu_in_idle() to return true for PC values which fall within these
functions, allowing nmi_backtrace() to produce cleaner output for CPUs
running idle functions. For example:

  # echo l >/proc/sysrq-trigger
  [   38.587170] sysrq: SysRq : Show backtrace of all active CPUs
  [   38.593657] NMI backtrace for cpu 1
  [   38.597611] CPU: 1 PID: 161 Comm: sh Not tainted 4.18.0-rc1+ #27
  [   38.604306] Stack : 00000000 00000004 00000006 80486724 00000000 00000000 00000000 00000000
  [   38.613647]         80e17eda 00000034 00000000 00000000 80d20000 80b67e98 8e559c90 0ffe1e88
  [   38.622986]         00000000 00000000 80e70000 00000000 8f61db18 38312e34 722d302e 202b3163
  [   38.632324]         8e559d3c 8e559adc 00000001 6b636162 80d20000 80000000 00000000 80d1cfa4
  [   38.641664]         00000001 80d20000 80d19520 00000000 00000003 80836724 00000004 80e10004
  [   38.650993]         ...
  [   38.653724] Call Trace:
  [   38.656499] [<8040cdd0>] show_stack+0xa0/0x144
  [   38.661475] [<80b67e98>] dump_stack+0xe8/0x120
  [   38.666455] [<80b6f6d4>] nmi_cpu_backtrace+0x1b4/0x1cc
  [   38.672189] [<80b6f81c>] nmi_trigger_cpumask_backtrace+0x130/0x1e4
  [   38.679081] [<808295d8>] __handle_sysrq+0xc0/0x180
  [   38.684421] [<80829b84>] write_sysrq_trigger+0x50/0x64
  [   38.690176] [<8061c984>] proc_reg_write+0xd0/0xfc
  [   38.695447] [<805aac1c>] __vfs_write+0x54/0x194
  [   38.700500] [<805aaf24>] vfs_write+0xe0/0x18c
  [   38.705360] [<805ab190>] ksys_write+0x7c/0xf0
  [   38.710238] [<80416018>] syscall_common+0x34/0x58
  [   38.715558] Sending NMI from CPU 1 to CPUs 0,2-3:
  [   38.720916] NMI backtrace for cpu 0 skipped: idling at r4k_wait_irqoff+0x2c/0x34
  [   38.729186] NMI backtrace for cpu 3 skipped: idling at r4k_wait_irqoff+0x2c/0x34
  [   38.737449] NMI backtrace for cpu 2 skipped: idling at r4k_wait_irqoff+0x2c/0x34

Without this we get register value & backtrace output from all CPUs,
which is generally useless for those running the idle function & serves
only to overwhelm & obfuscate the meaningful output from non-idle CPUs.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: linux-mips@linux-mips.org

---

 arch/mips/kernel/idle.c       | 12 ++++++------
 arch/mips/vr41xx/common/pmu.c |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 7c246b69c545..046846999efd 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -33,21 +33,21 @@
 void (*cpu_wait)(void);
 EXPORT_SYMBOL(cpu_wait);
 
-static void r3081_wait(void)
+static void __cpuidle r3081_wait(void)
 {
 	unsigned long cfg = read_c0_conf();
 	write_c0_conf(cfg | R30XX_CONF_HALT);
 	local_irq_enable();
 }
 
-static void r39xx_wait(void)
+static void __cpuidle r39xx_wait(void)
 {
 	if (!need_resched())
 		write_c0_conf(read_c0_conf() | TX39_CONF_HALT);
 	local_irq_enable();
 }
 
-void r4k_wait(void)
+void __cpuidle r4k_wait(void)
 {
 	local_irq_enable();
 	__r4k_wait();
@@ -60,7 +60,7 @@ void r4k_wait(void)
  * interrupt is requested" restriction in the MIPS32/MIPS64 architecture makes
  * using this version a gamble.
  */
-void r4k_wait_irqoff(void)
+void __cpuidle r4k_wait_irqoff(void)
 {
 	if (!need_resched())
 		__asm__(
@@ -75,7 +75,7 @@ void r4k_wait_irqoff(void)
  * The RM7000 variant has to handle erratum 38.	 The workaround is to not
  * have any pending stores when the WAIT instruction is executed.
  */
-static void rm7k_wait_irqoff(void)
+static void __cpuidle rm7k_wait_irqoff(void)
 {
 	if (!need_resched())
 		__asm__(
@@ -96,7 +96,7 @@ static void rm7k_wait_irqoff(void)
  * since coreclock (and the cp0 counter) stops upon executing it. Only an
  * interrupt can wake it, so they must be enabled before entering idle modes.
  */
-static void au1k_wait(void)
+static void __cpuidle au1k_wait(void)
 {
 	unsigned long c0status = read_c0_status() | 1;	/* irqs on */
 
diff --git a/arch/mips/vr41xx/common/pmu.c b/arch/mips/vr41xx/common/pmu.c
index 39a0db3e2b34..16e684b59875 100644
--- a/arch/mips/vr41xx/common/pmu.c
+++ b/arch/mips/vr41xx/common/pmu.c
@@ -17,6 +17,7 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
@@ -46,7 +47,7 @@ static void __iomem *pmu_base;
 #define pmu_read(offset)		readw(pmu_base + (offset))
 #define pmu_write(offset, value)	writew((value), pmu_base + (offset))
 
-static void vr41xx_cpu_wait(void)
+static void __cpuidle vr41xx_cpu_wait(void)
 {
 	local_irq_disable();
 	if (!need_resched())
-- 
2.17.1
