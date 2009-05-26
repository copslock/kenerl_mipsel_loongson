Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2009 20:11:24 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:39835 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024676AbZEZTJh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2009 20:09:37 +0100
Received: by pzk40 with SMTP id 40so3721137pzk.22
        for <multiple recipients>; Tue, 26 May 2009 12:09:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TiOiUFHJOyNb0+Zsfurt1HSnIev3s+AE15vXEid4t/A=;
        b=iKliMsgSo/8BckeUpGQ4iDLTfva1XCNbdXKlS4DyWBrcv04uCfQHwYTjn9iK6BNJiV
         1LvWBk6M03a5oYboc9qGbUfJgB/pul7MyOBVfpgqqwyfgHX9g9WNKeDCqUIG+ICtoEFh
         GHZ0hNwX7NsCLnsuv1OcEaszZDumjgWizAmiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hepl8pO+QgHgoUl+Hl3omNq5jMsQmlsQz8nzW667w1IQyarLdj989rfsPJHEF2hyQU
         NivfYewB11qDfQ7WxBeAMuOVl/rjVBoYbAS17G0lubBeVVLJf6rniMkqmoJyFxAlSv75
         AikksDZlzfSURTq2zfHdYacQPYELPLwS+ZvpA=
Received: by 10.114.134.1 with SMTP id h1mr17859558wad.219.1243364962980;
        Tue, 26 May 2009 12:09:22 -0700 (PDT)
Received: from localhost.localdomain ([219.246.59.144])
        by mx.google.com with ESMTPS id n9sm11868433wag.32.2009.05.26.12.09.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 May 2009 12:09:21 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [loongson-PATCH-v2 20/23] add gcc 4.4 support for MIPS and loongson
Date:	Wed, 27 May 2009 03:09:13 +0800
Message-Id: <afda033feccfe0946c308eddc86b2049f4919be2.1243362545.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1243362545.git.wuzj@lemote.com>
References: <cover.1243362545.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

the gcc 4.4 support for MIPS mostly refer to this PATCH:
http://www.nabble.com/-PATCH--MIPS:-Handle-removal-of-%27h%27-constraint-in-GCC-4.4-td22192768.html
but have been tuned a little.

because only gcc 4.4 have loongson-specific support, so, we need to
choose the suitable -march argument for gcc <= 4.3 and gcc >= 4.4, and
we also need to consider use -march=loongson2e and -march=loongson2f for
loongson2e and loongson2f respectively. this is handled by adding two
new kernel options: CPU_LOONGSON2E and CPU_LOONGSON2F(thanks for the
solutin provided by ZhangLe).

I have tested it on FuLoong(2f) in 32bit and 64bit with gcc-4.4 and
gcc-4.3. so, basically, it works.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Makefile               |    9 +++++-
 arch/mips/include/asm/compiler.h |   10 ++++++
 arch/mips/include/asm/delay.h    |   58 +++++++++++++++++++++++++------------
 3 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index a25c2e5..1ee5504 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -120,7 +120,14 @@ cflags-$(CONFIG_CPU_R4300)	+= -march=r4300 -Wa,--trap
 cflags-$(CONFIG_CPU_VR41XX)	+= -march=r4100 -Wa,--trap
 cflags-$(CONFIG_CPU_R4X00)	+= -march=r4600 -Wa,--trap
 cflags-$(CONFIG_CPU_TX49XX)	+= -march=r4600 -Wa,--trap
-cflags-$(CONFIG_CPU_LOONGSON2)	+= -march=r4600 -Wa,--trap
+
+# only gcc >= 4.4 have the loongson-specific support
+cflags-$(CONFIG_CPU_LOONGSON2)	+= -Wa,--trap
+cflags-$(CONFIG_CPU_LOONGSON2E)	+= $(shell if [ $(call cc-version) -lt 0440 ] ; then \
+	echo $(call cc-option,-march=r4600); else echo $(call cc-option,-march=loongson2e); fi ;)
+cflags-$(CONFIG_CPU_LOONGSON2F)	+= $(shell if [ $(call cc-version) -lt 0440 ] ; then \
+	echo $(call cc-option,-march=r4600); else echo $(call cc-option,-march=loongson2f); fi ;)
+
 cflags-$(CONFIG_CPU_MIPS32_R1)	+= $(call cc-option,-march=mips32,-mips32 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
 			-Wa,-mips32 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS32_R2)	+= $(call cc-option,-march=mips32r2,-mips32r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
diff --git a/arch/mips/include/asm/compiler.h b/arch/mips/include/asm/compiler.h
index 71f5c5c..95256a8 100644
--- a/arch/mips/include/asm/compiler.h
+++ b/arch/mips/include/asm/compiler.h
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2004, 2007  Maciej W. Rozycki
+ * Copyright (C) 2009  Wu Zhangjin, wuzj@lemote.com
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -16,4 +17,13 @@
 #define GCC_REG_ACCUM "accum"
 #endif
 
+#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 4)
+#define GCC_NO_H_CONSTRAINT
+#ifdef CONFIG_64BIT
+typedef unsigned int uintx_t __attribute__((mode(TI)));
+#else
+typedef u64 uintx_t;
+#endif
+#endif
+
 #endif /* _ASM_COMPILER_H */
diff --git a/arch/mips/include/asm/delay.h b/arch/mips/include/asm/delay.h
index b0bccd2..00d7969 100644
--- a/arch/mips/include/asm/delay.h
+++ b/arch/mips/include/asm/delay.h
@@ -7,6 +7,7 @@
  * Copyright (C) 1995 - 2000, 01, 03 by Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  * Copyright (C) 2007  Maciej W. Rozycki
+ * Copyright (C) 2009  Wu Zhangjin, wuzj@lemote.com
  */
 #ifndef _ASM_DELAY_H
 #define _ASM_DELAY_H
@@ -48,6 +49,43 @@ static inline void __delay(unsigned long loops)
 		: "0" (loops), "r" (1));
 }
 
+/*
+ * convert usecs to loops
+ *
+ * handle removal of 'h' constraint in GCC 4.4
+ */
+
+#ifndef GCC_NO_H_CONSTRAINT	/* gcc <= 4.3 */
+static inline unsigned long __usecs_to_loops(unsigned long usecs,
+		unsigned long lpj)
+{
+	unsigned long hi, lo;
+
+	if (sizeof(long) == 4)
+		__asm__("multu\t%2, %3"
+		: "=h" (usecs), "=l" (lo)
+		: "r" (usecs), "r" (lpj)
+		: GCC_REG_ACCUM);
+	else if (sizeof(long) == 8 && !R4000_WAR)
+		__asm__("dmultu\t%2, %3"
+		: "=h" (usecs), "=l" (lo)
+		: "r" (usecs), "r" (lpj)
+		: GCC_REG_ACCUM);
+	else if (sizeof(long) == 8 && R4000_WAR)
+		__asm__("dmultu\t%3, %4\n\tmfhi\t%0"
+		: "=r" (usecs), "=h" (hi), "=l" (lo)
+		: "r" (usecs), "r" (lpj)
+		: GCC_REG_ACCUM);
+
+	return usecs;
+}
+#else	/* GCC_NO_H_CONSTRAINT, gcc >= 4.4 */
+static inline unsigned long __usecs_to_loops(unsigned long usecs,
+		unsigned long lpj)
+{
+	return ((uintx_t)usecs * lpj) >> BITS_PER_LONG;
+}
+#endif
 
 /*
  * Division by multiplication: you don't have to worry about
@@ -62,8 +100,6 @@ static inline void __delay(unsigned long loops)
 
 static inline void __udelay(unsigned long usecs, unsigned long lpj)
 {
-	unsigned long hi, lo;
-
 	/*
 	 * The rates of 128 is rounded wrongly by the catchall case
 	 * for 64-bit.  Excessive precission?  Probably ...
@@ -77,23 +113,7 @@ static inline void __udelay(unsigned long usecs, unsigned long lpj)
 	                           0x80000000ULL) >> 32);
 #endif
 
-	if (sizeof(long) == 4)
-		__asm__("multu\t%2, %3"
-		: "=h" (usecs), "=l" (lo)
-		: "r" (usecs), "r" (lpj)
-		: GCC_REG_ACCUM);
-	else if (sizeof(long) == 8 && !R4000_WAR)
-		__asm__("dmultu\t%2, %3"
-		: "=h" (usecs), "=l" (lo)
-		: "r" (usecs), "r" (lpj)
-		: GCC_REG_ACCUM);
-	else if (sizeof(long) == 8 && R4000_WAR)
-		__asm__("dmultu\t%3, %4\n\tmfhi\t%0"
-		: "=r" (usecs), "=h" (hi), "=l" (lo)
-		: "r" (usecs), "r" (lpj)
-		: GCC_REG_ACCUM);
-
-	__delay(usecs);
+	__delay(__usecs_to_loops(usecs, lpj));
 }
 
 #define __udelay_val cpu_data[raw_smp_processor_id()].udelay_val
-- 
1.6.0.4
