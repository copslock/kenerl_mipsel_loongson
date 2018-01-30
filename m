Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jan 2018 23:43:07 +0100 (CET)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:41730
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994758AbeA3WmPRhLh2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Jan 2018 23:42:15 +0100
Received: by mail-lf0-x242.google.com with SMTP id f136so17788965lff.8;
        Tue, 30 Jan 2018 14:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4F07Dv3QeLawFAyJ7n5oqxZ6Jt648H/ZbBTASvBBY0g=;
        b=SQ11D4GFTKzDUnUtJ77UoWnTd34ndd0b7yGrzJCONcqWM3do3jKl2rD5iaPato7QoE
         Yb8T2Zs0BhPSq6iM49oahKXc+d0d2xuSZwzLTPUGEFgKEpzeGKLdqa1vz8VBgH0pSmap
         R8gt/51qRXSoFC8WRldpXdHM1DoDXvH0z2nNbUlavqOHAbujbS/h39BAAucqVs1m9SRz
         vOrqbE8ooU7pPMHjHUo0H+CF8g6cO5Iy6sZJgiP3xzKB5XNc+4zjY774/SAk10Wxls5C
         z+o5HD4B4h0jzzgGKWRhhck85CE45DHo7wXoF3uCsr/5zYJHCWxJJHRyZKwdkf719pno
         gEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4F07Dv3QeLawFAyJ7n5oqxZ6Jt648H/ZbBTASvBBY0g=;
        b=OOOH2T+znTDDGh8Td/hag233PomoIc7O5w9mY+KUNb7fxsJFjsOcyZi8qJ5IB1tWPn
         K+F8rnu1w3CcIYEmHDO6KPHWGVEKhhR2R2W3obf2+1K/ERmJBTgHnNvemOJApeI+5OCn
         sd0XBxQLZhidhRhG94QLQsaJySKGDEyltF1z13/Pb2K2wq8YWw6DRSwD3kuK99+W15Vo
         xeyHBAwVN8EA/ZzsLlsoXoTSiQ3P7Kb38P252uQ5ONLeCweQuMgIoyWnLtjsUMPVJOJl
         geaS/w/+rbg2K36QP9py9Fek3fYvFFRNBBfFn6WKTYhD3SJ7owTovIn2XKA1k5NVYCCr
         /flQ==
X-Gm-Message-State: AKwxytcLZmN/bJtXBNvWhywJdVIB9YAwwjpA/4v+/z6kRo6IleCDKnzI
        BdHziCqQ7i7FgcnLbbhgk1Y6TA==
X-Google-Smtp-Source: AH8x227vmBYjLDBulIRvJrRBi+HyARdhomU0aF4vC7ovlhckylRcDZkf/JUp4nD8JMsilbMq8Kuz/A==
X-Received: by 10.25.168.141 with SMTP id r135mr18349666lfe.80.1517352129488;
        Tue, 30 Jan 2018 14:42:09 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-108-121.pppoe.spdop.ru. [109.252.108.121])
        by smtp.gmail.com with ESMTPSA id 4sm2938194lja.20.2018.01.30.14.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 14:42:08 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Matt Redfearn <matt.redfearn@mips.com>
Subject: [PATCH v2 2/2] MIPS: use generic GCC library routines from lib/
Date:   Wed, 31 Jan 2018 01:42:02 +0300
Message-Id: <20180130224202.7682-3-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180130224202.7682-1-antonynpavlov@gmail.com>
References: <20180130224202.7682-1-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

The commit b35cd9884fa5 ("lib: Add shared copies of
some GCC library routines") makes it possible
to share generic GCC library routines by several
architectures.

This commit removes several generic GCC library
routines from arch/mips/lib/ in favour of similar
routines from lib/.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Matt Redfearn <matt.redfearn@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/Kconfig       |  5 +++++
 arch/mips/lib/Makefile  |  2 +-
 arch/mips/lib/ashldi3.c | 30 ------------------------------
 arch/mips/lib/ashrdi3.c | 32 --------------------------------
 arch/mips/lib/cmpdi2.c  | 28 ----------------------------
 arch/mips/lib/lshrdi3.c | 30 ------------------------------
 arch/mips/lib/ucmpdi2.c | 22 ----------------------
 7 files changed, 6 insertions(+), 143 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 350a990fc719..6f786d576dd2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -73,6 +73,11 @@ config MIPS
 	select RTC_LIB if !MACH_LOONGSON64
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS
+	select GENERIC_ASHLDI3
+	select GENERIC_ASHRDI3
+	select GENERIC_CMPDI2
+	select GENERIC_LSHRDI3
+	select GENERIC_UCMPDI2
 
 menu "Machine selection"
 
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 78c2affeabf8..195ab4cb0840 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -16,4 +16,4 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
 obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
 
 # libgcc-style stuff needed in the kernel
-obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o ucmpdi2.o
+obj-y += bswapsi.o bswapdi.o
diff --git a/arch/mips/lib/ashldi3.c b/arch/mips/lib/ashldi3.c
deleted file mode 100644
index 24cd6903e797..000000000000
--- a/arch/mips/lib/ashldi3.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
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
index 23f5295af51e..000000000000
--- a/arch/mips/lib/ashrdi3.c
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
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
index 93cfc785927d..000000000000
--- a/arch/mips/lib/cmpdi2.c
+++ /dev/null
@@ -1,28 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
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
diff --git a/arch/mips/lib/lshrdi3.c b/arch/mips/lib/lshrdi3.c
deleted file mode 100644
index 914b971aca3b..000000000000
--- a/arch/mips/lib/lshrdi3.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
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
index c31c78ca4175..000000000000
--- a/arch/mips/lib/ucmpdi2.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
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
2.11.0
