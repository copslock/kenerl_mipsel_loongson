Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:29:20 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:2688 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819540Ab3FJH3ALGdmy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:29:00 +0200
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:19:44 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:28:43 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:28:43 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id D62B4F2D74; Mon, 10
 Jun 2013 00:28:41 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        ddaney.cavm@gmail.com
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 1/5] MIPS: Move cop2 save/restore to switch_to()
Date:   Mon, 10 Jun 2013 13:00:00 +0530
Message-ID: <1370849404-4918-2-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370849404-4918-1-git-send-email-jchandra@broadcom.com>
References: <1370849404-4918-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DABA19A2L830675763-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Move the common code for saving and restoring platform specific COP2
registers to switch_to(). This will make supporting new platforms (like
Netlogic XLP) easier.

The platform specific COP2 definitions are to be specified in
asm/processor.h and in asm/cop2.h.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/cop2.h      |   19 +++++++++++++++++++
 arch/mips/include/asm/processor.h |   18 +++++++-----------
 arch/mips/include/asm/switch_to.h |   19 ++++++++++++++++++-
 arch/mips/kernel/octeon_switch.S  |   27 ---------------------------
 4 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/arch/mips/include/asm/cop2.h b/arch/mips/include/asm/cop2.h
index 3532e2c..b17f38e 100644
--- a/arch/mips/include/asm/cop2.h
+++ b/arch/mips/include/asm/cop2.h
@@ -11,6 +11,25 @@
 
 #include <linux/notifier.h>
 
+#if defined(CONFIG_CPU_CAVIUM_OCTEON)
+
+extern void octeon_cop2_save(struct octeon_cop2_state *);
+extern void octeon_cop2_restore(struct octeon_cop2_state *);
+
+#define cop2_save(r)		octeon_cop2_save(r)
+#define cop2_restore(r)		octeon_cop2_restore(r)
+
+#define cop2_present		1
+#define cop2_lazy_restore	1
+
+#else
+
+#define cop2_present		0
+#define cop2_lazy_restore	0
+#define cop2_save(r)
+#define cop2_restore(r)
+#endif
+
 enum cu2_ops {
 	CU2_EXCEPTION,
 	CU2_LWC2_OP,
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 1470b7b..7c637a4 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -137,7 +137,7 @@ union mips_watch_reg_state {
 	struct mips3264_watch_reg_state mips3264;
 };
 
-#ifdef CONFIG_CPU_CAVIUM_OCTEON
+#if defined(CONFIG_CPU_CAVIUM_OCTEON)
 
 struct octeon_cop2_state {
 	/* DMFC2 rt, 0x0201 */
@@ -182,13 +182,16 @@ struct octeon_cop2_state {
 	/* DMFC2 rt, 0x025A; DMFC2 rt, 0x025B - Pass2 */
 	unsigned long	cop2_gfm_result[2];
 };
-#define INIT_OCTEON_COP2 {0,}
+#define COP2_INIT						\
+	.cp2			= {0,},
 
 struct octeon_cvmseg_state {
 	unsigned long cvmseg[CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE]
 			    [cpu_dcache_line_size() / sizeof(unsigned long)];
 };
 
+#else
+#define COP2_INIT
 #endif
 
 typedef struct {
@@ -245,13 +248,6 @@ struct thread_struct {
 #define FPAFF_INIT
 #endif /* CONFIG_MIPS_MT_FPAFF */
 
-#ifdef CONFIG_CPU_CAVIUM_OCTEON
-#define OCTEON_INIT						\
-	.cp2			= INIT_OCTEON_COP2,
-#else
-#define OCTEON_INIT
-#endif /* CONFIG_CPU_CAVIUM_OCTEON */
-
 #define INIT_THREAD  {						\
 	/*							\
 	 * Saved main processor registers			\
@@ -300,9 +296,9 @@ struct thread_struct {
 	.cp0_baduaddr		= 0,				\
 	.error_code		= 0,				\
 	/*							\
-	 * Cavium Octeon specifics (null if not Octeon)		\
+	 * Platform specific cop2 registers(null if no COP2)	\
 	 */							\
-	OCTEON_INIT						\
+	COP2_INIT						\
 }
 
 struct task_struct;
diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
index fd16bcb..eb0af15 100644
--- a/arch/mips/include/asm/switch_to.h
+++ b/arch/mips/include/asm/switch_to.h
@@ -15,6 +15,7 @@
 #include <asm/cpu-features.h>
 #include <asm/watch.h>
 #include <asm/dsp.h>
+#include <asm/cop2.h>
 
 struct task_struct;
 
@@ -66,10 +67,18 @@ do {									\
 
 #define switch_to(prev, next, last)					\
 do {									\
-	u32 __usedfpu;							\
+	u32 __usedfpu, __c0_stat;					\
 	__mips_mt_fpaff_switch_to(prev);				\
 	if (cpu_has_dsp)						\
 		__save_dsp(prev);					\
+	if (cop2_present && (KSTK_STATUS(prev) & ST0_CU2)) {		\
+		if (cop2_lazy_restore)					\
+			KSTK_STATUS(prev) &= ~ST0_CU2;			\
+		__c0_stat = read_c0_status();				\
+		write_c0_status(__c0_stat | ST0_CU2);			\
+		cop2_save(&prev->thread.cp2);				\
+		write_c0_status(__c0_stat & ~ST0_CU2);			\
+	}								\
 	__clear_software_ll_bit();					\
 	__usedfpu = test_and_clear_tsk_thread_flag(prev, TIF_USEDFPU);	\
 	(last) = resume(prev, next, task_thread_info(next), __usedfpu); \
@@ -77,6 +86,14 @@ do {									\
 
 #define finish_arch_switch(prev)					\
 do {									\
+	u32 __c0_stat;							\
+	if (cop2_present && !cop2_lazy_restore &&			\
+			(KSTK_STATUS(current) & ST0_CU2)) {		\
+		__c0_stat = read_c0_status();				\
+		write_c0_status(__c0_stat | ST0_CU2);			\
+		cop2_restore(&current->thread.cp2);			\
+		write_c0_status(__c0_stat & ~ST0_CU2);			\
+	}								\
 	if (cpu_has_dsp)						\
 		__restore_dsp(current);					\
 	if (cpu_has_userlocal)						\
diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index 0e23343..22e2aa1 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -40,33 +40,6 @@
 	cpu_save_nonscratch a0
 	LONG_S	ra, THREAD_REG31(a0)
 
-	/* check if we need to save COP2 registers */
-	PTR_L	t2, TASK_THREAD_INFO(a0)
-	LONG_L	t0, ST_OFF(t2)
-	bbit0	t0, 30, 1f
-
-	/* Disable COP2 in the stored process state */
-	li	t1, ST0_CU2
-	xor	t0, t1
-	LONG_S	t0, ST_OFF(t2)
-
-	/* Enable COP2 so we can save it */
-	mfc0	t0, CP0_STATUS
-	or	t0, t1
-	mtc0	t0, CP0_STATUS
-
-	/* Save COP2 */
-	daddu	a0, THREAD_CP2
-	jal octeon_cop2_save
-	dsubu	a0, THREAD_CP2
-
-	/* Disable COP2 now that we are done */
-	mfc0	t0, CP0_STATUS
-	li	t1, ST0_CU2
-	xor	t0, t1
-	mtc0	t0, CP0_STATUS
-
-1:
 #if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
 	/* Check if we need to store CVMSEG state */
 	mfc0	t0, $11,7	/* CvmMemCtl */
-- 
1.7.9.5
