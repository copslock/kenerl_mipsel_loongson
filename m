Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Sep 2013 18:35:31 +0200 (CEST)
Received: from mail-la0-f44.google.com ([209.85.215.44]:60296 "EHLO
        mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827474Ab3I2QfPB323b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Sep 2013 18:35:15 +0200
Received: by mail-la0-f44.google.com with SMTP id eo20so3665859lab.17
        for <multiple recipients>; Sun, 29 Sep 2013 09:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=G8jnNBhW5sGLq0bRbKYD1fRLlHM+y9C3nM1JhnhCMhQ=;
        b=ibNkEzCmUvVb+dFpQPLNoXwYHYFtWGetu6G4nt9roxTzjBb3LBBkySDiu82EMkqxJC
         HkiMX8YMgp249RuAqPtvYNCyKzZ60uB6tMUCGyDIOKoN4xhLpKs8qLw9TLXLmk3fJsno
         hpgzcPjSQr7LbgUYeGZGsIHM52roLzPLdY4OdLCW/3nMbX6jYXNvjeXqTjD8GpgQ5vu4
         y2KmE9paRyiILJF8QnGScFv1mYjcoJMeFgLGLSSTbsuhHek9b0fkZs0BL6OcMX94tMkz
         rGVQ53j8I6TJ8mNj396mk4L90VtTDCS5NEY9rQmASdWM5R/IMVdZ7ky8o5d/njK+kADS
         XP6w==
X-Received: by 10.152.36.98 with SMTP id p2mr15845250laj.14.1380472509439;
        Sun, 29 Sep 2013 09:35:09 -0700 (PDT)
Received: from localhost.localdomain (ppp37-190-57-6.pppoe.spdop.ru. [37.190.57.6])
        by mx.google.com with ESMTPSA id f17sm12893632lbo.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 29 Sep 2013 09:35:08 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Antony Pavlov <antonynpavlov@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2] MIPS: ZBOOT: gather string functions into string.c
Date:   Sun, 29 Sep 2013 20:32:10 +0400
Message-Id: <1380472330-9247-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.8.4.rc3
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38059
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

In the worst case this adds less then 128 bytes of code
but on the other hand this makes code organization more clear.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/boot/compressed/Makefile     |  4 ++--
 arch/mips/boot/compressed/decompress.c | 22 ----------------------
 arch/mips/boot/compressed/string.c     | 28 ++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 24 deletions(-)
 create mode 100644 arch/mips/boot/compressed/string.c

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index ca0c343..61af6b6 100644
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
index a8c6fd6..c00c4dd 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -43,33 +43,11 @@ void error(char *x)
 /* activate the code for pre-boot environment */
 #define STATIC static
 
-#if defined(CONFIG_KERNEL_GZIP) || defined(CONFIG_KERNEL_XZ) || \
-	defined(CONFIG_KERNEL_LZ4)
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
-#endif
 #ifdef CONFIG_KERNEL_GZIP
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
