Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2011 22:04:30 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:3177 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491160Ab1FUUEZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jun 2011 22:04:25 +0200
X-TM-IMSS-Message-ID: <19d7903e000ad30c@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 19d7903e000ad30c ; Tue, 21 Jun 2011 13:03:19 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 21 Jun 2011 13:04:52 -0700
Date:   Wed, 22 Jun 2011 01:36:33 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 1/2] MIPS:Netlogic:Specify architecture CFLAGS
Message-ID: <20110621200627.GA16193@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 21 Jun 2011 20:04:52.0284 (UTC) FILETIME=[7B671FC0:01CC304E]
X-archive-position: 30486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17506

Use -march=xlr if available, otherwise fallback to mips64. This allows
us to support compilation with MIPS toolchains which are not customized
for XLR.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/netlogic/Platform |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/netlogic/Platform b/arch/mips/netlogic/Platform
index f87c164..b648b48 100644
--- a/arch/mips/netlogic/Platform
+++ b/arch/mips/netlogic/Platform
@@ -5,6 +5,11 @@ cflags-$(CONFIG_NLM_COMMON)  += -I$(srctree)/arch/mips/include/asm/mach-netlogic
 cflags-$(CONFIG_NLM_COMMON)  += -I$(srctree)/arch/mips/include/asm/netlogic
 
 #
+# use mips64 if xlr is not available
+#
+cflags-$(CONFIG_NLM_XLR)	+= $(call cc-option,-march=xlr,-march=mips64)
+
+#
 # NETLOGIC XLR/XLS SoC, Simulator and boards
 #
 core-$(CONFIG_NLM_XLR)	      += arch/mips/netlogic/xlr/
-- 
1.7.4.1
