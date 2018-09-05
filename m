Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 01:53:53 +0200 (CEST)
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42618 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994645AbeIEXxmk86hM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Sep 2018 01:53:42 +0200
Received: by mail-oi0-f66.google.com with SMTP id k81-v6so17109774oib.9;
        Wed, 05 Sep 2018 16:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P0zRVAO6zBJ5SnemJx7PUmyeySaJr2uMusE9pIAuuk0=;
        b=eTXY4IDlAJmCpOopdoQsHGjY4oXLFAtK+QCzdXRVcMGCmw4XIDnQjo+bZatU2QVThx
         R8ThqsuN+KhNgfUKUS8Quwl+6OwDK3k53FN6KRQQy2uAPMLSY9TwbVqIIDcGcjzt1iz2
         d8zp5bGn2XMwYKgiKzopnX3Izb4Zo2J2mQyhFV8c6z2u+u5+gY+QFzViy5/IlXc+hiJi
         pu7ZxZg8bW1gyyBZuQ5cHroU+s9imU8tWsEK+ds/A8lE5XXEdjyqyGzlLL9dYOZ40NeL
         4sxyfUyxw8gbkQsP8ZE2yk9iK6LuvT/9zWWJY/GgQe2cOl4zkOSYnRiii4zYoaOf63Qx
         tYSw==
X-Gm-Message-State: APzg51AUwUW3ccrlIt8faO4YQLy9gmR7q9Ari0MVtdfcNFA3VFKGyXOA
        HCXVqj8gPyVB1ux4F5kJXw==
X-Google-Smtp-Source: ANB0VdZ2xNqzwgmUe9tFQHnlBJ6xTSrldGusI9WQF8+rSOMEk9t8sAZwRFfqQ0DNDzOecWy5UgpuIA==
X-Received: by 2002:aca:4e50:: with SMTP id c77-v6mr127253oib.254.1536191616606;
        Wed, 05 Sep 2018 16:53:36 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id h186-v6sm3860624oib.55.2018.09.05.16.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 16:53:35 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-mips@linux-mips.org,
        nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH v2 6/9] kbuild: consolidate Devicetree dtb build rules
Date:   Wed,  5 Sep 2018 18:53:24 -0500
Message-Id: <20180905235327.5996-7-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905235327.5996-1-robh@kernel.org>
References: <20180905235327.5996-1-robh@kernel.org>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

There is nothing arch specific about building dtb files other than their
location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
The dependencies and supported targets are all slightly different.
Also, a cross-compiler for each arch is needed, but really the host
compiler preprocessor is perfectly fine for building dtbs. Move the
build rules to a common location and remove the arch specific ones. This
is done in a single step to avoid warnings about overriding rules.

The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
These pull in several dependencies some of which need a target compiler
(specifically devicetable-offsets.h) and aren't needed to build dtbs.
All that is really needed is dtc, so adjust the dependencies to only be
dtc.

This change enables support 'dtbs_install' on some arches which were
missing the target.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: uclinux-h8-devel@lists.sourceforge.jp
Cc: linux-mips@linux-mips.org
Cc: nios2-dev@lists.rocketboards.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-xtensa@linux-xtensa.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack so I can take the whole series via the DT tree.

v2:
 - Fix $arch/boot/dts path check for out of tree builds
 - Fix dtc dependency for building built-in dtbs
 - Fix microblaze built-in dtb building

 Makefile                          | 32 +++++++++++++++++++++++++++++++
 arch/arc/Makefile                 |  6 ------
 arch/arm/Makefile                 | 20 +------------------
 arch/arm64/Makefile               | 17 +---------------
 arch/c6x/Makefile                 |  2 --
 arch/h8300/Makefile               | 11 +----------
 arch/microblaze/Makefile          |  4 +---
 arch/microblaze/boot/dts/Makefile |  2 ++
 arch/mips/Makefile                | 15 +--------------
 arch/nds32/Makefile               |  2 +-
 arch/nios2/Makefile               |  7 -------
 arch/nios2/boot/Makefile          |  4 ----
 arch/powerpc/Makefile             |  3 ---
 arch/xtensa/Makefile              | 12 +-----------
 scripts/Makefile.lib              |  2 +-
 15 files changed, 42 insertions(+), 97 deletions(-)

diff --git a/Makefile b/Makefile
index 2b458801ba74..bc18dbbc16c5 100644
--- a/Makefile
+++ b/Makefile
@@ -1212,6 +1212,32 @@ kselftest-merge:
 		$(srctree)/tools/testing/selftests/*/config
 	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig

+# ---------------------------------------------------------------------------
+# Devicetree files
+
+ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
+dtstree := arch/$(SRCARCH)/boot/dts
+endif
+
+ifdef CONFIG_OF_EARLY_FLATTREE
+
+%.dtb %.dtb.S %.dtb.o: | dtc
+	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
+
+PHONY += dtbs
+dtbs: | dtc
+	$(Q)$(MAKE) $(build)=$(dtstree)
+
+dtbs_install: dtbs
+	$(Q)$(MAKE) $(dtbinst)=$(dtstree)
+
+all: dtbs
+
+dtc:
+	$(Q)$(MAKE) $(build)=scripts/dtc
+
+endif
+
 # ---------------------------------------------------------------------------
 # Modules

@@ -1421,6 +1447,12 @@ help:
 	@echo  '  kselftest-merge - Merge all the config dependencies of kselftest to existing'
 	@echo  '                    .config.'
 	@echo  ''
+	@$(if $(dtstree), \
+		echo 'Devicetree:'; \
+		echo '* dtbs            - Build device tree blobs for enabled boards'; \
+		echo '  dtbs_install    - Install dtbs to $(INSTALL_DTBS_PATH)'; \
+		echo '')
+
 	@echo 'Userspace tools targets:'
 	@echo '  use "make tools/help"'
 	@echo '  or  "cd tools; make help"'
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index fb026196aaab..5c7bc6d62f43 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -132,11 +132,5 @@ boot_targets += uImage uImage.bin uImage.gz
 $(boot_targets): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@

-%.dtb %.dtb.S %.dtb.o: scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts $(boot)/dts/$@
-
-dtbs: scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts
-
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index d1516f85f25d..161c2df6567e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -307,12 +307,7 @@ else
 KBUILD_IMAGE := $(boot)/zImage
 endif

-# Build the DT binary blobs if we have OF configured
-ifeq ($(CONFIG_USE_OF),y)
-KBUILD_DTBS := dtbs
-endif
-
-all:	$(notdir $(KBUILD_IMAGE)) $(KBUILD_DTBS)
+all:	$(notdir $(KBUILD_IMAGE))


 archheaders:
@@ -339,17 +334,6 @@ $(BOOT_TARGETS): vmlinux
 $(INSTALL_TARGETS):
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@

-%.dtb: | scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) $(boot)/dts/$@
-
-PHONY += dtbs dtbs_install
-
-dtbs: prepare scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts
-
-dtbs_install:
-	$(Q)$(MAKE) $(dtbinst)=$(boot)/dts
-
 PHONY += vdso_install
 vdso_install:
 ifeq ($(CONFIG_VDSO),y)
@@ -371,8 +355,6 @@ define archhelp
   echo  '  uImage        - U-Boot wrapped zImage'
   echo  '  bootpImage    - Combined zImage and initial RAM disk'
   echo  '                  (supply initrd image via make variable INITRD=<path>)'
-  echo  '* dtbs          - Build device tree blobs for enabled boards'
-  echo  '  dtbs_install  - Install dtbs to $(INSTALL_DTBS_PATH)'
   echo  '  install       - Install uncompressed kernel'
   echo  '  zinstall      - Install compressed kernel'
   echo  '  uinstall      - Install U-Boot wrapped compressed kernel'
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 106039d25e2f..b4e994cd3a42 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -113,9 +113,8 @@ core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 # Default target when executing plain make
 boot		:= arch/arm64/boot
 KBUILD_IMAGE	:= $(boot)/Image.gz
-KBUILD_DTBS	:= dtbs

-all:	Image.gz $(KBUILD_DTBS)
+all:	Image.gz


 Image: vmlinux
@@ -127,17 +126,6 @@ Image.%: Image
 zinstall install:
 	$(Q)$(MAKE) $(build)=$(boot) $@

-%.dtb: scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts $(boot)/dts/$@
-
-PHONY += dtbs dtbs_install
-
-dtbs: prepare scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts
-
-dtbs_install:
-	$(Q)$(MAKE) $(dtbinst)=$(boot)/dts
-
 PHONY += vdso_install
 vdso_install:
 	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso $@
@@ -145,7 +133,6 @@ vdso_install:
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
-	$(Q)$(MAKE) $(clean)=$(boot)/dts

 # We need to generate vdso-offsets.h before compiling certain files in kernel/.
 # In order to do that, we should use the archprepare target, but we can't since
@@ -160,8 +147,6 @@ vdso_prepare: prepare0
 define archhelp
   echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
   echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
-  echo  '* dtbs          - Build device tree blobs for enabled boards'
-  echo  '  dtbs_install  - Install dtbs to $(INSTALL_DTBS_PATH)'
   echo  '  install       - Install uncompressed kernel'
   echo  '  zinstall      - Install compressed kernel'
   echo  '                  Install using (your) ~/bin/installkernel or'
diff --git a/arch/c6x/Makefile b/arch/c6x/Makefile
index 3fe8a948e94c..b7aa854f7008 100644
--- a/arch/c6x/Makefile
+++ b/arch/c6x/Makefile
@@ -40,9 +40,7 @@ boot := arch/$(ARCH)/boot
 DTB:=$(subst dtbImage.,,$(filter dtbImage.%, $(MAKECMDGOALS)))
 export DTB

-ifneq ($(DTB),)
 core-y	+= $(boot)/dts/
-endif

 # With make 3.82 we cannot mix normal and wildcard targets

diff --git a/arch/h8300/Makefile b/arch/h8300/Makefile
index 58634e6bae92..4003ddc616e1 100644
--- a/arch/h8300/Makefile
+++ b/arch/h8300/Makefile
@@ -31,21 +31,12 @@ CROSS_COMPILE := h8300-unknown-linux-
 endif

 core-y	+= arch/$(ARCH)/kernel/ arch/$(ARCH)/mm/
-ifneq '$(CONFIG_H8300_BUILTIN_DTB)' '""'
-core-y += arch/h8300/boot/dts/
-endif
+core-y	+= arch/$(ARCH)/boot/dts/

 libs-y	+= arch/$(ARCH)/lib/

 boot := arch/h8300/boot

-%.dtb %.dtb.S %.dtb.o: | scripts
-	$(Q)$(MAKE) $(build)=arch/h8300/boot/dts arch/h8300/boot/dts/$@
-
-PHONY += dtbs
-dtbs: scripts
-	$(Q)$(MAKE) $(build)=arch/h8300/boot/dts
-
 archmrproper:

 archclean:
diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index 4f3ab5707265..0823d291fbeb 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -65,9 +65,7 @@ boot := arch/microblaze/boot
 # Are we making a simpleImage.<boardname> target? If so, crack out the boardname
 DTB:=$(subst simpleImage.,,$(filter simpleImage.%, $(MAKECMDGOALS)))

-ifneq ($(DTB),)
-	core-y	+= $(boot)/dts/
-endif
+core-y	+= $(boot)/dts/

 # defines filename extension depending memory management type
 ifeq ($(CONFIG_MMU),)
diff --git a/arch/microblaze/boot/dts/Makefile b/arch/microblaze/boot/dts/Makefile
index 1f77913d404d..fe9af267f598 100644
--- a/arch/microblaze/boot/dts/Makefile
+++ b/arch/microblaze/boot/dts/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #

+ifneq ($(DTB),)
 obj-y += linked_dtb.o

 # Ensure system.dtb exists
@@ -11,6 +12,7 @@ ifneq ($(DTB),system)
 $(obj)/system.dtb: $(obj)/$(DTB).dtb
 	$(call if_changed,cp)
 endif
+endif

 quiet_cmd_cp = CP      $< $@$2
 	cmd_cp = cat $< >$@$2 || (rm -f $@ && echo false)
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index d74b3742fa5d..d43eeaa6d75b 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -407,18 +407,7 @@ endif
 CLEAN_FILES += vmlinux.32 vmlinux.64

 # device-trees
-core-$(CONFIG_BUILTIN_DTB) += arch/mips/boot/dts/
-
-%.dtb %.dtb.S %.dtb.o: | scripts
-	$(Q)$(MAKE) $(build)=arch/mips/boot/dts arch/mips/boot/dts/$@
-
-PHONY += dtbs
-dtbs: scripts
-	$(Q)$(MAKE) $(build)=arch/mips/boot/dts
-
-PHONY += dtbs_install
-dtbs_install:
-	$(Q)$(MAKE) $(dtbinst)=arch/mips/boot/dts
+core-y += arch/mips/boot/dts/

 archprepare:
 ifdef CONFIG_MIPS32_N32
@@ -461,8 +450,6 @@ define archhelp
 	echo '  uImage.lzma          - U-Boot image (lzma)'
 	echo '  uImage.lzo           - U-Boot image (lzo)'
 	echo '  uzImage.bin          - U-Boot image (self-extracting)'
-	echo '  dtbs                 - Device-tree blobs for enabled boards'
-	echo '  dtbs_install         - Install dtbs to $(INSTALL_DTBS_PATH)'
 	echo
 	echo '  These will be default as appropriate for a configured platform.'
 	echo
diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
index 63f4f173e5f4..adcac830d051 100644
--- a/arch/nds32/Makefile
+++ b/arch/nds32/Makefile
@@ -43,7 +43,7 @@ CHECKFLAGS      += -D__NDS32_EB__
 endif

 boot := arch/nds32/boot
-core-$(BUILTIN_DTB) += $(boot)/dts/
+core-y += $(boot)/dts/

 .PHONY: FORCE

diff --git a/arch/nios2/Makefile b/arch/nios2/Makefile
index db2e78fe65c7..52c03e60b114 100644
--- a/arch/nios2/Makefile
+++ b/arch/nios2/Makefile
@@ -56,12 +56,6 @@ all: vmImage
 archclean:
 	$(Q)$(MAKE) $(clean)=$(nios2-boot)

-%.dtb %.dtb.S %.dtb.o: | scripts
-	$(Q)$(MAKE) $(build)=$(nios2-boot)/dts $(nios2-boot)/dts/$@
-
-dtbs:
-	$(Q)$(MAKE) $(build)=$(nios2-boot)/dts
-
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(nios2-boot) $(nios2-boot)/$@

@@ -74,5 +68,4 @@ define archhelp
   echo  '                     (your) ~/bin/$(INSTALLKERNEL) or'
   echo  '                     (distribution) /sbin/$(INSTALLKERNEL) or'
   echo  '                     install to $$(INSTALL_PATH)'
-  echo  '  dtbs            - Build device tree blobs for enabled boards'
 endef
diff --git a/arch/nios2/boot/Makefile b/arch/nios2/boot/Makefile
index 0b48f1bf086d..37dfc7e584bc 100644
--- a/arch/nios2/boot/Makefile
+++ b/arch/nios2/boot/Makefile
@@ -31,9 +31,5 @@ $(obj)/zImage: $(obj)/compressed/vmlinux FORCE
 $(obj)/compressed/vmlinux: $(obj)/vmlinux.gz FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed $@

-targets += $(dtb-y)
-
-$(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
-
 install:
 	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map "$(INSTALL_PATH)"
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 53ea887eb34e..42f225f6ec93 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -293,9 +293,6 @@ $(BOOT_TARGETS2): vmlinux
 bootwrapper_install:
 	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)

-%.dtb: scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts $(patsubst %,$(boot)/dts/%,$@)
-
 # Used to create 'merged defconfigs'
 # To use it $(call) it with the first argument as the base defconfig
 # and the second argument as a space separated list of .config files to merge,
diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index 295c120ed099..13fd3301c517 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -84,28 +84,18 @@ LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 head-y		:= arch/xtensa/kernel/head.o
 core-y		+= arch/xtensa/kernel/ arch/xtensa/mm/
 core-y		+= $(buildvar) $(buildplf)
+core-y 		+= arch/xtensa/boot/dts/

 libs-y		+= arch/xtensa/lib/ $(LIBGCC)
 drivers-$(CONFIG_OPROFILE)	+= arch/xtensa/oprofile/

-ifneq ($(CONFIG_BUILTIN_DTB),"")
-core-$(CONFIG_OF) += arch/xtensa/boot/dts/
-endif
-
 boot		:= arch/xtensa/boot

 all Image zImage uImage: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $@

-%.dtb:
-	$(Q)$(MAKE) $(build)=$(boot)/dts $(boot)/dts/$@
-
-dtbs: scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts
-
 define archhelp
   @echo '* Image       - Kernel ELF image with reset vector'
   @echo '* zImage      - Compressed kernel image (arch/xtensa/boot/images/zImage.*)'
   @echo '* uImage      - U-Boot wrapped image'
-  @echo '  dtbs        - Build device tree blobs for enabled boards'
 endef
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 61e596650ed3..8fe4468f9bda 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -283,7 +283,7 @@ $(obj)/%.dtb.S: $(obj)/%.dtb FORCE

 quiet_cmd_dtc = DTC     $@
 cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
-	$(CPP) $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
+	$(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
 	$(DTC) -O dtb -o $@ -b 0 \
 		$(addprefix -i,$(dir $<) $(DTC_INCLUDE)) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
--
2.17.1
