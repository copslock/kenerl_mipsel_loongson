Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 11:59:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57929 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010665AbbAPKwsa04Qh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:52:48 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 97C0A73CC05B1
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:52:40 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:52:42 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:52:42 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 28/70] MIPS: kernel: cpu-probe.c: Add support for MIPS R6
Date:   Fri, 16 Jan 2015 10:49:07 +0000
Message-ID: <1421405389-15512-29-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 45172
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

Add MIPS R6 support when decoding the config0 c0 register.
Also add MIPS R6 support when examining the ebase c0 register
to get the core number and when getting the shadow set number
from the srsctl c0 register.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/cpu-probe.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index cc77fdaca0eb..328b61f63430 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -237,6 +237,13 @@ static void set_isa(struct cpuinfo_mips *c, unsigned int isa)
 		c->isa_level |= MIPS_CPU_ISA_II | MIPS_CPU_ISA_III;
 		break;
 
+	/* R6 incopatible with everything else */
+	case MIPS_CPU_ISA_M64R6:
+		c->isa_level |= MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R6;
+	case MIPS_CPU_ISA_M32R6:
+		c->isa_level |= MIPS_CPU_ISA_M32R6;
+		/* Break here so we don't add incopatible ISAs */
+		break;
 	case MIPS_CPU_ISA_M32R2:
 		c->isa_level |= MIPS_CPU_ISA_M32R2;
 	case MIPS_CPU_ISA_M32R1:
@@ -326,6 +333,9 @@ static inline unsigned int decode_config0(struct cpuinfo_mips *c)
 		case 1:
 			set_isa(c, MIPS_CPU_ISA_M32R2);
 			break;
+		case 2:
+			set_isa(c, MIPS_CPU_ISA_M32R6);
+			break;
 		default:
 			goto unknown;
 		}
@@ -338,6 +348,9 @@ static inline unsigned int decode_config0(struct cpuinfo_mips *c)
 		case 1:
 			set_isa(c, MIPS_CPU_ISA_M64R2);
 			break;
+		case 2:
+			set_isa(c, MIPS_CPU_ISA_M64R6);
+			break;
 		default:
 			goto unknown;
 		}
@@ -541,7 +554,7 @@ static void decode_configs(struct cpuinfo_mips *c)
 	}
 
 #ifndef CONFIG_MIPS_CPS
-	if (cpu_has_mips_r2) {
+	if (cpu_has_mips_r2 || cpu_has_mips_r6) {
 		c->core = get_ebase_cpunum();
 		if (cpu_has_mipsmt)
 			c->core >>= fls(core_nvpes()) - 1;
@@ -1351,7 +1364,8 @@ void cpu_probe(void)
 		c->fpu_id = cpu_get_fpu_id();
 
 		if (c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M32R2 |
-				    MIPS_CPU_ISA_M64R1 | MIPS_CPU_ISA_M64R2)) {
+				    MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R1 |
+				    MIPS_CPU_ISA_M64R2 | MIPS_CPU_ISA_M64R6)) {
 			if (c->fpu_id & MIPS_FPIR_3D)
 				c->ases |= MIPS_ASE_MIPS3D;
 			if (c->fpu_id & MIPS_FPIR_FREP)
@@ -1359,7 +1373,7 @@ void cpu_probe(void)
 		}
 	}
 
-	if (cpu_has_mips_r2) {
+	if (cpu_has_mips_r2 || cpu_has_mips_r6) {
 		c->srsets = ((read_c0_srsctl() >> 26) & 0x0f) + 1;
 		/* R2 has Performance Counter Interrupt indicator */
 		c->options |= MIPS_CPU_PCI;
-- 
2.2.1
