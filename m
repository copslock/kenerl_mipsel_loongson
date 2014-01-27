Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:20:52 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43558 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823911AbaA0UU223AYU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:20:28 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 01/58] MIPS: Kconfig: Add Kconfig symbols for EVA support
Date:   Mon, 27 Jan 2014 20:18:48 +0000
Message-ID: <1390853985-14246-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_20_23
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Add basic Kconfig support for EVA. Not selectable by any platform
at this point.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/Kconfig | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f4c78c9..4230c7a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1446,6 +1446,26 @@ config CPU_XLP
 	  Netlogic Microsystems XLP processors.
 endchoice
 
+config CPU_MIPS32_3_5_FEATURES
+	bool "MIPS32 Release 3.5 Features"
+	depends on SYS_HAS_CPU_MIPS32_R3_5
+	depends on CPU_MIPS32_R2
+	help
+	  Choose this option to build a kernel for release 2 or later of the
+	  MIPS32 architecture including features from the 3.5 release such as
+	  support for Enhanced Virtual Addressing (EVA).
+
+config CPU_MIPS32_3_5_EVA
+	bool "Enhanced Virtual Addressing (EVA)"
+	depends on CPU_MIPS32_3_5_FEATURES
+	select EVA
+	default y
+	help
+	  Choose this option if you want to enable the Enhanced Virtual
+	  Addressing (EVA) on your MIPS32 core (such as proAptiv).
+	  One of its primary benefits is an increase in the maximum size
+	  of lowmem (up to 3GB). If unsure, say 'N' here.
+
 if CPU_LOONGSON2F
 config CPU_NOP_WORKAROUNDS
 	bool
@@ -1539,6 +1559,9 @@ config SYS_HAS_CPU_MIPS32_R1
 config SYS_HAS_CPU_MIPS32_R2
 	bool
 
+config SYS_HAS_CPU_MIPS32_R3_5
+	bool
+
 config SYS_HAS_CPU_MIPS64_R1
 	bool
 
@@ -1658,6 +1681,9 @@ config CPU_MIPSR2
 	bool
 	default y if CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_CAVIUM_OCTEON
 
+config EVA
+	bool
+
 config SYS_SUPPORTS_32BIT_KERNEL
 	bool
 config SYS_SUPPORTS_64BIT_KERNEL
@@ -2095,7 +2121,7 @@ config CPU_R4400_WORKAROUNDS
 #
 config HIGHMEM
 	bool "High Memory Support"
-	depends on 32BIT && CPU_SUPPORTS_HIGHMEM && SYS_SUPPORTS_HIGHMEM
+	depends on 32BIT && CPU_SUPPORTS_HIGHMEM && SYS_SUPPORTS_HIGHMEM && !CPU_MIPS32_3_5_EVA
 
 config CPU_SUPPORTS_HIGHMEM
 	bool
-- 
1.8.5.3
