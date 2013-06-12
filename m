From: David Daney <david.daney@cavium.com>
Date: Wed, 12 Jun 2013 17:28:33 +0000
Subject: MIPS: Octeon: Don't clobber bootloader data structures.
Message-ID: <20130612172833.bpQCV1EIrib0NJ38Q44eXusj5oe6Obpimx9ASkG1NeQ@z>

commit d949b4fe6d23dd92b5fa48cbf7af90ca32beed2e upstream.

Commit abe77f90dc (MIPS: Octeon: Add kexec and kdump support) added a
bootmem region for the kernel image itself.  The problem is that this
is rounded up to a 0x100000 boundary, which is memory that may not be
owned by the kernel.  Depending on the kernel's configuration based
size, this 'extra' memory may contain data passed from the bootloader
to the kernel itself, which if clobbered makes the kernel crash in
various ways.

The fix: Quit rounding the size up, so that we only use memory
assigned to the kernel.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/5449/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/cavium-octeon/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index d7e0a09..1271047 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -990,7 +990,7 @@ void __init plat_mem_setup(void)
 	cvmx_bootmem_unlock();
 	/* Add the memory region for the kernel. */
 	kernel_start = (unsigned long) _text;
-	kernel_size = ALIGN(_end - _text, 0x100000);
+	kernel_size = _end - _text;

 	/* Adjust for physical offset. */
 	kernel_start &= ~0xffffffff80000000ULL;
--
1.8.1.2
