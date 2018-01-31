Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jan 2018 16:34:45 +0100 (CET)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:38715
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994795AbeAaPdu3g5PN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Jan 2018 16:33:50 +0100
Received: by mail-lf0-x242.google.com with SMTP id g72so21316397lfg.5;
        Wed, 31 Jan 2018 07:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o733RUxoTYMaVmNks4XK8b05tA9540+q2HD5u7DVrlw=;
        b=qWTqO+MYesF7SkHFo9bP96sPNXKO6NhF7/zc3ixTXwc0NzWmmgN5qP1FALpAq55ObN
         EGjzO9ViFSbttwd67kG1AQ2GauUvhCmApV16yDNhoedvKl0EtzDCNEpaBVpkCdqGOElk
         bGHzGtohUw7PsA7K3+2P+jfCogroGR3n9VoZte+ngL9gBwUEun34Qd5AEKoefjTOiLGM
         5XQ5N/Dw7rZOScmPKDDw6KaupZJfnwgb0Ge+kUyD+IvkrFuhFoT4plPiKhqOOePQ0jBk
         HM+G5LNp6jPdhbB/IvQvf4jaT9fMnY+uUagO0D/o7iRrcNqhO0LIibSh1Hir/rej0VNA
         zkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o733RUxoTYMaVmNks4XK8b05tA9540+q2HD5u7DVrlw=;
        b=CM4uYxM+3jbd4eyZ5PDLQrA5OC1ymFYeMaPhioVZReVEQ35WXRtGlSc0hFKvgsI2ei
         jhkvd6lPaKSHMPQw/DZWg6XonmIrvxWz815mTUdvGr+SElWkF+iqrUYbJM7Al546ZBeW
         DxJcfM5g2CU8FUf847Ua1iiFWYe/jSpLiizJvVojVlDSyAbCWNhC7nqt4IDFMQ70ykSX
         OcSbAk/j/M8bHjsZGsiMFTgxWLmwd+ivW2laiq5kKg/P8Yjw5zDRRdbHi4jud4j+IWoh
         KrfjqFVd9ywXyifPMdYd/kQSPoMpgG0+12ghKQTBUKQ3VQCpBOY/tgiA7QORE7O5mMzb
         FWaQ==
X-Gm-Message-State: AKwxytdBsHW1Csdr0teAjRgwI4rCGnaimlKRzN+bwyo4w3SRVh/uPYUP
        ij5m+1Tq6gN9mnk/J7PnfE5yyw==
X-Google-Smtp-Source: AH8x2268CJ8zF4D7Msm3dmcQvyq27vStCZ0Dmfout8T0pDIf8ylDpCw0CBQOKIl/O7kJxc4FoxKHyA==
X-Received: by 10.25.67.67 with SMTP id m3mr20456275lfj.105.1517412823917;
        Wed, 31 Jan 2018 07:33:43 -0800 (PST)
Received: from localhost.localdomain (t109.niisi.ras.ru. [193.232.173.109])
        by smtp.gmail.com with ESMTPSA id u72sm3952454lfi.64.2018.01.31.07.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 07:33:43 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Matt Redfearn <matt.redfearn@mips.com>
Subject: [PATCH v3 2/2] MIPS: use generic GCC library routines from lib/
Date:   Wed, 31 Jan 2018 18:33:37 +0300
Message-Id: <20180131153337.29021-3-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180131153337.29021-1-antonynpavlov@gmail.com>
References: <20180131153337.29021-1-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62381
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
index 350a990fc719..b63a5422d485 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -18,16 +18,21 @@ config MIPS
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select CPU_PM if CPU_IDLE
+	select GENERIC_ASHLDI3
+	select GENERIC_ASHRDI3
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
+	select GENERIC_CMPDI2
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
+	select GENERIC_LSHRDI3
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_UCMPDI2
 	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KGDB
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
