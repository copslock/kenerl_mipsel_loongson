Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Mar 2010 15:28:12 +0100 (CET)
Received: from www.linuxtv.org ([130.149.80.248]:33640 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492108Ab0CFO2E (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 6 Mar 2010 15:28:04 +0100
Received: from mchehab by www.linuxtv.org with local (Exim 4.69)
        (envelope-from <mchehab@linuxtv.org>)
        id 1Nnuz4-0001b4-KN; Sat, 06 Mar 2010 15:28:02 +0100
Subject: [git:v4l-dvb/master] MIPS: Add support of LZO-compressed kernels
From:   Patch from Wu Zhangjin <linuxtv-commits-bounces@linuxtv.org>
To:     linuxtv-commits@linuxtv.org
Data:   Fri, 15 Jan 2010 20:34:46 +0800
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Sergei Shtylyov <sshtylyov@ru.mvista.com>,
        Ralf Baechle <ralf@linux-mips.org>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1Nnuz4-0001b4-KN@www.linuxtv.org>
Date:   Sat, 06 Mar 2010 15:28:02 +0100
Return-Path: <mchehab@linuxtv.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linuxtv-commits-bounces@linuxtv.org
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

The necessary changes to the x86 Kconfig and boot/compressed to allow the
use of this new compression method.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Patchwork: http://patchwork.linux-mips.org/patch/857/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/Kconfig                      |    1 +
 arch/mips/boot/compressed/Makefile     |    2 ++
 arch/mips/boot/compressed/decompress.c |    4 ++++
 3 files changed, 7 insertions(+), 0 deletions(-)

---

http://git.linuxtv.org/v4l-dvb.git?a=commitdiff;h=fe1d45e08650213ec83a72d3499c3dd703243792

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9541171..8b5d174 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1311,6 +1311,7 @@ config SYS_SUPPORTS_ZBOOT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_LZMA
+	select HAVE_KERNEL_LZO
 
 config SYS_SUPPORTS_ZBOOT_UART16550
 	bool
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 671d344..bdcfd49 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -41,9 +41,11 @@ $(obj)/vmlinux.bin: $(KBUILD_IMAGE)
 suffix_$(CONFIG_KERNEL_GZIP)  = gz
 suffix_$(CONFIG_KERNEL_BZIP2) = bz2
 suffix_$(CONFIG_KERNEL_LZMA)  = lzma
+suffix_$(CONFIG_KERNEL_LZO)   = lzo
 tool_$(CONFIG_KERNEL_GZIP)    = gzip
 tool_$(CONFIG_KERNEL_BZIP2)   = bzip2
 tool_$(CONFIG_KERNEL_LZMA)    = lzma
+tool_$(CONFIG_KERNEL_LZO)     = lzo
 $(obj)/vmlinux.$(suffix_y): $(obj)/vmlinux.bin
 	$(call if_changed,$(tool_y))
 
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index e48fd72..55d02b3 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -77,6 +77,10 @@ void *memset(void *s, int c, size_t n)
 #include "../../../../lib/decompress_unlzma.c"
 #endif
 
+#ifdef CONFIG_KERNEL_LZO
+#include "../../../../lib/decompress_unlzo.c"
+#endif
+
 void decompress_kernel(unsigned long boot_heap_start)
 {
 	int zimage_size;
