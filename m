Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2011 05:51:33 +0100 (CET)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:4982 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491052Ab1CYEva (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Mar 2011 05:51:30 +0100
X-TM-IMSS-Message-ID: <516531c90002ab93@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 516531c90002ab93 ; Thu, 24 Mar 2011 21:51:20 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 24 Mar 2011 21:52:06 -0700
Date:   Fri, 25 Mar 2011 10:28:09 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 4/7] Add XLR to asm/module.h
Message-ID: <ba147c1adee94bc50a1ba8acaa7fd96eb392e24d.1301028081.git.jayachandranc@netlogicmicro.com>
References: <cover.1301028080.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1301028080.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 25 Mar 2011 04:52:07.0160 (UTC) FILETIME=[647E5F80:01CBEAA8]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/include/asm/module.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
index d94085a..bc01a02 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -118,6 +118,8 @@ search_module_dbetables(unsigned long addr)
 #define MODULE_PROC_FAMILY "LOONGSON2 "
 #elif defined CONFIG_CPU_CAVIUM_OCTEON
 #define MODULE_PROC_FAMILY "OCTEON "
+#elif defined CONFIG_CPU_XLR
+#define MODULE_PROC_FAMILY "XLR "
 #else
 #error MODULE_PROC_FAMILY undefined for your processor configuration
 #endif
-- 
1.7.1


-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
jchandra@freebsd.org                               (The FreeBSD Project)
