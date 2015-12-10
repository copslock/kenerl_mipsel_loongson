Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Dec 2015 10:57:36 +0100 (CET)
Received: from smtp5-g21.free.fr ([212.27.42.5]:60511 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013517AbbLJJ5e2goLh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Dec 2015 10:57:34 +0100
Received: from localhost.localdomain (unknown [176.4.102.236])
        (Authenticated sender: albeu)
        by smtp5-g21.free.fr (Postfix) with ESMTPA id 007ECD4803E;
        Thu, 10 Dec 2015 10:56:18 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Alban Bedel <albeu@free.fr>, Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] MIPS: zboot: Avoid useless rebuilds
Date:   Thu, 10 Dec 2015 10:57:20 +0100
Message-Id: <1449741444-29110-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Add dummy.o to the targets list, and fill targets automatically from
$(vmlinuzobjs) to avoid having to maintain two lists.

When building with XZ compression copy ashldi3.c to the build
directory to use a different object file for the kernel and zboot.
Without this the same object file need to be build with different
flags which cause a rebuild at every run.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/boot/compressed/Makefile | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index d5bdee1..e66b2c6 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -29,8 +29,6 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
 	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
 
-targets := head.o decompress.o string.o dbg.o uart-16550.o uart-alchemy.o
-
 # decompressor objects (linked with vmlinuz)
 vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o
 
@@ -40,9 +38,13 @@ vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
 vmlinuzobjs-$(CONFIG_MIPS_ALCHEMY)		   += $(obj)/uart-alchemy.o
 endif
 
-ifdef CONFIG_KERNEL_XZ
-vmlinuzobjs-y += $(obj)/../../lib/ashldi3.o
-endif
+vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o
+
+$(obj)/ashldi3.o: KBUILD_CFLAGS += -I$(srctree)/arch/mips/lib
+$(obj)/ashldi3.c: $(srctree)/arch/mips/lib/ashldi3.c
+	$(call cmd,shipped)
+
+targets := $(notdir $(vmlinuzobjs-y))
 
 targets += vmlinux.bin
 OBJCOPYFLAGS_vmlinux.bin := $(OBJCOPYFLAGS) -O binary -R .comment -S
@@ -60,7 +62,7 @@ targets += vmlinux.bin.z
 $(obj)/vmlinux.bin.z: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,$(tool_y))
 
-targets += piggy.o
+targets += piggy.o dummy.o
 OBJCOPYFLAGS_piggy.o := --add-section=.image=$(obj)/vmlinux.bin.z \
 			--set-section-flags=.image=contents,alloc,load,readonly,data
 $(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.bin.z FORCE
-- 
2.0.0
