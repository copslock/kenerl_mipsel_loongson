From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Date: Wed, 23 Nov 2016 14:43:49 +0100
Subject: MIPS: fix mem=X@Y commandline processing
Message-ID: <20161123134349.HfD-cDEcS_QZAIJD_Gkz6zfyRLrcBrBEZMuQXuj6JuI@z>

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

commit 73fbc1eba7ffa3bf0ad12486232a8a1edb4e4411 upstream.

When a memory offset is specified through the commandline, add the
memory in range PHYS_OFFSET:Y as reserved memory area.
Otherwise the bootmem allocator is initialised with low page equal to
min_low_pfn = PHYS_OFFSET, and in free_all_bootmem will process pages
starting from min_low_pfn instead of PFN(Y).

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14613/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/setup.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -661,6 +661,10 @@ static int __init early_parse_mem(char *
 		start = memparse(p + 1, &p);
 
 	add_memory_region(start, size, BOOT_MEM_RAM);
+
+	if (start && start > PHYS_OFFSET)
+		add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
+				BOOT_MEM_RESERVED);
 	return 0;
 }
 early_param("mem", early_parse_mem);


Patches currently in stable-queue which might be from marcin.nowakowski@imgtec.com are

queue-4.9/irqchip-mips-gic-fix-local-interrupts.patch
queue-4.9/mips-fix-mem-x-y-commandline-processing.patch
