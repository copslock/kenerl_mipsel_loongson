Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Nov 2017 18:03:28 +0100 (CET)
Received: from mout.kundenserver.de ([217.72.192.75]:54033 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990408AbdK0RDVZL39h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Nov 2017 18:03:21 +0100
Received: from wuerfel.lan ([109.193.157.232]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MWjXP-1edz0n0oqR-00Xwgr; Mon, 27 Nov 2017 18:02:46 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     y2038@lists.linaro.org, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org,
        Albert ARIBAUD <albert.aribaud@3adev.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Mickael GUENE <mickael.guene@st.com>,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] y2038: elfcore: use __kernel_old_timeval for process times
Date:   Mon, 27 Nov 2017 18:00:46 +0100
Message-Id: <20171127170121.634826-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20171127170121.634826-1-arnd@arndb.de>
References: <20171127170121.634826-1-arnd@arndb.de>
X-Provags-ID: V03:K0:rpEDa9aUmmfvYKqaSMaHQ23NvD93GuXx5hKnCwcIpI23kBVnIR5
 +o8BM4pjhYnGJMJWsoyqajQsO1ocI2pR1n7dTqmhqwtCgJL4Rxzc+ONJhSra0R0gn0LR9hU
 zZ1Nl80/JJLz3a3/vvso6J7wvuNA4ksZE+R3n98xPbZgm0PH3l9uOlnNOvznf9+2B35fcWB
 VPX8w5GmjaK06+cGnk7Yg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qH/KOm9gvzw=:QYo8qV/MTbJZln0IAvo1c6
 FdzDJEcoXMviuW6oEo9Pp97Jlo8B9LXjjf/ETBLMjo7DgUdTZzzJFRDWpm8Xl7lx7FH/CquJR
 451MtsTlsSWobjvk7xsu8UzevFmZGO6pSiKeaRcECUEEwiiIIBqufZE9D/xRKIiFzHXDpWEPY
 nWOKxulexjHZL4WhxYzskVRMb5T8qMLAGeTXCWtZQOMRQ9I18XY6+VDhD5SFGSOj3I/7i58x8
 eeH6Y27M+xwB5ZBZmP9cCDOktHFMMkdSdz0XlwVBrHk3V0rfFPcObp1Esbib6tPW9eDU+qta3
 8uyhoS+y46b2LBDzqXR9B9gM5eSJAcEeBxZrG9WuO9SxlX0pX5qG+l4fGWOXlMR2AMjoCDb5n
 bmr5cwErEbaymcfxCbvywcQAk35c+ehqpSROsULaqoU8QNvqgZ1lv6e9epnTqhApPdiqBt2cB
 fXVpLD8afRGC8IQGZlcum/3CzO2u9AntpvXN7cu2n/suQYHeYAsFIDOVQlQT29NDKV9edl7NE
 wui5OI/3Z22sFfWMpPOQLZXpvmxV7ThaetlzYkCxKdqz3AuxAACI/lc3ge43xj4v6DCp4sTnR
 aTppKaAcZgA5qj7t3TGBsLKC5q/87uUKCFMEbcGjYtJC0RSoM0U3nLMD4vyuGDBEcPMrrVrgZ
 P7knRxZsN0qZCmDCCQ5HUeyFkNNSS3lOb7TT7B5nngCA3SEsTjMA7pyALt+i/yaTajSLoiATX
 weQysAZTnf2uA94nQc19aIq6DPAtnEnlkNPejw==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

We store elapsed time for a crashed process in struct elf_prstatus using
'timeval' structures. Once glibc starts using 64-bit time_t, this becomes
incompatible with the kernel's idea of timeval since the structure layout
no longer matches on 32-bit architectures.

This changes the definition of the elf_prstatus structure to use
__kernel_old_timeval instead, which is hardcoded to the currently used
binary layout. There is no risk of overflow in y2038 though, because
the time values are all relative times, and can store up to 68 years
of process elapsed time.

There is a risk of applications breaking at build time when they
use the new kernel headers and expect the type to be exactly 'timeval'
rather than a structure that has the same fields as before. Those
applications have to be modified to deal with 64-bit time_t anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/kernel/binfmt_elfn32.c  |  4 ++--
 arch/mips/kernel/binfmt_elfo32.c  |  4 ++--
 arch/parisc/kernel/binfmt_elf32.c |  4 ++--
 fs/binfmt_elf.c                   | 12 ++++++------
 fs/binfmt_elf_fdpic.c             | 12 ++++++------
 fs/compat_binfmt_elf.c            |  4 ++--
 include/uapi/linux/elfcore.h      |  8 ++++----
 7 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/mips/kernel/binfmt_elfn32.c b/arch/mips/kernel/binfmt_elfn32.c
index 89b234844534..2fe2d5573289 100644
--- a/arch/mips/kernel/binfmt_elfn32.c
+++ b/arch/mips/kernel/binfmt_elfn32.c
@@ -100,7 +100,7 @@ jiffies_to_compat_timeval(unsigned long jiffies, struct compat_timeval *value)
 #undef TASK_SIZE
 #define TASK_SIZE TASK_SIZE32
 
-#undef ns_to_timeval
-#define ns_to_timeval ns_to_compat_timeval
+#undef ns_to_kernel_old_timeval
+#define ns_to_kernel_old_timeval ns_to_compat_timeval
 
 #include "../../../fs/binfmt_elf.c"
diff --git a/arch/mips/kernel/binfmt_elfo32.c b/arch/mips/kernel/binfmt_elfo32.c
index a88c59db3d48..d3c37583ef91 100644
--- a/arch/mips/kernel/binfmt_elfo32.c
+++ b/arch/mips/kernel/binfmt_elfo32.c
@@ -103,7 +103,7 @@ jiffies_to_compat_timeval(unsigned long jiffies, struct compat_timeval *value)
 #undef TASK_SIZE
 #define TASK_SIZE TASK_SIZE32
 
-#undef ns_to_timeval
-#define ns_to_timeval ns_to_compat_timeval
+#undef ns_to_kernel_old_timeval
+#define ns_to_kernel_old_timeval ns_to_compat_timeval
 
 #include "../../../fs/binfmt_elf.c"
diff --git a/arch/parisc/kernel/binfmt_elf32.c b/arch/parisc/kernel/binfmt_elf32.c
index 20dfa081ed0b..ad3ea00c64f7 100644
--- a/arch/parisc/kernel/binfmt_elf32.c
+++ b/arch/parisc/kernel/binfmt_elf32.c
@@ -92,7 +92,7 @@ struct elf_prpsinfo32
 	current->thread.map_base = DEFAULT_MAP_BASE32; \
 	current->thread.task_size = DEFAULT_TASK_SIZE32 \
 
-#undef ns_to_timeval
-#define ns_to_timeval ns_to_compat_timeval
+#undef ns_to_kernel_old_timeval
+#define ns_to_kernel_old_timeval ns_to_compat_timeval
 
 #include "../../../fs/binfmt_elf.c"
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 83732fef510d..7ae716db7d99 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1500,18 +1500,18 @@ static void fill_prstatus(struct elf_prstatus *prstatus,
 		 * group-wide total, not its individual thread total.
 		 */
 		thread_group_cputime(p, &cputime);
-		prstatus->pr_utime = ns_to_timeval(cputime.utime);
-		prstatus->pr_stime = ns_to_timeval(cputime.stime);
+		prstatus->pr_utime = ns_to_kernel_old_timeval(cputime.utime);
+		prstatus->pr_stime = ns_to_kernel_old_timeval(cputime.stime);
 	} else {
 		u64 utime, stime;
 
 		task_cputime(p, &utime, &stime);
-		prstatus->pr_utime = ns_to_timeval(utime);
-		prstatus->pr_stime = ns_to_timeval(stime);
+		prstatus->pr_utime = ns_to_kernel_old_timeval(utime);
+		prstatus->pr_stime = ns_to_kernel_old_timeval(stime);
 	}
 
-	prstatus->pr_cutime = ns_to_timeval(p->signal->cutime);
-	prstatus->pr_cstime = ns_to_timeval(p->signal->cstime);
+	prstatus->pr_cutime = ns_to_kernel_old_timeval(p->signal->cutime);
+	prstatus->pr_cstime = ns_to_kernel_old_timeval(p->signal->cstime);
 }
 
 static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 429326b6e2e7..89717459224b 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1362,17 +1362,17 @@ static void fill_prstatus(struct elf_prstatus *prstatus,
 		 * group-wide total, not its individual thread total.
 		 */
 		thread_group_cputime(p, &cputime);
-		prstatus->pr_utime = ns_to_timeval(cputime.utime);
-		prstatus->pr_stime = ns_to_timeval(cputime.stime);
+		prstatus->pr_utime = ns_to_kernel_old_timeval(cputime.utime);
+		prstatus->pr_stime = ns_to_kernel_old_timeval(cputime.stime);
 	} else {
 		u64 utime, stime;
 
 		task_cputime(p, &utime, &stime);
-		prstatus->pr_utime = ns_to_timeval(utime);
-		prstatus->pr_stime = ns_to_timeval(stime);
+		prstatus->pr_utime = ns_to_kernel_old_timeval(utime);
+		prstatus->pr_stime = ns_to_kernel_old_timeval(stime);
 	}
-	prstatus->pr_cutime = ns_to_timeval(p->signal->cutime);
-	prstatus->pr_cstime = ns_to_timeval(p->signal->cstime);
+	prstatus->pr_cutime = ns_to_kernel_old_timeval(p->signal->cutime);
+	prstatus->pr_cstime = ns_to_kernel_old_timeval(p->signal->cstime);
 
 	prstatus->pr_exec_fdpic_loadmap = p->mm->context.exec_fdpic_loadmap;
 	prstatus->pr_interp_fdpic_loadmap = p->mm->context.interp_fdpic_loadmap;
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 504b3c3539dc..5df608af1306 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -51,8 +51,8 @@
 #define elf_prstatus	compat_elf_prstatus
 #define elf_prpsinfo	compat_elf_prpsinfo
 
-#undef ns_to_timeval
-#define ns_to_timeval ns_to_compat_timeval
+#undef ns_to_kernel_old_timeval
+#define ns_to_kernel_old_timeval ns_to_compat_timeval
 
 /*
  * To use this file, asm/elf.h must define compat_elf_check_arch.
diff --git a/include/uapi/linux/elfcore.h b/include/uapi/linux/elfcore.h
index 0b2c9e16e345..baf03562306d 100644
--- a/include/uapi/linux/elfcore.h
+++ b/include/uapi/linux/elfcore.h
@@ -53,10 +53,10 @@ struct elf_prstatus
 	pid_t	pr_ppid;
 	pid_t	pr_pgrp;
 	pid_t	pr_sid;
-	struct timeval pr_utime;	/* User time */
-	struct timeval pr_stime;	/* System time */
-	struct timeval pr_cutime;	/* Cumulative user time */
-	struct timeval pr_cstime;	/* Cumulative system time */
+	struct __kernel_old_timeval pr_utime;	/* User time */
+	struct __kernel_old_timeval pr_stime;	/* System time */
+	struct __kernel_old_timeval pr_cutime;	/* Cumulative user time */
+	struct __kernel_old_timeval pr_cstime;	/* Cumulative system time */
 #if 0
 	long	pr_instr;		/* Current instruction */
 #endif
-- 
2.9.0
