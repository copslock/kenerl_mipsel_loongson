Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 17:20:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28744 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013242AbaKJQUSZwqvF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 17:20:18 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F3E9D2DF84B84
        for <linux-mips@linux-mips.org>; Mon, 10 Nov 2014 16:20:09 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 10 Nov
 2014 16:20:12 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 10 Nov 2014 16:20:12 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.149) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 10 Nov 2014 16:20:11 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/3] MIPS: kernel: traps: Replace printk with pr_info for MC exceptions
Date:   Mon, 10 Nov 2014 16:20:02 +0000
Message-ID: <1415636404-11979-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1415636404-11979-1-git-send-email-markos.chandras@imgtec.com>
References: <1415636404-11979-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.149]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

printk should not be used without a KERN_ facility level

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/traps.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 22b19c275044..51fa5c3aa4fe 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1380,12 +1380,12 @@ asmlinkage void do_mcheck(struct pt_regs *regs)
 	show_regs(regs);
 
 	if (multi_match) {
-		printk("Index	: %0x\n", read_c0_index());
-		printk("Pagemask: %0x\n", read_c0_pagemask());
-		printk("EntryHi : %0*lx\n", field, read_c0_entryhi());
-		printk("EntryLo0: %0*lx\n", field, read_c0_entrylo0());
-		printk("EntryLo1: %0*lx\n", field, read_c0_entrylo1());
-		printk("\n");
+		pr_info("Index	: %0x\n", read_c0_index());
+		pr_info("Pagemask: %0x\n", read_c0_pagemask());
+		pr_info("EntryHi : %0*lx\n", field, read_c0_entryhi());
+		pr_info("EntryLo0: %0*lx\n", field, read_c0_entrylo0());
+		pr_info("EntryLo1: %0*lx\n", field, read_c0_entrylo1());
+		pr_info("\n");
 		dump_tlb_all();
 	}
 
-- 
2.1.3
