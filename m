Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2016 15:34:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15453 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991948AbcJSNdepA8b0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Oct 2016 15:33:34 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 565A2CFC09BBF;
        Wed, 19 Oct 2016 14:33:25 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 19 Oct 2016 14:33:28 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/4] MIPS: traps: Fix output of show_backtrace
Date:   Wed, 19 Oct 2016 14:33:20 +0100
Message-ID: <1476884003-17306-2-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1476884003-17306-1-git-send-email-matt.redfearn@imgtec.com>
References: <1476884003-17306-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Since commit 4bcc595ccd80 ("printk: reinstate KERN_CONT for printing
continuation lines") the output from show_backtrace on MIPS has been
pretty unreadable due to the lack of KERN_CONT markers. Use pr_cont to
provide the appropriate markers & restore the expected output.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

 arch/mips/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 1f5fdee1dfc3..6ae5ea752d4c 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -156,7 +156,7 @@ static void show_backtrace(struct task_struct *task, const struct pt_regs *regs)
 		print_ip_sym(pc);
 		pc = unwind_stack(task, &sp, pc, &ra);
 	} while (pc);
-	printk("\n");
+	pr_cont("\n");
 }
 
 /*
-- 
2.7.4
