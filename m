Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:18:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3373 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009174AbaLRPMKbPcnz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:12:10 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1D46CE6764D0C
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:12:02 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:12:04 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:12:04 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 27/67] MIPS: kernel: cpu-probe.c: Add support for MIPS R6
Date:   Thu, 18 Dec 2014 15:09:36 +0000
Message-ID: <1418915416-3196-28-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 44762
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
 arch/mips/kernel/cpu-probe.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 08574035b239..3a0b6c11d34b 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -180,6 +180,13 @@ static void set_isa(struct cpuinfo_mips *c, unsigned int isa)
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
@@ -269,6 +276,9 @@ static inline unsigned int decode_config0(struct cpuinfo_mips *c)
 		case 1:
 			set_isa(c, MIPS_CPU_ISA_M32R2);
 			break;
+		case 2:
+			set_isa(c, MIPS_CPU_ISA_M32R6);
+			break;
 		default:
 			goto unknown;
 		}
@@ -281,6 +291,9 @@ static inline unsigned int decode_config0(struct cpuinfo_mips *c)
 		case 1:
 			set_isa(c, MIPS_CPU_ISA_M64R2);
 			break;
+		case 2:
+			set_isa(c, MIPS_CPU_ISA_M64R6);
+			break;
 		default:
 			goto unknown;
 		}
@@ -481,7 +494,7 @@ static void decode_configs(struct cpuinfo_mips *c)
 	}
 
 #ifndef CONFIG_MIPS_CPS
-	if (cpu_has_mips_r2) {
+	if (cpu_has_mips_r2 || cpu_has_mips_r6) {
 		c->core = get_ebase_cpunum();
 		if (cpu_has_mipsmt)
 			c->core >>= fls(core_nvpes()) - 1;
@@ -1296,7 +1309,7 @@ void cpu_probe(void)
 		}
 	}
 
-	if (cpu_has_mips_r2) {
+	if (cpu_has_mips_r2 || cpu_has_mips_r6) {
 		c->srsets = ((read_c0_srsctl() >> 26) & 0x0f) + 1;
 		/* R2 has Performance Counter Interrupt indicator */
 		c->options |= MIPS_CPU_PCI;
-- 
2.2.0
