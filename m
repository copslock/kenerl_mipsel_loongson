Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Aug 2013 17:44:59 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:47283 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823569Ab3H3Pnypvsrx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Aug 2013 17:43:54 +0200
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH v2 2/3] MIPS: refactor load/entry address calculations
Date:   Fri, 30 Aug 2013 16:42:41 +0100
Message-ID: <1377877362-15650-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1377877362-15650-1-git-send-email-james.hogan@imgtec.com>
References: <1377877362-15650-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2013_08_30_16_43_06
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The vmlinux load address and entry address is calculated in multiple
places:
 - arch/mips/Makefile defines load-y from CONFIG_PHYSICAL_START (or
   defined by the platform) and passes it to
   arch/mips/boot/compressed/Makefile.
 - arch/mips/boot/compressed/Makefile calculates kernel entry using nm.
 - arch/mips/lasat/image/Makefile calculates both load and entry address
   using nm.

Lets combine these in the main Makefile and then pass them as Make
parameters to each of the three boot image Makefiles (in boot/,
boot/compressed, lasat/image/). The boot/ Makefile doesn't currently use
them, but will soon need to for U-Boot image targets.

The existing load-y definition is used in preference to calculating the
load address using nm.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Makefile                 | 13 ++++++++++---
 arch/mips/boot/compressed/Makefile |  2 +-
 arch/mips/lasat/image/Makefile     |  6 ++----
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 8be2f89..62311c7 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -198,6 +198,8 @@ include $(srctree)/arch/mips/Kbuild.platforms
 ifdef CONFIG_PHYSICAL_START
 load-y					= $(CONFIG_PHYSICAL_START)
 endif
+entry-y				= 0x$(shell $(NM) vmlinux 2>/dev/null \
+					| grep "\bkernel_entry\b" | cut -f1 -d \ )
 
 cflags-y			+= -I$(srctree)/arch/mips/include/asm/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/
@@ -229,6 +231,9 @@ KBUILD_CFLAGS	+= $(cflags-y)
 KBUILD_CPPFLAGS += -DVMLINUX_LOAD_ADDRESS=$(load-y)
 KBUILD_CPPFLAGS += -DDATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)
 
+bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y) \
+		  VMLINUX_ENTRY_ADDRESS=$(entry-y)
+
 LDFLAGS			+= -m $(ld-emul)
 
 ifdef CONFIG_CC_STACKPROTECTOR
@@ -271,7 +276,8 @@ bootz-y			+= vmlinuz.srec
 
 ifdef CONFIG_LASAT
 rom.bin rom.sw: vmlinux
-	$(Q)$(MAKE) $(build)=arch/mips/lasat/image $@
+	$(Q)$(MAKE) $(build)=arch/mips/lasat/image \
+		$(bootvars-y) $@
 endif
 
 #
@@ -296,12 +302,13 @@ all:	$(all-y)
 
 # boot
 $(boot-y): $(vmlinux-32) FORCE
-	$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) arch/mips/boot/$@
+	$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) \
+		$(bootvars-y) arch/mips/boot/$@
 
 # boot/compressed
 $(bootz-y): $(vmlinux-32) FORCE
 	$(Q)$(MAKE) $(build)=arch/mips/boot/compressed \
-	   VMLINUX_LOAD_ADDRESS=$(load-y) 32bit-bfd=$(32bit-bfd) $@
+		$(bootvars-y) 32bit-bfd=$(32bit-bfd) $@
 
 
 CLEAN_FILES += vmlinux.32 vmlinux.64
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index bb1dbf4..0048c08 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -25,7 +25,7 @@ KBUILD_CFLAGS := $(LINUXINCLUDE) $(KBUILD_CFLAGS) -D__KERNEL__ \
 
 KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
-	-DKERNEL_ENTRY=0x$(shell $(NM) $(objtree)/$(KBUILD_IMAGE) 2>/dev/null | grep " kernel_entry" | cut -f1 -d \ )
+	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
 
 targets := head.o decompress.o dbg.o uart-16550.o uart-alchemy.o
 
diff --git a/arch/mips/lasat/image/Makefile b/arch/mips/lasat/image/Makefile
index dfb509d..fd32075 100644
--- a/arch/mips/lasat/image/Makefile
+++ b/arch/mips/lasat/image/Makefile
@@ -13,13 +13,11 @@ endif
 MKLASATIMG = mklasatimg
 MKLASATIMG_ARCH = mq2,mqpro,sp100,sp200
 KERNEL_IMAGE = vmlinux
-KERNEL_START = $(shell $(NM) $(KERNEL_IMAGE) | grep " _text" | cut -f1 -d\ )
-KERNEL_ENTRY = $(shell $(NM) $(KERNEL_IMAGE) | grep kernel_entry | cut -f1 -d\ )
 
 LDSCRIPT= -L$(srctree)/$(src) -Tromscript.normal
 
-HEAD_DEFINES := -D_kernel_start=0x$(KERNEL_START) \
-		-D_kernel_entry=0x$(KERNEL_ENTRY) \
+HEAD_DEFINES := -D_kernel_start=$(VMLINUX_LOAD_ADDRESS) \
+		-D_kernel_entry=$(VMLINUX_ENTRY_ADDRESS) \
 		-D VERSION="\"$(Version)\"" \
 		-D TIMESTAMP=$(shell date +%s)
 
-- 
1.8.1.2
