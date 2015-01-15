From: Hemmo Nieminen <hemmo.nieminen@iki.fi>
Date: Thu, 15 Jan 2015 23:01:59 +0200
Subject: MIPS: Fix kernel lockup or crash after CPU offline/online
Message-ID: <20150115210159.OWZPpGWs8vF1BEDBc8ZxeX9N0vdPz-b4t2UCbPRDUL8@z>

commit c7754e75100ed5e3068ac5085747f2bfc386c8d6 upstream.

As printk() invocation can cause e.g. a TLB miss, printk() cannot be
called before the exception handlers have been properly initialized.
This can happen e.g. when netconsole has been loaded as a kernel module
and the TLB table has been cleared when a CPU was offline.

Call cpu_report() in start_secondary() only after the exception handlers
have been initialized to fix this.

Without the patch the kernel will randomly either lockup or crash
after a CPU is onlined and the console driver is a module.

Signed-off-by: Hemmo Nieminen <hemmo.nieminen@iki.fi>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/8953/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 0a022ee..18ed112 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -109,10 +109,10 @@ asmlinkage void start_secondary(void)
 	else
 #endif /* CONFIG_MIPS_MT_SMTC */
 	cpu_probe();
-	cpu_report();
 	per_cpu_trap_init(false);
 	mips_clockevent_init();
 	mp_ops->init_secondary();
+	cpu_report();

 	/*
 	 * XXX parity protection should be folded in here when it's converted
--
1.9.1
