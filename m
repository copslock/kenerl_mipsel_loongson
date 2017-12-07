Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2017 08:21:16 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:55354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990409AbdLGHVJcA9m2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Dec 2017 08:21:09 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 455FA21985;
        Thu,  7 Dec 2017 07:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455FA21985
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        James Hogan <jhogan@kernel.org>,
        "Maciej W . Rozycki" <macro@mips.com>,
        Matthew Fortune <matthew.fortune@mips.com>,
        Florian Fainelli <florian@openwrt.org>,
        Waldemar Brodkorb <wbx@openadk.org>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Implement __multi3 for GCC7 MIPS64r6 builds
Date:   Thu,  7 Dec 2017 07:20:46 +0000
Message-Id: <20171207072046.31125-1-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171206085034.3869dc9d@windsurf.lan>
References: <20171206085034.3869dc9d@windsurf.lan>
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61332
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

GCC7 is a bit too eager to generate suboptimal __multi3 calls (128bit
multiply with 128bit result) for MIPS64r6 builds, even in code which
doesn't explicitly use 128bit types, such as the following:

unsigned long func(unsigned long a, unsigned long b)
{
	return a > (~0UL) / b;
}

Which GCC rearanges to:

return (unsigned __int128)a * (unsigned __int128)b > 0xffffffff;

Therefore implement __multi3, but only for MIPS64r6 with GCC7 as under
normal circumstances we wouldn't expect any calls to __multi3 to be
generated from kernel code.

Reported-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@mips.com>
Cc: Matthew Fortune <matthew.fortune@mips.com>
Cc: Florian Fainelli <florian@openwrt.org>
Cc: Waldemar Brodkorb <wbx@openadk.org>
Cc: linux-mips@linux-mips.org
---
This should fix the issue Thomas. Thanks for reporting.
---
 arch/mips/lib/Makefile |  3 ++-
 arch/mips/lib/libgcc.h | 17 +++++++++++++++++
 arch/mips/lib/multi3.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/lib/multi3.c

diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 78c2affeabf8..e84e12655fa8 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -16,4 +16,5 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
 obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
 
 # libgcc-style stuff needed in the kernel
-obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o ucmpdi2.o
+obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o multi3.o \
+	 ucmpdi2.o
diff --git a/arch/mips/lib/libgcc.h b/arch/mips/lib/libgcc.h
index 28002ed90c2c..199a7f96282f 100644
--- a/arch/mips/lib/libgcc.h
+++ b/arch/mips/lib/libgcc.h
@@ -10,10 +10,18 @@ typedef int word_type __attribute__ ((mode (__word__)));
 struct DWstruct {
 	int high, low;
 };
+
+struct TWstruct {
+	long long high, low;
+};
 #elif defined(__LITTLE_ENDIAN)
 struct DWstruct {
 	int low, high;
 };
+
+struct TWstruct {
+	long long low, high;
+};
 #else
 #error I feel sick.
 #endif
@@ -23,4 +31,13 @@ typedef union {
 	long long ll;
 } DWunion;
 
+#if defined(CONFIG_64BIT) && defined(CONFIG_CPU_MIPSR6)
+typedef int ti_type __attribute__((mode(TI)));
+
+typedef union {
+	struct TWstruct s;
+	ti_type ti;
+} TWunion;
+#endif
+
 #endif /* __ASM_LIBGCC_H */
diff --git a/arch/mips/lib/multi3.c b/arch/mips/lib/multi3.c
new file mode 100644
index 000000000000..fba123e366c8
--- /dev/null
+++ b/arch/mips/lib/multi3.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/export.h>
+
+#include "libgcc.h"
+
+/*
+ * GCC 7 suboptimally generates __multi3 calls for mips64r6, so for that
+ * specific case only we'll implement it here.
+ *
+ * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82981
+ */
+#if defined(CONFIG_64BIT) && defined(CONFIG_CPU_MIPSR6) && (__GNUC__ == 7)
+
+/* multiply 64-bit values, low 64-bits returned */
+static inline long long notrace dmulu(long long a, long long b)
+{
+	long long res;
+	asm ("dmulu %0,%1,%2" : "=r" (res) : "r" (a), "r" (b));
+	return res;
+}
+
+/* multiply 64-bit unsigned values, high 64-bits of 128-bit result returned */
+static inline long long notrace dmuhu(long long a, long long b)
+{
+	long long res;
+	asm ("dmuhu %0,%1,%2" : "=r" (res) : "r" (a), "r" (b));
+	return res;
+}
+
+/* multiply 128-bit values, low 128-bits returned */
+ti_type notrace __multi3(ti_type a, ti_type b)
+{
+	TWunion res, aa, bb;
+
+	aa.ti = a;
+	bb.ti = b;
+
+	/*
+	 * a * b =           (a.lo * b.lo)
+	 *         + 2^64  * (a.hi * b.lo + a.lo * b.hi)
+	 *        [+ 2^128 * (a.hi * b.hi)]
+	 */
+	res.s.low = dmulu(aa.s.low, bb.s.low);
+	res.s.high = dmuhu(aa.s.low, bb.s.low);
+	res.s.high += dmulu(aa.s.high, bb.s.low);
+	res.s.high += dmulu(aa.s.low, bb.s.high);
+
+	return res.ti;
+}
+EXPORT_SYMBOL(__multi3);
+
+#endif /* 64BIT && CPU_MIPSR6 && GCC7 */
-- 
2.13.6
