Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Mar 2013 17:24:02 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:4058 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823082Ab3CVQXiYCY0m (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Mar 2013 17:23:38 +0100
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 22 Mar 2013 09:16:27 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Fri, 22 Mar 2013 09:23:21 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Fri, 22 Mar 2013 09:23:21 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id DE79239294; Fri, 22
 Mar 2013 09:23:18 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        ddaney.cavm@gmail.com
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 1/5] MIPS: Move cop2 save/restore to switch_to()
Date:   Fri, 22 Mar 2013 21:54:58 +0530
Message-ID: <d61d9a1f2baea8a73ef2a5143e032bdef9e54adb.1363966534.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1363966534.git.jchandra@broadcom.com>
References: <cover.1363966534.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7D525C513YC7239987-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35940
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Move the common code in saving and restoring platform specific COP2
registers to switch_to. This will make supporting new platforms (like
Netlogic XLR/XLP) easier.

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
index 2a5fa7a..131c78f 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -133,7 +133,7 @@ union mips_watch_reg_state {
 	struct mips3264_watch_reg_state mips3264;
 };
 
-#ifdef CONFIG_CPU_CAVIUM_OCTEON
+#if defined(CONFIG_CPU_CAVIUM_OCTEON)
 
 struct octeon_cop2_state {
 	/* DMFC2 rt, 0x0201 */
@@ -178,13 +178,16 @@ struct octeon_cop2_state {
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
@@ -241,13 +244,6 @@ struct thread_struct {
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
@@ -296,9 +292,9 @@ struct thread_struct {
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
