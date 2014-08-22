Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2014 21:19:08 +0200 (CEST)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:21202 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27028460AbaHVTTHAzZl2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2014 21:19:07 +0200
X-IronPort-AV: E=Sophos;i="5.04,377,1406617200"; 
   d="scan'208";a="43081614"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw3-out.broadcom.com with ESMTP; 21 Aug 2014 21:43:05 -0700
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Thu, 21 Aug 2014 21:28:33 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP Server id
 14.3.174.1; Thu, 21 Aug 2014 21:28:33 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 AB8F39FA03;    Thu, 21 Aug 2014 21:28:31 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>,
        <chenhc@lemote.com>
Subject: [PATCH 2/2] MIPS: Move topology macros to topology.h
Date:   Fri, 22 Aug 2014 09:48:32 +0530
Message-ID: <1408681112-26744-2-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1408681112-26744-1-git-send-email-jchandra@broadcom.com>
References: <CAAhV-H7x3FDAXYcH6J8mDeBnrgV1CZZtizerjHRa4cj_oZ1PuQ@mail.gmail.com>
 <1408681112-26744-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

commit bda4584cd943 ("MIPS: Support CPU topology files in sysfs")
added MIPS topology related macros to asm/smp.h. Move these to
asm/topology.h.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
[Resending this, looks like linux-mips.org is down]

 arch/mips/include/asm/smp.h      |    5 -----
 arch/mips/include/asm/topology.h |    5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 1e0f20a..eacf865 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -37,11 +37,6 @@ extern int __cpu_logical_map[NR_CPUS];
 
 #define NO_PROC_ID	(-1)
 
-#define topology_physical_package_id(cpu)	(cpu_data[cpu].package)
-#define topology_core_id(cpu)			(cpu_data[cpu].core)
-#define topology_core_cpumask(cpu)		(&cpu_core_map[cpu])
-#define topology_thread_cpumask(cpu)		(&cpu_sibling_map[cpu])
-
 #define SMP_RESCHEDULE_YOURSELF 0x1	/* XXX braindead */
 #define SMP_CALL_FUNCTION	0x2
 /* Octeon - Tell another core to flush its icache */
diff --git a/arch/mips/include/asm/topology.h b/arch/mips/include/asm/topology.h
index 20ea485..e012429 100644
--- a/arch/mips/include/asm/topology.h
+++ b/arch/mips/include/asm/topology.h
@@ -10,4 +10,9 @@
 
 #include <topology.h>
 
+#define topology_physical_package_id(cpu)	(cpu_data[cpu].package)
+#define topology_core_id(cpu)			(cpu_data[cpu].core)
+#define topology_core_cpumask(cpu)		(&cpu_core_map[cpu])
+#define topology_thread_cpumask(cpu)		(&cpu_sibling_map[cpu])
+
 #endif /* __ASM_TOPOLOGY_H */
-- 
1.7.9.5
