Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2017 09:42:26 +0200 (CEST)
Received: from bastet.se.axis.com ([195.60.68.11]:33668 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990509AbdDDHmTWQoXa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Apr 2017 09:42:19 +0200
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id F2BFC1811E;
        Tue,  4 Apr 2017 09:42:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id GVG8mp4ql2HS; Tue,  4 Apr 2017 09:42:13 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id F175E180FF;
        Tue,  4 Apr 2017 09:42:12 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D94871E0A3;
        Tue,  4 Apr 2017 09:42:12 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB6671E057;
        Tue,  4 Apr 2017 09:42:12 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Tue,  4 Apr 2017 09:42:12 +0200 (CEST)
Received: from lnxrabinv.se.axis.com (lnxrabinv.se.axis.com [10.88.144.1])
        by seth.se.axis.com (Postfix) with ESMTP id BEF13277E;
        Tue,  4 Apr 2017 09:42:12 +0200 (CEST)
Received: by lnxrabinv.se.axis.com (Postfix, from userid 10564)
        id A8E222034A; Tue,  4 Apr 2017 09:42:12 +0200 (CEST)
From:   Rabin Vincent <rabin.vincent@axis.com>
To:     ralf@linux-mips.org
Cc:     james.hogan@imgtec.com, linux-mips@linux-mips.org,
        Rabin Vincent <rabinv@axis.com>
Subject: [PATCH] MIPS: cevt-r4k: fix array out-of-bounds access
Date:   Tue,  4 Apr 2017 09:42:11 +0200
Message-Id: <1491291731-5797-1-git-send-email-rabin.vincent@axis.com>
X-Mailer: git-send-email 2.7.0
X-TM-AS-GCONF: 00
Return-Path: <rabin.vincent@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rabin.vincent@axis.com
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

From: Rabin Vincent <rabinv@axis.com>

calculate_min_delta() tries to access a fourth element of buf2 but the
array has only three elements.  This triggers undefined behaviour and
causes strange crashes in start_kernel() sometime after timer
initialization, when built with GCC 5.3, probably due to register/stack
corruption:

 sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 10737418237ns
 CPU 0 Unable to handle kernel paging request at virtual address ffffb0aa,
       epc == 8067daa8, ra == 8067da84
 Oops[#1]:
 CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.18 #51
 task: 8065e3e0 task.stack: 80644000
 $ 0   : 00000000 00000001 00000000 00000000
 $ 4   : 8065b4d0 00000000 805d0000 00000010
 $ 8   : 00000010 80321400 fffff000 812de408
 $12   : 00000000 00000000 00000000 ffffffff
 $16   : 00000002 ffffffff 80660000 806a666c
 $20   : 806c0000 00000000 00000000 00000000
 $24   : 00000000 00000010
 $28   : 80644000 80645ed0 00000000 8067da84
 Hi    : 00000000
 Lo    : 00000000
 epc   : 8067daa8 start_kernel+0x33c/0x500
 ra    : 8067da84 start_kernel+0x318/0x500
 Status: 11000402 KERNEL EXL
 Cause : 4080040c (ExcCode 03)
 BadVA : ffffb0aa
 PrId  : 0501992c (MIPS 1004Kc)
 Modules linked in:
 Process swapper/0 (pid: 0, threadinfo=80644000, task=8065e3e0, tls=00000000)
 Call Trace:
 [<8067daa8>] start_kernel+0x33c/0x500
 Code: 24050240  0c0131f9  24849c64 <a200b0a8> 41606020  000000c0  0c1a45e6
       00000000  0c1a5f44

UBSAN also detects it:

 ================================================================
 UBSAN: Undefined behaviour in arch/mips/kernel/cevt-r4k.c:85:41
 load of address 80647e4c with insufficient space
 for an object of type 'unsigned int'
 CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.18 #47
 Call Trace:
 [<80028f70>] show_stack+0x88/0xa4
 [<80312654>] dump_stack+0x84/0xc0
 [<8034163c>] ubsan_epilogue+0x14/0x50
 [<803417d8>] __ubsan_handle_type_mismatch+0x160/0x168
 [<8002dab0>] r4k_clockevent_init+0x544/0x764
 [<80684d34>] time_init+0x18/0x90
 [<8067fa5c>] start_kernel+0x2f0/0x500
 =================================================================

Fixes: 1fa405552e33f2 ("MIPS: cevt-r4k: Dynamically calculate min_delta_ns")
Signed-off-by: Rabin Vincent <rabinv@axis.com>
---
 arch/mips/kernel/cevt-r4k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 804d2a2..723a1f1 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -48,7 +48,7 @@ static int mips_next_event(unsigned long delta,
 static unsigned int calculate_min_delta(void)
 {
 	unsigned int cnt, i, j, k, l;
-	unsigned int buf1[4], buf2[3];
+	unsigned int buf1[4], buf2[4];
 	unsigned int min_delta;
 
 	/*
-- 
2.7.0
