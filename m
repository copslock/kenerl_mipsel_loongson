Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jan 2017 15:51:50 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7134 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992380AbdACOvoMd585 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jan 2017 15:51:44 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 604A680166285;
        Tue,  3 Jan 2017 14:51:34 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 3 Jan 2017 14:51:37 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] MIPS: Fix printk continuations in cpu-bugs64.c
Date:   Tue, 3 Jan 2017 14:51:20 +0000
Message-ID: <20170103145120.14879-1-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

64-bit pre-r6 kernels output the following broken printk continuation
lines during boot:

Checking for the multiply/shift bug...
no.
Checking for the daddiu bug...
no.
Checking for the daddi bug...
no.

Fix the printk continuations in cpu-bugs64.c to use pr_cont to restore
the correct output:

Checking for the multiply/shift bug... no.
Checking for the daddiu bug... no.
Checking for the daddi bug... no.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/cpu-bugs64.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kernel/cpu-bugs64.c b/arch/mips/kernel/cpu-bugs64.c
index a378e44688f5..c9e8622b5a16 100644
--- a/arch/mips/kernel/cpu-bugs64.c
+++ b/arch/mips/kernel/cpu-bugs64.c
@@ -148,11 +148,11 @@ static inline void check_mult_sh(void)
 			bug = 1;
 
 	if (bug == 0) {
-		printk("no.\n");
+		pr_cont("no.\n");
 		return;
 	}
 
-	printk("yes, workaround... ");
+	pr_cont("yes, workaround... ");
 
 	fix = 1;
 	for (i = 0; i < 8; i++)
@@ -160,11 +160,11 @@ static inline void check_mult_sh(void)
 			fix = 0;
 
 	if (fix == 1) {
-		printk("yes.\n");
+		pr_cont("yes.\n");
 		return;
 	}
 
-	printk("no.\n");
+	pr_cont("no.\n");
 	panic(bug64hit, !R4000_WAR ? r4kwar : nowar);
 }
 
@@ -218,11 +218,11 @@ static inline void check_daddi(void)
 	local_irq_restore(flags);
 
 	if (daddi_ov) {
-		printk("no.\n");
+		pr_cont("no.\n");
 		return;
 	}
 
-	printk("yes, workaround... ");
+	pr_cont("yes, workaround... ");
 
 	local_irq_save(flags);
 	handler = set_except_vector(EXCCODE_OV, handle_daddi_ov);
@@ -236,11 +236,11 @@ static inline void check_daddi(void)
 	local_irq_restore(flags);
 
 	if (daddi_ov) {
-		printk("yes.\n");
+		pr_cont("yes.\n");
 		return;
 	}
 
-	printk("no.\n");
+	pr_cont("no.\n");
 	panic(bug64hit, !DADDI_WAR ? daddiwar : nowar);
 }
 
@@ -288,11 +288,11 @@ static inline void check_daddiu(void)
 	daddiu_bug = v != w;
 
 	if (!daddiu_bug) {
-		printk("no.\n");
+		pr_cont("no.\n");
 		return;
 	}
 
-	printk("yes, workaround... ");
+	pr_cont("yes, workaround... ");
 
 	asm volatile(
 		"addiu	%2, $0, %3\n\t"
@@ -304,11 +304,11 @@ static inline void check_daddiu(void)
 		: "I" (0xffffffffffffdb9aUL), "I" (0x1234));
 
 	if (v == w) {
-		printk("yes.\n");
+		pr_cont("yes.\n");
 		return;
 	}
 
-	printk("no.\n");
+	pr_cont("no.\n");
 	panic(bug64hit, !DADDI_WAR ? daddiwar : nowar);
 }
 
-- 
2.11.0
