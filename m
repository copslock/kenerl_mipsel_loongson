Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 07:51:38 +0100 (CET)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:35213
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992615AbeAQGvbokFzr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 07:51:31 +0100
Received: by mail-lf0-x242.google.com with SMTP id a204so12213344lfa.2;
        Tue, 16 Jan 2018 22:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PPL3EA2sq5ncXFue1ARh8YOc1mR+/y4q2txvwpzkmfU=;
        b=XkDd11c/B8iIqNGtGqcISAQoCpxHcwobrWVcACjJ+0+9OjlYx71r4sIpcHkolyoZxq
         yYt6taijUuY4vTyxlyp/lKRMMb12ojZdBMbmsgKTmXzR1WxHy9uvw/HpHWn7gfNFFJDN
         iaeDIebI8SJWpsTBeCmkITTDHTqra3RQ3d+qEngQ/um/fMR6reJj5Q7XGW48fhfhxAWa
         4Ve1+vDvQXssfMnnx0NgQ/jp2WRIoDLC4Ohnv9ZBMumUUAtmV3ZmWv9d1pedUL2U/hJ5
         K7f1udt6Lb3cFbV++20WZKV4iluEy0LEQPSDhcJ6do70Iq6y7l+dALW2uozAm3Eh2wGp
         cndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PPL3EA2sq5ncXFue1ARh8YOc1mR+/y4q2txvwpzkmfU=;
        b=F1VjAul0DMWDTyVXamXXEnsj+lV94QgJIDZRrTsva+VJrs98UATUnn/+406RTGKbTF
         IxCIu5EJV4nSPTFfkZvNNEpvdVAj5btM1miBmKldjPkyCKlsumtcwvh9BZYyJvXDutzZ
         fd6Vgbyg4rb6uzouizpQ0LMCepdmlR5z/I+I2jODlBqDHn0JuM/reon9IVS8shNYv0a9
         jXKbYeACehgXBrpavzPdETLMK2lCnNqiWAm/RIXKO33PIgM7HmK3iUY9VcbsstKf0fww
         YKjXgV9KUYhmEIR3YHisyYV7op6+biQvfbbs3s1wth5XcsgSShXoZQUa3f8Qp3Z7DFF1
         TitA==
X-Gm-Message-State: AKwxyteiOrlynamsCeBODzJngcSNY6cspRgbUsPTO/2wXXL55aboJKTR
        I2KMsBXkzggkLG/UOe+78QBC4A6H
X-Google-Smtp-Source: ACJfBotJFz01XZgokx9Prt5+3E13bDXD7ZdbKmJ6RhofDs3LaUtJOtbA4ZP5hgzVaAy9Sn2qdg1IMg==
X-Received: by 10.46.101.207 with SMTP id e76mr2001423ljf.115.1516171885641;
        Tue, 16 Jan 2018 22:51:25 -0800 (PST)
Received: from localhost.localdomain ([31.173.87.225])
        by smtp.gmail.com with ESMTPSA id 17sm699001ljd.94.2018.01.16.22.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2018 22:51:24 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: use generic GCC library routines from lib/
Date:   Wed, 17 Jan 2018 09:51:21 +0300
Message-Id: <20180117065121.30437-1-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.15.1
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62196
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
 delete mode 100644 arch/mips/lib/ashldi3.c
 delete mode 100644 arch/mips/lib/ashrdi3.c
 delete mode 100644 arch/mips/lib/cmpdi2.c
 delete mode 100644 arch/mips/lib/lshrdi3.c
 delete mode 100644 arch/mips/lib/ucmpdi2.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 350a990fc719..9cd49ee848c6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -73,6 +73,11 @@ config MIPS
 	select RTC_LIB if !MACH_LOONGSON64
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS
+	select GENERIC_ASHLDI3
+	select GENERIC_ASHRDI3
+	select GENERIC_LSHRDI3
+	select GENERIC_CMPDI2
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
2.15.1
