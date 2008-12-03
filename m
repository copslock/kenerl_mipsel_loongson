Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2008 23:50:26 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:36247 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24087259AbYLCXpc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Dec 2008 23:45:32 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B493719e80003>; Wed, 03 Dec 2008 18:44:40 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Dec 2008 15:44:39 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Dec 2008 15:44:39 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mB3NiYCH015638;
	Wed, 3 Dec 2008 15:44:34 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mB3NiY7B015637;
	Wed, 3 Dec 2008 15:44:34 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 13/21] MIPS: Add Cavium OCTEON specific registers to ptrace.h and asm-offsets.c
Date:	Wed,  3 Dec 2008 15:44:23 -0800
Message-Id: <1228347871-15563-13-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <493718EA.40703@caviumnetworks.com>
References: <493718EA.40703@caviumnetworks.com>
X-OriginalArrivalTime: 03 Dec 2008 23:44:39.0117 (UTC) FILETIME=[1B32A7D0:01C955A1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21519
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
index c2c8bac..1f30d16 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -48,6 +48,10 @@ struct pt_regs {
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
