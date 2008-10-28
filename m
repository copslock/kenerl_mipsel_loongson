Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 00:14:13 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17174 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22533351AbYJ1AF2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 00:05:28 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490656f7000a>; Mon, 27 Oct 2008 20:04:07 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:12 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:12 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9S0376D003328;
	Mon, 27 Oct 2008 17:03:07 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9S037GY003327;
	Mon, 27 Oct 2008 17:03:07 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 21/36] Cavium OCTEON: Add cop2/cvmseg state entries to processor.h.
Date:	Mon, 27 Oct 2008 17:02:53 -0700
Message-Id: <1225152181-3221-21-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1225152181-3221-20-git-send-email-ddaney@caviumnetworks.com>
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
X-OriginalArrivalTime: 28 Oct 2008 00:03:12.0726 (UTC) FILETIME=[91AD2760:01C93890]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Add in the cop2 and cvmseg state info to the known proc reg
data for Cavium so that it can be tracked, saved, restored...

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/processor.h |   69 +++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 18ee58e..0f926aa 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -118,6 +118,60 @@ union mips_watch_reg_state {
 	struct mips3264_watch_reg_state mips3264;
 };
 
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+
+struct octeon_cop2_state {
+	/* DMFC2 rt, 0x0201 */
+	unsigned long   cop2_crc_iv;
+	/* DMFC2 rt, 0x0202 (Set with DMTC2 rt, 0x1202) */
+	unsigned long   cop2_crc_length;
+	/* DMFC2 rt, 0x0200 (set with DMTC2 rt, 0x4200) */
+	unsigned long   cop2_crc_poly;
+	/* DMFC2 rt, 0x0402; DMFC2 rt, 0x040A */
+	unsigned long   cop2_llm_dat[2];
+       /* DMFC2 rt, 0x0084 */
+	unsigned long   cop2_3des_iv;
+	/* DMFC2 rt, 0x0080; DMFC2 rt, 0x0081; DMFC2 rt, 0x0082 */
+	unsigned long   cop2_3des_key[3];
+	/* DMFC2 rt, 0x0088 (Set with DMTC2 rt, 0x0098) */
+	unsigned long   cop2_3des_result;
+	/* DMFC2 rt, 0x0111 (FIXME: Read Pass1 Errata) */
+	unsigned long   cop2_aes_inp0;
+	/* DMFC2 rt, 0x0102; DMFC2 rt, 0x0103 */
+	unsigned long   cop2_aes_iv[2];
+	/* DMFC2 rt, 0x0104; DMFC2 rt, 0x0105; DMFC2 rt, 0x0106; DMFC2
+	 * rt, 0x0107 */
+	unsigned long   cop2_aes_key[4];
+	/* DMFC2 rt, 0x0110 */
+	unsigned long   cop2_aes_keylen;
+	/* DMFC2 rt, 0x0100; DMFC2 rt, 0x0101 */
+	unsigned long   cop2_aes_result[2];
+	/* DMFC2 rt, 0x0240; DMFC2 rt, 0x0241; DMFC2 rt, 0x0242; DMFC2
+	 * rt, 0x0243; DMFC2 rt, 0x0244; DMFC2 rt, 0x0245; DMFC2 rt,
+	 * 0x0246; DMFC2 rt, 0x0247; DMFC2 rt, 0x0248; DMFC2 rt,
+	 * 0x0249; DMFC2 rt, 0x024A; DMFC2 rt, 0x024B; DMFC2 rt,
+	 * 0x024C; DMFC2 rt, 0x024D; DMFC2 rt, 0x024E - Pass2 */
+	unsigned long   cop2_hsh_datw[15];
+	/* DMFC2 rt, 0x0250; DMFC2 rt, 0x0251; DMFC2 rt, 0x0252; DMFC2
+	 * rt, 0x0253; DMFC2 rt, 0x0254; DMFC2 rt, 0x0255; DMFC2 rt,
+	 * 0x0256; DMFC2 rt, 0x0257 - Pass2 */
+	unsigned long   cop2_hsh_ivw[8];
+	/* DMFC2 rt, 0x0258; DMFC2 rt, 0x0259 - Pass2 */
+	unsigned long   cop2_gfm_mult[2];
+	/* DMFC2 rt, 0x025E - Pass2 */
+	unsigned long   cop2_gfm_poly;
+	/* DMFC2 rt, 0x025A; DMFC2 rt, 0x025B - Pass2 */
+	unsigned long   cop2_gfm_result[2];
+};
+#define INIT_OCTEON_COP2 {0,}
+
+struct octeon_cvmseg_state {
+	unsigned long cvmseg[CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE]
+			    [cpu_dcache_line_size() / sizeof(unsigned long)];
+};
+
+#endif
+
 typedef struct {
 	unsigned long seg;
 } mm_segment_t;
@@ -160,6 +214,10 @@ struct thread_struct {
 	unsigned long trap_no;
 	unsigned long irix_trampoline;  /* Wheee... */
 	unsigned long irix_oldctx;
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+    struct octeon_cop2_state cp2 __attribute__ ((__aligned__(128)));
+    struct octeon_cvmseg_state cvmseg __attribute__ ((__aligned__(128)));
+#endif
 	struct mips_abi *abi;
 };
 
@@ -171,6 +229,13 @@ struct thread_struct {
 #define FPAFF_INIT
 #endif /* CONFIG_MIPS_MT_FPAFF */
 
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+#define OCTEON_INIT						\
+	.cp2			= INIT_OCTEON_COP2,
+#else
+#define OCTEON_INIT
+#endif /* CONFIG_CPU_CAVIUM_OCTEON */
+
 #define INIT_THREAD  {						\
         /*							\
          * Saved main processor registers			\
@@ -221,6 +286,10 @@ struct thread_struct {
 	.trap_no		= 0,				\
 	.irix_trampoline	= 0,				\
 	.irix_oldctx		= 0,				\
+	/*							\
+	 * Cavium Octeon specifics (null if not Octeon)		\
+	 */							\
+	OCTEON_INIT						\
 }
 
 struct task_struct;
-- 
1.5.6.5
