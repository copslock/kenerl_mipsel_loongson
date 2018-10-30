Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2018 02:28:18 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:42879 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994243AbeJ3B2Bqmgpb convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 30 Oct 2018 02:28:01 +0100
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 30 Oct 2018 01:27:56 +0000
Received: from ubuntu-hassan.mipstec.com (10.20.2.43) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Mon, 29
 Oct 2018 18:28:20 -0700
From:   Hassan Naveed <hassan.naveed@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Hassan Naveed <hnaveed@wavecomp.com>
Subject: [PATCH] MIPS: Enable IOREMAP_PROT config option for MIPS cpus
Date:   Mon, 29 Oct 2018 18:27:41 -0700
Message-ID: <20181030012741.31391-1-hassan.naveed@mips.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.20.2.43]
X-ClientProxiedBy: mipsdag01.mipstec.com (10.20.40.46) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1540862875-298554-14355-130617-1
X-BESS-VER: 2018.14-r1810251557
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.202835
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Hassan.Naveed@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hassan.naveed@mips.com
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

From: Hassan Naveed <hnaveed@wavecomp.com>

Allows the users of ptrace to access memory mapped by the ptraced process
using the same cache coherency attributes as the original process.
For example while using gdb with ioremap_prot() incorporated, both gdb and
the process being traced will have same cache coherency attributes.

Signed-off-by: Hassan Naveed <hnaveed@wavecomp.com>
---
 .../features/vm/ioremap_prot/arch-support.txt        |  2 +-
 arch/mips/Kconfig                                    |  1 +
 arch/mips/include/asm/io.h                           | 12 ++++++++++++
 arch/mips/include/asm/page.h                         |  1 +
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
index 8527601a3739..326e4797bc65 100644
--- a/Documentation/features/vm/ioremap_prot/arch-support.txt
+++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
@@ -16,7 +16,7 @@
     |        ia64: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
-    |        mips: | TODO |
+    |        mips: |  ok  |
     |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 35511999156a..630a4d694b02 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -56,6 +56,7 @@ config MIPS
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_IDE
+	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KPROBES
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 54c730aed327..61eca84d8b82 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -223,6 +223,18 @@ static inline void __iomem * __ioremap_mode(phys_addr_t offset, unsigned long si
 #undef __IS_LOW512
 }
 
+/*
+ * ioremap_prot     -   map bus memory into CPU space
+ * @offset:    bus address of the memory
+ * @size:      size of the resource to map
+
+ * ioremap_prot gives the caller control over cache coherency attributes (CCA)
+ */
+static inline void __iomem *ioremap_prot(phys_addr_t offset,
+		unsigned long size, unsigned long prot_val) {
+	return __ioremap_mode(offset, size, prot_val & _CACHE_MASK);
+}
+
 /*
  * ioremap     -   map bus memory into CPU space
  * @offset:    bus address of the memory
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index e8cc328fce2d..6b31c93b5eaa 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -154,6 +154,7 @@ typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
 #define pgprot_val(x)	((x).pgprot)
 #define __pgprot(x)	((pgprot_t) { (x) } )
+#define pte_pgprot(x)	__pgprot(pte_val(x) & ~_PFN_MASK)
 
 /*
  * On R4000-style MMUs where a TLB entry is mapping a adjacent even / odd
-- 
2.19.0
