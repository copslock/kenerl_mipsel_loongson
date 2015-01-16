Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 11:55:14 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24107 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010547AbbAPKwJG4w4H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:52:09 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 314763C72A869
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:52:01 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:52:03 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:52:02 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 14/70] MIPS: asm: cpu: Add MIPSR6 ISA definitions
Date:   Fri, 16 Jan 2015 10:48:53 +0000
Message-ID: <1421405389-15512-15-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 45158
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

Add MIPS R6 to the ISA definitions

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-features.h | 16 ++++++++++++----
 arch/mips/include/asm/cpu.h          |  7 +++++--
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 2897cfafcaf0..aa2819526c42 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -189,12 +189,18 @@
 #ifndef cpu_has_mips32r2
 # define cpu_has_mips32r2	(cpu_data[0].isa_level & MIPS_CPU_ISA_M32R2)
 #endif
+#ifndef cpu_has_mips32r6
+# define cpu_has_mips32r6	(cpu_data[0].isa_level & MIPS_CPU_ISA_M32R6)
+#endif
 #ifndef cpu_has_mips64r1
 # define cpu_has_mips64r1	(cpu_data[0].isa_level & MIPS_CPU_ISA_M64R1)
 #endif
 #ifndef cpu_has_mips64r2
 # define cpu_has_mips64r2	(cpu_data[0].isa_level & MIPS_CPU_ISA_M64R2)
 #endif
+#ifndef cpu_has_mips64r6
+# define cpu_has_mips64r6	(cpu_data[0].isa_level & MIPS_CPU_ISA_M64R6)
+#endif
 
 /*
  * Shortcuts ...
@@ -210,15 +216,17 @@
 
 #define cpu_has_mips_4_5_r2	(cpu_has_mips_4_5 | cpu_has_mips_r2)
 
-#define cpu_has_mips32	(cpu_has_mips32r1 | cpu_has_mips32r2)
-#define cpu_has_mips64	(cpu_has_mips64r1 | cpu_has_mips64r2)
+#define cpu_has_mips32	(cpu_has_mips32r1 | cpu_has_mips32r2 | cpu_has_mips32r6)
+#define cpu_has_mips64	(cpu_has_mips64r1 | cpu_has_mips64r2 | cpu_has_mips64r6)
 #define cpu_has_mips_r1 (cpu_has_mips32r1 | cpu_has_mips64r1)
 #define cpu_has_mips_r2 (cpu_has_mips32r2 | cpu_has_mips64r2)
+#define cpu_has_mips_r6	(cpu_has_mips32r6 | cpu_has_mips64r6)
 #define cpu_has_mips_r	(cpu_has_mips32r1 | cpu_has_mips32r2 | \
-			 cpu_has_mips64r1 | cpu_has_mips64r2)
+			 cpu_has_mips32r6 | cpu_has_mips64r1 | \
+			 cpu_has_mips64r2 | cpu_has_mips64r6)
 
 #ifndef cpu_has_mips_r2_exec_hazard
-#define cpu_has_mips_r2_exec_hazard cpu_has_mips_r2
+#define cpu_has_mips_r2_exec_hazard (cpu_has_mips_r2 | cpu_has_mips_r6)
 #endif
 
 /*
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 0b74bbf976e4..f604523aec3d 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -332,11 +332,14 @@ enum cpu_type_enum {
 #define MIPS_CPU_ISA_M32R2	0x00000020
 #define MIPS_CPU_ISA_M64R1	0x00000040
 #define MIPS_CPU_ISA_M64R2	0x00000080
+#define MIPS_CPU_ISA_M32R6	0x00000100
+#define MIPS_CPU_ISA_M64R6	0x00000200
 
 #define MIPS_CPU_ISA_32BIT (MIPS_CPU_ISA_II | MIPS_CPU_ISA_M32R1 | \
-	MIPS_CPU_ISA_M32R2)
+	MIPS_CPU_ISA_M32R2 | MIPS_CPU_ISA_M32R6)
 #define MIPS_CPU_ISA_64BIT (MIPS_CPU_ISA_III | MIPS_CPU_ISA_IV | \
-	MIPS_CPU_ISA_V | MIPS_CPU_ISA_M64R1 | MIPS_CPU_ISA_M64R2)
+	MIPS_CPU_ISA_V | MIPS_CPU_ISA_M64R1 | MIPS_CPU_ISA_M64R2 | \
+	MIPS_CPU_ISA_M64R6)
 
 /*
  * CPU Option encodings
-- 
2.2.1
