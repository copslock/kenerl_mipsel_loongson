Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jul 2017 15:35:18 +0200 (CEST)
Received: from cn.fujitsu.com ([59.151.112.132]:35759 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992036AbdGZNfKGCg90 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Jul 2017 15:35:10 +0200
X-IronPort-AV: E=Sophos;i="5.22,518,1449504000"; 
   d="scan'208";a="21846599"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Jul 2017 21:34:56 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 3D275402BB97;
        Wed, 26 Jul 2017 21:34:54 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.167.226.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.319.2; Wed, 26 Jul 2017 21:34:54 +0800
From:   Dou Liyang <douly.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mpe@ellerman.id.au>, Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 04/11] MIPS: numa: Remove the unused parent_node() macro
Date:   Wed, 26 Jul 2017 21:34:29 +0800
Message-ID: <1501076076-1974-5-git-send-email-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1501076076-1974-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1501076076-1974-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 3D275402BB97.AE90D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Return-Path: <douly.fnst@cn.fujitsu.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: douly.fnst@cn.fujitsu.com
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

Commit a7be6e5a7f8d ("mm: drop useless local parameters of
__register_one_node()") removes the last user of parent_node().

The parent_node() macros in both IP27 and Loongson64 are unnecessary.

Remove it for cleanup.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mach-ip27/topology.h       | 1 -
 arch/mips/include/asm/mach-loongson64/topology.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-ip27/topology.h b/arch/mips/include/asm/mach-ip27/topology.h
index defd135..3fb7a0e 100644
--- a/arch/mips/include/asm/mach-ip27/topology.h
+++ b/arch/mips/include/asm/mach-ip27/topology.h
@@ -23,7 +23,6 @@ struct cpuinfo_ip27 {
 extern struct cpuinfo_ip27 sn_cpu_info[NR_CPUS];
 
 #define cpu_to_node(cpu)	(sn_cpu_info[(cpu)].p_nodeid)
-#define parent_node(node)	(node)
 #define cpumask_of_node(node)	((node) == -1 ?				\
 				 cpu_all_mask :				\
 				 &hub_data(node)->h_cpus)
diff --git a/arch/mips/include/asm/mach-loongson64/topology.h b/arch/mips/include/asm/mach-loongson64/topology.h
index 0d8f3b5..bcb8856 100644
--- a/arch/mips/include/asm/mach-loongson64/topology.h
+++ b/arch/mips/include/asm/mach-loongson64/topology.h
@@ -4,7 +4,6 @@
 #ifdef CONFIG_NUMA
 
 #define cpu_to_node(cpu)	(cpu_logical_map(cpu) >> 2)
-#define parent_node(node)	(node)
 #define cpumask_of_node(node)	(&__node_data[(node)]->cpumask)
 
 struct pci_bus;
-- 
2.5.5
