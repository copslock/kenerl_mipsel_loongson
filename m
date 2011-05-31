Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 May 2011 10:48:55 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:3793 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491059Ab1EaIst (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 May 2011 10:48:49 +0200
X-TM-IMSS-Message-ID: <ab47b5ee000752e7@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id ab47b5ee000752e7 ; Tue, 31 May 2011 01:47:58 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 31 May 2011 01:49:48 -0700
Date:   Tue, 31 May 2011 14:18:59 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH] Add netlogic to mips build platforms.
Message-ID: <20110531084853.GA10062@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 31 May 2011 08:49:48.0790 (UTC) FILETIME=[B2C3A960:01CC1F6F]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

arch/mips/netlogic/Platform added with platform make flags.
netlogic entry added to arch/mips/Kbuild.platforms.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/Kbuild.platforms  |    1 +
 arch/mips/netlogic/Platform |   11 +++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/netlogic/Platform

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index aef6c91..5ce8029 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -16,6 +16,7 @@ platforms += lasat
 platforms += loongson
 platforms += mipssim
 platforms += mti-malta
+platforms += netlogic
 platforms += pmc-sierra
 platforms += pnx833x
 platforms += pnx8550
diff --git a/arch/mips/netlogic/Platform b/arch/mips/netlogic/Platform
new file mode 100644
index 0000000..d41edc3
--- /dev/null
+++ b/arch/mips/netlogic/Platform
@@ -0,0 +1,11 @@
+#
+# NETLOGIC includes
+#
+cflags-$(CONFIG_NLM_COMMON)		+= -I$(srctree)/arch/mips/include/asm/mach-netlogic
+cflags-$(CONFIG_NLM_COMMON)		+= -I$(srctree)/arch/mips/include/asm/netlogic
+
+#
+# NETLOGIC XLR/XLS SoC, Simulator and boards
+#
+core-$(CONFIG_NLM_XLR)      		+= arch/mips/netlogic/xlr/
+load-$(CONFIG_NLM_XLR_BOARD)		+= 0xffffffff84000000
-- 
1.7.4.1
