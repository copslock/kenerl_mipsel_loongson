Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 00:14:38 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18198 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22533354AbYJ1AFb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 00:05:31 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490656f7000b>; Mon, 27 Oct 2008 20:04:07 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:13 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:13 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9S038ef003332;
	Mon, 27 Oct 2008 17:03:08 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9S0388O003331;
	Mon, 27 Oct 2008 17:03:08 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 22/36] Add Cavium OCTEON specific registers to ptrace.h and asm-offsets.c
Date:	Mon, 27 Oct 2008 17:02:54 -0700
Message-Id: <1225152181-3221-22-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1225152181-3221-21-git-send-email-ddaney@caviumnetworks.com>
References: <490655B6.4030406@caviumnetworks.com>
 <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-12-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-13-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-14-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-15-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-16-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-17-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-18-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-19-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-20-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-21-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 28 Oct 2008 00:03:13.0257 (UTC) FILETIME=[91FE2D90:01C93890]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
---
 arch/mips/include/asm/ptrace.h |    4 ++++
 arch/mips/kernel/asm-offsets.c |   31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 813abd1..db01535 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -52,6 +52,10 @@ struct pt_regs {
 #ifdef CONFIG_MIPS_MT_SMTC
 	unsigned long cp0_tcstatus;
 #endif /* CONFIG_MIPS_MT_SMTC */
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+	unsigned long long mpl[3];        /* MTM{0,1,2} */
+	unsigned long long mtp[3];        /* MTP{0,1,2} */
+#endif
 } __attribute__ ((aligned (8)));
 
 /* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 7294222..c901c22 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -64,6 +64,10 @@ void output_ptreg_defines(void)
 #ifdef CONFIG_MIPS_MT_SMTC
 	OFFSET(PT_TCSTATUS, pt_regs, cp0_tcstatus);
 #endif /* CONFIG_MIPS_MT_SMTC */
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+	OFFSET(PT_MPL, pt_regs, mpl);
+	OFFSET(PT_MTP, pt_regs, mtp);
+#endif /* CONFIG_CPU_CAVIUM_OCTEON */
 	DEFINE(PT_SIZE, sizeof(struct pt_regs));
 	BLANK();
 }
@@ -295,3 +299,30 @@ void output_irq_cpustat_t_defines(void)
 	DEFINE(IC_IRQ_CPUSTAT_T, sizeof(irq_cpustat_t));
 	BLANK();
 }
+
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+void output_octeon_cop2_state_defines(void)
+{
+	COMMENT("Octeon specific octeon_cop2_state offsets.");
+	OFFSET(OCTEON_CP2_CRC_IV,	octeon_cop2_state, cop2_crc_iv);
+	OFFSET(OCTEON_CP2_CRC_LENGTH,	octeon_cop2_state, cop2_crc_length);
+	OFFSET(OCTEON_CP2_CRC_POLY,	octeon_cop2_state, cop2_crc_poly);
+	OFFSET(OCTEON_CP2_LLM_DAT,	octeon_cop2_state, cop2_llm_dat);
+	OFFSET(OCTEON_CP2_3DES_IV,	octeon_cop2_state, cop2_3des_iv);
+	OFFSET(OCTEON_CP2_3DES_KEY,	octeon_cop2_state, cop2_3des_key);
+	OFFSET(OCTEON_CP2_3DES_RESULT,	octeon_cop2_state, cop2_3des_result);
+	OFFSET(OCTEON_CP2_AES_INP0,	octeon_cop2_state, cop2_aes_inp0);
+	OFFSET(OCTEON_CP2_AES_IV,	octeon_cop2_state, cop2_aes_iv);
+	OFFSET(OCTEON_CP2_AES_KEY,	octeon_cop2_state, cop2_aes_key);
+	OFFSET(OCTEON_CP2_AES_KEYLEN,	octeon_cop2_state, cop2_aes_keylen);
+	OFFSET(OCTEON_CP2_AES_RESULT,	octeon_cop2_state, cop2_aes_result);
+	OFFSET(OCTEON_CP2_GFM_MULT,	octeon_cop2_state, cop2_gfm_mult);
+	OFFSET(OCTEON_CP2_GFM_POLY,	octeon_cop2_state, cop2_gfm_poly);
+	OFFSET(OCTEON_CP2_GFM_RESULT,	octeon_cop2_state, cop2_gfm_result);
+	OFFSET(OCTEON_CP2_HSH_DATW,	octeon_cop2_state, cop2_hsh_datw);
+	OFFSET(OCTEON_CP2_HSH_IVW,	octeon_cop2_state, cop2_hsh_ivw);
+	OFFSET(THREAD_CP2,	task_struct, thread.cp2);
+	OFFSET(THREAD_CVMSEG,	task_struct, thread.cvmseg.cvmseg);
+	BLANK();
+}
+#endif
-- 
1.5.6.5
