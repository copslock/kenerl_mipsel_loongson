Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 09:38:46 +0100 (CET)
Received: from smtp4-g21.free.fr ([212.27.42.4]:27609 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010456AbcAZIip36XC1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jan 2016 09:38:45 +0100
Received: from localhost.localdomain (unknown [176.4.135.180])
        (Authenticated sender: albeu)
        by smtp4-g21.free.fr (Postfix) with ESMTPA id 91BC34C8066;
        Tue, 26 Jan 2016 09:37:02 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH v3 1/3] MIPS: zboot: Fix the build with XZ compression on older GCC versions
Date:   Tue, 26 Jan 2016 09:38:27 +0100
Message-Id: <1453797509-14604-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51392
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

Some older GCC version (at least 4.6) emits calls to __bswapsi2() when
building the XZ decompressor. The link of the compressed image then
fails with the following error:

arch/mips/boot/compressed/decompress.o: In function '__fswab32':
include/uapi/linux/swab.h:60: undefined reference to '__bswapsi2'

Add bswapsi.o to the link to fix the build with these versions.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
Changelog:
v2: * Added CC to stable as the patch hasn't been merged in 4.4
v3: * Updated to 4.5-rc1
    * Removed CC to stable as this version of the patch doesn't
      apply to 4.4.
---
 arch/mips/boot/compressed/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 4eff1ef..acfc3ce 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -39,10 +39,10 @@ vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART_PROM) += $(obj)/uart-prom.o
 vmlinuzobjs-$(CONFIG_MIPS_ALCHEMY)		   += $(obj)/uart-alchemy.o
 endif
 
-vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o
+vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o $(obj)/bswapsi.o
 
-$(obj)/ashldi3.o: KBUILD_CFLAGS += -I$(srctree)/arch/mips/lib
-$(obj)/ashldi3.c: $(srctree)/arch/mips/lib/ashldi3.c
+$(obj)/ashldi3.o $(obj)/bswapsi.o: KBUILD_CFLAGS += -I$(srctree)/arch/mips/lib
+$(obj)/ashldi3.c $(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
 	$(call cmd,shipped)
 
 targets := $(notdir $(vmlinuzobjs-y))
-- 
2.0.0
