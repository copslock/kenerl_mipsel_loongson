From: Nicholas Mc Guire <hofrat@osadl.org>
Date: Wed, 11 Jul 2018 20:32:45 +0200
Subject: MIPS: generic: fix missing of_node_put()
Message-ID: <20180711183245.LoT9ZzUuQ0Qb52U6_VNYV4zSxsE2n0qdHFa7ptq9uj8@z>

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 28ec2238f37e72a3a40a7eb46893e7651bcc40a6 ]

of_find_compatible_node() returns a device_node pointer with refcount
incremented and must be decremented explicitly.
 As this code is using the result only to check presence of the interrupt
controller (!NULL) but not actually using the result otherwise the
refcount can be decremented here immediately again.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19820/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/generic/init.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -159,6 +159,7 @@ void __init arch_init_irq(void)
 					    "mti,cpu-interrupt-controller");
 	if (!cpu_has_veic && !intc_node)
 		mips_cpu_irq_init();
+	of_node_put(intc_node);
 
 	irqchip_init();
 }


Patches currently in stable-queue which might be from hofrat@osadl.org are

queue-4.9/mips-generic-fix-missing-of_node_put.patch
queue-4.9/mips-octeon-add-missing-of_node_put.patch
