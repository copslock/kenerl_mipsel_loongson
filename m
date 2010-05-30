From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 30 May 2010 16:00:38 +0200
Subject: [PATCH 6/6] mips: clean up arch/mips/Makefile
Message-ID: <20100530140038.708usIlBID-SlC2nWgg8eVqwfFb23DhKDs2Zgo4CHN4@z>

- Drop CLEAN_FILES assignments that is no longer required
- Add $(Q) in a few rules

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/mips/Makefile |   17 ++++-------------
 1 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index eaed885..c2e1068 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -740,8 +740,7 @@ vmlinuz vmlinuz.bin vmlinuz.ecoff vmlinuz.srec: $(vmlinux-32) FORCE
 	   VMLINUX_LOAD_ADDRESS=$(load-y) 32bit-bfd=$(32bit-bfd) $@
 
 
-CLEAN_FILES += vmlinux.ecoff \
-	       vmlinux.srec
+CLEAN_FILES += vmlinux.32 vmlinux.64
 
 archprepare:
 ifdef CONFIG_MIPS32_N32
@@ -760,9 +759,9 @@ install:
 	$(Q)install -D -m 644 System.map $(INSTALL_PATH)/System.map-$(KERNELRELEASE)
 
 archclean:
-	@$(MAKE) $(clean)=arch/mips/boot
-	@$(MAKE) $(clean)=arch/mips/boot/compressed
-	@$(MAKE) $(clean)=arch/mips/lasat
+	$(Q)$(MAKE) $(clean)=arch/mips/boot
+	$(Q)$(MAKE) $(clean)=arch/mips/boot/compressed
+	$(Q)$(MAKE) $(clean)=arch/mips/lasat
 
 define archhelp
 	echo '  install              - install kernel into $(INSTALL_PATH)'
@@ -776,11 +775,3 @@ define archhelp
 	echo
 	echo '  These will be default as apropriate for a configured platform.'
 endef
-
-CLEAN_FILES += vmlinux.32 \
-	       vmlinux.64 \
-	       vmlinux.ecoff \
-	       vmlinuz \
-	       vmlinuz.ecoff \
-	       vmlinuz.bin \
-	       vmlinuz.srec
-- 
1.6.0.6
