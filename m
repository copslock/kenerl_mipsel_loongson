Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2012 03:40:11 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:54640 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6828067Ab2KVCfjQGSXb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Nov 2012 03:35:39 +0100
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 21 Nov 2012 18:35:31 -0800
Received: by agni.kymasys.com (Postfix, from userid 500)
        id B4CDE630285; Wed, 21 Nov 2012 18:34:18 -0800 (PST)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 16/18] MIPS: Export symbols used by KVM/MIPS module
Date:   Wed, 21 Nov 2012 18:34:14 -0800
Message-Id: <1353551656-23579-17-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
X-archive-position: 35092
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
index f468185..a424028 100644
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
