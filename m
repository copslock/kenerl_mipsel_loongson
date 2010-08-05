Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2010 15:51:58 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:40536 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492973Ab0HENvy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Aug 2010 15:51:54 +0200
Received: by wyf19 with SMTP id 19so3505736wyf.36
        for <multiple recipients>; Thu, 05 Aug 2010 06:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=nJBF3vaQwmfvIEEYbYGcDouD3hMOUhLj7ja7u/wGjyk=;
        b=G9cpO8CKskuqLqNaEDBAWL47cpWSscQ7NqVtZ2GinUv6sbwmMmDCjA3ibrLlCX9CB1
         Mb+JOum4Mn7P0JkhVGobZf2NV+49gKkZjg6sO1kUMXDgj2QCAd/a/VKCbY4iVDTheA/J
         iLcBFmdLElY/GLR74SS28D7B0QfVM0qxknq2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=ra39CsL+k6N1Lz5xGEej0A3f1s+EWNL60rygtRJsBlck2cWptQblBGDGxjVWDLLtZI
         7N0KfKdQwUovqSFrlzuUUC3mLO19gtVY0hPoONfI97OdbiUY/f9DAZw64QGMPnn0YMdN
         JQmGKIypLs7rL8fOT3YWq4NlRBJd0hRMnKgAM=
Received: by 10.227.72.139 with SMTP id m11mr9016254wbj.30.1281016309096;
        Thu, 05 Aug 2010 06:51:49 -0700 (PDT)
Received: from localhost.localdomain (adsl203-161-174.mclink.it [213.203.161.174])
        by mx.google.com with ESMTPS id w46sm133041weq.43.2010.08.05.06.51.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 06:51:47 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     gelma@gelma.net
Cc:     Andrea Gelmini <andrea.gelmini@gelma.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Martin Hicks <mort@sgi.com>, linux-mips@linux-mips.org
Subject: [PATCH 01/15] arch: mips: kernel: Fix a typo.
Date:   Thu,  5 Aug 2010 15:51:25 +0200
Message-Id: <1281016299-23958-1-git-send-email-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 1.7.2.1.85.g2d089
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
Precedence: bulk
X-list: linux-mips

"Userpace" -> "Userspace"

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/kernel/kgdb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
index 9b78ff6..f0f74f4 100644
--- a/arch/mips/kernel/kgdb.c
+++ b/arch/mips/kernel/kgdb.c
@@ -196,7 +196,7 @@ static int kgdb_mips_notify(struct notifier_block *self, unsigned long cmd,
 	struct pt_regs *regs = args->regs;
 	int trap = (regs->cp0_cause & 0x7c) >> 2;
 
-	/* Userpace events, ignore. */
+	/* Userspace events, ignore. */
 	if (user_mode(regs))
 		return NOTIFY_DONE;
 
-- 
1.7.2.1.85.g2d089
