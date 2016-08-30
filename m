Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 19:38:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60187 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992381AbcH3RfMyXMu0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2016 19:35:12 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1478A6E1822A7;
        Tue, 30 Aug 2016 18:34:53 +0100 (IST)
Received: from localhost (10.100.200.118) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 30 Aug
 2016 18:34:56 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 20/26] MIPS: Adjust MIPS64 CAC_BASE to reflect Config.K0
Date:   Tue, 30 Aug 2016 18:29:23 +0100
Message-ID: <20160830172929.16948-21-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160830172929.16948-1-paul.burton@imgtec.com>
References: <20160830172929.16948-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.118]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On MIPS64 we define the default CAC_BASE as one of the xkphys regions of
the virtual address space. Since the CCA is encoded in bits 61:59 of
xkphys addresses, fixing CAC_BASE to any particular one prevents us from
dynamically changing the CCA as we do for MIPS32 where CAC_BASE is
placed within kseg0. In order to make the kernel more generic, drop the
current kludge that gives CAC_BASE CCA=3 if CONFIG_DMA_NONCOHERENT is
selected (disregarding CONFIG_DMA_MAYBE_COHERENT) & CCA=5 (which is not
standardised by the architecture) otherwise. Instead read Config.K0 and
generate the appropriate offset into xkphys, presuming that either the
bootloader or early kernel code will have configured Config.K0
appropriately. This seems like the best option for a generic
implementation.

The ip27 spaces.h is adjusted to set its former value of CAC_BASE, since
it's the only user of CAC_BASE from assembly (in its smp_slave_setup
macro). This allows the generic case to focus solely on C code without
breaking ip27.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 arch/mips/include/asm/addrspace.h           | 3 +--
 arch/mips/include/asm/mach-generic/spaces.h | 8 +++-----
 arch/mips/include/asm/mach-ip27/spaces.h    | 1 +
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/addrspace.h b/arch/mips/include/asm/addrspace.h
index c5b04e7..4856adc 100644
--- a/arch/mips/include/asm/addrspace.h
+++ b/arch/mips/include/asm/addrspace.h
@@ -126,8 +126,7 @@
 #define PHYS_TO_XKSEG_UNCACHED(p)	PHYS_TO_XKPHYS(K_CALG_UNCACHED, (p))
 #define PHYS_TO_XKSEG_CACHED(p)		PHYS_TO_XKPHYS(K_CALG_COH_SHAREABLE, (p))
 #define XKPHYS_TO_PHYS(p)		((p) & TO_PHYS_MASK)
-#define PHYS_TO_XKPHYS(cm, a)		(_CONST64_(0x8000000000000000) | \
-					 (_CONST64_(cm) << 59) | (a))
+#define PHYS_TO_XKPHYS(cm, a)		(XKPHYS | (_ACAST64_(cm) << 59) | (a))
 
 /*
  * The ultimate limited of the 64-bit MIPS architecture:  2 bits for selecting
diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
index afc96ec..952b0fd 100644
--- a/arch/mips/include/asm/mach-generic/spaces.h
+++ b/arch/mips/include/asm/mach-generic/spaces.h
@@ -12,6 +12,8 @@
 
 #include <linux/const.h>
 
+#include <asm/mipsregs.h>
+
 /*
  * This gives the physical RAM offset.
  */
@@ -52,11 +54,7 @@
 #ifdef CONFIG_64BIT
 
 #ifndef CAC_BASE
-#ifdef CONFIG_DMA_NONCOHERENT
-#define CAC_BASE		_AC(0x9800000000000000, UL)
-#else
-#define CAC_BASE		_AC(0xa800000000000000, UL)
-#endif
+#define CAC_BASE	PHYS_TO_XKPHYS(read_c0_config() & CONF_CM_CMASK, 0)
 #endif
 
 #ifndef IO_BASE
diff --git a/arch/mips/include/asm/mach-ip27/spaces.h b/arch/mips/include/asm/mach-ip27/spaces.h
index b18802a..4775a11 100644
--- a/arch/mips/include/asm/mach-ip27/spaces.h
+++ b/arch/mips/include/asm/mach-ip27/spaces.h
@@ -19,6 +19,7 @@
 #define IO_BASE			0x9200000000000000
 #define MSPEC_BASE		0x9400000000000000
 #define UNCAC_BASE		0x9600000000000000
+#define CAC_BASE		0xa800000000000000
 
 #define TO_MSPEC(x)		(MSPEC_BASE | ((x) & TO_PHYS_MASK))
 #define TO_HSPEC(x)		(HSPEC_BASE | ((x) & TO_PHYS_MASK))
-- 
2.9.3
