Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 13:25:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50243 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006150AbaKJMZoxEeSI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 13:25:44 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CFA2C362728F5;
        Mon, 10 Nov 2014 12:25:36 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 10 Nov
 2014 12:25:38 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 10 Nov 2014 12:25:38 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.149) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 10 Nov 2014 12:25:37 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] MIPS: cpu-probe: Set the FTLB probability bit on supported cores
Date:   Mon, 10 Nov 2014 12:25:34 +0000
Message-ID: <1415622334-12014-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.149]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43950
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

Make use of the Config6/FLTBP bit to set the probability of a TLBWR
instruction to hit the FTLB or the VTLB. A value of 0 (which may be
the default value on certain cores, such as proAptiv or P5600)
means that a TLBWR instruction will never hit the VTLB which
leads to performance limitations since it effectively decreases
the number of available TLB slots.

Cc: <stable@vger.kernel.org> # v3.15+
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/mipsregs.h |  2 ++
 arch/mips/kernel/cpu-probe.c     | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index b46cd220a018..22a135ac91de 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -661,6 +661,8 @@
 #define MIPS_CONF6_SYND		(_ULCAST_(1) << 13)
 /* proAptiv FTLB on/off bit */
 #define MIPS_CONF6_FTLBEN	(_ULCAST_(1) << 15)
+/* FTLB probability bits */
+#define MIPS_CONF6_FTLBP_SHIFT	(16)
 
 #define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 25554f21a524..6d14a1153964 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -250,6 +250,32 @@ static void set_isa(struct cpuinfo_mips *c, unsigned int isa)
 static char unknown_isa[] = KERN_ERR \
 	"Unsupported ISA type, c0.config0: %d.";
 
+static unsigned int calculate_ftlb_probability(struct cpuinfo_mips *c)
+{
+
+	unsigned int probability = c->tlbsize / c->tlbsizevtlb;
+
+	/*
+	 * 0 = All TLBWR instructions go to FTLB
+	 * 1 = 15:1: For every 16 TBLWR instructions, 15 go to the
+	 * FTLB and 1 goes to the VTLB.
+	 * 2 = 7:1: As above with 7:1 ratio.
+	 * 3 = 3:1: As above with 3:1 ratio.
+	 *
+	 * Use the linear midpoint as the probability threshold.
+	 */
+	if (probability >= 12)
+		return 1;
+	else if (probability >= 6)
+		return 2;
+	else
+		/*
+		 * So FTLB is less than 4 times bigger than VTLB.
+		 * A 3:1 ratio can still be useful though.
+		 */
+		return 3;
+}
+
 static void set_ftlb_enable(struct cpuinfo_mips *c, int enable)
 {
 	unsigned int config6;
@@ -260,9 +286,14 @@ static void set_ftlb_enable(struct cpuinfo_mips *c, int enable)
 	case CPU_P5600:
 		/* proAptiv & related cores use Config6 to enable the FTLB */
 		config6 = read_c0_config6();
+		/* Clear the old probability value */
+		config6 &= ~(3 << MIPS_CONF6_FTLBP_SHIFT);
 		if (enable)
 			/* Enable FTLB */
-			write_c0_config6(config6 | MIPS_CONF6_FTLBEN);
+			write_c0_config6(config6 |
+					 (calculate_ftlb_probability(c)
+					  << MIPS_CONF6_FTLBP_SHIFT)
+					 | MIPS_CONF6_FTLBEN);
 		else
 			/* Disable FTLB */
 			write_c0_config6(config6 &  ~MIPS_CONF6_FTLBEN);
-- 
2.1.3
