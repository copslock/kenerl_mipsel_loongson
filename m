From: David Daney <david.daney@cavium.com>
Date: Tue, 6 Jan 2015 10:42:23 -0800
Subject: MIPS: Fix C0_Pagegrain[IEC] support.
Message-ID: <20150106184223.rJvGQdkpYu06wWr3LtcTUpyGgJAlgJHUX6uzrY3vs6M@z>

commit 9ead8632bbf454cfc709b6205dc9cd8582fb0d64 upstream.

The following commits:

  5890f70f15c52d (MIPS: Use dedicated exception handler if CPU supports RI/XI exceptions)
  6575b1d4173eae (MIPS: kernel: cpu-probe: Detect unique RI/XI exceptions)

break the kernel for *all* existing MIPS CPUs that implement the
CP0_PageGrain[IEC] bit.  They cause the TLB exception handlers to be
generated without the legacy execute-inhibit handling, but never set
the CP0_PageGrain[IEC] bit to activate the use of dedicated exception
vectors for execute-inhibit exceptions.  The result is that upon
detection of an execute-inhibit violation, we loop forever in the TLB
exception handlers instead of sending SIGSEGV to the task.

If we are generating TLB exception handlers expecting separate
vectors, we must also enable the CP0_PageGrain[IEC] feature.

The bug was introduced in kernel version 3.17.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: http://patchwork.linux-mips.org/patch/8880/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/mm/tlb-r4k.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index da3b0b9..d04fe4e 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -429,6 +429,8 @@ void tlb_init(void)
 #ifdef CONFIG_64BIT
 		pg |= PG_ELPA;
 #endif
+		if (cpu_has_rixiex)
+			pg |= PG_IEC;
 		write_c0_pagegrain(pg);
 	}

--
1.9.1
