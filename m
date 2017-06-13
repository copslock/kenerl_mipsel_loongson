Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jun 2017 19:02:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61591 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993911AbdFMRByts0x5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Jun 2017 19:01:54 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTP id B39B87592322;
        Tue, 13 Jun 2017 18:01:44 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 13 Jun 2017 18:01:48
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Bryan O'Donoghue <Bryan.ODonoghue@imgtec.com>,
        Ed Blake <ed.blake@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2] MIPS: Perform post-DMA cache flushes on systems with MAARs
Date:   Tue, 13 Jun 2017 10:01:08 -0700
Message-ID: <20170613170108.15875-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170612214218.25370-1-paul.burton@imgtec.com>
References: <20170612214218.25370-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58424
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

Note that the return type of cpu_needs_post_dma_flush() is changed to
bool, such that it's clearer what's happening when cpu_has_maar is cast
to bool for the return value. If this patch were backported to a
pre-v4.7 kernel then MIPS_CPU_MAAR was 1ull<<34, so when cast to an int
we would incorrectly return 0. It so happens that MIPS_CPU_MAAR is
currently 1ull<<30, so when truncated to an int gives a non-zero value
anyway, but even so the implicit conversion from long long int to bool
makes it clearer to understand what will happen than the implicit
conversion from long long int to int would. The bool return type also
fits this usage better semantically, so seems like an all-round win.

Thanks to Ed for spotting the issue for pre-v4.7 kernels & suggesting
the return type change.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Bryan O'Donoghue <Bryan.ODonoghue@imgtec.com>
Cc: Ed Blake <ed.blake@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

Changes in v2:
- Change cpu_needs_post_dma_flush() return type to bool.
- Comment explaining the default cpu_has_maar case.

 arch/mips/mm/dma-default.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index fe8df14b6169..e08598c70b3e 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -68,12 +68,25 @@ static inline struct page *dma_addr_to_page(struct device *dev,
  * systems and only the R10000 and R12000 are used in such systems, the
  * SGI IP28 Indigo² rsp. SGI IP32 aka O2.
  */
-static inline int cpu_needs_post_dma_flush(struct device *dev)
+static inline bool cpu_needs_post_dma_flush(struct device *dev)
 {
-	return !plat_device_is_coherent(dev) &&
-	       (boot_cpu_type() == CPU_R10000 ||
-		boot_cpu_type() == CPU_R12000 ||
-		boot_cpu_type() == CPU_BMIPS5000);
+	if (plat_device_is_coherent(dev))
+		return false;
+
+	switch (boot_cpu_type()) {
+	case CPU_R10000:
+	case CPU_R12000:
+	case CPU_BMIPS5000:
+		return true;
+
+	default:
+		/*
+		 * Presence of MAARs suggests that the CPU supports
+		 * speculatively prefetching data, and therefore requires
+		 * the post-DMA flush/invalidate.
+		 */
+		return cpu_has_maar;
+	}
 }
 
 static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
-- 
2.13.1
