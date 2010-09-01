Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Sep 2010 11:17:56 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:64527 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490993Ab0IAJRw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Sep 2010 11:17:52 +0200
Received: by fxm12 with SMTP id 12so5533031fxm.36
        for <multiple recipients>; Wed, 01 Sep 2010 02:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:cc
         :subject:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=7x0e6Oc62S5BwzMU3nYcvtYKUsskzgZ8eULEbgBFf1U=;
        b=kLq+k2DV1yGESuVI88MNS13tBotWk4157nPHPzvEn75gIXfwj/lFMG/VzluXSOclk1
         kR/mLOUxP1Yy4uvKGSSvGTdUqCwe3G3iRUWXIbWvhOtLUHr9QC9vpHUrVMl4z077hLLK
         HCrkWrLeRYt2o66eDS7ENrqac7oepj6h6iWP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:cc:subject:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=HXosbwylVB0tx1e1TSosUebQve4ZmBVheVCMYj2A9Mf4xBc+aBhMV4F96KZbLe/XCi
         /QYqUf+UpnOiK3blbog1W7mv2XOMKifty2BlkAI3WitnIerMeVP+BqGtt3QGvCF9yrJ/
         CALFggNj6nLZZsp0pDUxo8FY1XWuPhM4DqqpE=
Received: by 10.223.105.76 with SMTP id s12mr6581425fao.107.1283332667331;
        Wed, 01 Sep 2010 02:17:47 -0700 (PDT)
Received: from pixies.home.jungo.com (pptp-il.jungo.com [194.90.113.98])
        by mx.google.com with ESMTPS id u8sm4478022fah.36.2010.09.01.02.17.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 02:17:46 -0700 (PDT)
Message-ID: <4c7e1a3a.c83ddf0a.5918.ffffcf6a@mx.google.com>
Date:   Wed, 1 Sep 2010 12:17:43 +0300
From:   Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     ralf@linux-mips.org, wuzhangjin@gmail.com,
        linux-mips@linux-mips.org
Cc:     alex@digriz.org.uk, manuel.lauss@googlemail.com, sam@ravnborg.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Fix vmlinuz to flush the caches after kernel
 decompression
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.18.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 27708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shmulik.ladkani@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 292

Flush caches after kernel decompression.

When writing instructions, the D-cache should be written-back, and I-cache
should be invalidated.

The patch implements L1 cache flushing, for r4k style caches - suitable for
all MIPS32 CPUs (and probably for other CPUs too).

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
---
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index ed9bb70..9a8d2da 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -30,6 +30,9 @@ targets := head.o decompress.o dbg.o uart-16550.o uart-alchemy.o
 # decompressor objects (linked with vmlinuz)
 vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
 
+targets += $(obj)/c-r4k.o
+vmlinuzobjs-$(CONFIG_CPU_MIPS32) += $(obj)/c-r4k.o
+
 ifdef CONFIG_DEBUG_ZBOOT
 vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
 vmlinuzobjs-$(CONFIG_MIPS_ALCHEMY)		   += $(obj)/uart-alchemy.o
diff --git a/arch/mips/boot/compressed/c-r4k.c b/arch/mips/boot/compressed/c-r4k.c
new file mode 100644
index 0000000..1959cdc
--- /dev/null
+++ b/arch/mips/boot/compressed/c-r4k.c
@@ -0,0 +1,92 @@
+#include <linux/types.h>
+#include <linux/kernel.h>
+
+#include <asm/addrspace.h>
+#include <asm/asm.h>
+#include <asm/cacheops.h>
+#include <asm/mipsregs.h>
+
+#define INDEX_BASE CKSEG0
+
+extern void puts(const char *s);
+extern void puthex(unsigned long long val);
+
+#define cache_op(op, addr)			\
+	__asm__ __volatile__(			\
+	"	.set push		\n"	\
+	"	.set noreorder		\n"	\
+	"	.set mips3		\n"	\
+	"	cache %1, 0(%0)		\n"	\
+	"	.set pop		\n"	\
+	:					\
+	: "r" (addr), "i" (op))
+
+#define cache_all_index_op(cachesz, linesz, op) do {			\
+	unsigned long addr = INDEX_BASE;				\
+	for (; addr < INDEX_BASE + (cachesz); addr += (linesz))		\
+		cache_op(op, addr);					\
+} while (0)
+
+static void dcache_writeback(const unsigned long cache_size,
+	const unsigned long line_size)
+{
+#ifdef DEBUG
+	puts("dcache writeback, cachesize ");
+	puthex(cache_size);
+	puts(" linesize ");
+	puthex(line_size);
+	puts("\n");
+#endif
+
+	cache_all_index_op(cache_size, line_size, Index_Writeback_Inv_D);
+}
+
+static void icache_invalidate(const unsigned long cache_size,
+	const unsigned long line_size)
+{
+#ifdef DEBUG
+	puts("icache invalidate, cachesize ");
+	puthex(cache_size);
+	puts(" linesize ");
+	puthex(line_size);
+	puts("\n");
+#endif
+
+	cache_all_index_op(cache_size, line_size, Index_Invalidate_I);
+}
+
+void cache_flush(void)
+{
+	volatile unsigned long config1;
+	unsigned long tmp;
+	unsigned long line_size;
+	unsigned long ways;
+	unsigned long sets;
+	unsigned long cache_size;
+
+	if (!(read_c0_config() & MIPS_CONF_M)) {
+		puts("cache_flush error: Config1 unavailable\n");
+		return;
+	}
+	config1 = read_c0_config1();
+
+	/* calculate D-cache line-size and cache-size, then writeback */
+	tmp = (config1 >> 10) & 7;
+	if (tmp) {
+		line_size = 2 << tmp;
+		sets = 64 << ((config1 >> 13) & 7);
+		ways = 1 + ((config1 >> 7) & 7);
+		cache_size = sets * ways * line_size;
+		dcache_writeback(cache_size, line_size);
+	}
+
+	/* calculate I-cache line-size and cache-size, then invalidate */
+	tmp = (config1 >> 19) & 7;
+	if (tmp) {
+		line_size = 2 << tmp;
+		sets = 64 << ((config1 >> 22) & 7);
+		ways = 1 + ((config1 >> 16) & 7);
+		cache_size = sets * ways * line_size;
+		icache_invalidate(cache_size, line_size);
+	}
+}
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index 5cad0fa..c86f9bd 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -30,6 +30,10 @@ extern unsigned char __image_begin, __image_end;
 extern void puts(const char *s);
 extern void puthex(unsigned long long val);
 
+void __weak cache_flush(void)
+{
+}
+
 void error(char *x)
 {
 	puts("\n\n");
@@ -105,6 +109,7 @@ void decompress_kernel(unsigned long boot_heap_start)
 	decompress((char *)zimage_start, zimage_size, 0, 0,
 		   (void *)VMLINUX_LOAD_ADDRESS_ULL, 0, error);
 
-	/* FIXME: should we flush cache here? */
+	cache_flush();
+
 	puts("Now, booting the kernel...\n");
 }
-- 
Shmulik Ladkani
