Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Oct 2011 15:44:15 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:1373 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491019Ab1JWNoJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 Oct 2011 15:44:09 +0200
X-TM-IMSS-Message-ID: <b9685e6b0004e55a@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id b9685e6b0004e55a ; Sun, 23 Oct 2011 06:43:59 -0700
Date:   Sun, 23 Oct 2011 19:08:18 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 01/12] MIPS: Netlogic: Style fixes for Platform
Message-ID: <20111023133811.GA21170@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 23 Oct 2011 13:36:17.0550 (UTC) FILETIME=[BDF60AE0:01CC9188]
X-archive-position: 31270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16575

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
