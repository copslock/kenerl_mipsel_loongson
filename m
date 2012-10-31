Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 16:25:54 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:49064 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6822164Ab2JaPVOl2mBm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Oct 2012 16:21:14 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 31 Oct 2012 08:21:07 -0700
From:   Sanjay Lal <sanjayl@kymasys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [PATCH 18/20] MIPS: Export symbols used by KVM/MIPS module
Date:   Wed, 31 Oct 2012 11:21:03 -0400
Message-Id: <FB1F4AAB-473A-41DC-8938-54464E0FAA73@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Mime-Version: 1.0 (Apple Message framework v1283)
X-Mailer: Apple Mail (2.1283)
X-archive-position: 34829
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kernel/smp.c | 1 +
 mm/bootmem.c           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 9005bf9..60ea489 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -83,6 +83,7 @@ static inline void set_cpu_sibling_map(int cpu)
 }
 
 struct plat_smp_ops *mp_ops;
+EXPORT_SYMBOL(mp_ops);
 
 __cpuinit void register_smp_ops(struct plat_smp_ops *ops)
 {
diff --git a/mm/bootmem.c b/mm/bootmem.c
index 434be4a..f9c0221 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -32,6 +32,7 @@ EXPORT_SYMBOL(contig_page_data);
 
 unsigned long max_low_pfn;
 unsigned long min_low_pfn;
+EXPORT_SYMBOL(min_low_pfn);
 unsigned long max_pfn;
 
 bootmem_data_t bootmem_node_data[MAX_NUMNODES] __initdata;
-- 
1.7.11.3
