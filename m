Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 00:07:50 +0200 (CEST)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:36429
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994954AbdEWWGtXR2Nc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 May 2017 00:06:49 +0200
Received: by mail-pf0-x243.google.com with SMTP id n23so30173856pfb.3
        for <linux-mips@linux-mips.org>; Tue, 23 May 2017 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc:subject:date
         :message-id:in-reply-to:references;
        bh=8f+zD8m2cy1CemPsxlJcDGXOPaS4YLHZ8cajjOD70lk=;
        b=xX3Y2KoM/VoOlWzHyb02Z+hsjxEuNbTH6r+U1zPerzq8MN/YiIlU2k0N3n+t7LR7kx
         pDMTGO19vFkcxG+ih/JDldR/z7HL8lQ5RjpTdSB0qzhiOTkolMq272ig5cbJtg2MzdHg
         rqXiLnIwpa7StkwCWzLlsARvFicy09Z0e84Ra2S9XqZWuTPTBGfreYqVFC7Z3pC6IgKU
         hHd4ewbw1Rlxz7FAditk02rBfUzChA8oBLpaweZUAFR09AQEBpXuULq0yO2xVxSkxrFF
         Pbc/gPzCzgJlHVqnu1tvRvvdFQsF+A/2CMCrOV7Ej5VQaBOAtvpzjK/rvO8EcFmkcJV8
         gYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc
         :subject:date:message-id:in-reply-to:references;
        bh=8f+zD8m2cy1CemPsxlJcDGXOPaS4YLHZ8cajjOD70lk=;
        b=dQI2ESRcaw98s9oYulX7LBie+eZuIlxl9ReXLfCB84u1jEgoIB3FHUuiRC/hKClY3a
         PU3OC2XBby1AGz0Jic3/s2prLKbrvxkJPDcE+bixWPuuHOlSUgL3n0jct4BAXd0oY0rp
         xrV40xvRPdmIRjyFteKLhMrfkpa8X3K6E70lcbv45QRUlK0T/oFLjNnqqIRokVEjNqlo
         SMW/2e5csnyCShsIYgzusTJf/JfSNXBMVkVX4DlL/47jgO46Y47S9/gyggxu5gLf91BP
         /TobqG/Lqdu3jYVCD28j43zc44ABfLgz6R9QnMk0bPWVjabUG+r/bnIwUECNOKk/uifX
         tqxw==
X-Gm-Message-State: AODbwcAlWYUABjIKHfxw9Tqc704hnR4bXZRGIumI3qRudjcyfiL2LoI/
        9tBchwiqH2K+Mv65
X-Received: by 10.84.245.8 with SMTP id i8mr38876251pll.109.1495577202335;
        Tue, 23 May 2017 15:06:42 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id f63sm3253002pgc.63.2017.05.23.15.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 15:06:41 -0700 (PDT)
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     monstr@monstr.eu
To:     ralf@linux-mips.org
To:     liqin.linux@gmail.com
To:     lennox.wu@gmail.com
To:     ysato@users.sourceforge.jp
To:     dalias@libc.org
To:     davem@davemloft.net
To:     linux-mips@linux-mips.org
To:     linux-sh@vger.kernel.org
To:     sparclinux@vger.kernel.org
To:     geert@linux-m68k.org
To:     linux-kernel@vger.kernel.org
To:     linux-arch@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 3/7] microblaze: Use libgcc files from lib/
Date:   Tue, 23 May 2017 15:05:42 -0700
Message-Id: <20170523220546.16758-4-palmer@dabbelt.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523220546.16758-1-palmer@dabbelt.com>
References: <20170523220546.16758-1-palmer@dabbelt.com>
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@dabbelt.com
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

These files are functionally identical to the shared copies that I
recently added.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/microblaze/Kconfig       |  6 +++++
 arch/microblaze/lib/Makefile  |  3 +--
 arch/microblaze/lib/ashldi3.c | 28 ---------------------
 arch/microblaze/lib/ashrdi3.c | 30 -----------------------
 arch/microblaze/lib/cmpdi2.c  | 26 --------------------
 arch/microblaze/lib/libgcc.h  | 32 ------------------------
 arch/microblaze/lib/lshrdi3.c | 28 ---------------------
 arch/microblaze/lib/muldi3.c  | 57 -------------------------------------------
 arch/microblaze/lib/ucmpdi2.c | 20 ---------------
 9 files changed, 7 insertions(+), 223 deletions(-)
 delete mode 100644 arch/microblaze/lib/ashldi3.c
 delete mode 100644 arch/microblaze/lib/ashrdi3.c
 delete mode 100644 arch/microblaze/lib/cmpdi2.c
 delete mode 100644 arch/microblaze/lib/libgcc.h
 delete mode 100644 arch/microblaze/lib/lshrdi3.c
 delete mode 100644 arch/microblaze/lib/muldi3.c
 delete mode 100644 arch/microblaze/lib/ucmpdi2.c

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 85885a501dce..cc88ea3d18a7 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -34,6 +34,12 @@ config MICROBLAZE
 	select TRACING_SUPPORT
 	select VIRT_TO_BUS
 	select CPU_NO_EFFICIENT_FFS
+	select LIB_ASHLDI3
+	select LIB_ASHRDI3
+	select LIB_CMPDI2
+	select LIB_LSHRDI3
+	select LIB_MULDI3
+	select LIB_UCMPDI3
 
 config SWAP
 	def_bool n
diff --git a/arch/microblaze/lib/Makefile b/arch/microblaze/lib/Makefile
index 70c7ae6a3fb5..c9a4d537e2fd 100644
--- a/arch/microblaze/lib/Makefile
+++ b/arch/microblaze/lib/Makefile
@@ -19,5 +19,4 @@ endif
 lib-y += uaccess_old.o
 
 # libgcc-style stuff needed in the kernel
-obj-y += ashldi3.o ashrdi3.o cmpdi2.o divsi3.o lshrdi3.o modsi3.o
-obj-y += muldi3.o mulsi3.o ucmpdi2.o udivsi3.o umodsi3.o
+obj-y += divsi3.o modsi3.o mulsi3.o udivsi3.o umodsi3.o
diff --git a/arch/microblaze/lib/ashldi3.c b/arch/microblaze/lib/ashldi3.c
deleted file mode 100644
index 1af904cd972d..000000000000
--- a/arch/microblaze/lib/ashldi3.c
+++ /dev/null
@@ -1,28 +0,0 @@
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-long long __ashldi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b == 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		w.s.low = 0;
-		w.s.high = (unsigned int) uu.s.low << -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.low >> bm;
-
-		w.s.low = (unsigned int) uu.s.low << b;
-		w.s.high = ((unsigned int) uu.s.high << b) | carries;
-	}
-
-	return w.ll;
-}
-EXPORT_SYMBOL(__ashldi3);
diff --git a/arch/microblaze/lib/ashrdi3.c b/arch/microblaze/lib/ashrdi3.c
deleted file mode 100644
index 32c334c05d04..000000000000
--- a/arch/microblaze/lib/ashrdi3.c
+++ /dev/null
@@ -1,30 +0,0 @@
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-long long __ashrdi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b == 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		/* w.s.high = 1..1 or 0..0 */
-		w.s.high =
-		    uu.s.high >> 31;
-		w.s.low = uu.s.high >> -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.high << bm;
-
-		w.s.high = uu.s.high >> b;
-		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
-	}
-
-	return w.ll;
-}
-EXPORT_SYMBOL(__ashrdi3);
diff --git a/arch/microblaze/lib/cmpdi2.c b/arch/microblaze/lib/cmpdi2.c
deleted file mode 100644
index 67abc9ac1bd4..000000000000
--- a/arch/microblaze/lib/cmpdi2.c
+++ /dev/null
@@ -1,26 +0,0 @@
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-word_type __cmpdi2(long long a, long long b)
-{
-	const DWunion au = {
-		.ll = a
-	};
-	const DWunion bu = {
-		.ll = b
-	};
-
-	if (au.s.high < bu.s.high)
-		return 0;
-	else if (au.s.high > bu.s.high)
-		return 2;
-
-	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
-		return 0;
-	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
-		return 2;
-
-	return 1;
-}
-EXPORT_SYMBOL(__cmpdi2);
diff --git a/arch/microblaze/lib/libgcc.h b/arch/microblaze/lib/libgcc.h
deleted file mode 100644
index ab077ef7e14b..000000000000
--- a/arch/microblaze/lib/libgcc.h
+++ /dev/null
@@ -1,32 +0,0 @@
-#ifndef __ASM_LIBGCC_H
-#define __ASM_LIBGCC_H
-
-#include <asm/byteorder.h>
-
-typedef int word_type __attribute__ ((mode (__word__)));
-
-#ifdef __BIG_ENDIAN
-struct DWstruct {
-	int high, low;
-};
-#elif defined(__LITTLE_ENDIAN)
-struct DWstruct {
-	int low, high;
-};
-#else
-#error I feel sick.
-#endif
-
-typedef union {
-	struct DWstruct s;
-	long long ll;
-} DWunion;
-
-extern long long __ashldi3(long long u, word_type b);
-extern long long __ashrdi3(long long u, word_type b);
-extern word_type __cmpdi2(long long a, long long b);
-extern long long __lshrdi3(long long u, word_type b);
-extern long long __muldi3(long long u, long long v);
-extern word_type __ucmpdi2(unsigned long long a, unsigned long long b);
-
-#endif /* __ASM_LIBGCC_H */
diff --git a/arch/microblaze/lib/lshrdi3.c b/arch/microblaze/lib/lshrdi3.c
deleted file mode 100644
index adcb253f11c8..000000000000
--- a/arch/microblaze/lib/lshrdi3.c
+++ /dev/null
@@ -1,28 +0,0 @@
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-long long __lshrdi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b == 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		w.s.high = 0;
-		w.s.low = (unsigned int) uu.s.high >> -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.high << bm;
-
-		w.s.high = (unsigned int) uu.s.high >> b;
-		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
-	}
-
-	return w.ll;
-}
-EXPORT_SYMBOL(__lshrdi3);
diff --git a/arch/microblaze/lib/muldi3.c b/arch/microblaze/lib/muldi3.c
deleted file mode 100644
index a3f9a03acdcd..000000000000
--- a/arch/microblaze/lib/muldi3.c
+++ /dev/null
@@ -1,57 +0,0 @@
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-#define W_TYPE_SIZE 32
-
-#define __ll_B ((unsigned long) 1 << (W_TYPE_SIZE / 2))
-#define __ll_lowpart(t) ((unsigned long) (t) & (__ll_B - 1))
-#define __ll_highpart(t) ((unsigned long) (t) >> (W_TYPE_SIZE / 2))
-
-/* If we still don't have umul_ppmm, define it using plain C.  */
-#if !defined(umul_ppmm)
-#define umul_ppmm(w1, w0, u, v)						\
-	do {								\
-		unsigned long __x0, __x1, __x2, __x3;			\
-		unsigned short __ul, __vl, __uh, __vh;			\
-									\
-		__ul = __ll_lowpart(u);					\
-		__uh = __ll_highpart(u);				\
-		__vl = __ll_lowpart(v);					\
-		__vh = __ll_highpart(v);				\
-									\
-		__x0 = (unsigned long) __ul * __vl;			\
-		__x1 = (unsigned long) __ul * __vh;			\
-		__x2 = (unsigned long) __uh * __vl;			\
-		__x3 = (unsigned long) __uh * __vh;			\
-									\
-		__x1 += __ll_highpart(__x0); /* this can't give carry */\
-		__x1 += __x2; /* but this indeed can */			\
-		if (__x1 < __x2) /* did we get it? */			\
-		__x3 += __ll_B; /* yes, add it in the proper pos */	\
-									\
-		(w1) = __x3 + __ll_highpart(__x1);			\
-		(w0) = __ll_lowpart(__x1) * __ll_B + __ll_lowpart(__x0);\
-	} while (0)
-#endif
-
-#if !defined(__umulsidi3)
-#define __umulsidi3(u, v) ({				\
-	DWunion __w;					\
-	umul_ppmm(__w.s.high, __w.s.low, u, v);		\
-	__w.ll;						\
-	})
-#endif
-
-long long __muldi3(long long u, long long v)
-{
-	const DWunion uu = {.ll = u};
-	const DWunion vv = {.ll = v};
-	DWunion w = {.ll = __umulsidi3(uu.s.low, vv.s.low)};
-
-	w.s.high += ((unsigned long) uu.s.low * (unsigned long) vv.s.high
-		+ (unsigned long) uu.s.high * (unsigned long) vv.s.low);
-
-	return w.ll;
-}
-EXPORT_SYMBOL(__muldi3);
diff --git a/arch/microblaze/lib/ucmpdi2.c b/arch/microblaze/lib/ucmpdi2.c
deleted file mode 100644
index d05f1585121c..000000000000
--- a/arch/microblaze/lib/ucmpdi2.c
+++ /dev/null
@@ -1,20 +0,0 @@
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-word_type __ucmpdi2(unsigned long long a, unsigned long long b)
-{
-	const DWunion au = {.ll = a};
-	const DWunion bu = {.ll = b};
-
-	if ((unsigned int) au.s.high < (unsigned int) bu.s.high)
-		return 0;
-	else if ((unsigned int) au.s.high > (unsigned int) bu.s.high)
-		return 2;
-	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
-		return 0;
-	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
-		return 2;
-	return 1;
-}
-EXPORT_SYMBOL(__ucmpdi2);
-- 
2.13.0
