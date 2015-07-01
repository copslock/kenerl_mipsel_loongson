From: Markos Chandras <markos.chandras@imgtec.com>
Date: Wed, 1 Jul 2015 09:13:28 +0100
Subject: MIPS: kernel: smp-cps: Fix 64-bit compatibility errors due to pointer
 casting
Message-ID: <20150701081328.z7yN9u2mV3E2DrQCOn3z7T96uAWClw2ppURXe45Arz4@z>

commit fd5ed3066bb2f47814fe53cdc56d11a678551ae1 upstream.

Commit 1d8f1f5a780a ("MIPS: smp-cps: hotplug support") added hotplug
support in the SMP/CPS implementation but it introduced a few build problems
on 64-bit kernels due to pointer being casted to and from 'int' C types. We
fix this problem by using 'unsigned long' instead which should match the size
of the pointers in 32/64-bit kernels. Finally, we fix the comment since the
CM base address is loaded to v1($3) instead of v0.

Fixes the following build problems:

arch/mips/kernel/smp-cps.c: In function 'wait_for_sibling_halt':
arch/mips/kernel/smp-cps.c:366:17: error: cast from pointer to integer of
different size [-Werror=pointer-to-int-cast]
[...]
arch/mips/kernel/smp-cps.c: In function 'cps_cpu_die':
arch/mips/kernel/smp-cps.c:427:13: error: cast to pointer
from integer of different size [-Werror=int-to-pointer-cast]

cc1: all warnings being treated as errors

Fixes: 1d8f1f5a780a ("MIPS: smp-cps: hotplug support")
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10586/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/smp-cps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index bed7590..81012b9 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -127,7 +127,7 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 	/*
 	 * Patch the start of mips_cps_core_entry to provide:
 	 *
-	 * v0 = CM base address
+	 * v1 = CM base address
 	 * s0 = kseg0 CCA
 	 */
 	entry_code = (u32 *)&mips_cps_core_entry;
@@ -363,7 +363,7 @@ void play_dead(void)

 static void wait_for_sibling_halt(void *ptr_cpu)
 {
-	unsigned cpu = (unsigned)ptr_cpu;
+	unsigned cpu = (unsigned long)ptr_cpu;
 	unsigned vpe_id = cpu_vpe_id(&cpu_data[cpu]);
 	unsigned halted;
 	unsigned long flags;
@@ -424,7 +424,7 @@ static void cps_cpu_die(unsigned int cpu)
 		 */
 		err = smp_call_function_single(cpu_death_sibling,
 					       wait_for_sibling_halt,
-					       (void *)cpu, 1);
+					       (void *)(unsigned long)cpu, 1);
 		if (err)
 			panic("Failed to call remote sibling CPU\n");
 	}
--
1.9.1
