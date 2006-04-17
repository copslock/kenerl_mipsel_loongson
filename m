Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 13:06:59 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:8479 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133415AbWDQMGu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Apr 2006 13:06:50 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 17 Apr 2006 21:19:14 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id D441D207C2;
	Mon, 17 Apr 2006 21:19:12 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id C927620797;
	Mon, 17 Apr 2006 21:19:12 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k3HCJC4D087091;
	Mon, 17 Apr 2006 21:19:12 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 17 Apr 2006 21:19:12 +0900 (JST)
Message-Id: <20060417.211912.108120254.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, mita@miraclelinux.com
Subject: [PATCH] fix bitops for MIPS32/MIPS64 CPUs
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

With recent rewrite for generic bitops, fls() for 32bit kernel with
MIPS64_CPU is broken.  Also, ffs(), fls() should be defined the same
way as the libc and compiler built-in routines (returns int instead of
unsigned long).

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/bitops.h b/include/asm-mips/bitops.h
index a1728f8..d2f4445 100644
--- a/include/asm-mips/bitops.h
+++ b/include/asm-mips/bitops.h
@@ -467,64 +467,56 @@ static inline unsigned long __ffs(unsign
 }
 
 /*
- * ffs - find first bit set.
+ * fls - find last bit set.
  * @word: The word to search
  *
- * Returns 1..SZLONG
- * Returns 0 if no bit exists
+ * This is defined the same way as ffs.
+ * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-
-static inline unsigned long ffs(unsigned long word)
+static inline int fls(int word)
 {
-	if (!word)
-		return 0;
+	__asm__ ("clz %0, %1" : "=r" (word) : "r" (word));
 
-	return __ffs(word) + 1;
+	return 32 - word;
 }
 
-/*
- * ffz - find first zero in word.
- * @word: The word to search
- *
- * Undefined if no zero exists, so code should check against ~0UL first.
- */
-static inline unsigned long ffz(unsigned long word)
+#if defined(CONFIG_64BIT) && defined(CONFIG_CPU_MIPS64)
+static inline int fls64(__u64 word)
 {
-	return __ffs (~word);
+	__asm__ ("dclz %0, %1" : "=r" (word) : "r" (word));
+
+	return 64 - word;
 }
+#else
+#include <asm-generic/bitops/fls64.h>
+#endif
 
 /*
- * fls - find last bit set.
+ * ffs - find first bit set.
  * @word: The word to search
  *
- * Returns 1..SZLONG
- * Returns 0 if no bit exists
+ * This is defined the same way as
+ * the libc and compiler builtin ffs routines, therefore
+ * differs in spirit from the above ffz (man ffs).
  */
-static inline unsigned long fls(unsigned long word)
+static inline int ffs(int word)
 {
-#ifdef CONFIG_CPU_MIPS32
-	__asm__ ("clz %0, %1" : "=r" (word) : "r" (word));
-
-	return 32 - word;
-#endif
-
-#ifdef CONFIG_CPU_MIPS64
-	__asm__ ("dclz %0, %1" : "=r" (word) : "r" (word));
+	if (!word)
+		return 0;
 
-	return 64 - word;
-#endif
+	return fls(word & -word);
 }
 
 #else
 
 #include <asm-generic/bitops/__ffs.h>
 #include <asm-generic/bitops/ffs.h>
-#include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/fls64.h>
 
 #endif /*defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64) */
 
-#include <asm-generic/bitops/fls64.h>
+#include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/find.h>
 
 #ifdef __KERNEL__
