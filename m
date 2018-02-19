Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Feb 2018 17:56:55 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:53353 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994655AbeBSQ4qgTMon (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Feb 2018 17:56:46 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 19 Feb 2018 16:55:58 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Mon, 19 Feb 2018 08:55:21 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Kees Cook <keescook@chromium.org>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     <kernel-hardening@lists.openwall.com>, <linux-mips@linux-mips.org>,
        "Matt Redfearn" <matt.redfearn@mips.com>
Subject: [PATCH] signals: Move put_compat_sigset to compat.h to silence hardened usercopy
Date:   Mon, 19 Feb 2018 16:55:06 +0000
Message-ID: <1519059306-30135-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1515636190-24061-1-git-send-email-keescook@chromium.org>
References: <1515636190-24061-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1519059351-321457-31242-22847-5
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190190
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Since commit afcc90f8621e ("usercopy: WARN() on slab cache usercopy
region violations"), MIPS systems booting with a compat root filesystem
emit a warning when copying compat siginfo to userspace:

WARNING: CPU: 0 PID: 953 at mm/usercopy.c:81 usercopy_warn+0x98/0xe8
Bad or missing usercopy whitelist? Kernel memory exposure attempt
detected from SLAB object 'task_struct' (offset 1432, size 16)!
Modules linked in:
CPU: 0 PID: 953 Comm: S01logging Not tainted 4.16.0-rc2 #10
Stack : ffffffff808c0000 0000000000000000 0000000000000001 65ac85163f3bdc4a
	65ac85163f3bdc4a 0000000000000000 90000000ff667ab8 ffffffff808c0000
	00000000000003f8 ffffffff808d0000 00000000000000d1 0000000000000000
	000000000000003c 0000000000000000 ffffffff808c8ca8 ffffffff808d0000
	ffffffff808d0000 ffffffff80810000 fffffc0000000000 ffffffff80785c30
	0000000000000009 0000000000000051 90000000ff667eb0 90000000ff667db0
	000000007fe0d938 0000000000000018 ffffffff80449958 0000000020052798
	ffffffff808c0000 90000000ff664000 90000000ff667ab0 00000000100c0000
	ffffffff80698810 0000000000000000 0000000000000000 0000000000000000
	0000000000000000 0000000000000000 ffffffff8010d02c 65ac85163f3bdc4a
	...
Call Trace:
[<ffffffff8010d02c>] show_stack+0x9c/0x130
[<ffffffff80698810>] dump_stack+0x90/0xd0
[<ffffffff80137b78>] __warn+0x100/0x118
[<ffffffff80137bdc>] warn_slowpath_fmt+0x4c/0x70
[<ffffffff8021e4a8>] usercopy_warn+0x98/0xe8
[<ffffffff8021e68c>] __check_object_size+0xfc/0x250
[<ffffffff801bbfb8>] put_compat_sigset+0x30/0x88
[<ffffffff8011af24>] setup_rt_frame_n32+0xc4/0x160
[<ffffffff8010b8b4>] do_signal+0x19c/0x230
[<ffffffff8010c408>] do_notify_resume+0x60/0x78
[<ffffffff80106f50>] work_notifysig+0x10/0x18
---[ end trace 88fffbf69147f48a ]---

Commit 5905429ad856 ("fork: Provide usercopy whitelisting for
task_struct") noted that:

"While the blocked and saved_sigmask fields of task_struct are copied to
userspace (via sigmask_to_save() and setup_rt_frame()), it is always
copied with a static length (i.e. sizeof(sigset_t))."

However, this is not true in the case of compat signals, whose sigset
is copied by put_compat_sigset and receives size as an argument.

At most call sites, put_compat_sigset is copying a sigset from the
current task_struct. This triggers a warning when
CONFIG_HARDENED_USERCOPY is active. However, by marking this function as
static inline, the warning can be avoided because in all of these cases
the size is constant at compile time, which is allowed. The only site
where this is not the case is handling the rt_sigpending syscall, but
there the copy is being made from a stack local variable so does not
trigger the warning.

Move put_compat_sigset to compat.h, and mark it static inline. This
fixes the WARN on MIPS.

Fixes: afcc90f8621e ("usercopy: WARN() on slab cache usercopy region violations")
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 include/linux/compat.h | 26 ++++++++++++++++++++++++--
 kernel/compat.c        | 19 -------------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 8a9643857c4a..c4139c7a0de0 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -17,6 +17,7 @@
 #include <linux/if.h>
 #include <linux/fs.h>
 #include <linux/aio_abi.h>	/* for aio_context_t */
+#include <linux/uaccess.h>
 #include <linux/unistd.h>
 
 #include <asm/compat.h>
@@ -550,8 +551,29 @@ asmlinkage long compat_sys_settimeofday(struct compat_timeval __user *tv,
 asmlinkage long compat_sys_adjtimex(struct compat_timex __user *utp);
 
 extern int get_compat_sigset(sigset_t *set, const compat_sigset_t __user *compat);
-extern int put_compat_sigset(compat_sigset_t __user *compat,
-			     const sigset_t *set, unsigned int size);
+
+/*
+ * Defined inline such that size can be compile time constant, which avoids
+ * CONFIG_HARDENED_USERCOPY complaining about copies from task_struct
+ */
+static inline int
+put_compat_sigset(compat_sigset_t __user *compat, const sigset_t *set,
+		  unsigned int size)
+{
+	/* size <= sizeof(compat_sigset_t) <= sizeof(sigset_t) */
+#ifdef __BIG_ENDIAN
+	compat_sigset_t v;
+	switch (_NSIG_WORDS) {
+	case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
+	case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
+	case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
+	case 1: v.sig[1] = (set->sig[0] >> 32); v.sig[0] = set->sig[0];
+	}
+	return copy_to_user(compat, &v, size) ? -EFAULT : 0;
+#else
+	return copy_to_user(compat, set, size) ? -EFAULT : 0;
+#endif
+}
 
 asmlinkage long compat_sys_migrate_pages(compat_pid_t pid,
 		compat_ulong_t maxnode, const compat_ulong_t __user *old_nodes,
diff --git a/kernel/compat.c b/kernel/compat.c
index 3247fe761f60..3f5fa8902e7d 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -488,25 +488,6 @@ get_compat_sigset(sigset_t *set, const compat_sigset_t __user *compat)
 }
 EXPORT_SYMBOL_GPL(get_compat_sigset);
 
-int
-put_compat_sigset(compat_sigset_t __user *compat, const sigset_t *set,
-		  unsigned int size)
-{
-	/* size <= sizeof(compat_sigset_t) <= sizeof(sigset_t) */
-#ifdef __BIG_ENDIAN
-	compat_sigset_t v;
-	switch (_NSIG_WORDS) {
-	case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
-	case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
-	case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
-	case 1: v.sig[1] = (set->sig[0] >> 32); v.sig[0] = set->sig[0];
-	}
-	return copy_to_user(compat, &v, size) ? -EFAULT : 0;
-#else
-	return copy_to_user(compat, set, size) ? -EFAULT : 0;
-#endif
-}
-
 #ifdef CONFIG_NUMA
 COMPAT_SYSCALL_DEFINE6(move_pages, pid_t, pid, compat_ulong_t, nr_pages,
 		       compat_uptr_t __user *, pages32,
-- 
2.7.4
