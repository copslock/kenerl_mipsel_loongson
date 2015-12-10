Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Dec 2015 10:57:53 +0100 (CET)
Received: from smtp5-g21.free.fr ([212.27.42.5]:61324 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013600AbbLJJ5qxmnYh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Dec 2015 10:57:46 +0100
Received: from localhost.localdomain (unknown [176.4.102.236])
        (Authenticated sender: albeu)
        by smtp5-g21.free.fr (Postfix) with ESMTPA id 9B1A6D4808F;
        Thu, 10 Dec 2015 10:56:30 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Alban Bedel <albeu@free.fr>, Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] MIPS: zboot: Add support for serial debug using the PROM
Date:   Thu, 10 Dec 2015 10:57:21 +0100
Message-Id: <1449741444-29110-2-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1449741444-29110-1-git-send-email-albeu@free.fr>
References: <1449741444-29110-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50523
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

As most platforms implement the PROM serial interface prom_putchar()
add a simple bridge to allow re-using this code for zboot.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/Kconfig                     | 4 ++++
 arch/mips/boot/compressed/Makefile    | 1 +
 arch/mips/boot/compressed/uart-prom.c | 7 +++++++
 3 files changed, 12 insertions(+)
 create mode 100644 arch/mips/boot/compressed/uart-prom.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 71683a8..ef1d665 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1756,6 +1756,10 @@ config SYS_SUPPORTS_ZBOOT_UART16550
 	bool
 	select SYS_SUPPORTS_ZBOOT
 
+config SYS_SUPPORTS_ZBOOT_UART_PROM
+	bool
+	select SYS_SUPPORTS_ZBOOT
+
 config CPU_LOONGSON2
 	bool
 	select CPU_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index e66b2c6..4eff1ef 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -35,6 +35,7 @@ vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o
 ifdef CONFIG_DEBUG_ZBOOT
 vmlinuzobjs-$(CONFIG_DEBUG_ZBOOT)		   += $(obj)/dbg.o
 vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
+vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART_PROM) += $(obj)/uart-prom.o
 vmlinuzobjs-$(CONFIG_MIPS_ALCHEMY)		   += $(obj)/uart-alchemy.o
 endif
 
diff --git a/arch/mips/boot/compressed/uart-prom.c b/arch/mips/boot/compressed/uart-prom.c
new file mode 100644
index 0000000..1c3d51b
--- /dev/null
+++ b/arch/mips/boot/compressed/uart-prom.c
@@ -0,0 +1,7 @@
+
+extern void prom_putchar(unsigned char ch);
+
+void putc(char c)
+{
+	prom_putchar(c);
+}
-- 
2.0.0
