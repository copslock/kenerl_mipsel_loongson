Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2007 20:14:43 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.184]:32095 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20031057AbXKDUOf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 Nov 2007 20:14:35 +0000
Received: by nf-out-0910.google.com with SMTP id c10so982036nfd
        for <linux-mips@linux-mips.org>; Sun, 04 Nov 2007 12:14:25 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        bh=5Xm9jcuqI1EtgdLfe0qOV0zdK8dvncE3HsM/fsA/VLU=;
        b=jNanxCbm4MATErYmsHmN2RvUxICrJNInVbzRbFfqquJb/gj+eJe/RnFKZdZAaiybnXMOJaNGSazWsGKND8rlH0HiqETWhc1EGQgbjZOweN2RG70uZF5V8iswYbrl/89TZ5LCvWDAVh4YKIQHfnaRBVyYYXKCmvE1rjNqw/1JBps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=iHsLHVjQUFeUVdE9v/pccfbbFEC0uIpMiTwMX9ZosTNlvKssB5tLWx03pAAwX8izn+XS8BsCToJ+6gH8M8i/ILLLols4wSGo8G+FzdOiAi9TMs4+JcV6ZQYLgikNbeT4mQLlfPU6j3r8ULE+p8vpxu5iKv/Z+JER2HAflwppZUo=
Received: by 10.86.86.12 with SMTP id j12mr2796067fgb.1194207264778;
        Sun, 04 Nov 2007 12:14:24 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id y6sm12861978mug.2007.11.04.12.14.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Nov 2007 12:14:23 -0800 (PST)
Message-ID: <472E27D7.9030602@gmail.com>
Date:	Sun, 04 Nov 2007 21:13:11 +0100
From:	Franck Bui-Huu <fbuihuu@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] Kill __bzero() [take #2]
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17392
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

 This take includes Atsushi's comment.

		Franck

 arch/mips/kernel/mips_ksyms.c |    2 --
 arch/mips/lib/csum_partial.S  |    2 +-
 arch/mips/lib/memcpy.S        |    2 +-
 arch/mips/lib/memset.S        |    4 +---
 include/asm-mips/uaccess.h    |    4 ++--
 5 files changed, 5 insertions(+), 9 deletions(-)

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
index c30c718..35c5fad 100644
--- a/include/asm-mips/uaccess.h
+++ b/include/asm-mips/uaccess.h
@@ -643,11 +643,11 @@ __clear_user(void __user *addr, __kernel_size_t size)
 		"move\t$4, %1\n\t"
 		"move\t$5, $0\n\t"
 		"move\t$6, %2\n\t"
-		__MODULE_JAL(__bzero)
+		__MODULE_JAL(memset)
 		"move\t%0, $6"
 		: "=r" (res)
 		: "r" (addr), "r" (size)
-		: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+		: "$2", "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
 
 	return res;
 }
-- 
1.5.3.4
