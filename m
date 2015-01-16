Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 11:52:18 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13230 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010085AbbAPKvlExX0u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:51:41 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9A8E1A5FDA7
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:51:30 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:51:32 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:51:31 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 04/70] MIPS: Add build support for the MIPS R6 ISA
Date:   Fri, 16 Jan 2015 10:48:43 +0000
Message-ID: <1421405389-15512-5-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45148
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
index 3289969ee423..72156ea62a69 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1304,6 +1304,20 @@ config CPU_MIPS32_R2
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
@@ -1339,6 +1353,20 @@ config CPU_MIPS64_R2
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
@@ -1539,7 +1567,7 @@ endchoice
 config CPU_MIPS32_3_5_FEATURES
 	bool "MIPS32 Release 3.5 Features"
 	depends on SYS_HAS_CPU_MIPS32_R3_5
-	depends on CPU_MIPS32_R2
+	depends on CPU_MIPS32_R2 || CPU_MIPS32_R6
 	help
 	  Choose this option to build a kernel for release 2 or later of the
 	  MIPS32 architecture including features from the 3.5 release such as
@@ -1659,12 +1687,18 @@ config SYS_HAS_CPU_MIPS32_R2
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
 
@@ -1764,11 +1798,11 @@ endmenu
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
@@ -1781,6 +1815,10 @@ config CPU_MIPSR2
 	bool
 	default y if CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_CAVIUM_OCTEON
 
+config CPU_MIPSR6
+	bool
+	default y if CPU_MIPS32_R6 || CPU_MIPS64_R6
+
 config EVA
 	bool
 
@@ -2148,7 +2186,7 @@ config CPU_HAS_SMARTMIPS
 	  here.
 
 config CPU_MICROMIPS
-	depends on 32BIT && SYS_SUPPORTS_MICROMIPS
+	depends on 32BIT && SYS_SUPPORTS_MICROMIPS && !CPU_MIPSR6
 	bool "microMIPS"
 	help
 	  When this option is enabled the kernel will be built using the
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 2563a088d3b8..b54d5a14b9f0 100644
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
2.2.1
