Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2006 08:33:23 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:2430 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133786AbWHCHaN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Aug 2006 08:30:13 +0100
Received: by nf-out-0910.google.com with SMTP id q29so939687nfc
        for <linux-mips@linux-mips.org>; Thu, 03 Aug 2006 00:30:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cC3xrHybvTFz6JhqS+dtP78kON+t16/shqtHcDCWiR1ekvZ44jKuZYhOZ+sDGHX0ML0/GVHMIdJ5TzGZaauKT6LFQ0Vlns5xE4M5fAWsWAlRyNIL7eWoxfO3v2279Tr3Vwf+uABr8vZApy7ECwxKiK+rkIweI5I9TcbSoZRu/Zk=
Received: by 10.48.48.18 with SMTP id v18mr3365424nfv;
        Thu, 03 Aug 2006 00:30:13 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id l22sm658408nfc.2006.08.03.00.30.11;
        Thu, 03 Aug 2006 00:30:12 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id AA40B23F772; Thu,  3 Aug 2006 09:29:21 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	anemo@mba.ocn.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 4/7] Make frame_info_init() more readable.
Date:	Thu,  3 Aug 2006 09:29:18 +0200
Message-Id: <11545901612879-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <11545901611096-git-send-email-vagabon.xyz@gmail.com>
References: <11545901611096-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/process.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 93d5432..da332d7 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -370,15 +370,15 @@ #else
 	mfinfo[0].func = schedule;
 	schedule_frame = &mfinfo[0];
 #endif
-	for (i = 0; i < ARRAY_SIZE(mfinfo) && mfinfo[i].func; i++) {
-		struct mips_frame_info *info = &mfinfo[i];
-		if (get_frame_info(info)) {
-			/* leaf or unknown */
-			if (info->func == schedule)
-				printk("Can't analyze prologue code at %p\n",
-				       info->func);
-		}
-	}
+	for (i = 0; i < ARRAY_SIZE(mfinfo) && mfinfo[i].func; i++)
+		get_frame_info(mfinfo + i);
+
+	/*
+	 * Without schedule() frame info, result given by
+	 * thread_saved_pc() and get_wchan() are not reliable.
+	 */
+	if (schedule_frame->pc_offset < 0)
+		printk("Can't analyze schedule() prologue at %p\n", schedule);
 
 	mfinfo_num = i;
 	return 0;
-- 
1.4.2.rc2
