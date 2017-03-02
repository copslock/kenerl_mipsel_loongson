Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 10:38:27 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13375 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993868AbdCBJhWdYMQt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 10:37:22 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 3EB6158166F6E;
        Thu,  2 Mar 2017 09:37:14 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Mar 2017 09:37:15 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 2/32] MIPS: Separate MAAR V bit into VL and VH for XPA
Date:   Thu, 2 Mar 2017 09:36:29 +0000
Message-ID: <dc933d2e7365a9beb3b62906609f527c1bbf1de5.1488447004.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The MAAR V bit has been renamed VL since another bit called VH is added
at the top of the register when it is extended to 64-bits on a 32-bit
processor with XPA. Rename the V definition, fix the various users, and
add definitions for the VH bit. Also add a definition for the MAARI
Index field.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/maar.h     | 10 +++++-----
 arch/mips/include/asm/mipsregs.h |  8 +++++++-
 arch/mips/mm/init.c              |  2 +-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/maar.h b/arch/mips/include/asm/maar.h
index 21d9607c80d7..e10f78befbd9 100644
--- a/arch/mips/include/asm/maar.h
+++ b/arch/mips/include/asm/maar.h
@@ -36,7 +36,7 @@ unsigned platform_maar_init(unsigned num_pairs);
  * @upper:	The highest address that the MAAR pair will affect. Must be
  *		aligned to one byte before a 2^16 byte boundary.
  * @attrs:	The accessibility attributes to program, eg. MIPS_MAAR_S. The
- *		MIPS_MAAR_V attribute will automatically be set.
+ *		MIPS_MAAR_VL attribute will automatically be set.
  *
  * Program the pair of MAAR registers specified by idx to apply the attributes
  * specified by attrs to the range of addresses from lower to higher.
@@ -49,10 +49,10 @@ static inline void write_maar_pair(unsigned idx, phys_addr_t lower,
 	BUG_ON(((upper & 0xffff) != 0xffff)
 		|| ((upper & ~0xffffull) & ~(MIPS_MAAR_ADDR << 4)));
 
-	/* Automatically set MIPS_MAAR_V */
-	attrs |= MIPS_MAAR_V;
+	/* Automatically set MIPS_MAAR_VL */
+	attrs |= MIPS_MAAR_VL;
 
-	/* Write the upper address & attributes (only MIPS_MAAR_V matters) */
+	/* Write the upper address & attributes (only MIPS_MAAR_VL matters) */
 	write_c0_maari(idx << 1);
 	back_to_back_c0_hazard();
 	write_c0_maar(((upper >> 4) & MIPS_MAAR_ADDR) | attrs);
@@ -81,7 +81,7 @@ extern void maar_init(void);
  * @upper:	The highest address that the MAAR pair will affect. Must be
  *		aligned to one byte before a 2^16 byte boundary.
  * @attrs:	The accessibility attributes to program, eg. MIPS_MAAR_S. The
- *		MIPS_MAAR_V attribute will automatically be set.
+ *		MIPS_MAAR_VL attribute will automatically be set.
  *
  * Describes the configuration of a pair of Memory Accessibility Attribute
  * Registers - applying attributes from attrs to the range of physical
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index f8d1d2f1d80d..c20df6081479 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -34,8 +34,10 @@
  */
 #ifdef __ASSEMBLY__
 #define _ULCAST_
+#define _U64CAST_
 #else
 #define _ULCAST_ (unsigned long)
+#define _U64CAST_ (u64)
 #endif
 
 /*
@@ -719,10 +721,14 @@
 #define XLR_PERFCTRL_ALLTHREADS	(_ULCAST_(1) << 13)
 
 /* MAAR bit definitions */
+#define MIPS_MAAR_VH		(_U64CAST_(1) << 63)
 #define MIPS_MAAR_ADDR		((BIT_ULL(BITS_PER_LONG - 12) - 1) << 12)
 #define MIPS_MAAR_ADDR_SHIFT	12
 #define MIPS_MAAR_S		(_ULCAST_(1) << 1)
-#define MIPS_MAAR_V		(_ULCAST_(1) << 0)
+#define MIPS_MAAR_VL		(_ULCAST_(1) << 0)
+
+/* MAARI bit definitions */
+#define MIPS_MAARI_INDEX	(_ULCAST_(0x3f) << 0)
 
 /* EBase bit definitions */
 #define MIPS_EBASE_CPUNUM_SHIFT	0
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index aa75849c36bc..3ca20283b31e 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -348,7 +348,7 @@ void maar_init(void)
 		upper = ((upper & MIPS_MAAR_ADDR) << 4) | 0xffff;
 
 		pr_info("  [%d]: ", i / 2);
-		if (!(attr & MIPS_MAAR_V)) {
+		if (!(attr & MIPS_MAAR_VL)) {
 			pr_cont("disabled\n");
 			continue;
 		}
-- 
git-series 0.8.10
