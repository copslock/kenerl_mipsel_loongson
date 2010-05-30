From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 30 May 2010 15:44:09 +0200
Subject: [PATCH 5/6] mips: refactor arch/mips/boot/compressed/Makefile
Message-ID: <20100530134409.1KPKpg82did0PfgxA2Xk5-GS8360wzZDp6CTboKqO-E@z>

- use hostprogs-y for the elf2ecoff
- list all *.o file in targets
- renamed obj-y to vmlinuzobjs-y (it was confusing to re-use a kbuild variable)
- fix all uses of if_changed/cmd
- use kbuild rules to beautify output
- update clean-file to clean vmlinuz.* in top-level directory

- simplied logic in arch/mips/Makefile for compressed targets

The net result is a more kbuild conformant Makefile but
readability did not increase.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/mips/Makefile                 |   22 ++++----------
 arch/mips/boot/compressed/Makefile |   54 +++++++++++++++++++----------------
 2 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 7098674..eaed885 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -728,26 +728,18 @@ vmlinux.32: vmlinux
 vmlinux.64: vmlinux
 	$(OBJCOPY) -O $(64bit-bfd) $(OBJCOPYFLAGS) $< $@
 
-makezboot =$(Q)$(MAKE) $(build)=arch/mips/boot/compressed \
-	   VMLINUX_LOAD_ADDRESS=$(load-y) 32bit-bfd=$(32bit-bfd) $(1)
-
 all:	$(all-y)
 
-vmlinuz: vmlinux FORCE
-	+@$(call makezboot,$@)
-
-vmlinuz.bin: vmlinux
-	+@$(call makezboot,$@)
-
-vmlinuz.ecoff: vmlinux
-	+@$(call makezboot,$@)
-
-vmlinuz.srec: vmlinux
-	+@$(call makezboot,$@)
-
+# boot
 vmlinux.bin vmlinux.ecoff vmlinux.srec: $(vmlinux-32) FORCE
 	$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) arch/mips/boot/$@
 
+# boot/compressed
+vmlinuz vmlinuz.bin vmlinuz.ecoff vmlinuz.srec: $(vmlinux-32) FORCE
+	$(Q)$(MAKE) $(build)=arch/mips/boot/compressed \
+	   VMLINUX_LOAD_ADDRESS=$(load-y) 32bit-bfd=$(32bit-bfd) $@
+
+
 CLEAN_FILES += vmlinux.ecoff \
 	       vmlinux.srec
 
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 790ddd3..74a52d7 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -33,15 +33,19 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
 	-DKERNEL_ENTRY=0x$(shell $(NM) $(objtree)/$(KBUILD_IMAGE) 2>/dev/null | grep " kernel_entry" | cut -f1 -d \ )
 
-obj-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
+targets := head.o decompress.o dbg.o uart-16550.o uart-alchemy.o
+
+# decompressor objects (linked with vmlinuz)
+vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
 
 ifdef CONFIG_DEBUG_ZBOOT
-obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
-obj-$(CONFIG_MACH_ALCHEMY)		   += $(obj)/uart-alchemy.o
+vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
+vmlinuzobjs-$(CONFIG_MACH_ALCHEMY)		   += $(obj)/uart-alchemy.o
 endif
 
+targets += vmlinux.bin
 OBJCOPYFLAGS_vmlinux.bin := $(OBJCOPYFLAGS) -O binary -R .comment -S
-$(obj)/vmlinux.bin: $(KBUILD_IMAGE)
+$(obj)/vmlinux.bin: $(KBUILD_IMAGE) FORCE
 	$(call if_changed,objcopy)
 
 suffix_$(CONFIG_KERNEL_GZIP)  = gz
@@ -52,30 +56,31 @@ tool_$(CONFIG_KERNEL_GZIP)    = gzip
 tool_$(CONFIG_KERNEL_BZIP2)   = bzip2
 tool_$(CONFIG_KERNEL_LZMA)    = lzma
 tool_$(CONFIG_KERNEL_LZO)     = lzo
-$(obj)/vmlinux.$(suffix_y): $(obj)/vmlinux.bin
+
+targets += vmlinux.gz vmlinux.bz2 vmlinux.lzma vmlinux.lzo
+$(obj)/vmlinux.$(suffix_y): $(obj)/vmlinux.bin FORCE
 	$(call if_changed,$(tool_y))
 
-$(obj)/piggy.o: $(obj)/vmlinux.$(suffix_y) $(obj)/dummy.o
-	$(Q)$(OBJCOPY) $(OBJCOPYFLAGS) \
-		--add-section=.image=$< \
-		--set-section-flags=.image=contents,alloc,load,readonly,data \
-		$(obj)/dummy.o $@
+targets += piggy.o
+OBJCOPYFLAGS_piggy.o := --add-section=.image=$(obj)/vmlinux.$(suffix_y) \
+                        --set-section-flags=.image=contents,alloc,load,readonly,data
+$(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.$(suffix_y) FORCE
+	$(call if_changed,objcopy)
 
 LDFLAGS_vmlinuz := $(LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T
-vmlinuz: $(src)/ld.script $(obj-y) $(obj)/piggy.o
-	$(call if_changed,ld)
+vmlinuz: $(src)/ld.script $(vmlinuzobjs-y) $(obj)/piggy.o
+	$(call cmd,ld)
 	$(Q)$(OBJCOPY) $(OBJCOPYFLAGS) $@
 
 #
 # Some DECstations need all possible sections of an ECOFF executable
 #
 ifdef CONFIG_MACH_DECSTATION
-  E2EFLAGS = -a
-else
-  E2EFLAGS =
+  e2eflag := -a
 endif
 
 # elf2ecoff can only handle 32bit image
+hostprogs-y := ../elf2ecoff
 
 ifdef CONFIG_32BIT
 	VMLINUZ = vmlinuz
@@ -83,23 +88,22 @@ else
 	VMLINUZ = vmlinuz.32
 endif
 
+quiet_cmd_32 = OBJCOPY $@
+      cmd_32 = $(OBJCOPY) -O $(32bit-bfd) $(OBJCOPYFLAGS) $< $@
 vmlinuz.32: vmlinuz
-	$(Q)$(OBJCOPY) -O $(32bit-bfd) $(OBJCOPYFLAGS) $< $@
+	$(call cmd,32)
 
+quiet_cmd_ecoff = ECOFF   $@
+      cmd_ecoff = $< $(VMLINUZ) $@ $(e2eflag)
 vmlinuz.ecoff: $(obj)/../elf2ecoff $(VMLINUZ)
-	$(Q)$(obj)/../elf2ecoff $(VMLINUZ) vmlinuz.ecoff $(E2EFLAGS)
-
-$(obj)/../elf2ecoff: $(src)/../elf2ecoff.c
-	$(Q)$(HOSTCC) -o $@ $^
+	$(call cmd,ecoff)
 
 OBJCOPYFLAGS_vmlinuz.bin := $(OBJCOPYFLAGS) -O binary
 vmlinuz.bin: vmlinuz
-	$(call if_changed,objcopy)
+	$(call cmd,objcopy)
 
 OBJCOPYFLAGS_vmlinuz.srec := $(OBJCOPYFLAGS) -S -O srec
 vmlinuz.srec: vmlinuz
-	$(call if_changed,objcopy)
+	$(call cmd,objcopy)
 
-clean:
-clean-files += *.o \
-	       vmlinu*
+clean-files := $(objtree)/vmlinuz.*
-- 
1.6.0.6
