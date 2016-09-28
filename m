Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2016 11:14:54 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:46723 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992391AbcI1JMcQM0VG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Sep 2016 11:12:32 +0200
Received: from localhost (unknown [89.202.203.52])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EDBF289E;
        Wed, 28 Sep 2016 09:12:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.7 48/69] MIPS: Avoid a BUG warning during prctl(PR_SET_FP_MODE, ...)
Date:   Wed, 28 Sep 2016 11:05:30 +0200
Message-Id: <20160928090447.128742683@linuxfoundation.org>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160928090445.054716307@linuxfoundation.org>
References: <20160928090445.054716307@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55285
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

4.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

commit b244614a60ab7ce54c12a9cbe15cfbf8d79d0967 upstream.

cpu_has_fpu macro uses smp_processor_id() and is currently executed
with preemption enabled, that triggers the warning at runtime.

It is assumed throughout the kernel that if any CPU has an FPU, then all
CPUs would have an FPU as well, so it is safe to perform the check with
preemption enabled - change the code to use raw_ variant of the check to
avoid the warning.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14125/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/process.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -591,14 +591,14 @@ int mips_set_process_fp_mode(struct task
 		return -EOPNOTSUPP;
 
 	/* Avoid inadvertently triggering emulation */
-	if ((value & PR_FP_MODE_FR) && cpu_has_fpu &&
-	    !(current_cpu_data.fpu_id & MIPS_FPIR_F64))
+	if ((value & PR_FP_MODE_FR) && raw_cpu_has_fpu &&
+	    !(raw_current_cpu_data.fpu_id & MIPS_FPIR_F64))
 		return -EOPNOTSUPP;
-	if ((value & PR_FP_MODE_FRE) && cpu_has_fpu && !cpu_has_fre)
+	if ((value & PR_FP_MODE_FRE) && raw_cpu_has_fpu && !cpu_has_fre)
 		return -EOPNOTSUPP;
 
 	/* FR = 0 not supported in MIPS R6 */
-	if (!(value & PR_FP_MODE_FR) && cpu_has_fpu && cpu_has_mips_r6)
+	if (!(value & PR_FP_MODE_FR) && raw_cpu_has_fpu && cpu_has_mips_r6)
 		return -EOPNOTSUPP;
 
 	/* Proceed with the mode switch */
