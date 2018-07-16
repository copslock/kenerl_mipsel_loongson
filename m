Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2018 09:40:07 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37772 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994587AbeGPHj6cUE2t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jul 2018 09:39:58 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0170DC03;
        Mon, 16 Jul 2018 07:39:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org
Subject: [PATCH 4.14 03/54] MIPS: Call dump_stack() from show_regs()
Date:   Mon, 16 Jul 2018 09:35:00 +0200
Message-Id: <20180716073451.016568406@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073450.534886211@linuxfoundation.org>
References: <20180716073450.534886211@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64843
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit 5a267832c2ec47b2dad0fdb291a96bb5b8869315 upstream.

The generic nmi_cpu_backtrace() function calls show_regs() when a struct
pt_regs is available, and dump_stack() otherwise. If we were to make use
of the generic nmi_cpu_backtrace() with MIPS' current implementation of
show_regs() this would mean that we see only register data with no
accompanying stack information, in contrast with our current
implementation which calls dump_stack() regardless of whether register
state is available.

In preparation for making use of the generic nmi_cpu_backtrace() to
implement arch_trigger_cpumask_backtrace(), have our implementation of
show_regs() call dump_stack() and drop the explicit dump_stack() call in
arch_dump_stack() which is invoked by arch_trigger_cpumask_backtrace().

This will allow the output we produce to remain the same after a later
patch switches to using nmi_cpu_backtrace(). It may mean that we produce
extra stack output in other uses of show_regs(), but this:

  1) Seems harmless.
  2) Is good for consistency between arch_trigger_cpumask_backtrace()
     and other users of show_regs().
  3) Matches the behaviour of the ARM & PowerPC architectures.

Marked for stable back to v4.9 as a prerequisite of the following patch
"MIPS: Call dump_stack() from show_regs()".

Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19596/
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.9+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/process.c |    4 ++--
 arch/mips/kernel/traps.c   |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -663,8 +663,8 @@ static void arch_dump_stack(void *info)
 
 	if (regs)
 		show_regs(regs);
-
-	dump_stack();
+	else
+		dump_stack();
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -351,6 +351,7 @@ static void __show_regs(const struct pt_
 void show_regs(struct pt_regs *regs)
 {
 	__show_regs((struct pt_regs *)regs);
+	dump_stack();
 }
 
 void show_registers(struct pt_regs *regs)
