Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jul 2010 21:11:15 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:59719 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492053Ab0GQTLL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Jul 2010 21:11:11 +0200
Received: by pwj7 with SMTP id 7so1539222pwj.36
        for <multiple recipients>; Sat, 17 Jul 2010 12:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=6d7y1BDHKMq6wKs33M2LFaRmOv2YIqN+Ju5JVdyZ9KY=;
        b=Rl25S2HHlyl0OVh0o8Zi6yEvm+qWnU6sslItdlsfbVwBAdL5o4AlNz0nJRTiAxmBMQ
         QDA+D2sWdTM62l0mQtSLMNogQZI0V3Z6i0i4ByDTubOJltjXi+H9T2YIfPTiNPOw6c2C
         247RReVmmj0pH9nYj1MneMze7gWDSdWc6mw3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=EoG3Bx1ZNUejkfFXi8LDTqgmQ/m3KNtL3WuLxbQ8wc9QFLerYDcZ5tZMff41+PsskV
         7o51yhRnQVaSx6ZAn3rlf8qBGobaFZwu68gsQMs+JD8uWOdtW5Icg5VMfNJnbprliorE
         VoMW/j+Wsq1H/SRHB6htwU11b0K3VG33hyHb0=
Received: by 10.142.224.7 with SMTP id w7mr3754279wfg.84.1279393864511;
        Sat, 17 Jul 2010 12:11:04 -0700 (PDT)
Received: from localhost.localdomain ([182.18.29.11])
        by mx.google.com with ESMTPS id c16sm14837754rvn.1.2010.07.17.12.11.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Jul 2010 12:11:03 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: tracing: Fix the indentation of mcount.S
Date:   Sun, 18 Jul 2010 03:10:51 +0800
Message-Id: <1279393851-27153-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

The commit "MIPS: Tracing: Cleanup the arguments passing of
prepare_ftrace_return" has moved the "jal     prepare_ftrace_return"
instruction after the handling of the 3rd argument but forgotten
removing the superfluous space before the related instructions, this
patch does it.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/mcount.S |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 6bfcb7a..4c968e7 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -165,12 +165,12 @@ NESTED(ftrace_graph_caller, PT_SIZE, ra)
 
 	/* arg3: Get frame pointer of current stack */
 #ifdef CONFIG_FRAME_POINTER
-	 move	a2, fp
+	move	a2, fp
 #else /* ! CONFIG_FRAME_POINTER */
 #ifdef CONFIG_64BIT
-	 PTR_LA	a2, PT_SIZE(sp)
+	PTR_LA	a2, PT_SIZE(sp)
 #else
-	 PTR_LA	a2, (PT_SIZE+8)(sp)
+	PTR_LA	a2, (PT_SIZE+8)(sp)
 #endif
 #endif
 
-- 
1.7.0.4
