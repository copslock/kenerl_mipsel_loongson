Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 00:09:47 +0200 (CEST)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:35601
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994963AbdEWWGvBRwUc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 May 2017 00:06:51 +0200
Received: by mail-pf0-x241.google.com with SMTP id u26so30210035pfd.2
        for <linux-mips@linux-mips.org>; Tue, 23 May 2017 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc:subject:date
         :message-id:in-reply-to:references;
        bh=JOtMdsT6cr2ubCOFUC8qbXPyrNfMEf1quS68U8P4FOw=;
        b=V7rm+Co+s+zlLg95mJweV2hvwh1Qc6a7N7aB00Eu9IEWxF3sO3Blj92OSweYTV8jev
         dsujULI1MAfVvMbeWCw9QkqDrfsnKbjIOnzgzqA4h28m/TWHT49IJrdmha54b/04NdMl
         sEJ/QRyq0gQfV1ooef3LSCwKn6MEUyNGNwnWReS7jZzNmT+QSVf+fGTNRO0YqbXoqEXW
         eokFva2iIih0txl9G4dvXNDxn/jGqY7/TqEkZ2HNTmNIsBOqY91cE+r8eEyOyjUkRfLk
         fYxTuoUCEuotzcxPPRxeYjbGAGwN8QWK7Ucx5z60TQh5vl+ilpV1GPBguQJAQDKDJc5J
         Mlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc
         :subject:date:message-id:in-reply-to:references;
        bh=JOtMdsT6cr2ubCOFUC8qbXPyrNfMEf1quS68U8P4FOw=;
        b=YjaQ0C2bQj1xCf3FN2yubKNZHiTJHMWEP3hLGWvsmB/wCS6LFZwiOEcsQnHc4Chu+W
         kV1nor0FeV1tVkZ7nXPBXXWllA/+lQntLohy103OlOfb9moq0Eq0E5jHt/OakSgULD0J
         tNEeCs4+v5RDgTfJlLbOv56bHviKGP2C+6J33s7DTziwsY9dUInkaye8juhRDq0b3/hy
         7hiWifBSVxrTTuwXQjqYWm5abjN9asLFZVwp7eaOf+9px9idoyudTiwybQNIbj7ioXv1
         9NJVZPiyzz/+gKoMUHP6Pn7uyKL7X11eODi5g+bg0X1zYdVnuDoyRz+iNt0kxjSiKOlN
         V0Iw==
X-Gm-Message-State: AODbwcB4r6JDGlsXKiXsg3t2K5ZIxE4/3dBUj7EbzW70qfQmwbSK4vTc
        Qsvp9aqYEsedp9v9
X-Received: by 10.98.15.23 with SMTP id x23mr33826856pfi.86.1495577205194;
        Tue, 23 May 2017 15:06:45 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id p4sm243232pgf.21.2017.05.23.15.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 15:06:44 -0700 (PDT)
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
Subject: [PATCH 6/7] sh: Use lib/ashldi3,ashrdi3,lshrdi3}.c
Date:   Tue, 23 May 2017 15:05:45 -0700
Message-Id: <20170523220546.16758-7-palmer@dabbelt.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523220546.16758-1-palmer@dabbelt.com>
References: <20170523220546.16758-1-palmer@dabbelt.com>
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57973
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
 arch/sh/Kconfig       |  3 +++
 arch/sh/lib/Makefile  |  4 +---
 arch/sh/lib/ashldi3.c | 29 -----------------------------
 arch/sh/lib/ashrdi3.c | 31 -------------------------------
 arch/sh/lib/libgcc.h  | 25 -------------------------
 arch/sh/lib/lshrdi3.c | 29 -----------------------------
 6 files changed, 4 insertions(+), 117 deletions(-)
 delete mode 100644 arch/sh/lib/ashldi3.c
 delete mode 100644 arch/sh/lib/ashrdi3.c
 delete mode 100644 arch/sh/lib/libgcc.h
 delete mode 100644 arch/sh/lib/lshrdi3.c

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index ee086958b2b2..f991632f31ba 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -48,6 +48,9 @@ config SUPERH
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_NMI
+	select LIB_ASHLDI3
+	select LIB_ASHRDI3
+	select LIB_LSHRDI3
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
diff --git a/arch/sh/lib/Makefile b/arch/sh/lib/Makefile
index 3baff31e58cf..8caae109a728 100644
--- a/arch/sh/lib/Makefile
+++ b/arch/sh/lib/Makefile
@@ -6,9 +6,7 @@ lib-y  = delay.o memmove.o memchr.o \
 	 checksum.o strlen.o div64.o div64-generic.o
 
 # Extracted from libgcc
-obj-y += movmem.o ashldi3.o ashrdi3.o lshrdi3.o \
-	 ashlsi3.o ashrsi3.o ashiftrt.o lshrsi3.o \
-	 udiv_qrnnd.o
+obj-y += movmem.o ashlsi3.o ashrsi3.o ashiftrt.o udiv_qrnnd.o
 
 udivsi3-y			:= udivsi3_i4i-Os.o
 
diff --git a/arch/sh/lib/ashldi3.c b/arch/sh/lib/ashldi3.c
deleted file mode 100644
index beb80f316095..000000000000
--- a/arch/sh/lib/ashldi3.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include <linux/module.h>
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
-
-EXPORT_SYMBOL(__ashldi3);
diff --git a/arch/sh/lib/ashrdi3.c b/arch/sh/lib/ashrdi3.c
deleted file mode 100644
index c884a912b660..000000000000
--- a/arch/sh/lib/ashrdi3.c
+++ /dev/null
@@ -1,31 +0,0 @@
-#include <linux/module.h>
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
-
-EXPORT_SYMBOL(__ashrdi3);
diff --git a/arch/sh/lib/libgcc.h b/arch/sh/lib/libgcc.h
deleted file mode 100644
index 05909d58e2fe..000000000000
--- a/arch/sh/lib/libgcc.h
+++ /dev/null
@@ -1,25 +0,0 @@
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
-#endif /* __ASM_LIBGCC_H */
diff --git a/arch/sh/lib/lshrdi3.c b/arch/sh/lib/lshrdi3.c
deleted file mode 100644
index dcf8d6810b7c..000000000000
--- a/arch/sh/lib/lshrdi3.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include <linux/module.h>
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
-
-EXPORT_SYMBOL(__lshrdi3);
-- 
2.13.0
