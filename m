From: Dengcheng Zhu <dzhu@wavecomp.com>
Date: Tue, 11 Sep 2018 14:49:20 -0700
Subject: MIPS: kexec: Mark CPU offline before disabling local IRQ
Message-ID: <20180911214920.4lT57SAgglagxva5dablmrftDafuGiD7vP3W6rrTryg@z>

From: Dengcheng Zhu <dzhu@wavecomp.com>

[ Upstream commit dc57aaf95a516f70e2d527d8287a0332c481a226 ]

After changing CPU online status, it will not be sent any IPIs such as in
__flush_cache_all() on software coherency systems. Do this before disabling
local IRQ.

Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20571/
Cc: pburton@wavecomp.com
Cc: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Cc: rachel.mozes@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/crash.c         |    3 +++
 arch/mips/kernel/machine_kexec.c |    3 +++
 2 files changed, 6 insertions(+)

--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -34,6 +34,9 @@ static void crash_shutdown_secondary(voi
 	if (!cpu_online(cpu))
 		return;
 
+	/* We won't be sent IPIs any more. */
+	set_cpu_online(cpu, false);
+
 	local_irq_disable();
 	if (!cpumask_test_cpu(cpu, &cpus_in_crash))
 		crash_save_cpu(regs, cpu);
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -96,6 +96,9 @@ machine_kexec(struct kimage *image)
 			*ptr = (unsigned long) phys_to_virt(*ptr);
 	}
 
+	/* Mark offline BEFORE disabling local irq. */
+	set_cpu_online(smp_processor_id(), false);
+
 	/*
 	 * we do not want to be bothered.
 	 */


Patches currently in stable-queue which might be from dzhu@wavecomp.com are

queue-4.9/mips-kexec-mark-cpu-offline-before-disabling-local-irq.patch
