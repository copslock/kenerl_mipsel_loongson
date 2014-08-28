Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 18:03:19 +0200 (CEST)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:53251 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007231AbaH1QDSIkJBG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Aug 2014 18:03:18 +0200
X-IronPort-AV: E=Sophos;i="5.04,418,1406617200"; 
   d="scan'208";a="43917619"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw2-out.broadcom.com with ESMTP; 28 Aug 2014 09:18:17 -0700
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Thu, 28 Aug 2014 09:03:10 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP Server id
 14.3.174.1; Thu, 28 Aug 2014 09:03:09 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 1FF329F9FF;    Thu, 28 Aug 2014 09:03:07 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] MIPS: Netlogic: Use MIPS topology.h
Date:   Thu, 28 Aug 2014 21:23:52 +0530
Message-ID: <1409241232-4205-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <Message-ID: <20140825132050.GH27724@linux-mips.org>
References: <Message-ID: <20140825132050.GH27724@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42312
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

commit bbbf6d8768f5 ("MIPS: NL: Fix nlm_xlp_defconfig build error")
removed topology related macros from mach-netlogic/topology.h, but
did not setup the current_cpu_data.package.

Fix this by setting the package field in netlogic/common/smp.c. Also
mach-netlogic/topology.h can be removed now as it no longer needs to
override mips topology definitions.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Huacai Chen <chenhc@lemote.com>
---
[ Ralf: This is for 3.17, fixes an issue which went into -rc1, and was fixed
  partially in -rc2]

 arch/mips/include/asm/mach-netlogic/topology.h | 15 ---------------
 arch/mips/netlogic/common/smp.c                |  1 +
 2 files changed, 1 insertion(+), 15 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-netlogic/topology.h

diff --git a/arch/mips/include/asm/mach-netlogic/topology.h b/arch/mips/include/asm/mach-netlogic/topology.h
deleted file mode 100644
index 0eb43c8..0000000
--- a/arch/mips/include/asm/mach-netlogic/topology.h
+++ /dev/null
@@ -1,15 +0,0 @@
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
1.9.1
