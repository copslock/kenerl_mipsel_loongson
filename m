Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 13:49:55 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:50645 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010588AbcAWMtWU0XKI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jan 2016 13:49:22 +0100
Received: from localhost.localdomain (unknown [78.54.16.94])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id D37F3A6258;
        Sat, 23 Jan 2016 13:47:41 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH v2 4/4] MIPS: ath79: Add zboot debug serial support
Date:   Sat, 23 Jan 2016 13:48:18 +0100
Message-Id: <1453553326-26445-4-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1453553326-26445-1-git-send-email-albeu@free.fr>
References: <1453553326-26445-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51319
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

Reuse the early printk code to support the serial in zboot. We copy
early_printk.c instead of referencing it because we need to build a
different object file for the normal kernel and zboot.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
Changelog:
v2: * Properly delete the copied source files on clean
---
 arch/mips/Kconfig                  | 2 +-
 arch/mips/boot/compressed/Makefile | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ef1d665..bb2987b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -138,7 +138,7 @@ config ATH79
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_MIPS16
-	select SYS_SUPPORTS_ZBOOT
+	select SYS_SUPPORTS_ZBOOT_UART_PROM
 	select USE_OF
 	help
 	  Support for the Atheros AR71XX/AR724X/AR913X SoCs.
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 309d2ad..90aca95 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -37,8 +37,13 @@ vmlinuzobjs-$(CONFIG_DEBUG_ZBOOT)		   += $(obj)/dbg.o
 vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
 vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART_PROM) += $(obj)/uart-prom.o
 vmlinuzobjs-$(CONFIG_MIPS_ALCHEMY)		   += $(obj)/uart-alchemy.o
+vmlinuzobjs-$(CONFIG_ATH79)			   += $(obj)/uart-ath79.o
 endif
 
+extra-y += uart-ath79.c
+$(obj)/uart-ath79.c: $(srctree)/arch/mips/ath79/early_printk.c
+	$(call cmd,shipped)
+
 vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o $(obj)/bswapsi.o
 
 extra-y += ashldi3.c bswapsi.c
-- 
2.0.0
