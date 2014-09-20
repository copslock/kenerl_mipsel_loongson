Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Sep 2014 12:42:21 +0200 (CEST)
Received: from www262.sakura.ne.jp ([202.181.97.72]:25652 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007509AbaITKmPvQrd6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Sep 2014 12:42:15 +0200
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.14.5/8.14.5) with ESMTP id s8KAeDEP001705;
        Sat, 20 Sep 2014 19:40:13 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/virusgw_smtp/412/fsav403.sakura.ne.jp);
 Sat, 20 Sep 2014 19:40:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/virusgw_smtp/412/fsav403.sakura.ne.jp)
Received: from CLAMP (KD175108057186.ppp-bb.dion.ne.jp [175.108.57.186])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.14.5/8.14.5) with ESMTP id s8KAeCZn001699;
        Sat, 20 Sep 2014 19:40:12 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
To:     keescook@chromium.org, linux-kernel@vger.kernel.org
Cc:     james.l.morris@oracle.com, oleg@redhat.com, luto@amacapital.net,
        drysdale@google.com, mtk.manpages@gmail.com, wad@chromium.org,
        jln@chromium.org, linux-api@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH 3.17-rc5] Fix confusing PFA_NO_NEW_PRIVS constant.
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <201409192053.IHJ35462.JLOMOSOFFVtQFH@I-love.SAKURA.ne.jp>
        <541D16EA.70407@huawei.com>
In-Reply-To: <541D16EA.70407@huawei.com>
Message-Id: <201409201940.AHG21834.LJOFFHSFQOtVMO@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date:   Sat, 20 Sep 2014 19:40:30 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <penguin-kernel@I-love.SAKURA.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: penguin-kernel@I-love.SAKURA.ne.jp
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

Can you apply below patch before new PFA_* are defined?
Cgroups code might want to define PFA_SPREAD_PAGE as 1 and PFA_SPREAD_SLAB as 2.
----------------------------------------
>From 8543e68adb210142fa347d8bc9d83df0bb2c5291 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 20 Sep 2014 19:24:23 +0900
Subject: [PATCH 3.17-rc5] Fix confusing PFA_NO_NEW_PRIVS constant.

Commit 1d4457f99928 ("sched: move no_new_privs into new atomic flags")
defined PFA_NO_NEW_PRIVS as hexadecimal value, but it is confusing
because it is used as bit number. Redefine it as decimal bit number.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/sched.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5c2c885..4557765 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1957,7 +1957,7 @@ static inline void memalloc_noio_restore(unsigned int flags)
 }
 
 /* Per-process atomic flags. */
-#define PFA_NO_NEW_PRIVS 0x00000001	/* May not gain new privileges. */
+#define PFA_NO_NEW_PRIVS 0	/* May not gain new privileges. */
 
 static inline bool task_no_new_privs(struct task_struct *p)
 {
-- 
1.7.1
