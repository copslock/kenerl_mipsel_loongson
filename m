Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2010 08:31:57 +0100 (CET)
Received: from mail-yw0-f182.google.com ([209.85.211.182]:60832 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491138Ab0AOHbx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jan 2010 08:31:53 +0100
Received: by ywh12 with SMTP id 12so338461ywh.21
        for <multiple recipients>; Thu, 14 Jan 2010 23:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=OICIwg5t47Lim9/mHpgdjBIuBwRSSyZpgaJkXP3S0rM=;
        b=yFHQ+7ADs8hCIrd7XyN261umcS2WE6S2IsCFZW3LWCWgST53QeRgLcnIZYLpDH10Ot
         j6cNJynDzBFXFHIelNFddgeS7TvlWNi0CiuSa/JAy3/tM6Wts465mX+8euUat3U4JLDm
         EEgboSSZb3Zy7k1xutTl6xFsh1BwUKAuAX18Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kMXdU7RuzfhpkXoWhCu6BxmIkz+Zmg96W+DdVAYkN7Fc4WrN+uQZAY7K147V+bj6lx
         ELn+CikGRnqiAtrZ5ZlCNhOymVbtI4WuSMjZQMLe0XA3dyHy1kEKOx3DtDUE6hkZk0/f
         e5jefIos0KFbXEwURD0hqHSetEC7Mi6ZwetGU=
Received: by 10.91.193.19 with SMTP id v19mr2120088agp.4.1263540706956;
        Thu, 14 Jan 2010 23:31:46 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 23sm1223653iwn.11.2010.01.14.23.31.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Jan 2010 23:31:46 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: Add support of LZO-compressed kernels
Date:   Fri, 15 Jan 2010 15:31:16 +0800
Message-Id: <1263540676-26295-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.5.6
X-archive-position: 25595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 10020

The commit "lib: add support for LZO-compressed kernels" has been merged
into linus' 2.6.33-rc4 tree, so, It is time to add the support for MIPS.

NOTE: to enable this support, the lzop application is needed.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig                      |    1 +
 arch/mips/boot/compressed/Makefile     |    2 ++
 arch/mips/boot/compressed/decompress.c |    4 ++++
 3 files changed, 7 insertions(+), 0 deletions(-)

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
index 671d344..e3c93f8 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -41,9 +41,11 @@ $(obj)/vmlinux.bin: $(KBUILD_IMAGE)
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
-- 
1.6.5.6
