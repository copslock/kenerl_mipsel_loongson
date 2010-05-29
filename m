From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 29 May 2010 13:11:08 +0200
Subject: [PATCH] mips: drop CLEAN_FILES from arch/mips/Makefile
Message-ID: <20100529111108.dfE2SfX370rTGBelRSoKGAW7Xn3wOmV52agihzWsHig@z>

Fix clean-file usage in arch/mips/boot/compressed/Makefile
With this fixed there is no need for CLEAN_FILES

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

Noticed this while browsing the mips makefiles.
I have tested this lightly (only with the ar7 platfrom).

	Sam


 arch/mips/Makefile                 |   10 ----------
 arch/mips/boot/compressed/Makefile |    4 +---
 2 files changed, 1 insertions(+), 13 deletions(-)

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
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 790ddd3..80f6de5 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -100,6 +100,4 @@ OBJCOPYFLAGS_vmlinuz.srec := $(OBJCOPYFLAGS) -S -O srec
 vmlinuz.srec: vmlinuz
 	$(call if_changed,objcopy)
 
-clean:
-clean-files += *.o \
-	       vmlinu*
+clean-files := $(objtree)/vmlinu*
-- 
1.6.0.6
