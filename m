Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2017 11:01:09 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:58223 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992866AbdLLJ7SkDLaC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Dec 2017 10:59:18 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 12 Dec 2017 09:59:16 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 12 Dec 2017 01:59:13 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>
Subject: [RFC PATCH 06/16] MIPS: KASLR: Change relocate_kernel to return applied offset.
Date:   Tue, 12 Dec 2017 09:57:52 +0000
Message-ID: <1513072682-1371-7-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
References: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1513072756-298554-22590-147215-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187894
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Currently the init_thread_union contains both the stack and the
thread_info of the init thread. The current kernel relocation code makes
use of this such that the C code can update the thread_info in r28, and
then the asm can manipulate that value to find the value for the SP in
the new image.

Once CONFIG_THREAD_INFO_IN_TASK is activated, this will no longer be
possible since the task struct held in r28 will be separate from the
stack.

In preparation for this, change relocate_kernel to just prepare the new
image, and return the applied offset. The assembly code in kernel_entry
can then perform the necessary steps to set up the state for the
relocated image just as it did for the initial image.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/kernel/head.S     | 16 ++++++++--------
 arch/mips/kernel/relocate.c | 20 ++++++--------------
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index d1bb506adc10..0fcb3e048ece 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -142,20 +142,20 @@ dtb_found:
 	/* Copy kernel and apply the relocations */
 	jal		relocate_kernel
 
-	/* Repoint the sp into the new kernel image */
-	PTR_LI		sp, _THREAD_SIZE - 32 - PT_SIZE
-	PTR_ADDU	sp, $28
+	/* relocate_kernel returns the offset applied, apply it to ti & sp */
+	PTR_ADDU	$28, v0
+	PTR_ADDU	sp, v0
+
 	set_saved_sp	sp, t0, t1
-	PTR_SUBU	sp, 4 * SZREG		# init stack pointer
 
 	/*
-	 * relocate_kernel returns the entry point either
-	 * in the relocated kernel or the original if for
-	 * some reason relocation failed - jump there now
+	 * Find start_kernel in relocated image and jump there
 	 * with instruction hazard barrier because of the
 	 * newly sync'd icache.
 	 */
-	jr.hb		v0
+	PTR_LA		t0, start_kernel
+	PTR_ADDU	t0, v0
+	jr.hb		t0
 #else
 	j		start_kernel
 #endif
diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
index cbf4cc0b0b6c..6c9a8e5c1652 100644
--- a/arch/mips/kernel/relocate.c
+++ b/arch/mips/kernel/relocate.c
@@ -294,15 +294,13 @@ static inline int __init relocation_addr_valid(void *loc_new)
 	return 1;
 }
 
-void *__init relocate_kernel(void)
+int __init relocate_kernel(void)
 {
 	void *loc_new;
 	unsigned long kernel_length;
 	unsigned long bss_length;
 	long offset = 0;
 	int res = 1;
-	/* Default to original kernel entry point */
-	void *kernel_entry = start_kernel;
 	void *fdt = NULL;
 
 	/* Get the command line */
@@ -359,14 +357,14 @@ void *__init relocate_kernel(void)
 		/* Perform relocations on the new kernel */
 		res = do_relocations(&_text, loc_new, offset);
 		if (res < 0)
-			goto out;
+			return 0;
 
 		/* Sync the caches ready for execution of new kernel */
 		sync_icache(loc_new, kernel_length);
 
 		res = relocate_exception_table(offset);
 		if (res < 0)
-			goto out;
+			return 0;
 
 		/*
 		 * The original .bss has already been cleared, and
@@ -390,16 +388,10 @@ void *__init relocate_kernel(void)
 		 * resident in memory and ready to be executed.
 		 */
 		if (plat_post_relocation(offset))
-			goto out;
-
-		/* The current thread is now within the relocated image */
-		__current_thread_info = RELOCATED(&init_thread_union);
-
-		/* Return the new kernel's entry point */
-		kernel_entry = RELOCATED(start_kernel);
+			return 0;
 	}
-out:
-	return kernel_entry;
+
+	return offset;
 }
 
 /*
-- 
2.7.4
