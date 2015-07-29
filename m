Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jul 2015 15:31:33 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40806 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011397AbbG2NbbzTLzy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Jul 2015 15:31:31 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6TDVUDl021094
        for <linux-mips@linux-mips.org>; Wed, 29 Jul 2015 15:31:30 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6TDVUh5021093
        for linux-mips@linux-mips.org; Wed, 29 Jul 2015 15:31:30 +0200
Date:   Wed, 29 Jul 2015 15:31:29 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: MIPS: Scheduler changes
Message-ID: <20150729133129.GL24049@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Because the resume function in the MIPS implementation of switch_to()
doesn't return to its original caller when a newly created thread is
scheduled for the first time any code following the invocation of
resume() in switch_to() will be skipped.  So far MIPS was using the
finish_arch_switch() hook for that purpose but that function was
originally meant for a different purpose for which it is no longer
required and it also is used only on few platforms.  But there is no
real reason why with some minor changes the code the code of
finish_arch_switch() couldn't be moved into switch_to().  So do that
preparing for removal of finish_arch_switch().

This probably should be tested on a number of different configurations
with/without DSP, MSA, FPU etc. so I'm posting this for review and testing.

Thanks,

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/switch_to.h | 48 +++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
index 7163cd7..9733cd0 100644
--- a/arch/mips/include/asm/switch_to.h
+++ b/arch/mips/include/asm/switch_to.h
@@ -83,45 +83,43 @@ do {	if (cpu_has_rw_llb) {						\
 	}								\
 } while (0)
 
+/*
+ * For newly created kernel threads switch_to() will return to
+ * ret_from_kernel_thread, newly created user threads to ret_from_fork.
+ * That is, everything following resume() will be skipped for new threads.
+ * So everything that matters to new threads should be placed before resume().
+ */
 #define switch_to(prev, next, last)					\
 do {									\
-	u32 __c0_stat;							\
 	s32 __fpsave = FP_SAVE_NONE;					\
 	__mips_mt_fpaff_switch_to(prev);				\
-	if (cpu_has_dsp)						\
+	if (cpu_has_dsp) {						\
 		__save_dsp(prev);					\
-	if (cop2_present && (KSTK_STATUS(prev) & ST0_CU2)) {		\
-		if (cop2_lazy_restore)					\
-			KSTK_STATUS(prev) &= ~ST0_CU2;			\
-		__c0_stat = read_c0_status();				\
-		write_c0_status(__c0_stat | ST0_CU2);			\
-		cop2_save(prev);					\
-		write_c0_status(__c0_stat & ~ST0_CU2);			\
+		__restore_dsp(next);					\
+	}								\
+	if (cop2_present) {						\
+		set_c0_status(ST0_CU2);					\
+		if ((KSTK_STATUS(prev) & ST0_CU2)) {			\
+			if (cop2_lazy_restore)				\
+				KSTK_STATUS(prev) &= ~ST0_CU2;		\
+			cop2_save(prev);				\
+		}							\
+		if (KSTK_STATUS(next) & ST0_CU2 &&			\
+		    !cop2_lazy_restore) {				\
+			cop2_restore(next);				\
+		}							\
+		clear_c0_status(ST0_CU2);				\
 	}								\
 	__clear_software_ll_bit();					\
 	if (test_and_clear_tsk_thread_flag(prev, TIF_USEDFPU))		\
 		__fpsave = FP_SAVE_SCALAR;				\
 	if (test_and_clear_tsk_thread_flag(prev, TIF_USEDMSA))		\
 		__fpsave = FP_SAVE_VECTOR;				\
-	(last) = resume(prev, next, task_thread_info(next), __fpsave);	\
-} while (0)
-
-#define finish_arch_switch(prev)					\
-do {									\
-	u32 __c0_stat;							\
-	if (cop2_present && !cop2_lazy_restore &&			\
-			(KSTK_STATUS(current) & ST0_CU2)) {		\
-		__c0_stat = read_c0_status();				\
-		write_c0_status(__c0_stat | ST0_CU2);			\
-		cop2_restore(current);					\
-		write_c0_status(__c0_stat & ~ST0_CU2);			\
-	}								\
-	if (cpu_has_dsp)						\
-		__restore_dsp(current);					\
 	if (cpu_has_userlocal)						\
-		write_c0_userlocal(current_thread_info()->tp_value);	\
+		write_c0_userlocal(task_thread_info(next)->tp_value);	\
 	__restore_watch();						\
 	disable_msa();							\
+	(last) = resume(prev, next, task_thread_info(next), __fpsave);	\
 } while (0)
 
 #endif /* _ASM_SWITCH_TO_H */
