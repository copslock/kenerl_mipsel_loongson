Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2010 13:35:21 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:36375 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492246Ab0AOMfR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jan 2010 13:35:17 +0100
Received: by pzk35 with SMTP id 35so583761pzk.22
        for <multiple recipients>; Fri, 15 Jan 2010 04:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=3QMDt3hs/4A82/HXXzPeVFUW8Ig3GbXsMsg03TodJGk=;
        b=KzyvCh1kjhG4lpJvFDcdOawBGpcSzZcAEuzLx4K00S7z8A5Ta1qrUysE+RXclbYhO9
         d9V78e55GE9dCul5JMyP86Cd33oULpsDOBe66pROq9NDVU0d3REaaKA4vhKcb0oUZMOL
         b0XtHEvrPDdFD8GCSDllo/tJhh2mKFrXo1p3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kUiYxBnhGU6wc3VPH4r4lfQlrP0zoomz1SdlzUqCsMeDY50HIg3gome6jq5ssPhBgV
         kHaisFdT4nfKdfFq6qOR3dMWq2iz5BiIYDvlL85WI7F49kfyPDstvW+cfgqqNRsygnaJ
         rTu+lStJT22LKpQpIpM3M9btwTilqeNwWAByw=
Received: by 10.142.7.4 with SMTP id 4mr1618764wfg.12.1263558910105;
        Fri, 15 Jan 2010 04:35:10 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 23sm1381641pzk.12.2010.01.15.04.35.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 04:35:09 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Sergei Shtylyov <sshtylyov@ru.mvista.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v1] MIPS: Add support of LZO-compressed kernels
Date:   Fri, 15 Jan 2010 20:34:46 +0800
Message-Id: <2efc4ca08c90ad087a2e84cadee03eb09b5268ba.1263558635.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.5.6
X-archive-position: 25599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 10144

(Changes from v0: 'align "lzo" with the rest of the suffixes/tool names' as
 Sergei suggested.)

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
-- 
1.6.5.6
