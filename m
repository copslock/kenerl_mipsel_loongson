Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Dec 2015 10:58:10 +0100 (CET)
Received: from smtp5-g21.free.fr ([212.27.42.5]:62002 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013601AbbLJJ54r834h (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Dec 2015 10:57:56 +0100
Received: from localhost.localdomain (unknown [176.4.102.236])
        (Authenticated sender: albeu)
        by smtp5-g21.free.fr (Postfix) with ESMTPA id 6C923D4801A;
        Thu, 10 Dec 2015 10:56:40 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Alban Bedel <albeu@free.fr>, Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] MIPS: ath79: Add zboot debug serial support
Date:   Thu, 10 Dec 2015 10:57:22 +0100
Message-Id: <1449741444-29110-3-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1449741444-29110-1-git-send-email-albeu@free.fr>
References: <1449741444-29110-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50524
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
 arch/mips/Kconfig                  | 2 +-
 arch/mips/boot/compressed/Makefile | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

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
index 4eff1ef..f648bf7 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -37,8 +37,12 @@ vmlinuzobjs-$(CONFIG_DEBUG_ZBOOT)		   += $(obj)/dbg.o
 vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
 vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART_PROM) += $(obj)/uart-prom.o
 vmlinuzobjs-$(CONFIG_MIPS_ALCHEMY)		   += $(obj)/uart-alchemy.o
+vmlinuzobjs-$(CONFIG_ATH79)			   += $(obj)/uart-ath79.o
 endif
 
+$(obj)/uart-ath79.c: $(srctree)/arch/mips/ath79/early_printk.c
+	$(call cmd,shipped)
+
 vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o
 
 $(obj)/ashldi3.o: KBUILD_CFLAGS += -I$(srctree)/arch/mips/lib
-- 
2.0.0
