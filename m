Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jun 2016 23:49:30 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:60039 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042439AbcFEVmnsk3tp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Jun 2016 23:42:43 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BB0CE83D;
        Sun,  5 Jun 2016 21:42:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 17/99] MIPS: Disable preemption during prctl(PR_SET_FP_MODE, ...)
Date:   Sun,  5 Jun 2016 14:40:50 -0700
Message-Id: <20160605213904.797888781@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160605213902.974592018@linuxfoundation.org>
References: <20160605213902.974592018@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53836
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit bd239f1e1429e7781096bf3884bdb1b2b1bb4f28 upstream.

Whilst a PR_SET_FP_MODE prctl is performed there are decisions made
based upon whether the task is executing on the current CPU. This may
change if we're preempted, so disable preemption to avoid such changes
for the lifetime of the mode switch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 9791554b45a2 ("MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS")
Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Cc: Adam Buchbinder <adam.buchbinder@gmail.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/13144/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/process.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -603,6 +603,9 @@ int mips_set_process_fp_mode(struct task
 	if (!(value & PR_FP_MODE_FR) && cpu_has_fpu && cpu_has_mips_r6)
 		return -EOPNOTSUPP;
 
+	/* Proceed with the mode switch */
+	preempt_disable();
+
 	/* Save FP & vector context, then disable FPU & MSA */
 	if (task->signal == current->signal)
 		lose_fpu(1);
@@ -661,6 +664,7 @@ int mips_set_process_fp_mode(struct task
 
 	/* Allow threads to use FP again */
 	atomic_set(&task->mm->context.fp_mode_switching, 0);
+	preempt_enable();
 
 	return 0;
 }
