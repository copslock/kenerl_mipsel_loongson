Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:11:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14625 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009137AbaLRPLAv4smU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:11:00 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 03E5B84C420D
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:10:52 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:10:54 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:10:53 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 04/67] MIPS: Add build support for the MIPS R6 ISA
Date:   Thu, 18 Dec 2014 15:09:13 +0000
Message-ID: <1418915416-3196-5-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44739
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

Add build support for the latest revision (R6) of the MIPS ISA.
microMIPS is not yet supported.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/Kconfig  | 46 ++++++++++++++++++++++++++++++++++++++++++----
 arch/mips/Makefile |  4 ++++
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9536ef912f59..12e831b815b1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1268,6 +1268,20 @@ config CPU_MIPS32_R2
 	  specific type of processor in your system, choose those that one
 	  otherwise CPU_MIPS32_R1 is a safe bet for any MIPS32 system.
 
+config CPU_MIPS32_R6
+	bool "MIPS32 Release 6 (EXPERIMENTAL)"
+	depends on SYS_HAS_CPU_MIPS32_R6
+	select CPU_HAS_PREFETCH
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_HIGHMEM
+	select CPU_SUPPORTS_MSA
+	select HAVE_KVM
+	help
+	  Choose this option to build a kernel for release 6 or later of the
+	  MIPS32 architecture.  New MIPS processors, starting with the Warrior
+	  family, are based on a MIPS32r6 processor. If you own an older
+	  processor, you probably need to select MIPS32r1 or MIPS32r2 instead.
+
 config CPU_MIPS64_R1
 	bool "MIPS64 Release 1"
 	depends on SYS_HAS_CPU_MIPS64_R1
@@ -1303,6 +1317,20 @@ config CPU_MIPS64_R2
 	  specific type of processor in your system, choose those that one
 	  otherwise CPU_MIPS64_R1 is a safe bet for any MIPS64 system.
 
+config CPU_MIPS64_R6
+	bool "MIPS64 Release 6 (EXPERIMENTAL)"
+	depends on SYS_HAS_CPU_MIPS64_R6
+	select CPU_HAS_PREFETCH
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
+	select CPU_SUPPORTS_HIGHMEM
+	select CPU_SUPPORTS_MSA
+	help
+	  Choose this option to build a kernel for release 6 or later of the
+	  MIPS64 architecture.  New MIPS processors, starting with the Warrior
+	  family, are based on a MIPS64r6 processor. If you own an older
+	  processor, you probably need to select MIPS64r1 or MIPS64r2 instead.
+
 config CPU_R3000
 	bool "R3000"
 	depends on SYS_HAS_CPU_R3000
@@ -1503,7 +1531,7 @@ endchoice
 config CPU_MIPS32_3_5_FEATURES
 	bool "MIPS32 Release 3.5 Features"
 	depends on SYS_HAS_CPU_MIPS32_R3_5
-	depends on CPU_MIPS32_R2
+	depends on CPU_MIPS32_R2 || CPU_MIPS32_R6
 	help
 	  Choose this option to build a kernel for release 2 or later of the
 	  MIPS32 architecture including features from the 3.5 release such as
@@ -1620,12 +1648,18 @@ config SYS_HAS_CPU_MIPS32_R2
 config SYS_HAS_CPU_MIPS32_R3_5
 	bool
 
+config SYS_HAS_CPU_MIPS32_R6
+	bool
+
 config SYS_HAS_CPU_MIPS64_R1
 	bool
 
 config SYS_HAS_CPU_MIPS64_R2
 	bool
 
+config SYS_HAS_CPU_MIPS64_R6
+	bool
+
 config SYS_HAS_CPU_R3000
 	bool
 
@@ -1725,11 +1759,11 @@ endmenu
 #
 config CPU_MIPS32
 	bool
-	default y if CPU_MIPS32_R1 || CPU_MIPS32_R2
+	default y if CPU_MIPS32_R1 || CPU_MIPS32_R2 || CPU_MIPS32_R6
 
 config CPU_MIPS64
 	bool
-	default y if CPU_MIPS64_R1 || CPU_MIPS64_R2
+	default y if CPU_MIPS64_R1 || CPU_MIPS64_R2 || CPU_MIPS64_R6
 
 #
 # These two indicate the revision of the architecture, either Release 1 or Release 2
@@ -1742,6 +1776,10 @@ config CPU_MIPSR2
 	bool
 	default y if CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_CAVIUM_OCTEON
 
+config CPU_MIPSR6
+	bool
+	default y if CPU_MIPS32_R6 || CPU_MIPS64_R6
+
 config EVA
 	bool
 
@@ -2122,7 +2160,7 @@ config CPU_HAS_SMARTMIPS
 	  here.
 
 config CPU_MICROMIPS
-	depends on SYS_SUPPORTS_MICROMIPS
+	depends on SYS_SUPPORTS_MICROMIPS || !CPU_MIPSR6
 	bool "microMIPS"
 	help
 	  When this option is enabled the kernel will be built using the
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 58076472bdd8..5f1eb7975546 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -156,10 +156,14 @@ cflags-$(CONFIG_CPU_MIPS32_R1)	+= $(call cc-option,-march=mips32,-mips32 -U_MIPS
 			-Wa,-mips32 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS32_R2)	+= $(call cc-option,-march=mips32r2,-mips32r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
 			-Wa,-mips32r2 -Wa,--trap
+cflags-$(CONFIG_CPU_MIPS32_R6)	+= $(call cc-option,-march=mips32r6,-mips32r6 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
+			-Wa,-mips32r6 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS64_R1)	+= $(call cc-option,-march=mips64,-mips64 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64) \
 			-Wa,-mips64 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS64_R2)	+= $(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64) \
 			-Wa,-mips64r2 -Wa,--trap
+cflags-$(CONFIG_CPU_MIPS64_R6)	+= $(call cc-option,-march=mips64r6,-mips64r6 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
+			-Wa,-mips64r6 -Wa,--trap
 cflags-$(CONFIG_CPU_R5000)	+= -march=r5000 -Wa,--trap
 cflags-$(CONFIG_CPU_R5432)	+= $(call cc-option,-march=r5400,-march=r5000) \
 			-Wa,--trap
-- 
2.2.0
