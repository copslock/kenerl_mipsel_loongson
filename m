Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 May 2011 02:17:44 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:44832 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491884Ab1ENARh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 14 May 2011 02:17:37 +0200
Received: (qmail 25897 invoked from network); 14 May 2011 00:17:31 -0000
Received: from localhost (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by localhost with (DHE-RSA-AES128-SHA encrypted) SMTP; 14 May 2011 00:17:31 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Fri, 13 May 2011 17:17:31 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ipc: Add missing sys_ni entries for ipc/compat.c functions
Date:   Fri, 13 May 2011 17:07:28 -0700
Message-Id: <cb0939f54999dd3754808f2c5fc1cf0f@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

When building with:

CONFIG_64BIT=y
CONFIG_MIPS32_COMPAT=y
CONFIG_COMPAT=y
CONFIG_MIPS32_O32=y
CONFIG_MIPS32_N32=y
CONFIG_SYSVIPC is not set
(and implicitly: CONFIG_SYSVIPC_COMPAT is not set)

the final link fails with unresolved symbols for:

compat_sys_semctl, compat_sys_msgsnd, compat_sys_msgrcv,
compat_sys_shmctl, compat_sys_msgctl, compat_sys_semtimedop

The fix is to add cond_syscall declarations for all syscalls in
ipc/compat.c

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 kernel/sys_ni.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 25cc41c..1140c12 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -69,15 +69,22 @@ cond_syscall(compat_sys_epoll_pwait);
 cond_syscall(sys_semget);
 cond_syscall(sys_semop);
 cond_syscall(sys_semtimedop);
+cond_syscall(compat_sys_semtimedop);
 cond_syscall(sys_semctl);
+cond_syscall(compat_sys_semctl);
 cond_syscall(sys_msgget);
 cond_syscall(sys_msgsnd);
+cond_syscall(compat_sys_msgsnd);
 cond_syscall(sys_msgrcv);
+cond_syscall(compat_sys_msgrcv);
 cond_syscall(sys_msgctl);
+cond_syscall(compat_sys_msgctl);
 cond_syscall(sys_shmget);
 cond_syscall(sys_shmat);
+cond_syscall(compat_sys_shmat);
 cond_syscall(sys_shmdt);
 cond_syscall(sys_shmctl);
+cond_syscall(compat_sys_shmctl);
 cond_syscall(sys_mq_open);
 cond_syscall(sys_mq_unlink);
 cond_syscall(sys_mq_timedsend);
-- 
1.7.5
