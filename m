Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2010 17:55:05 +0200 (CEST)
Received: from mgw1.diku.dk ([130.225.96.91]:47799 "EHLO mgw1.diku.dk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491842Ab0EZPzA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 May 2010 17:55:00 +0200
Received: from localhost (localhost [127.0.0.1])
        by mgw1.diku.dk (Postfix) with ESMTP id E9EAC52C5A4;
        Wed, 26 May 2010 17:54:59 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
        by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hvH67drN6qt9; Wed, 26 May 2010 17:54:55 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
        by mgw1.diku.dk (Postfix) with ESMTP id 76EF552C555;
        Wed, 26 May 2010 17:54:55 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
        by nhugin.diku.dk (Postfix) with ESMTP
        id BB11A6DFD0A; Wed, 26 May 2010 17:47:29 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3767)
        id 5CAFD200BF; Wed, 26 May 2010 17:54:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by ask.diku.dk (Postfix) with ESMTP id 57057200BC;
        Wed, 26 May 2010 17:54:55 +0200 (CEST)
Date:   Wed, 26 May 2010 17:54:55 +0200 (CEST)
From:   Julia Lawall <julia@diku.dk>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 3/17] arch/mips/kernel: Add missing read_unlock
Message-ID: <Pine.LNX.4.64.1005261754390.23743@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

From: Julia Lawall <julia@diku.dk>

Add a read_unlock missing on the error path.  Other ways of reaching
out_unlock have tasklist_lock unlocked.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression E1;
@@

* read_lock(E1,...);
  <+... when != E1
  if (...) {
    ... when != E1
*   return ...;
  }
  ...+>
* read_unlock(E1,...);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
I wasn't able to find what security_task_setscheduler actually does.  
If it releases tasklist_lock in an error case, then ignire this patch.

 arch/mips/kernel/mips-mt-fpaff.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index f5981c4..73581bf 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -86,8 +86,10 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	}
 
 	retval = security_task_setscheduler(p, 0, NULL);
-	if (retval)
+	if (retval) {
+		read_unlock(&tasklist_lock);
 		goto out_unlock;
+	}
 
 	/* Record new user-specified CPU set for future reference */
 	p->thread.user_cpus_allowed = new_mask;
