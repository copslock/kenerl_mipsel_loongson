Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2014 16:33:27 +0200 (CEST)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:30646 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843084AbaD2ObyRkANl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Apr 2014 16:31:54 +0200
X-IronPort-AV: E=Sophos;i="4.97,951,1389772800"; 
   d="scan'208";a="27210953"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw1-out.broadcom.com with ESMTP; 29 Apr 2014 08:42:13 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Tue, 29 Apr 2014 07:31:46 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Tue, 29 Apr 2014 07:31:47 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 928D151E7E;    Tue, 29 Apr 2014 07:31:45 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 02/17] MIPS: Netlogic: Fix uniprocessor compilation
Date:   Tue, 29 Apr 2014 20:07:41 +0530
Message-ID: <86312bbcf6a5d9fe484cb22fa5f11d8c96e4eafe.1398780013.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1398780013.git.jchandra@broadcom.com>
References: <cover.1398780013.git.jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39972
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

The macros in topology.h need CONFIG_SMP, and the uniprocessor compilation
fails due to this. Wrap the macros in an ifdef so that uniprocessor works.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/mach-netlogic/topology.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/mach-netlogic/topology.h b/arch/mips/include/asm/mach-netlogic/topology.h
index 0da99fa..ceeb1f5 100644
--- a/arch/mips/include/asm/mach-netlogic/topology.h
+++ b/arch/mips/include/asm/mach-netlogic/topology.h
@@ -10,10 +10,12 @@
 
 #include <asm/mach-netlogic/multi-node.h>
 
+#ifdef CONFIG_SMP
 #define topology_physical_package_id(cpu)	cpu_to_node(cpu)
 #define topology_core_id(cpu)	(cpu_logical_map(cpu) / NLM_THREADS_PER_CORE)
 #define topology_thread_cpumask(cpu)		(&cpu_sibling_map[cpu])
 #define topology_core_cpumask(cpu)	cpumask_of_node(cpu_to_node(cpu))
+#endif
 
 #include <asm-generic/topology.h>
 
-- 
1.7.9.5
