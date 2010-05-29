From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 29 May 2010 21:50:50 +0200
Subject: [PATCH] mips: refactor arch/mips/boot/Makefile
Message-ID: <20100529195050.x4RO8pIB4LjDxz8Jl1hzLcN_JM9JjfJ5veFhxZxwdaI@z>

- remove stuff that is not needed
  VMLINUX assignment, all: rule, unused assignment
- use hostprogs-y for the host program
- use direct assignmnet when possible
- use kbuild rules for the three targets - to beautify output
- update clean-files to specify the targets that is built in the top.level dir

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/mips/boot/Makefile |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index de20e81..28dbf92 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -11,32 +11,32 @@
 # Some DECstations need all possible sections of an ECOFF executable
 #
 ifdef CONFIG_MACH_DECSTATION
-  E2EFLAGS = -a
-else
-  E2EFLAGS =
+  E2EFLAGS := -a
 endif
 
 #
 # Drop some uninteresting sections in the kernel.
 # This is only relevant for ELF kernels but doesn't hurt a.out
 #
-drop-sections	= .reginfo .mdebug .comment .note .pdr .options .MIPS.options
-strip-flags	= $(addprefix --remove-section=,$(drop-sections))
+drop-sections := .reginfo .mdebug .comment .note .pdr .options .MIPS.options
+strip-flags   := $(addprefix --remove-section=,$(drop-sections))
 
-VMLINUX = vmlinux
-
-all: vmlinux.ecoff vmlinux.srec
+hostprogs-y := elf2ecoff
 
+quiet_cmd_ecoff = ECOFF   $@
+      cmd_ecoff = $(obj)/elf2ecoff $(VMLINUX) $(obj)/vmlinux.ecoff $(E2EFLAGS)
 vmlinux.ecoff: $(obj)/elf2ecoff $(VMLINUX)
-	$(obj)/elf2ecoff $(VMLINUX) $(obj)/vmlinux.ecoff $(E2EFLAGS)
-
-$(obj)/elf2ecoff: $(obj)/elf2ecoff.c
-	$(HOSTCC) -o $@ $^
+	$(call cmd,ecoff)
 
+quiet_cmd_bin = OBJCOPY $@
+      cmd_bin = $(OBJCOPY) -O binary $(strip-flags) $(VMLINUX) $(obj)/vmlinux.bin
 vmlinux.bin: $(VMLINUX)
-	$(OBJCOPY) -O binary $(strip-flags) $(VMLINUX) $(obj)/vmlinux.bin
+	$(call cmd,bin)
 
+quiet_cmd_srec = OBJCOPY $@
+      cmd_srec = $(OBJCOPY) -S -O srec $(strip-flags) $(VMLINUX) $(obj)/vmlinux.srec
 vmlinux.srec: $(VMLINUX)
-	$(OBJCOPY) -S -O srec $(strip-flags) $(VMLINUX) $(obj)/vmlinux.srec
+	$(call cmd,srec)
 
-clean-files += elf2ecoff
+# clean files created in top-level directory
+clean-files := $(objtree)/vmlinux.*
-- 
1.6.0.6
