Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2010 20:24:57 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19507 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491992Ab0HCSWw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Aug 2010 20:22:52 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c585e950001>; Tue, 03 Aug 2010 11:23:17 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 11:22:48 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 11:22:48 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o73IMf0o026426;
        Tue, 3 Aug 2010 11:22:41 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o73IMfDK026425;
        Tue, 3 Aug 2010 11:22:41 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org, ananth@in.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        masami.hiramatsu.pt@hitachi.com
Cc:     linux-kernel@vger.kernel.org, hschauhan@nulltrace.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 4/5] samples: kprobe_example: Make it print something on MIPS.
Date:   Tue,  3 Aug 2010 11:22:21 -0700
Message-Id: <1280859742-26364-5-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1280859742-26364-1-git-send-email-ddaney@caviumnetworks.com>
References: <1280859742-26364-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 03 Aug 2010 18:22:48.0266 (UTC) FILETIME=[E030A2A0:01CB3338]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This KProbes example is a little useless if it doesn't print anything.
For MIPS print similar messages to those produced on x86 and PPC.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 samples/kprobes/kprobe_example.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index a681998..ebf5e0c 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -32,6 +32,11 @@ static int handler_pre(struct kprobe *p, struct pt_regs *regs)
 			" msr = 0x%lx\n",
 		p->addr, regs->nip, regs->msr);
 #endif
+#ifdef CONFIG_MIPS
+	printk(KERN_INFO "pre_handler: p->addr = 0x%p, epc = 0x%lx,"
+			" status = 0x%lx\n",
+		p->addr, regs->cp0_epc, regs->cp0_status);
+#endif
 
 	/* A dump_stack() here will give a stack backtrace */
 	return 0;
@@ -49,6 +54,10 @@ static void handler_post(struct kprobe *p, struct pt_regs *regs,
 	printk(KERN_INFO "post_handler: p->addr = 0x%p, msr = 0x%lx\n",
 		p->addr, regs->msr);
 #endif
+#ifdef CONFIG_MIPS
+	printk(KERN_INFO "post_handler: p->addr = 0x%p, status = 0x%lx\n",
+		p->addr, regs->cp0_status);
+#endif
 }
 
 /*
-- 
1.7.1.1
