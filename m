Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 12:37:50 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:11205 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038773AbWJMLho (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Oct 2006 12:37:44 +0100
Received: by nf-out-0910.google.com with SMTP id a25so844436nfc
        for <linux-mips@linux-mips.org>; Fri, 13 Oct 2006 04:37:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=DQ/GMe96WAA3rSoh33yjHhVed4hBmsZfBAbqeMfhLTOjtv7w6vdrK+Co2b0wmqF0NBuS5L5sub2CIYXi+5/b301uvfjmPePf0Bez5aiSumofl9IFlZQ/lAeliBaKS8ScoeqPJYLhefiQI2gLb3g7WkV5FUgbVg6F8FCit1Cyie4=
Received: by 10.49.8.10 with SMTP id l10mr6792388nfi;
        Fri, 13 Oct 2006 04:37:43 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id l22sm733219nfc.2006.10.13.04.37.42;
        Fri, 13 Oct 2006 04:37:43 -0700 (PDT)
Message-ID: <452F7A7F.7060504@innova-card.com>
Date:	Fri, 13 Oct 2006 13:37:35 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: [PATCH] Use kallsyms_lookup_size_offset() instead of kallsyms_lookup()
 [take #2]
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This new routine doesn't lookup for symbol names. So we needn't
to pass any char buffers or pointer since we don't care about
names.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---

 Ralf,

 Please consider it, it's only trivial changes.

 arch/mips/kernel/process.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 045d987..cace1ba 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -358,10 +358,8 @@ static int __init frame_info_init(void)
 	unsigned long size = 0;
 #ifdef CONFIG_KALLSYMS
 	unsigned long ofs;
-	char *modname;
-	char namebuf[KSYM_NAME_LEN + 1];
 
-	kallsyms_lookup((unsigned long)schedule, &size, &ofs, &modname, namebuf);
+	kallsyms_lookup_size_offset((unsigned long)schedule, &size, &ofs);
 #endif
 	schedule_mfi.func = schedule;
 	schedule_mfi.func_size = size;
@@ -403,8 +401,6 @@ unsigned long unwind_stack(struct task_s
 {
 	unsigned long stack_page;
 	struct mips_frame_info info;
-	char *modname;
-	char namebuf[KSYM_NAME_LEN + 1];
 	unsigned long size, ofs;
 	int leaf;
 	extern void ret_from_irq(void);
@@ -433,7 +429,7 @@ unsigned long unwind_stack(struct task_s
 		}
 		return 0;
 	}
-	if (!kallsyms_lookup(pc, &size, &ofs, &modname, namebuf))
+	if (!kallsyms_lookup_size_offset(pc, &size, &ofs))
 		return 0;
 	/*
 	 * Return ra if an exception occured at the first instruction
-- 
1.4.2.3
