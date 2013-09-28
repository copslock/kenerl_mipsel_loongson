Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Sep 2013 17:45:50 +0200 (CEST)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46277 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816285Ab3I1Ppni9Ll1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Sep 2013 17:45:43 +0200
Received: by mail-lb0-f174.google.com with SMTP id w6so3146619lbh.5
        for <multiple recipients>; Sat, 28 Sep 2013 08:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=txOuMoPz25JYF6XrFJWxVvCn62wQ6lTnWvEdx5IECtQ=;
        b=Y7GyGEJXJXtxQM50zsHYzsSm36fPGK2vVWXskbDVgr+qSWYwfOLi51Jfw350R3IvAK
         AZn7H8yB+4kN/f5Ipis2KcNZ1deLVCu26qq5ygxsuPrJ/PeuSk0y910o3xMn+y7MIpxi
         780Wp5+3GKJF9x7KDKrvcJAbR/W40gxU0A2RO4P0WY95XDpBn5isGBVeSWOPF4ekktIL
         SUye+Th4smNlfib+6sgKfywyYt/VJTAFV9XjmYs3ZFw1fAEzJaNKYtlPrfNAOjq5NeV7
         4VDpjslfpQcYV5IZnK69wAQc4o/9w/KKYKvbTnD8dzoNOgp7Aha0sLilUWnSvA9lQ5ei
         s9Ig==
X-Received: by 10.152.115.176 with SMTP id jp16mr10911214lab.17.1380383137714;
        Sat, 28 Sep 2013 08:45:37 -0700 (PDT)
Received: from localhost.localdomain (ppp37-190-57-6.pppoe.spdop.ru. [37.190.57.6])
        by mx.google.com with ESMTPSA id f17sm9565479lbo.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 08:45:36 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [PATCH] MIPS: vmlinuz: gather some string functions into string.c
Date:   Sat, 28 Sep 2013 19:42:54 +0400
Message-Id: <1380382974-27884-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.8.4.rc3
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

This patch fixes linker error:

    LD    vmlinuz
  arch/mips/boot/compressed/decompress.o: In function `decompress_kernel':
  decompress.c:(.text+0x754): undefined reference to `memcpy'
  make[1]: *** [vmlinuz] Error 1

Which appears when compiling vmlinuz image with CONFIG_KERNEL_LZO=y.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/boot/compressed/Makefile     |  4 ++--
 arch/mips/boot/compressed/decompress.c | 19 -------------------
 arch/mips/boot/compressed/string.c     | 28 ++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 21 deletions(-)
 create mode 100644 arch/mips/boot/compressed/string.c

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 0048c08..30e30d4 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -27,10 +27,10 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
 	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
 
-targets := head.o decompress.o dbg.o uart-16550.o uart-alchemy.o
+targets := head.o decompress.o string.o dbg.o uart-16550.o uart-alchemy.o
 
 # decompressor objects (linked with vmlinuz)
-vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
+vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o $(obj)/dbg.o
 
 ifdef CONFIG_DEBUG_ZBOOT
 vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index 2c95730..fc1f294 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -44,29 +44,10 @@ void error(char *x)
 #define STATIC static
 
 #ifdef CONFIG_KERNEL_GZIP
-void *memcpy(void *dest, const void *src, size_t n)
-{
-	int i;
-	const char *s = src;
-	char *d = dest;
-
-	for (i = 0; i < n; i++)
-		d[i] = s[i];
-	return dest;
-}
 #include "../../../../lib/decompress_inflate.c"
 #endif
 
 #ifdef CONFIG_KERNEL_BZIP2
-void *memset(void *s, int c, size_t n)
-{
-	int i;
-	char *ss = s;
-
-	for (i = 0; i < n; i++)
-		ss[i] = c;
-	return s;
-}
 #include "../../../../lib/decompress_bunzip2.c"
 #endif
 
diff --git a/arch/mips/boot/compressed/string.c b/arch/mips/boot/compressed/string.c
new file mode 100644
index 0000000..49e6db0
--- /dev/null
+++ b/arch/mips/boot/compressed/string.c
@@ -0,0 +1,28 @@
+/*
+ * arch/mips/boot/compressed/string.c
+ *
+ * Very small subset of simple string routines
+ */
+
+#include <linux/string.h>
+
+void *memcpy(void *dest, const void *src, size_t n)
+{
+	int i;
+	const char *s = src;
+	char *d = dest;
+
+	for (i = 0; i < n; i++)
+		d[i] = s[i];
+	return dest;
+}
+
+void *memset(void *s, int c, size_t n)
+{
+	int i;
+	char *ss = s;
+
+	for (i = 0; i < n; i++)
+		ss[i] = c;
+	return s;
+}
-- 
1.8.4.rc3
