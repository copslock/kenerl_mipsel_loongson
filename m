Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 13:49:18 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:49654 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010454AbcAWMtGgj90I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jan 2016 13:49:06 +0100
Received: from localhost.localdomain (unknown [78.54.16.94])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 082ECA6228;
        Sat, 23 Jan 2016 13:47:25 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH v2 2/4] MIPS: zboot: Avoid useless rebuilds
Date:   Sat, 23 Jan 2016 13:48:16 +0100
Message-Id: <1453553326-26445-2-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1453553326-26445-1-git-send-email-albeu@free.fr>
References: <1453553326-26445-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51317
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

dummy.o is missing from the targets list which cause useless rebuilds.
Instead of adding it to the target list we now fill the list
automatically from $(vmlinuzobjs) to avoid having to maintain two
lists.

Building with XZ compression also lead to useless rebuilds because it
reuse source files from another directory. The kernel and zboot
wrapper use different flags, so if these object are built for the
kernel, they then get overwritten by the zboot wrapper version.
In the next build these object files are missing for the kernel,
so they get rebuild again, and then again for the zboot wrapper. To
solve this we copy the source files to the build directory to avoid
overwritting the kernel objects.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
Changelog:
v2: * Properly delete the copied source files on clean
    * Rewrote the commit log to better explain the problem
---
 arch/mips/boot/compressed/Makefile | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 45f8abb..2d5d97f 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -29,8 +29,6 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
 	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
 
-targets := head.o decompress.o string.o dbg.o uart-16550.o uart-alchemy.o
-
 # decompressor objects (linked with vmlinuz)
 vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o
 
@@ -40,9 +38,14 @@ vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
 vmlinuzobjs-$(CONFIG_MIPS_ALCHEMY)		   += $(obj)/uart-alchemy.o
 endif
 
-ifdef CONFIG_KERNEL_XZ
-vmlinuzobjs-y += $(obj)/../../lib/ashldi3.o $(obj)/../../lib/bswapsi.o
-endif
+vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o $(obj)/bswapsi.o
+
+extra-y += ashldi3.c bswapsi.c
+$(obj)/ashldi3.o $(obj)/bswapsi.o: KBUILD_CFLAGS += -I$(srctree)/arch/mips/lib
+$(obj)/ashldi3.c $(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
+	$(call cmd,shipped)
+
+targets := $(notdir $(vmlinuzobjs-y))
 
 targets += vmlinux.bin
 OBJCOPYFLAGS_vmlinux.bin := $(OBJCOPYFLAGS) -O binary -R .comment -S
@@ -60,7 +63,7 @@ targets += vmlinux.bin.z
 $(obj)/vmlinux.bin.z: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,$(tool_y))
 
-targets += piggy.o
+targets += piggy.o dummy.o
 OBJCOPYFLAGS_piggy.o := --add-section=.image=$(obj)/vmlinux.bin.z \
 			--set-section-flags=.image=contents,alloc,load,readonly,data
 $(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.bin.z FORCE
-- 
2.0.0
