From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 30 May 2010 15:16:05 +0200
Subject: [PATCH 4/6] mips: refactor arch/mips/boot/Makefile
Message-ID: <20100530131605.2W4qaKh42nYJe91erqFItfbKdEQo8LNXRhxqJpf7piQ@z>

- remove stuff that is not needed
  VMLINUX assignment, all: rule
- use hostprogs-y for the host program
- use kbuild rules for the three targets - to beautify output
- drop clean-files - it is no longer needed
- simplify arch/mips/Makefile when calling targets in boot/Makefile

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/mips/Makefile      |   11 +--------
 arch/mips/boot/Makefile |   49 ++++++++++++++++++++++------------------------
 2 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 92346d0..7098674 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -728,7 +728,6 @@ vmlinux.32: vmlinux
 vmlinux.64: vmlinux
 	$(OBJCOPY) -O $(64bit-bfd) $(OBJCOPYFLAGS) $< $@
 
-makeboot =$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) $(1)
 makezboot =$(Q)$(MAKE) $(build)=arch/mips/boot/compressed \
 	   VMLINUX_LOAD_ADDRESS=$(load-y) 32bit-bfd=$(32bit-bfd) $(1)
 
@@ -746,14 +745,8 @@ vmlinuz.ecoff: vmlinux
 vmlinuz.srec: vmlinux
 	+@$(call makezboot,$@)
 
-vmlinux.bin: $(vmlinux-32)
-	+@$(call makeboot,$@)
-
-vmlinux.ecoff: $(vmlinux-32)
-	+@$(call makeboot,$@)
-
-vmlinux.srec: $(vmlinux-32)
-	+@$(call makeboot,$@)
+vmlinux.bin vmlinux.ecoff vmlinux.srec: $(vmlinux-32) FORCE
+	$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) arch/mips/boot/$@
 
 CLEAN_FILES += vmlinux.ecoff \
 	       vmlinux.srec
diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index e39a08e..85bcb5a 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -11,35 +11,32 @@
 # Some DECstations need all possible sections of an ECOFF executable
 #
 ifdef CONFIG_MACH_DECSTATION
-  E2EFLAGS = -a
-else
-  E2EFLAGS =
+  e2eflag := -a
 endif
 
 #
 # Drop some uninteresting sections in the kernel.
 # This is only relevant for ELF kernels but doesn't hurt a.out
 #
-drop-sections	= .reginfo .mdebug .comment .note .pdr .options .MIPS.options
-strip-flags	= $(addprefix --remove-section=,$(drop-sections))
-
-VMLINUX = vmlinux
-
-all: vmlinux.ecoff vmlinux.srec
-
-vmlinux.ecoff: $(obj)/elf2ecoff $(VMLINUX)
-	$(obj)/elf2ecoff $(VMLINUX) $(obj)/vmlinux.ecoff $(E2EFLAGS)
-
-$(obj)/elf2ecoff: $(obj)/elf2ecoff.c
-	$(HOSTCC) -o $@ $^
-
-vmlinux.bin: $(VMLINUX)
-	$(OBJCOPY) -O binary $(strip-flags) $(VMLINUX) $(obj)/vmlinux.bin
-
-vmlinux.srec: $(VMLINUX)
-	$(OBJCOPY) -S -O srec $(strip-flags) $(VMLINUX) $(obj)/vmlinux.srec
-
-clean-files += elf2ecoff \
-	       vmlinux.bin \
-	       vmlinux.ecoff \
-	       vmlinux.srec
+drop-sections := .reginfo .mdebug .comment .note .pdr .options .MIPS.options
+strip-flags   := $(addprefix --remove-section=,$(drop-sections))
+
+hostprogs-y := elf2ecoff
+
+targets := vmlinux.ecoff
+quiet_cmd_ecoff = ECOFF   $@
+      cmd_ecoff = $(obj)/elf2ecoff $(VMLINUX) $@ $(e2eflag)
+$(obj)/vmlinux.ecoff: $(obj)/elf2ecoff $(VMLINUX) FORCE
+	$(call if_changed,ecoff)
+
+targets += vmlinux.bin
+quiet_cmd_bin = OBJCOPY $@
+      cmd_bin = $(OBJCOPY) -O binary $(strip-flags) $(VMLINUX) $@
+$(obj)/vmlinux.bin: $(VMLINUX) FORCE
+	$(call if_changed,bin)
+
+targets += vmlinux.srec
+quiet_cmd_srec = OBJCOPY $@
+      cmd_srec = $(OBJCOPY) -S -O srec $(strip-flags) $(VMLINUX) $@
+$(obj)/vmlinux.srec: $(VMLINUX) FORCE
+	$(call if_changed,srec)
-- 
1.6.0.6
