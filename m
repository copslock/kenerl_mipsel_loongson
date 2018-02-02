From: James Hogan <jhogan@kernel.org>
Date: Fri, 2 Feb 2018 22:14:09 +0000
Subject: MIPS: generic: Fix machine compatible matching
Message-ID: <20180202221409.UgGQ2U1qMmEzIBsIIZ_fhH70zHGFAg97wKrty8EThUM@z>

From: James Hogan <jhogan@kernel.org>

[ Upstream commit 9a9ab3078e2744a1a55163cfaec73a5798aae33e ]

We now have a platform (Ranchu) in the "generic" platform which matches
based on the FDT compatible string using mips_machine_is_compatible(),
however that function doesn't stop at a blank struct
of_device_id::compatible as that is an array in the struct, not a
pointer to a string.

Fix the loop completion to check the first byte of the compatible array
rather than the address of the compatible array in the struct.

Fixes: eed0eabd12ef ("MIPS: generic: Introduce generic DT-based board support")
Signed-off-by: James Hogan <jhogan@kernel.org>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18580/
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/machine.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/machine.h
+++ b/arch/mips/include/asm/machine.h
@@ -52,7 +52,7 @@ mips_machine_is_compatible(const struct
 	if (!mach->matches)
 		return NULL;
 
-	for (match = mach->matches; match->compatible; match++) {
+	for (match = mach->matches; match->compatible[0]; match++) {
 		if (fdt_node_check_compatible(fdt, 0, match->compatible) == 0)
 			return match;
 	}


Patches currently in stable-queue which might be from jhogan@kernel.org are

queue-4.9/mips-ptrace-expose-fir-register-through-fp-regset.patch
queue-4.9/mips-ath79-fix-ar724x_pll_reg_pcie_config-offset.patch
queue-4.9/mips-txx9-use-is_builtin-for-config_leds_class.patch
queue-4.9/mips-octeon-fix-logging-messages-with-spurious-periods-after-newlines.patch
queue-4.9/mips-generic-fix-machine-compatible-matching.patch
queue-4.9/mips-fix-ptrace-2-ptrace_peekusr-and-ptrace_pokeusr-accesses-to-o32-fgrs.patch
queue-4.9/kvm-fix-spelling-mistake-cop_unsuable-cop_unusable.patch
queue-4.9/mips-c-r4k-fix-data-corruption-related-to-cache-coherence.patch
