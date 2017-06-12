Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jun 2017 23:42:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1791 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991346AbdFLVmk0Br8L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jun 2017 23:42:40 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 05C108744028F;
        Mon, 12 Jun 2017 22:42:30 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 12 Jun 2017 22:42:34
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Perform post-DMA cache flushes on systems with MAARs
Date:   Mon, 12 Jun 2017 14:42:17 -0700
Message-ID: <20170612214218.25370-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58415
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

Recent CPUs from Imagination Technologies such as the I6400 or P6600 are
able to speculatively fetch data from memory into caches. This means
that if used in a system with non-coherent DMA they require that caches
be invalidated after a device performs DMA, and before the CPU reads the
DMA'd data, in order to ensure that stale values weren't speculatively
prefetched.

Such CPUs also introduced Memory Accessibility Attribute Registers
(MAARs) in order to control the regions in which they are allowed to
speculate. Thus we can use the presence of MAARs as a good indication
that the CPU requires the above cache maintenance. Use the presence of
MAARs to determine the result of cpu_needs_post_dma_flush() in the
default case, in order to handle these recent CPUs correctly.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/mm/dma-default.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index fe8df14b6169..48f0354b1b09 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -70,10 +70,18 @@ static inline struct page *dma_addr_to_page(struct device *dev,
  */
 static inline int cpu_needs_post_dma_flush(struct device *dev)
 {
-	return !plat_device_is_coherent(dev) &&
-	       (boot_cpu_type() == CPU_R10000 ||
-		boot_cpu_type() == CPU_R12000 ||
-		boot_cpu_type() == CPU_BMIPS5000);
+	if (plat_device_is_coherent(dev))
+		return 0;
+
+	switch (boot_cpu_type()) {
+	case CPU_R10000:
+	case CPU_R12000:
+	case CPU_BMIPS5000:
+		return 1;
+
+	default:
+		return cpu_has_maar;
+	}
 }
 
 static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
-- 
2.13.1
