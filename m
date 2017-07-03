Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2017 15:50:09 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41452 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994771AbdGCNtgljFKi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jul 2017 15:49:36 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8613596F;
        Mon,  3 Jul 2017 13:49:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.11 37/84] MIPS: Avoid accidental raw backtrace
Date:   Mon,  3 Jul 2017 15:35:17 +0200
Message-Id: <20170703133405.350415697@linuxfoundation.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170703133402.874816941@linuxfoundation.org>
References: <20170703133402.874816941@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59002
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

4.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 854236363370995a609a10b03e35fd3dc5e9e4a1 upstream.

Since commit 81a76d7119f6 ("MIPS: Avoid using unwind_stack() with
usermode") show_backtrace() invokes the raw backtracer when
cp0_status & ST0_KSU indicates user mode to fix issues on EVA kernels
where user and kernel address spaces overlap.

However this is used by show_stack() which creates its own pt_regs on
the stack and leaves cp0_status uninitialised in most of the code paths.
This results in the non deterministic use of the raw back tracer
depending on the previous stack content.

show_stack() deals exclusively with kernel mode stacks anyway, so
explicitly initialise regs.cp0_status to KSU_KERNEL (i.e. 0) to ensure
we get a useful backtrace.

Fixes: 81a76d7119f6 ("MIPS: Avoid using unwind_stack() with usermode")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16656/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/traps.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -201,6 +201,8 @@ void show_stack(struct task_struct *task
 {
 	struct pt_regs regs;
 	mm_segment_t old_fs = get_fs();
+
+	regs.cp0_status = KSU_KERNEL;
 	if (sp) {
 		regs.regs[29] = (unsigned long)sp;
 		regs.regs[31] = 0;
