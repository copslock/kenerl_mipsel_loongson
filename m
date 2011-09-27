Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2011 10:29:21 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:1390 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491802Ab1I0I3O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Sep 2011 10:29:14 +0200
X-TM-IMSS-Message-ID: <3263265f0000108c@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id 3263265f0000108c ; Tue, 27 Sep 2011 01:29:07 -0700
Received: from orion8.netlogicmicro.com (10.10.16.60) by
 hqcas01.netlogicmicro.com (10.10.50.14) with Microsoft SMTP Server id
 14.1.339.1; Tue, 27 Sep 2011 01:29:06 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by
 orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);         Tue, 27 Sep
 2011 01:28:10 -0700
Date:   Tue, 27 Sep 2011 14:07:01 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: [PATCH 1/9] MIPS: Netlogic: Style fixes for Platform
Message-ID: <24108a12da253e6311399fd70ddc3a38467fd0a9.1317111127.git.jayachandranc@netlogicmicro.com>
References: <cover.1317111127.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1317111127.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 27 Sep 2011 08:28:10.0700 (UTC) FILETIME=[643318C0:01CC7CEF]
X-archive-position: 31172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15272

- Use platform- variable for xlr
- Load address common for all netlogic chips

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/netlogic/Platform |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/netlogic/Platform b/arch/mips/netlogic/Platform
index 502d912..4fb6b83 100644
--- a/arch/mips/netlogic/Platform
+++ b/arch/mips/netlogic/Platform
@@ -1,8 +1,8 @@
 #
 # NETLOGIC includes
 #
-cflags-$(CONFIG_NLM_COMMON)  += -I$(srctree)/arch/mips/include/asm/mach-netlogic
-cflags-$(CONFIG_NLM_COMMON)  += -I$(srctree)/arch/mips/include/asm/netlogic
+cflags-$(CONFIG_NLM_COMMON)	+= -I$(srctree)/arch/mips/include/asm/mach-netlogic
+cflags-$(CONFIG_NLM_COMMON)	+= -I$(srctree)/arch/mips/include/asm/netlogic
 
 #
 # use mips64 if xlr is not available
@@ -10,7 +10,7 @@ cflags-$(CONFIG_NLM_COMMON)  += -I$(srctree)/arch/mips/include/asm/netlogic
 cflags-$(CONFIG_NLM_XLR)	+= $(call cc-option,-march=xlr,-march=mips64)
 
 #
-# NETLOGIC XLR/XLS SoC, Simulator and boards
+# NETLOGIC processor support
 #
-core-$(CONFIG_NLM_XLR)	      += arch/mips/netlogic/xlr/
-load-$(CONFIG_NLM_XLR_BOARD)  += 0xffffffff80100000
+platform-$(CONFIG_NLM_XLR)  	+= netlogic/xlr
+load-$(CONFIG_NLM_COMMON)  	+= 0xffffffff80100000
-- 
1.7.4.1
