Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2006 15:19:04 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.239]:54129 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037791AbWHROSi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Aug 2006 15:18:38 +0100
Received: by wr-out-0506.google.com with SMTP id i31so153072wra
        for <linux-mips@linux-mips.org>; Fri, 18 Aug 2006 07:18:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=CaT7xFTO8neVRjf5FZ08JbOzVYqKINdnYvviux52bRKRCTv46uaLPSv0mMBToZJMXGfql/uWQaQmEY92f7SW/XxyPYCUuOLXv2lTFYNW3Na0rDRm676bVFr3AKusggwyFrYPyDRAdqS1Am+B4iqjBReCUA+/XevTradlVCqZbOE=
Received: by 10.65.122.15 with SMTP id z15mr3709489qbm;
        Fri, 18 Aug 2006 07:18:34 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id e15sm294776qba.2006.08.18.07.18.33;
        Fri, 18 Aug 2006 07:18:34 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 78D7623F76A; Fri, 18 Aug 2006 16:18:09 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	anemo@mba.ocn.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 1/3] unwind_stack(): return ra if an exception occured at the first instruction
Date:	Fri, 18 Aug 2006 16:18:07 +0200
Message-Id: <11559106892428-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc4
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/process.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 951bf9c..e7b0b38 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -465,8 +465,11 @@ unsigned long unwind_stack(struct task_s
 
 	if (!kallsyms_lookup(pc, &size, &ofs, &modname, namebuf))
 		return 0;
-	if (ofs == 0)
-		return 0;
+	/*
+	 * Return ra if an exception occured at the first instruction
+	 */
+	if (unlikely(ofs == 0))
+		return ra;
 
 	info.func = (void *)(pc - ofs);
 	info.func_size = ofs;	/* analyze from start to ofs */
-- 
1.4.2.rc4
