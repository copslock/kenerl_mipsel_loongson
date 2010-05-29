From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 29 May 2010 13:11:08 +0200
Subject: [PATCH] mips: drop CLEAN_FILES from arch/mips/Makefile
Message-ID: <20100529111108.y9R6ZyDzGW4hzgjRHAe7LSWCly6lzqXxUNTLNXbkfQ4@z>

Fix clean-file usage in arch/mips/boot/compressed/Makefile
With this fixed there is no need for CLEAN_FILES

Update clean-files in arch/mips/boot/Makefile so
it only list relevant files.

Include fix from Wu Zhangjin so we do not miss any
files in arch/mips/boot/compressed

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Wu Zhangjin <wuzhangjin@gmail.com>
---

Hi Wu - thanks for spotting this bug!
Updated patch below.

	Sam

 arch/mips/Makefile                 |   10 ----------
 arch/mips/boot/Makefile            |    5 +----
 arch/mips/boot/compressed/Makefile |    7 ++++---
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 92346d0..9a94dee 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -755,9 +755,6 @@ vmlinux.ecoff: $(vmlinux-32)
 vmlinux.srec: $(vmlinux-32)
 	+@$(call makeboot,$@)
 
-CLEAN_FILES += vmlinux.ecoff \
-	       vmlinux.srec
-
 archprepare:
 ifdef CONFIG_MIPS32_N32
 	@echo '  Checking missing-syscalls for N32'
@@ -792,10 +789,3 @@ define archhelp
 	echo '  These will be default as apropriate for a configured platform.'
 endef
 
-CLEAN_FILES += vmlinux.32 \
-	       vmlinux.64 \
-	       vmlinux.ecoff \
-	       vmlinuz \
-	       vmlinuz.ecoff \
-	       vmlinuz.bin \
-	       vmlinuz.srec
diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index e39a08e..de20e81 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -39,7 +39,4 @@ vmlinux.bin: $(VMLINUX)
 vmlinux.srec: $(VMLINUX)
 	$(OBJCOPY) -S -O srec $(strip-flags) $(VMLINUX) $(obj)/vmlinux.srec
 
-clean-files += elf2ecoff \
-	       vmlinux.bin \
-	       vmlinux.ecoff \
-	       vmlinux.srec
+clean-files += elf2ecoff
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 790ddd3..223dd4d 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -100,6 +100,7 @@ OBJCOPYFLAGS_vmlinuz.srec := $(OBJCOPYFLAGS) -S -O srec
 vmlinuz.srec: vmlinuz
 	$(call if_changed,objcopy)
 
-clean:
-clean-files += *.o \
-	       vmlinu*
+# vmlinu* files created in top-level dir of the kernel
+clean-files := $(objtree)/vmlinu*
+# files created in arch/mips/boot/compressed
+clean-files += vmlinux.* piggy.o
-- 
1.6.0.6
