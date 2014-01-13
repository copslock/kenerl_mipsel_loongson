Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jan 2014 22:23:03 +0100 (CET)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:40925 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6828766AbaAMVXBeyvYO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jan 2014 22:23:01 +0100
Received: by mail-lb0-f170.google.com with SMTP id u14so1819718lbd.29
        for <multiple recipients>; Mon, 13 Jan 2014 13:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5bQr8OswqiHjvaYXgOuMqyOjfM9ccQLNZwkTWQRaiJs=;
        b=0t+Ul8Y1T3v6Ym3xF9bNaJltXxwUTnliIU06cLDga5+vZmW9TrzPfEvvDq9pxcPfYB
         gUokq2z6L1y4rNQgqFKXttYUbJGfmTNkSoMscLFeInNS9+Xlg2/K4asg27dy65LVvI+0
         FjJvW5mJcfS0T+DkarM2Y2HDcMvW5WjKJB7aGksmu0LAo+mbp+2zOaFDSnpg14WZTuVz
         LEXqqdcbUIRmStgoq3MuMS1Su4wR5dpY4dBreYAYbrYc9AU8ANiGCJOr46V/vo6G6zSk
         GTsJZWu+Hs8jkj78TC2ybNjKz22GjSmQUKeO56aX29q7sOJtLT2mgINQHIHOx0BcebRa
         VsKQ==
X-Received: by 10.152.42.230 with SMTP id r6mr3835810lal.18.1389648175886;
        Mon, 13 Jan 2014 13:22:55 -0800 (PST)
Received: from flare.NIISI (t35.niisi.ras.ru. [193.232.173.35])
        by mx.google.com with ESMTPSA id j6sm7728104lam.6.2014.01.13.13.22.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jan 2014 13:22:54 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Antony Pavlov <antonynpavlov@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v3] MIPS: ZBOOT: gather string functions into string.c
Date:   Tue, 14 Jan 2014 01:30:56 +0400
Message-Id: <1389648656-25709-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.8.5.2
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38961
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
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <blogic@openwrt.org>
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
index 0000000..9de9885
--- /dev/null
+++ b/arch/mips/boot/compressed/string.c
@@ -0,0 +1,28 @@
+/*
+ * arch/mips/boot/compressed/string.c
+ *
+ * Very small subset of simple string routines
+ */
+
+#include <linux/types.h>
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
1.8.5.2
