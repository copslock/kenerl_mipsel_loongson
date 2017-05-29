Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 May 2017 09:23:13 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:18712 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990601AbdE2HW5bPs7p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 May 2017 09:22:57 +0200
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v4T7Md9T004409
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 May 2017 07:22:40 GMT
Received: from t460.home (dhcp-ukc1-twvpn-2-vpnpool-10-175-199-173.vpn.oracle.com [10.175.199.173])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v4T7MSGL018388;
        Mon, 29 May 2017 07:22:29 GMT
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        linux-mips@linux-mips.org, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, Oleg Nesterov <oleg@redhat.com>,
        Jamie Iles <jamie.iles@oracle.com>
Subject: [PATCH] kthread: fix boot hang (regression) on MIPS/OpenRISC
Date:   Mon, 29 May 2017 09:22:07 +0200
Message-Id: <20170529072207.16130-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.12.0.rc0
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Return-Path: <vegard.nossum@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vegard.nossum@oracle.com
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

This fixes a regression in commit 4d6501dce079 where I didn't notice
that MIPS and OpenRISC were reinitialising p->{set,clear}_child_tid to
NULL after our initialisation in copy_process().

We can simply get rid of the arch-specific initialisation here since it
is now always done in copy_process() before hitting copy_thread{,_tls}().

Review notes:

 - As far as I can tell, copy_process() is the only user of
   copy_thread_tls(), which is the only caller of copy_thread() for
   architectures that don't implement copy_thread_tls().

 - After this patch, there is no arch-specific code touching
   p->set_child_tid or p->clear_child_tid whatsoever.

 - It may look like MIPS/OpenRISC wanted to always have these fields be
   NULL, but that's not true, as copy_process() would unconditionally
   set them again _after_ calling copy_thread_tls() before commit
   4d6501dce079.

Fixes: 4d6501dce079c1eb6bf0b1d8f528a5e81770109e ("kthread: Fix use-after-free if kthread fork fails")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net> # MIPS only
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Jamie Iles <jamie.iles@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
Not sure who this should go through, the last patch went through tglx/the
core-urgent-for-linus tree, but it does touch arch code + fix a mainline
boot hang regression on at least MIPS (Guenter said OpenRISC didn't seem
affected in his boot tests, but the code looks wrong in any case). Maybe
we could get acks/reviews by MIPS and OpenRISC maintainers?
---
 arch/mips/kernel/process.c     | 1 -
 arch/openrisc/kernel/process.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 918d4c73e951..5351e1f3950d 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -120,7 +120,6 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
 	unsigned long childksp;
-	p->set_child_tid = p->clear_child_tid = NULL;
 
 	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
 
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index f8da545854f9..106859ae27ff 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -167,8 +167,6 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	top_of_kernel_stack = sp;
 
-	p->set_child_tid = p->clear_child_tid = NULL;
-
 	/* Locate userspace context on stack... */
 	sp -= STACK_FRAME_OVERHEAD;	/* redzone */
 	sp -= sizeof(struct pt_regs);
-- 
2.12.0.rc0
