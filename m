Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 19:19:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13871 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992536AbcHSRTOHpHOr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 19:19:14 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8452329F8447;
        Fri, 19 Aug 2016 18:18:54 +0100 (IST)
Received: from localhost (10.100.200.126) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 19 Aug
 2016 18:18:57 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/3] MIPS: Stop setting I6400 FTLBP
Date:   Fri, 19 Aug 2016 18:18:26 +0100
Message-ID: <20160819171828.29109-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160819171828.29109-1-paul.burton@imgtec.com>
References: <20160819171828.29109-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.126]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The FTLBP field in Config7 for the I6400 is intended as chicken bits for
debugging rather than as a field that software actually makes use of.
For best performance, FTLBP should be left at its default value of 0
with all TLB writes hitting the FTLB by default.

Additionally, since set_ftlb_enable is called from decode_configs before
decode_config4 which determines the size of the TLBs, this was
previously always setting FTLBP=3 for a 3:1 FTLB:VTLB write ratio which
makes abysmal use of the available FTLB resources.

This effectively reverts b0c4e1b79d8a ("MIPS: Set up FTLB probability
for I6400").

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Fixes: b0c4e1b79d8a ("MIPS: Set up FTLB probability for I6400")
---
 arch/mips/include/asm/mipsregs.h | 2 --
 arch/mips/kernel/cpu-probe.c     | 9 ++-------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index e1ca65c..f78f0b3 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -659,8 +659,6 @@
 
 #define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
 #define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
-/* FTLB probability bits for R6 */
-#define MIPS_CONF7_FTLBP_SHIFT	(18)
 
 /* WatchLo* register definitions */
 #define MIPS_WATCHLO_IRW	(_ULCAST_(0x7) << 0)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index a88d442..ae29050 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -555,13 +555,8 @@ static int set_ftlb_enable(struct cpuinfo_mips *c, int enable)
 			write_c0_config6(config &  ~MIPS_CONF6_FTLBEN);
 		break;
 	case CPU_I6400:
-		/* I6400 & related cores use Config7 to configure FTLB */
-		config = read_c0_config7();
-		/* Clear the old probability value */
-		config &= ~(3 << MIPS_CONF7_FTLBP_SHIFT);
-		write_c0_config7(config | (calculate_ftlb_probability(c)
-					   << MIPS_CONF7_FTLBP_SHIFT));
-		break;
+		/* There's no way to disable the FTLB */
+		return !enable;
 	case CPU_LOONGSON3:
 		/* Flush ITLB, DTLB, VTLB and FTLB */
 		write_c0_diag(LOONGSON_DIAG_ITLB | LOONGSON_DIAG_DTLB |
-- 
2.9.3
