Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2018 17:58:48 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:52076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994562AbeFDP6lwdmB9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jun 2018 17:58:41 +0200
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7B1A20896;
        Mon,  4 Jun 2018 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528127915;
        bh=8jXNP8vnwcF+TR6+0YdF5rciKwGAeWP5OJuYS69gA/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/DVTDy3ROAoeJrwKudzqFzqLD9reE0eaEqgRXrkUJSMnbkWQTCaw2pnZNhA6JDkk
         Xk2+Zm4VujLcgCBwOkYEqWHmYvaLByH5fp2lB+CMiRqwhuow2wVjfuSnjkFknn5p8i
         WuE1jvUtc9FALeUH2Kl/plpY3KdznqVYYjm28/XQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: [RFC PATCH -tip v5 20/27] MIPS: kprobes: Don't call the ->break_handler() in MIPS kprobes code
Date:   Tue,  5 Jun 2018 00:58:12 +0900
Message-Id: <152812789186.10068.4347487945198034534.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <mhiramat@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhiramat@kernel.org
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

Don't call the ->break_handler() from the MIPS kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/kprobes.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index efdcd0b1ce12..7fd277bc59b9 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -326,19 +326,13 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 				preempt_enable_no_resched();
 			}
 			return 1;
-		} else {
-			if (addr->word != breakpoint_insn.word) {
-				/*
-				 * The breakpoint instruction was removed by
-				 * another cpu right after we hit, no further
-				 * handling of this interrupt is appropriate
-				 */
-				ret = 1;
-				goto no_kprobe;
-			}
-			p = __this_cpu_read(current_kprobe);
-			if (p->break_handler && p->break_handler(p, regs))
-				goto ss_probe;
+		} else if (addr->word != breakpoint_insn.word) {
+			/*
+			 * The breakpoint instruction was removed by
+			 * another cpu right after we hit, no further
+			 * handling of this interrupt is appropriate
+			 */
+			ret = 1;
 		}
 		goto no_kprobe;
 	}
@@ -367,7 +361,6 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 		return 1;
 	}
 
-ss_probe:
 	prepare_singlestep(p, regs, kcb);
 	if (kcb->flags & SKIP_DELAYSLOT) {
 		kcb->kprobe_status = KPROBE_HIT_SSDONE;
