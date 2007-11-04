Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2007 08:19:50 +0000 (GMT)
Received: from fk-out-0910.google.com ([209.85.128.191]:13282 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20026943AbXKDITk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 Nov 2007 08:19:40 +0000
Received: by fk-out-0910.google.com with SMTP id f40so1263845fka
        for <linux-mips@linux-mips.org>; Sun, 04 Nov 2007 01:19:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        bh=X4XThZ4Ium8+3c73WGJsYDASN3SXYv8dWm+egw0+ovo=;
        b=Uw3B92dTXEmw4MEP+ncBMLVsAOs/OK+Y/FsFLVniHPaWIooz+rQJ9QNdeJ2X5inn06YGnNWT+ZfNM23HszNJSVQtxHn5kbFIUpCEgeEICGsFZQOmSh+Ejyli+f3V+9m01xdLwSgjNnIMBAJvtcmJEscrTCtjU1BQGmge+JaehEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=XLqsUOn1Oo8mBVkr0LiE78/Y7IklKMuofTkBGbCQz0Eash5oMmFvMWUzs7gM7fEYALeccH3AJ0FWbPEE+uMDWf6Ae6/TfzPFsckWxbhLePtWAjny+RsStQCn7hXgqQodBsiLwtj2uiWTPj3PHLKhqL8VewaGaIQ2Ukpouu8WkgI=
Received: by 10.86.74.15 with SMTP id w15mr2354736fga.1194164379301;
        Sun, 04 Nov 2007 01:19:39 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id d13sm9319629fka.2007.11.04.01.19.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Nov 2007 01:19:37 -0700 (PDT)
Message-ID: <472D8058.5080209@gmail.com>
Date:	Sun, 04 Nov 2007 09:18:32 +0100
From:	Franck Bui-Huu <fbuihuu@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] Kill __bzero() 
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

This patch removes this function because:

  1/ Its unconventional prototype is error prone: its prototype is
  the same as memset one but was documented by mips_ksym.c like the
  following:

	   extern void *__bzero(void *__s, size_t __count);

  2/ For the caller, it makes no difference to call memset instead
  since it has to setup the second parameter of __bzero to 0.

  3/ It's not part of the Linux user access API, so no module can use
  it.

  4/ It needs to be exported with EXPORT_SYMBOL and therefore consumes
  some extra bytes.

  5/ It has only one user.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---

 I'm wondering if I'm missing something, because this function seems
 so ugly and useless in the first place, that I can't refrain to
 submit a patch to get rid of it.

		Franck

 arch/mips/kernel/mips_ksyms.c |    2 --
 arch/mips/lib/csum_partial.S  |    2 +-
 arch/mips/lib/memcpy.S        |    2 +-
 arch/mips/lib/memset.S        |    4 +---
 include/asm-mips/uaccess.h    |    2 +-
 5 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index 225755d..6da9fa8 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -14,7 +14,6 @@
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 
-extern void *__bzero(void *__s, size_t __count);
 extern long __strncpy_from_user_nocheck_asm(char *__to,
                                             const char *__from, long __len);
 extern long __strncpy_from_user_asm(char *__to, const char *__from,
@@ -38,7 +37,6 @@ EXPORT_SYMBOL(kernel_thread);
  */
 EXPORT_SYMBOL(__copy_user);
 EXPORT_SYMBOL(__copy_user_inatomic);
-EXPORT_SYMBOL(__bzero);
 EXPORT_SYMBOL(__strncpy_from_user_nocheck_asm);
 EXPORT_SYMBOL(__strncpy_from_user_asm);
 EXPORT_SYMBOL(__strlen_user_nocheck_asm);
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index c0a77fe..8d3fa1e 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -694,7 +694,7 @@ l_exc:
 	ADD	dst, t0			# compute start address in a1
 	SUB	dst, src
 	/*
-	 * Clear len bytes starting at dst.  Can't call __bzero because it
+	 * Clear len bytes starting at dst.  Can't call memset because it
 	 * might modify len.  An inefficient loop for these rare times...
 	 */
 	beqz	len, done
diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index a526c62..425f2c3 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -443,7 +443,7 @@ l_exc:
 	ADD	dst, t0			# compute start address in a1
 	SUB	dst, src
 	/*
-	 * Clear len bytes starting at dst.  Can't call __bzero because it
+	 * Clear len bytes starting at dst.  Can't call memset because it
 	 * might modify len.  An inefficient loop for these rare times...
 	 */
 	beqz	len, done
diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 3f8b8b3..a13248b 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -46,7 +46,7 @@
 	.endm
 
 /*
- * memset(void *s, int c, size_t n)
+ * void *memset(void *s, int c, size_t n)
  *
  * a0: start of area to clear
  * a1: char to fill with
@@ -68,8 +68,6 @@ LEAF(memset)
 #endif
 	or		a1, t1
 1:
-
-FEXPORT(__bzero)
 	sltiu		t0, a2, LONGSIZE	/* very small region? */
 	bnez		t0, small_memset
 	 andi		t0, a0, LONGMASK	/* aligned? */
diff --git a/include/asm-mips/uaccess.h b/include/asm-mips/uaccess.h
index c30c718..9b8234a 100644
--- a/include/asm-mips/uaccess.h
+++ b/include/asm-mips/uaccess.h
@@ -643,7 +643,7 @@ __clear_user(void __user *addr, __kernel_size_t size)
 		"move\t$4, %1\n\t"
 		"move\t$5, $0\n\t"
 		"move\t$6, %2\n\t"
-		__MODULE_JAL(__bzero)
+		__MODULE_JAL(memset)
 		"move\t%0, $6"
 		: "=r" (res)
 		: "r" (addr), "r" (size)
-- 
1.5.3.4
