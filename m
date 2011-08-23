Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Aug 2011 10:09:53 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:4877 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491914Ab1HWIJU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Aug 2011 10:09:20 +0200
X-TM-IMSS-Message-ID: <5bb8b01c0000ab74@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 5bb8b01c0000ab74 ; Tue, 23 Aug 2011 01:07:19 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 23 Aug 2011 01:02:12 -0700
Date:   Tue, 23 Aug 2011 13:35:30 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 2/4] MIPS: Netlogic: add r4k_wait as the cpu_wait
Message-ID: <875c162c5f475390dc05534f7ee2bd7e60260b51.1314086142.git.jayachandranc@netlogicmicro.com>
References: <cover.1314086142.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1314086142.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 23 Aug 2011 08:02:12.0762 (UTC) FILETIME=[F7235FA0:01CC616A]
X-archive-position: 30950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16620

Use r4k_wait as the CPU wait function for XLR/XLS processors.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/kernel/cpu-probe.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index ebc0cd2..664bc13 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -190,6 +190,7 @@ void __init check_wait(void)
 	case CPU_CAVIUM_OCTEON_PLUS:
 	case CPU_CAVIUM_OCTEON2:
 	case CPU_JZRISC:
+	case CPU_XLR:
 		cpu_wait = r4k_wait;
 		break;
 
-- 
1.7.4.1
