Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 00:10:27 +0200 (CEST)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:34083
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994955AbdEWWGto1mIc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 May 2017 00:06:49 +0200
Received: by mail-pf0-x241.google.com with SMTP id w69so30199288pfk.1
        for <linux-mips@linux-mips.org>; Tue, 23 May 2017 15:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc:subject:date
         :message-id:in-reply-to:references;
        bh=VEOiZUqzXu5G7fQ5yVtFnxx7oB8NlDkVXYVf8TjarpI=;
        b=1fIahCZ1GRqo3gJ6aK4ikVC1LONtqK4Pnhi5xIJ9lDT6kcR+5xYXixVbGWaRSd47zg
         +CVhE00z1+zLkBPuulbJVQ1wc/ur7btwgG0mZEeQln7Hl59jUaZDTjoKRf3SNDSN4DPm
         N+Tt+KZxUIkBunOAZDhv69IgvtxRxlP6sU1jLrOcbHMmIgFhw1VfKj5/nJ46sPKrv+sR
         xhJtqZ3/KivOkqNnCaHGeSoYVR4PrLUQFpz+5mzmx2r/uqy2J8DfREukpq5pRCwGX0aa
         OZS4DTRGA5B4CLvvzRNPRJHNGGT8sQX5/7kaQn7wU/r2rjM6F5zSY3oJx7JCZLN7A/H0
         1Zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:to:to:to:to:to:to:to:to:to:to:to:to:cc
         :subject:date:message-id:in-reply-to:references;
        bh=VEOiZUqzXu5G7fQ5yVtFnxx7oB8NlDkVXYVf8TjarpI=;
        b=ZxFhoVfu1ojRaWInaYHcfK8q6mkZE2cXNcuGn1mdkm8SCsSgZV01BSlxBBYqahY82W
         RT6+2c2IQ4PvYFOmL4EPQCggUiYXNlfyVMp6ZUhvF5dKgJGW22xT7rfkqcZIpwgwhX71
         fJfJhpk9m1yXzMNGXGz0km0knHK69PYiyJIQUi7HXOhuGvMJLnOcvz8fNy+ZvUftdxDh
         vpki0hoBOR7S/84O8oBOmzXh0LIfyN4LiFHOEbEr6tNAYkE2ODtIWnH0a62S2TbhuOz6
         1voOiFBuYo7lVraM7Qn5IEd6onnoda1sB2LB2rZRRBb5e5s92hfjrp5TF0xjFEsF6Zjv
         Gu5Q==
X-Gm-Message-State: AODbwcD3u37Jip+1ipNnWcQfLVJrTf6A/SNJ8wERFPGfwK7lD1kleJRk
        7z20IcLvbW3749Zb
X-Received: by 10.99.121.141 with SMTP id u135mr35850641pgc.48.1495577203324;
        Tue, 23 May 2017 15:06:43 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id q64sm4569958pfi.69.2017.05.23.15.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 15:06:42 -0700 (PDT)
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
Subject: [PATCH 4/7] mips: Use lib/{ashldi3,ashrdi3,cmpdi2,lshrdi3,ucmpdi2}.c
Date:   Tue, 23 May 2017 15:05:43 -0700
Message-Id: <20170523220546.16758-5-palmer@dabbelt.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523220546.16758-1-palmer@dabbelt.com>
References: <20170523220546.16758-1-palmer@dabbelt.com>
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57974
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
 arch/mips/Kconfig       |  1 +
 arch/mips/lib/Makefile  |  2 +-
 arch/mips/lib/ashldi3.c |  2 +-
 arch/mips/lib/ashrdi3.c |  2 +-
 arch/mips/lib/cmpdi2.c  |  2 +-
 arch/mips/lib/libgcc.h  | 25 -------------------------
 arch/mips/lib/lshrdi3.c |  2 +-
 arch/mips/lib/ucmpdi2.c | 21 ---------------------
 8 files changed, 6 insertions(+), 51 deletions(-)
 delete mode 100644 arch/mips/lib/libgcc.h
 delete mode 100644 arch/mips/lib/ucmpdi2.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2828ecde133d..b106e6165db0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -70,6 +70,7 @@ config MIPS
 	select HAVE_EXIT_THREAD
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_COPY_THREAD_TLS
+	select LIB_UCMPDI3
 
 menu "Machine selection"
 
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 0344e575f522..e38dbafea074 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -15,4 +15,4 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
 obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
 
 # libgcc-style stuff needed in the kernel
-obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o ucmpdi2.o
+obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o
diff --git a/arch/mips/lib/ashldi3.c b/arch/mips/lib/ashldi3.c
index c3e22053d13e..b3d706155fce 100644
--- a/arch/mips/lib/ashldi3.c
+++ b/arch/mips/lib/ashldi3.c
@@ -1,6 +1,6 @@
 #include <linux/export.h>
 
-#include "libgcc.h"
+#include <lib/libgcc.h>
 
 long long notrace __ashldi3(long long u, word_type b)
 {
diff --git a/arch/mips/lib/ashrdi3.c b/arch/mips/lib/ashrdi3.c
index 17456024873d..bca87aca6f5c 100644
--- a/arch/mips/lib/ashrdi3.c
+++ b/arch/mips/lib/ashrdi3.c
@@ -1,6 +1,6 @@
 #include <linux/export.h>
 
-#include "libgcc.h"
+#include <lib/libgcc.h>
 
 long long notrace __ashrdi3(long long u, word_type b)
 {
diff --git a/arch/mips/lib/cmpdi2.c b/arch/mips/lib/cmpdi2.c
index 9d849d8743c9..774b109921b5 100644
--- a/arch/mips/lib/cmpdi2.c
+++ b/arch/mips/lib/cmpdi2.c
@@ -1,6 +1,6 @@
 #include <linux/export.h>
 
-#include "libgcc.h"
+#include <lib/libgcc.h>
 
 word_type notrace __cmpdi2(long long a, long long b)
 {
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
index 221167c1be55..ceb1a5c14bc8 100644
--- a/arch/mips/lib/lshrdi3.c
+++ b/arch/mips/lib/lshrdi3.c
@@ -1,6 +1,6 @@
 #include <linux/export.h>
 
-#include "libgcc.h"
+#include <lib/libgcc.h>
 
 long long notrace __lshrdi3(long long u, word_type b)
 {
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
