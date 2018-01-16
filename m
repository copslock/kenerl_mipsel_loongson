From: James Hogan <jhogan@kernel.org>
Date: Tue, 16 Jan 2018 21:38:24 +0000
Subject: MIPS: Fix clean of vmlinuz.{32,ecoff,bin,srec}
Message-ID: <20180116213824.Z1aVQP3uV7NKZYTefqYnQg80JwAxR5dBNjbjW92DzzI@z>

From: James Hogan <jhogan@kernel.org>


[ Upstream commit 5f2483eb2423152445b39f2db59d372f523e664e ]

Make doesn't expand shell style "vmlinuz.{32,ecoff,bin,srec}" to the 4
separate files, so none of these files get cleaned up by make clean.
List the files separately instead.

Fixes: ec3352925b74 ("MIPS: Remove all generated vmlinuz* files on "make clean"")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18491/
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/boot/compressed/Makefile |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -133,4 +133,8 @@ vmlinuz.srec: vmlinuz
 uzImage.bin: vmlinuz.bin FORCE
 	$(call if_changed,uimage,none)
 
-clean-files := $(objtree)/vmlinuz $(objtree)/vmlinuz.{32,ecoff,bin,srec}
+clean-files += $(objtree)/vmlinuz
+clean-files += $(objtree)/vmlinuz.32
+clean-files += $(objtree)/vmlinuz.ecoff
+clean-files += $(objtree)/vmlinuz.bin
+clean-files += $(objtree)/vmlinuz.srec


Patches currently in stable-queue which might be from jhogan@kernel.org are

queue-4.14/mips-generic-support-gic-in-eic-mode.patch
queue-4.14/mips-txx9-use-is_builtin-for-config_leds_class.patch
queue-4.14/mips-generic-fix-machine-compatible-matching.patch
queue-4.14/mips-fix-clean-of-vmlinuz.-32-ecoff-bin-srec.patch
