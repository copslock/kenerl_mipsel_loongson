Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2014 23:47:42 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:48070 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008242AbaLEWqEKBDKq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Dec 2014 23:46:04 +0100
Received: from localhost (c-24-22-230-10.hsd1.wa.comcast.net [24.22.230.10])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A5C06A82;
        Fri,  5 Dec 2014 22:45:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.17 007/122] MIPS: cpu-probe: Set the FTLB probability bit on supported cores
Date:   Fri,  5 Dec 2014 14:43:01 -0800
Message-Id: <20141205223306.616304416@linuxfoundation.org>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <20141205223305.514276242@linuxfoundation.org>
References: <20141205223305.514276242@linuxfoundation.org>
User-Agent: quilt/0.63-1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit cf0a8aa0226da5de88011e7f30eff22a894b2f49 upstream.

Make use of the Config6/FLTBP bit to set the probability of a TLBWR
instruction to hit the FTLB or the VTLB. A value of 0 (which may be
the default value on certain cores, such as proAptiv or P5600)
means that a TLBWR instruction will never hit the VTLB which
leads to performance limitations since it effectively decreases
the number of available TLB slots.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8368/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/mipsregs.h |    2 ++
 arch/mips/kernel/cpu-probe.c     |   33 ++++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -661,6 +661,8 @@
 #define MIPS_CONF6_SYND		(_ULCAST_(1) << 13)
 /* proAptiv FTLB on/off bit */
 #define MIPS_CONF6_FTLBEN	(_ULCAST_(1) << 15)
+/* FTLB probability bits */
+#define MIPS_CONF6_FTLBP_SHIFT	(16)
 
 #define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
 
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -192,6 +192,32 @@ static void set_isa(struct cpuinfo_mips
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
@@ -202,9 +228,14 @@ static void set_ftlb_enable(struct cpuin
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
