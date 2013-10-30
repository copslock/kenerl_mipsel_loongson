Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Oct 2013 15:28:06 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:12015 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823124Ab3J3O2A5cp1L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Oct 2013 15:28:00 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: malta: Fix GIC interrupt offsets
Date:   Wed, 30 Oct 2013 14:27:48 +0000
Message-ID: <1383143268-14134-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_10_30_14_27_55
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The GIC interrupt offsets are calculated based on the value of NR_CPUS.
However, this is wrong because NR_CPUS may or may not contain the real
number of the actual cpus present in the system. We fix that by using
the 'nr_cpu_ids' variable which contains the real number of cpus in
the system. Previously, an MT core (eg with 8 VPEs) will fail to boot if
NR_CPUS was > 8 with the following errors:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/irq/chip.c:670 __irq_set_handler+0x15c/0x164()
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W    3.12.0-rc5-00087-gced5633 5
Stack : 00000006 00000004 00000000 00000000 00000000 00000000 807a4f36 00000053
          807a0000 00000000 80173218 80565aa8 00000000 00000000 00000000 0000000
          00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000000
          00000000 00000000 00000000 8054fd00 8054fd94 80500514 805657a7 8016eb4
          807a0000 80500514 00000000 00000000 80565aa8 8079a5d8 80565766 8054fd0
          ...
Call Trace:
[<801098c0>] show_stack+0x64/0x7c
[<8049c6b0>] dump_stack+0x64/0x84
[<8012efc4>] warn_slowpath_common+0x84/0xb4
[<8012f00c>] warn_slowpath_null+0x18/0x24
[<80173218>] __irq_set_handler+0x15c/0x164
[<80587cf4>] arch_init_ipiirq+0x2c/0x3c
[<805880c8>] arch_init_irq+0x3c4/0x4bc
[<80588e28>] init_IRQ+0x3c/0x50
[<805847e8>] start_kernel+0x230/0x3d8

---[ end trace 4eaa2a86a8e2da26 ]---

This is now fixed and the Malta board can boot with any NR_CPUS value
which also helps supporting more processors in a single kernel binary.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
This patch is for the upstream-sfr/mips-for-linux-next tree
---
 arch/mips/mti-malta/malta-int.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index be4a1092..0892575 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -472,7 +472,7 @@ static void __init fill_ipi_map(void)
 {
 	int cpu;
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
 		fill_ipi_map1(gic_resched_int_base, cpu, GIC_CPU_INT1);
 		fill_ipi_map1(gic_call_int_base, cpu, GIC_CPU_INT2);
 	}
@@ -573,8 +573,9 @@ void __init arch_init_irq(void)
 		/* FIXME */
 		int i;
 #if defined(CONFIG_MIPS_MT_SMP)
-		gic_call_int_base = GIC_NUM_INTRS - NR_CPUS;
-		gic_resched_int_base = gic_call_int_base - NR_CPUS;
+		gic_call_int_base = GIC_NUM_INTRS -
+			(NR_CPUS - nr_cpu_ids) * 2 - nr_cpu_ids;
+		gic_resched_int_base = gic_call_int_base - nr_cpu_ids;
 		fill_ipi_map();
 #endif
 		gic_init(GIC_BASE_ADDR, GIC_ADDRSPACE_SZ, gic_intr_map,
@@ -598,7 +599,7 @@ void __init arch_init_irq(void)
 		printk("CPU%d: status register now %08x\n", smp_processor_id(), read_c0_status());
 		write_c0_status(0x1100dc00);
 		printk("CPU%d: status register frc %08x\n", smp_processor_id(), read_c0_status());
-		for (i = 0; i < NR_CPUS; i++) {
+		for (i = 0; i < nr_cpu_ids; i++) {
 			arch_init_ipiirq(MIPS_GIC_IRQ_BASE +
 					 GIC_RESCHED_INT(i), &irq_resched);
 			arch_init_ipiirq(MIPS_GIC_IRQ_BASE +
-- 
1.8.4
