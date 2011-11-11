Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 12:35:45 +0100 (CET)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:1067 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1903959Ab1KKLf2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2011 12:35:28 +0100
X-TM-IMSS-Message-ID: <1acb1e730007c9d1@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id 1acb1e730007c9d1 ; Fri, 11 Nov 2011 03:35:21 -0800
Date:   Fri, 11 Nov 2011 17:07:24 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: [PATCH 01/12] MIPS: Netlogic: Style fixes for Platform
Message-ID: <25708afa4858007e33fdf243417cc7b7a501c0bb.1321011000.git.jayachandranc@netlogicmicro.com>
References: <cover.1321010998.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1321010998.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 11 Nov 2011 11:35:20.0817 (UTC) FILETIME=[FE75B610:01CCA065]
X-archive-position: 31543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10219

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
1.7.5.4
