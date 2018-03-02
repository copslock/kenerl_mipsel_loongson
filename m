Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2018 11:17:07 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:38194 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992916AbeCBKQ7Bjs-H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Mar 2018 11:16:59 +0100
Received: from localhost (clnet-b04-243.ikbnet.co.at [83.175.124.243])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5A9E311C2;
        Fri,  2 Mar 2018 08:59:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        James Hogan <jhogan@kernel.org>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Matthew Fortune <matthew.fortune@mips.com>,
        Florian Fainelli <florian@openwrt.org>,
        linux-mips@linux-mips.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 56/56] MIPS: Implement __multi3 for GCC7 MIPS64r6 builds
Date:   Fri,  2 Mar 2018 09:51:42 +0100
Message-Id: <20180302084452.354487935@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

commit ebabcf17bcd7ce968b1631ebe08236275698f39b upstream.

GCC7 is a bit too eager to generate suboptimal __multi3 calls (128bit
multiply with 128bit result) for MIPS64r6 builds, even in code which
doesn't explicitly use 128bit types, such as the following:

unsigned long func(unsigned long a, unsigned long b)
{
	return a > (~0UL) / b;
}

Which GCC rearanges to:

return (unsigned __int128)a * (unsigned __int128)b > 0xffffffffffffffff;

Therefore implement __multi3, but only for MIPS64r6 with GCC7 as under
normal circumstances we wouldn't expect any calls to __multi3 to be
generated from kernel code.

Reported-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: James Hogan <jhogan@kernel.org>
Tested-by: Waldemar Brodkorb <wbx@openadk.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@mips.com>
Cc: Matthew Fortune <matthew.fortune@mips.com>
Cc: Florian Fainelli <florian@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17890/
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lib/Makefile |    3 +-
 arch/mips/lib/libgcc.h |   17 +++++++++++++++
 arch/mips/lib/multi3.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)

--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -15,4 +15,5 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb
 obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
 
 # libgcc-style stuff needed in the kernel
-obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o ucmpdi2.o
+obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o multi3.o \
+	 ucmpdi2.o
--- a/arch/mips/lib/libgcc.h
+++ b/arch/mips/lib/libgcc.h
@@ -9,10 +9,18 @@ typedef int word_type __attribute__ ((mo
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
@@ -22,4 +30,13 @@ typedef union {
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
--- /dev/null
+++ b/arch/mips/lib/multi3.c
@@ -0,0 +1,54 @@
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
+
+	asm ("dmulu %0,%1,%2" : "=r" (res) : "r" (a), "r" (b));
+	return res;
+}
+
+/* multiply 64-bit unsigned values, high 64-bits of 128-bit result returned */
+static inline long long notrace dmuhu(long long a, long long b)
+{
+	long long res;
+
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
