Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 21:14:41 +0200 (CEST)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:33197
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993920AbdFFTKnr8UXB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jun 2017 21:10:43 +0200
Received: by mail-pf0-x244.google.com with SMTP id f27so25182188pfe.0
        for <linux-mips@linux-mips.org>; Tue, 06 Jun 2017 12:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc:cc:subject:date
         :message-id:in-reply-to:references;
        bh=TZlcJV//R+QG2+yMxLUPC8TdYkAcqJMkbdBNoVFBfZ4=;
        b=I85vhzvwHgdJxxDdLh+FYYNccWBeK4tIITItgZq2S8tNrGzwLj+qg8K0foD7XEnVr1
         vvqLD9xUesZHXdM+5sCXmvFhLIKg05C9o1ee7SMy/B9aPpoLs8GTB6V7fzjhRxh4HWN7
         DKd0LAoa37eUK80rqt/9OmVy1egMNVNRZuMw/57o1uiRuG0DZwNFnfu0SxbZU34esxCF
         vxkM+zHPULD5ojWKPlZKX8ccsSm/xRM6jesB1glPDYKHwrO+wqfJFtoW94pnSJ+3blfO
         wL/wlRfjIjoB+LNqvxGNgNZuqiSvM3krGy3pDhocpfvwkTAp5lNYlvrsblkOqit4XS3Q
         Sq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc
         :cc:subject:date:message-id:in-reply-to:references;
        bh=TZlcJV//R+QG2+yMxLUPC8TdYkAcqJMkbdBNoVFBfZ4=;
        b=Hm2qIqEQX+xdILSrUUKjOeHWvkVyAevh9dyNbRL+XuiOKPzigBGkWp2vaHv6nAJrg6
         xHB3Dj7ozmP7c6mvHGRuD/pUNWKtIlZBzd+5017v8CTGVuNhiub7AoE9vR3DEHmYhaQA
         GfnYD6JsO2j0jMNfw1oM4wNNlIA/58lWo5t+OWFVj7GyY/OcDyHp+t4aGScVN4D4znhc
         hyCOMNgDJTxcJkHVnEUSlz3HF7LfriAVVh2QXLE+kanqhxKA6xeOJ2uEJZ0Rutr5eL4M
         PN+eZUYIMmi7CnrUxMxlV1u+CWE7+ZMoM6bZf5xcmZl311wzeOVR9Ym4cyuIgk88CCqb
         Bl7Q==
X-Gm-Message-State: AODbwcDJDZtCE7v9J6EXNfrHuLHPE1K9hSYz+jk1jlo9q6wl1lyvkclY
        C9d+9JPDWRxWc3H0
X-Received: by 10.84.224.76 with SMTP id a12mr22859902plt.25.1496776237787;
        Tue, 06 Jun 2017 12:10:37 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id t2sm14488085pfi.76.2017.06.06.12.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jun 2017 12:10:37 -0700 (PDT)
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
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH 7/7] MIPS: Use generic libgcc intrinsics
Date:   Tue,  6 Jun 2017 12:10:23 -0700
Message-Id: <20170606191023.24581-8-palmer@dabbelt.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170606191023.24581-1-palmer@dabbelt.com>
References: <20170523220546.16758-1-palmer@dabbelt.com>
 <20170606191023.24581-1-palmer@dabbelt.com>
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58268
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

These routines in arch/mips/lib/ are functionally identical to those
recently added to lib/ so remove them and select the generic ones.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/mips/Kconfig                  |  5 +++++
 arch/mips/boot/compressed/Makefile |  4 +++-
 arch/mips/lib/Makefile             |  2 +-
 arch/mips/lib/ashldi3.c            | 29 -----------------------------
 arch/mips/lib/ashrdi3.c            | 31 -------------------------------
 arch/mips/lib/cmpdi2.c             | 27 ---------------------------
 arch/mips/lib/libgcc.h             | 25 -------------------------
 arch/mips/lib/lshrdi3.c            | 29 -----------------------------
 arch/mips/lib/ucmpdi2.c            | 21 ---------------------
 9 files changed, 9 insertions(+), 164 deletions(-)
 delete mode 100644 arch/mips/lib/ashldi3.c
 delete mode 100644 arch/mips/lib/ashrdi3.c
 delete mode 100644 arch/mips/lib/cmpdi2.c
 delete mode 100644 arch/mips/lib/libgcc.h
 delete mode 100644 arch/mips/lib/lshrdi3.c
 delete mode 100644 arch/mips/lib/ucmpdi2.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2828ecde133d..25713699ef1d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -70,6 +70,11 @@ config MIPS
 	select HAVE_EXIT_THREAD
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_COPY_THREAD_TLS
+	select GENERIC_ASHLDI3
+	select GENERIC_ASHRDI3
+	select GENERIC_CMPDI2
+	select GENERIC_LSHRDI3
+	select GENERIC_UCMPDI2
 
 menu "Machine selection"
 
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index c675eece389a..83cc738fb7af 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -48,7 +48,9 @@ vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o $(obj)/bswapsi.o
 
 extra-y += ashldi3.c bswapsi.c
 $(obj)/ashldi3.o $(obj)/bswapsi.o: KBUILD_CFLAGS += -I$(srctree)/arch/mips/lib
-$(obj)/ashldi3.c $(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
+$(obj)/ashldi3.c $(obj)/%.c: $(srctree)/lib/%.c
+	$(call cmd,shipped)
+$(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
 	$(call cmd,shipped)
 
 targets := $(notdir $(vmlinuzobjs-y))
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 0344e575f522..814e739d6f86 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -15,4 +15,4 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
 obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
 
 # libgcc-style stuff needed in the kernel
-obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o ucmpdi2.o
+obj-y += bswapsi.o bswapdi.o
diff --git a/arch/mips/lib/ashldi3.c b/arch/mips/lib/ashldi3.c
deleted file mode 100644
index c3e22053d13e..000000000000
--- a/arch/mips/lib/ashldi3.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-long long notrace __ashldi3(long long u, word_type b)
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
diff --git a/arch/mips/lib/ashrdi3.c b/arch/mips/lib/ashrdi3.c
deleted file mode 100644
index 17456024873d..000000000000
--- a/arch/mips/lib/ashrdi3.c
+++ /dev/null
@@ -1,31 +0,0 @@
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-long long notrace __ashrdi3(long long u, word_type b)
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
diff --git a/arch/mips/lib/cmpdi2.c b/arch/mips/lib/cmpdi2.c
deleted file mode 100644
index 9d849d8743c9..000000000000
--- a/arch/mips/lib/cmpdi2.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-word_type notrace __cmpdi2(long long a, long long b)
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
-
-EXPORT_SYMBOL(__cmpdi2);
diff --git a/arch/mips/lib/libgcc.h b/arch/mips/lib/libgcc.h
deleted file mode 100644
index 05909d58e2fe..000000000000
--- a/arch/mips/lib/libgcc.h
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
diff --git a/arch/mips/lib/lshrdi3.c b/arch/mips/lib/lshrdi3.c
deleted file mode 100644
index 221167c1be55..000000000000
--- a/arch/mips/lib/lshrdi3.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-long long notrace __lshrdi3(long long u, word_type b)
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
diff --git a/arch/mips/lib/ucmpdi2.c b/arch/mips/lib/ucmpdi2.c
deleted file mode 100644
index 08067fa538f2..000000000000
--- a/arch/mips/lib/ucmpdi2.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
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
-
-EXPORT_SYMBOL(__ucmpdi2);
-- 
2.13.0
