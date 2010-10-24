Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Oct 2010 23:24:10 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:40028 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491153Ab0JXVYH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 24 Oct 2010 23:24:07 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9OLNq5t003521;
        Sun, 24 Oct 2010 22:23:53 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9OLNowE003519;
        Sun, 24 Oct 2010 22:23:50 +0100
Date:   Sun, 24 Oct 2010 22:23:50 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        James Morris <jmorris@namei.org>
Subject: [PATCH] MIPS: MT: Fix build error iFPU affinity code
Message-ID: <20101024212350.GA18747@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

> commit b0ae19811375031ae3b3fecc65b702a9c6e5cc28
> Author: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
> Date:   Fri Oct 15 04:21:18 2010 +0900
>
>     security: remove unused parameter from security_task_setscheduler()

broke the build of arch/mips/kernel/mips-mt-fpaff.c.  The function
arguments were unnecessary, not the semicolon ...

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/kernel/mips-mt-fpaff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 9a526ba..802e616 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -103,7 +103,7 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	if (!check_same_owner(p) && !capable(CAP_SYS_NICE))
 		goto out_unlock;
 
-	retval = security_task_setscheduler(p)
+	retval = security_task_setscheduler(p);
 	if (retval)
 		goto out_unlock;
 
