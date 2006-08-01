Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2006 10:30:47 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:2584 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133579AbWHAJ2M (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Aug 2006 10:28:12 +0100
Received: by nf-out-0910.google.com with SMTP id q29so210812nfc
        for <linux-mips@linux-mips.org>; Tue, 01 Aug 2006 02:28:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ze+4QAX5xuVlquWRT1s77yhGl1iZPJ3IaWvFKkDfRXCCWoCcr3MNmwFO0NfT/ZGML4ng8DKtT2yJqkHSFU5b/apVM5irKSg1vkamoDIClyHzEV9F1Ii0nDHsTrB+C02ckaubhWHNpwcp6IAVW5UIwMKVnZYEbC2HIqymmv2r8So=
Received: by 10.49.8.10 with SMTP id l10mr408286nfi;
        Tue, 01 Aug 2006 02:28:12 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id k24sm539561nfc.2006.08.01.02.28.11;
        Tue, 01 Aug 2006 02:28:12 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id A982E23F770; Tue,  1 Aug 2006 11:27:18 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	anemo@mba.ocn.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 3/7] Make frame_info_init() more readable.
Date:	Tue,  1 Aug 2006 11:27:13 +0200
Message-Id: <11544244381170-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <11544244373398-git-send-email-vagabon.xyz@gmail.com>
References: <11544244373398-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12143
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
index 333f0bb..539b23b 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -364,15 +364,15 @@ #else
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
