Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 13:51:23 +0200 (CEST)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:37678 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492341AbZJMLvR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 13:51:17 +0200
Received: by pzk32 with SMTP id 32so10013492pzk.21
        for <multiple recipients>; Tue, 13 Oct 2009 04:51:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+0CkdTm6JHO7IppbY4shXf5pbgKqEdvH0ZIyFMWSPH4=;
        b=icMw1V4+SbHX3kCQTal5Yg4/SKHpXx4BmMWJ2ryDKRDWOjyHLVDNPVlVbHqAvJElpj
         4XNB0ZZ4guNwdUwu90Ypg5D9SRri3R5lBGqZklx8OCIc1ohOACAsfYTlNGtlNeZW5N2O
         dztLiEyiDyr2Jr6JykV5B7TraEtV/E5r+qsGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XPIYvyeiEhEgCbyvHLjtYVmeOheao4eUmwDQyW27keJ2S7tHLvlewrzvSk8YGVaFzS
         Tcaosm7gGvbaKw0SUflJ9YdS6iGZ/epWoGSqn/Zf3opin1RVPHF2i+EyTOLHg1K4Rt0+
         PELjW9edcMAOrDE/HgrRIn80aD3gpa9JAa2Es=
Received: by 10.115.39.23 with SMTP id r23mr12329180waj.2.1255434668296;
        Tue, 13 Oct 2009 04:51:08 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm835784pxi.4.2009.10.13.04.51.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Oct 2009 04:51:07 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Alexander Clouter <alex@digriz.org.uk>, huhb@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] Add support of LZO-compressed kernels for MIPS
Date:	Tue, 13 Oct 2009 19:50:56 +0800
Message-Id: <1255434656-22075-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch need the Compressed kernel support for MIPS and the support
of LZO-compressed kernel, both of them are not available in the official
kernel yet, but you can get them in the following links respectively:

[PATCH -v2] MIPS: add support for gzip/bzip2/lzma compressed kernel image

http://www.linux-mips.org/archives/linux-mips/2009-10/msg00110.html

[PATCH v2.1 2/5] Add support for LZO-compressed kernels
http://marc.info/?l=linux-kernel&m=125525500919174&w=2

The advantage of this algorithm:

Uncompressed size: 3.24Mo
gzip  1.61Mo 0.72s
lzo   1.75Mo 0.48s

and what about the compression ratio?

$ ls -sh vmlinux  (original)
6.0M vmlinux
$ ls -sh vmlinuz (lzma)
1.2M vmlinuz
$ ls -sh vmlinuz (bzip2)
1.5M vmlinuz
$ ls -sh vmlinuz (gzip)
1.6M vmlinuz
$ ls -sh vmlinuz (lzop)
1.7M vmlinuz

the time statisticed for gzip,bzip2,lzma from booting to printing.

	SIZE	AVG. TIME(in 4 times)
gzip   2011314       2.64
bzip2  1831170       4.0625
lzma   1470938       3.2075

so, if you want to get the best compression ratio, you are recommended to use
LZMA, and if you need the fastest one, LZO is recommanded.

and BTW: if you need to use the gzip,bzip2,lzma,lzo support, the
corresponding tools are need to install in your machine to compress the
original kernel, they are gzip,bzip2,lzma and lzop.

(Thanks very much to Alexander Clouter <alex@digriz.org.uk> for giving the
information about LZO to me)

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig                      |    1 +
 arch/mips/boot/compressed/Makefile     |    2 ++
 arch/mips/boot/compressed/decompress.c |    4 ++++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 96bb02d..6bfab06 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1303,6 +1303,7 @@ config SYS_SUPPORTS_ZBOOT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_LZMA
+	select HAVE_KERNEL_LZO
 
 config SYS_SUPPORTS_ZBOOT_UART16550
 	bool
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 140bd9b..d746c00 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -38,9 +38,11 @@ $(obj)/vmlinux.bin: $(KBUILD_IMAGE)
 suffix_$(CONFIG_KERNEL_GZIP)  = gz
 suffix_$(CONFIG_KERNEL_BZIP2) = bz2
 suffix_$(CONFIG_KERNEL_LZMA)  = lzma
+suffix_$(CONFIG_KERNEL_LZO)  = lzo
 tool_$(CONFIG_KERNEL_GZIP)    = gzip
 tool_$(CONFIG_KERNEL_BZIP2)   = bzip2
 tool_$(CONFIG_KERNEL_LZMA)    = lzma
+tool_$(CONFIG_KERNEL_LZO)    = lzo
 $(obj)/vmlinux.$(suffix_y): $(obj)/vmlinux.bin
 	$(call if_changed,$(tool_y))
 	$(Q)rm -f $<
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index 67330c2..6a7cbb9 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -79,6 +79,10 @@ void *memset(void *s, int c, size_t n)
 #include "../../../../lib/decompress_unlzma.c"
 #endif
 
+#ifdef CONFIG_KERNEL_LZO
+#include "../../../../lib/decompress_unlzo.c"
+#endif
+
 void decompress_kernel(unsigned long boot_heap_start)
 {
 	int zimage_size;
-- 
1.6.2.1
