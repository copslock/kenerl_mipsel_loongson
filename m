Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2014 21:19:26 +0200 (CEST)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:19170 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27028420AbaHVTTHBhLRp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2014 21:19:07 +0200
X-IronPort-AV: E=Sophos;i="5.04,377,1406617200"; 
   d="scan'208";a="43542981"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw1-out.broadcom.com with ESMTP; 21 Aug 2014 22:19:52 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Thu, 21 Aug 2014 21:28:31 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Thu, 21 Aug 2014 21:28:31 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 1BF889F9FD;    Thu, 21 Aug 2014 21:28:29 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>,
        <chenhc@lemote.com>
Subject: [PATCH 1/2] MIPS: Netlogic: Use MIPS topology.h
Date:   Fri, 22 Aug 2014 09:48:31 +0530
Message-ID: <1408681112-26744-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <CAAhV-H7x3FDAXYcH6J8mDeBnrgV1CZZtizerjHRa4cj_oZ1PuQ@mail.gmail.com>
References: <CAAhV-H7x3FDAXYcH6J8mDeBnrgV1CZZtizerjHRa4cj_oZ1PuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42165
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
added topology related macros for all MIPS platforms. This causes
compile failure for Netlogic platforms with errors like:

arch/mips/include/asm/mach-netlogic/topology.h:14:0: error: "topology_physical_package_id" redefined [-Werror]

Fix this by dropping Netlogic specific topology.h and setting up package
field in cpu data.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
[Resending this, looks like linux-mips.org is down]

 arch/mips/include/asm/mach-netlogic/topology.h |   22 ----------------------
 arch/mips/netlogic/common/smp.c                |    1 +
 2 files changed, 1 insertion(+), 22 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-netlogic/topology.h

diff --git a/arch/mips/include/asm/mach-netlogic/topology.h b/arch/mips/include/asm/mach-netlogic/topology.h
deleted file mode 100644
index ceeb1f5..0000000
--- a/arch/mips/include/asm/mach-netlogic/topology.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2013 Broadcom Corporation
- */
-#ifndef _ASM_MACH_NETLOGIC_TOPOLOGY_H
-#define _ASM_MACH_NETLOGIC_TOPOLOGY_H
-
-#include <asm/mach-netlogic/multi-node.h>
-
-#ifdef CONFIG_SMP
-#define topology_physical_package_id(cpu)	cpu_to_node(cpu)
-#define topology_core_id(cpu)	(cpu_logical_map(cpu) / NLM_THREADS_PER_CORE)
-#define topology_thread_cpumask(cpu)		(&cpu_sibling_map[cpu])
-#define topology_core_cpumask(cpu)	cpumask_of_node(cpu_to_node(cpu))
-#endif
-
-#include <asm-generic/topology.h>
-
-#endif /* _ASM_MACH_NETLOGIC_TOPOLOGY_H */
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index 4fde7ac..f23fe22 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -120,6 +120,7 @@ static void nlm_init_secondary(void)
 
 	hwtid = hard_smp_processor_id();
 	current_cpu_data.core = hwtid / NLM_THREADS_PER_CORE;
+	current_cpu_data.package = nlm_cpuid_to_node(hwtid);
 	nlm_percpu_init(hwtid);
 	nlm_smp_irq_init(hwtid);
 }
-- 
1.7.9.5
