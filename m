Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 21:13:32 +0200 (CEST)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:36190
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993910AbdFFTKlJflvB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jun 2017 21:10:41 +0200
Received: by mail-pf0-x241.google.com with SMTP id y7so6590990pfd.3
        for <linux-mips@linux-mips.org>; Tue, 06 Jun 2017 12:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc:subject:date
         :message-id:in-reply-to:references;
        bh=I+fr6Mm21zrgIPp4UTkPmjaP4fWEqHvdA+EeHaFptok=;
        b=EU4egGBbMk/10/XqIOExtI8K3a3nJ8RiMOnbnxJliXWXjJEuntIx+PeMnFyk5b+YHT
         AMz3DCDvArAcC5AATzBadCaBPsBwZAjMQD1Q525egGBcL2sCSWcqbSuhnFq5Pfu6sqgr
         dZvx3pxM1i9hqZbBPHEYPgYtCCvhUL8+wNbVYmDdPtkjgxIgJqXz7erN9H4QRIdiwk22
         zxXyX8XXsuZR5vN0mmq9fgP/yyyupOyvmpfZDjxOqnjGePP0pLVJQlKW15afCl260LGT
         GlzVOeRGbpkFczVW3ZVXfc7xEeBStU5tnN8mbwmqiOwp5UvMAt/l2a0wgGu5yPMFBY7K
         /Uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc
         :subject:date:message-id:in-reply-to:references;
        bh=I+fr6Mm21zrgIPp4UTkPmjaP4fWEqHvdA+EeHaFptok=;
        b=LG2y7RpgNo6oAijWS39FeaKD7rXpi4m1e3vWOA1pPMflm6yAysi6UtVgcP4jCQURYV
         SYZXla5e+XfVnt8Amd6H5xNujJRMwV0VM8qN7x/2SkLoZWW6ZBzK4kycxgUARIGbnpBF
         j/uEVYs5XRSdlTnriIzJm5ys8CvNTdNTGUwdolspc9t+p9FzKjkYCXQhpmDgY/IUXAVl
         xpPw8ajwsUC9PKMOwVMbVaS1qm4qqu0auYw7I5wPD7b6yg7XDpp+cUsKI8ddg9ogregU
         xHUZ+DUf8Pum9ilf7AqjsxLy23ErgCaOtpx0R1nZb2RWUPi6HBwLWs+SswBfqzwoLY8d
         6lDw==
X-Gm-Message-State: AODbwcCTXKL0i60EPsjDR2cpmHA+Bwj1cKJJm89xnz7mkjq297OSyPhV
        3weJlpUGYN38q2uH
X-Received: by 10.98.68.2 with SMTP id r2mr27079980pfa.45.1496776235242;
        Tue, 06 Jun 2017 12:10:35 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id c23sm56892065pfh.131.2017.06.06.12.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jun 2017 12:10:34 -0700 (PDT)
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
Subject: [PATCH 5/7] sh: Use lib/ashldi3,ashrdi3,lshrdi3}.c
Date:   Tue,  6 Jun 2017 12:10:21 -0700
Message-Id: <20170606191023.24581-6-palmer@dabbelt.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170606191023.24581-1-palmer@dabbelt.com>
References: <20170523220546.16758-1-palmer@dabbelt.com>
 <20170606191023.24581-1-palmer@dabbelt.com>
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58266
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
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/sh/Kconfig                  |  3 +++
 arch/sh/boot/compressed/Makefile |  6 +++---
 arch/sh/lib/Makefile             |  4 +---
 arch/sh/lib/ashldi3.c            | 29 -----------------------------
 arch/sh/lib/ashrdi3.c            | 31 -------------------------------
 arch/sh/lib/libgcc.h             | 25 -------------------------
 arch/sh/lib/lshrdi3.c            | 29 -----------------------------
 7 files changed, 7 insertions(+), 120 deletions(-)
 delete mode 100644 arch/sh/lib/ashldi3.c
 delete mode 100644 arch/sh/lib/ashrdi3.c
 delete mode 100644 arch/sh/lib/libgcc.h
 delete mode 100644 arch/sh/lib/lshrdi3.c

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index ee086958b2b2..49b98f74d7a0 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -48,6 +48,9 @@ config SUPERH
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_NMI
+	select GENERIC_ASHLDI3
+	select GENERIC_ASHRDI3
+	select GENERIC_LSHRDI3
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index c4c47ea9fa94..45a8e1349103 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -38,10 +38,10 @@ LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext $(IMAGE_OFFSET) -e startup \
 #
 # Pull in the necessary libgcc bits from the in-kernel implementation.
 #
-lib1funcs-$(CONFIG_SUPERH32)	:= ashiftrt.S ashldi3.c ashrsi3.S ashlsi3.S \
-				   lshrsi3.S
+lib1funcs-$(CONFIG_SUPERH32)	:= ashiftrt.S ashrsi3.S ashlsi3.S lshrsi3.S
 lib1funcs-obj			:= \
-	$(addsuffix .o, $(basename $(addprefix $(obj)/, $(lib1funcs-y))))
+	$(addsuffix .o, $(basename $(addprefix $(obj)/, $(lib1funcs-y)))) \
+	$(srctree)/lib/ashldi3.o
 
 lib1funcs-dir		:= $(srctree)/arch/$(SRCARCH)/lib
 ifeq ($(BITS),64)
diff --git a/arch/sh/lib/Makefile b/arch/sh/lib/Makefile
index 3baff31e58cf..971d9ac1e068 100644
--- a/arch/sh/lib/Makefile
+++ b/arch/sh/lib/Makefile
@@ -6,9 +6,7 @@ lib-y  = delay.o memmove.o memchr.o \
 	 checksum.o strlen.o div64.o div64-generic.o
 
 # Extracted from libgcc
-obj-y += movmem.o ashldi3.o ashrdi3.o lshrdi3.o \
-	 ashlsi3.o ashrsi3.o ashiftrt.o lshrsi3.o \
-	 udiv_qrnnd.o
+obj-y += movmem.o ashlsi3.o ashrsi3.o ashiftrt.o lshrsi3.o udiv_qrnnd.o
 
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
