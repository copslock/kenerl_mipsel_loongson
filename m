Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2018 12:12:15 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:56192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990498AbeDQKLyjPYj4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Apr 2018 12:11:54 +0200
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1E0C21838;
        Tue, 17 Apr 2018 10:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E0C21838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH v3 1/3] alpha: Use OPTIMIZE_INLINING instead of asm/compiler.h
Date:   Tue, 17 Apr 2018 11:11:04 +0100
Message-Id: <a20761a842efe590da08e835ecc5690a4cf50213.1523959603.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
References: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
In-Reply-To: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
References: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

Use CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING and CONFIG_OPTIMIZE_INLINING
instead of undefining the inline macros in the alpha specific
asm/compiler.h. This is to allow asm/compiler.h to become a general
header that can be used for overriding linux/compiler*.h.

A build of alpha's defconfig on GCC 7.3 before and after this series
(i.e. this commit and "compiler.h: Allow arch-specific overrides" which
includes asm/compiler.h from linux/compiler_types.h) results in the
following size differences, which appear harmless to me:

$ ./scripts/bloat-o-meter vmlinux.1 vmlinux.2
add/remove: 1/1 grow/shrink: 3/0 up/down: 264/-348 (-84)
Function                                     old     new   delta
cap_bprm_set_creds                          1496    1664    +168
cap_issubset                                   -      68     +68
flex_array_put                               328     344     +16
cap_capset                                   488     500     +12
nonroot_raised_pE.constprop                  348       -    -348
Total: Before=5823709, After=5823625, chg -0.00%

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
Changes in v3 (James):
- New patch in v3.
---
 arch/alpha/Kconfig                |  6 ++++++
 arch/alpha/include/asm/compiler.h | 11 -----------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index b2022885ced8..b296ba9bd8b7 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -81,6 +81,12 @@ config PGTABLE_LEVELS
 	int
 	default 3
 
+config ARCH_SUPPORTS_OPTIMIZED_INLINING
+	def_bool y
+
+config OPTIMIZE_INLINING
+	def_bool y
+
 source "init/Kconfig"
 source "kernel/Kconfig.freezer"
 
diff --git a/arch/alpha/include/asm/compiler.h b/arch/alpha/include/asm/compiler.h
index 5159ba259d65..ae645959018a 100644
--- a/arch/alpha/include/asm/compiler.h
+++ b/arch/alpha/include/asm/compiler.h
@@ -4,15 +4,4 @@
 
 #include <uapi/asm/compiler.h>
 
-/* Some idiots over in <linux/compiler.h> thought inline should imply
-   always_inline.  This breaks stuff.  We'll include this file whenever
-   we run into such problems.  */
-
-#include <linux/compiler.h>
-#undef inline
-#undef __inline__
-#undef __inline
-#undef __always_inline
-#define __always_inline		inline __attribute__((always_inline))
-
 #endif /* __ALPHA_COMPILER_H */
-- 
git-series 0.9.1
