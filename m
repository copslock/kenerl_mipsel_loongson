Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2016 15:34:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18535 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991978AbcJSNdfcI0H0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Oct 2016 15:33:35 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 60BB67FE0F8A4;
        Wed, 19 Oct 2016 14:33:26 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 19 Oct 2016 14:33:29 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/4] MIPS: traps: Fix output of show_stacktrace
Date:   Wed, 19 Oct 2016 14:33:21 +0100
Message-ID: <1476884003-17306-3-git-send-email-matt.redfearn@imgtec.com>
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
X-archive-position: 55513
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
continuation lines") the output from show_stacktrace on MIPS has been
pretty unreadable due to the lack of KERN_CONT markers. Use pr_cont to
provide the appropriate markers & restore the expected output. Also
start a new line with printk such that the presence of timing
information does not interfere with output.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/kernel/traps.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 6ae5ea752d4c..25ce866b2895 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -174,22 +174,24 @@ static void show_stacktrace(struct task_struct *task,
 	printk("Stack :");
 	i = 0;
 	while ((unsigned long) sp & (PAGE_SIZE - 1)) {
-		if (i && ((i % (64 / field)) == 0))
-			printk("\n	 ");
+		if (i && ((i % (64 / field)) == 0)) {
+			pr_cont("\n");
+			printk("       ");
+		}
 		if (i > 39) {
-			printk(" ...");
+			pr_cont(" ...");
 			break;
 		}
 
 		if (__get_user(stackdata, sp++)) {
-			printk(" (Bad stack address)");
+			pr_cont(" (Bad stack address)");
 			break;
 		}
 
-		printk(" %0*lx", field, stackdata);
+		pr_cont(" %0*lx", field, stackdata);
 		i++;
 	}
-	printk("\n");
+	pr_cont("\n");
 	show_backtrace(task, regs);
 }
 
-- 
2.7.4
