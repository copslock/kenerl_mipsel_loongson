Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Sep 2017 00:26:26 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38439 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994827AbdIIWY40VTYB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Sep 2017 00:24:56 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1dqoBI-00014U-Hg; Sat, 09 Sep 2017 23:24:52 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1dqoBG-0006zm-P2; Sat, 09 Sep 2017 23:24:50 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "James Hogan" <james.hogan@imgtec.com>
Date:   Sat, 09 Sep 2017 22:47:15 +0100
Message-ID: <lsq.1504993635.238869332@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 226/233] MIPS: Avoid accidental raw backtrace
In-Reply-To: <lsq.1504993633.197134470@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.48-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/traps.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -190,6 +190,8 @@ void show_stack(struct task_struct *task
 {
 	struct pt_regs regs;
 	mm_segment_t old_fs = get_fs();
+
+	regs.cp0_status = KSU_KERNEL;
 	if (sp) {
 		regs.regs[29] = (unsigned long)sp;
 		regs.regs[31] = 0;
