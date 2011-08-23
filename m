Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Aug 2011 10:09:30 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:4873 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491846Ab1HWIJU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Aug 2011 10:09:20 +0200
X-TM-IMSS-Message-ID: <5bb8afaf0000ab73@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 5bb8afaf0000ab73 ; Tue, 23 Aug 2011 01:07:19 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 23 Aug 2011 01:01:51 -0700
Date:   Tue, 23 Aug 2011 13:35:08 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 1/4] MIPS: Netlogic: Change load address
Message-ID: <34f7e6b49638c11ba32e6cbe0dd22cc1207c84ad.1314086142.git.jayachandranc@netlogicmicro.com>
References: <cover.1314086142.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1314086142.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 23 Aug 2011 08:01:51.0761 (UTC) FILETIME=[EA9EE010:01CC616A]
X-archive-position: 30949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16619

Move load address from 0x84000000 to 0x80100000 to avoid wasting
memory.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/netlogic/Platform |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/netlogic/Platform b/arch/mips/netlogic/Platform
index b648b48..502d912 100644
--- a/arch/mips/netlogic/Platform
+++ b/arch/mips/netlogic/Platform
@@ -13,4 +13,4 @@ cflags-$(CONFIG_NLM_XLR)	+= $(call cc-option,-march=xlr,-march=mips64)
 # NETLOGIC XLR/XLS SoC, Simulator and boards
 #
 core-$(CONFIG_NLM_XLR)	      += arch/mips/netlogic/xlr/
-load-$(CONFIG_NLM_XLR_BOARD)  += 0xffffffff84000000
+load-$(CONFIG_NLM_XLR_BOARD)  += 0xffffffff80100000
-- 
1.7.4.1
