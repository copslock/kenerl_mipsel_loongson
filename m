Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jan 2018 13:40:00 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:48408 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994630AbeAOMitnlVhK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Jan 2018 13:38:49 +0100
Received: from localhost (LFbn-1-12258-90.w90-92.abo.wanadoo.fr [90.92.71.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4949A11DD;
        Mon, 15 Jan 2018 12:38:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@mips.com>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 05/87] MIPS: Validate PR_SET_FP_MODE prctl(2) requests against the ABI of the task
Date:   Mon, 15 Jan 2018 13:34:04 +0100
Message-Id: <20180115123349.837244184@linuxfoundation.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180115123349.252309699@linuxfoundation.org>
References: <20180115123349.252309699@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62117
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

From: Maciej W. Rozycki <macro@mips.com>

commit b67336eee3fcb8ecedc6c13e2bf88aacfa3151e2 upstream.

Fix an API loophole introduced with commit 9791554b45a2 ("MIPS,prctl:
add PR_[GS]ET_FP_MODE prctl options for MIPS"), where the caller of
prctl(2) is incorrectly allowed to make a change to CP0.Status.FR or
CP0.Config5.FRE register bits even if CONFIG_MIPS_O32_FP64_SUPPORT has
not been enabled, despite that an executable requesting the mode
requested via ELF file annotation would not be allowed to run in the
first place, or for n64 and n64 ABI tasks which do not have non-default
modes defined at all.  Add suitable checks to `mips_set_process_fp_mode'
and bail out if an invalid mode change has been requested for the ABI in
effect, even if the FPU hardware or emulation would otherwise allow it.

Always succeed however without taking any further action if the mode
requested is the same as one already in effect, regardless of whether
any mode change, should it be requested, would actually be allowed for
the task concerned.

Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Fixes: 9791554b45a2 ("MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS")
Reviewed-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <james.hogan@mips.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/17800/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/process.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -664,6 +664,18 @@ int mips_set_process_fp_mode(struct task
 	unsigned long switch_count;
 	struct task_struct *t;
 
+	/* If nothing to change, return right away, successfully.  */
+	if (value == mips_get_process_fp_mode(task))
+		return 0;
+
+	/* Only accept a mode change if 64-bit FP enabled for o32.  */
+	if (!IS_ENABLED(CONFIG_MIPS_O32_FP64_SUPPORT))
+		return -EOPNOTSUPP;
+
+	/* And only for o32 tasks.  */
+	if (IS_ENABLED(CONFIG_64BIT) && !test_thread_flag(TIF_32BIT_REGS))
+		return -EOPNOTSUPP;
+
 	/* Check the value is valid */
 	if (value & ~known_bits)
 		return -EOPNOTSUPP;
