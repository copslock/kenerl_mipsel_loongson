Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Oct 2005 17:18:21 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:30921 "EHLO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with ESMTP id S8133406AbVJBQSB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Oct 2005 17:18:01 +0100
Received: from localhost (p7129-ipad210funabasi.chiba.ocn.ne.jp [58.88.126.129])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 35F748D00;
	Mon,  3 Oct 2005 01:17:56 +0900 (JST)
Date:	Mon, 03 Oct 2005 01:16:37 +0900 (JST)
Message-Id: <20051003.011637.41198806.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix some sparse warnings
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Make memcpy_fromio etc. more sparse-friendly.
Remove duplicate __user annotation from __copy_to_user.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
--- a/include/asm-mips/io.h
+++ b/include/asm-mips/io.h
@@ -25,6 +25,7 @@
 #include <asm/page.h>
 #include <asm/pgtable-bits.h>
 #include <asm/processor.h>
+#include <asm/string.h>
 
 #include <ioremap.h>
 #include <mangle-port.h>
@@ -521,9 +522,18 @@ BUILDSTRING(q, u64)
 /* Depends on MIPS II instruction set */
 #define mmiowb() asm volatile ("sync" ::: "memory")
 
-#define memset_io(a,b,c)	memset((void *)(a),(b),(c))
-#define memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
-#define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
+static inline void memset_io(volatile void __iomem *addr, unsigned char val, int count)
+{
+	memset((void __force *) addr, val, count);
+}
+static inline void memcpy_fromio(void *dst, const volatile void __iomem *src, int count)
+{
+	memcpy(dst, (void __force *) src, count);
+}
+static inline void memcpy_toio(volatile void __iomem *dst, const void *src, int count)
+{
+	memcpy((void __force *) dst, src, count);
+}
 
 /*
  * ISA space is 'always mapped' on currently supported MIPS systems, no need
diff --git a/include/asm-mips/uaccess.h b/include/asm-mips/uaccess.h
--- a/include/asm-mips/uaccess.h
+++ b/include/asm-mips/uaccess.h
@@ -417,7 +417,7 @@ extern size_t __copy_user(void *__to, co
  */
 #define __copy_to_user(to,from,n)					\
 ({									\
-	void __user __user *__cu_to;					\
+	void __user *__cu_to;						\
 	const void *__cu_from;						\
 	long __cu_len;							\
 									\
