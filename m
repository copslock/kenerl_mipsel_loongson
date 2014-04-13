Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Apr 2014 02:27:06 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:55700 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822082AbaDMAZVGzGPg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Apr 2014 02:25:21 +0200
Received: by mail-pa0-f45.google.com with SMTP id kl14so6870482pab.32
        for <multiple recipients>; Sat, 12 Apr 2014 17:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ISHlKnTbnqSDlr9pu+om0ZolbYjejKD/6XUDgt4TeZ8=;
        b=g+SfSkvKzzUxDVW0zhbD8b94HSVWqcU6Blkfb9oq0DjpTh4GI88+a6q2UA6KUy8avd
         J5wbZ8OMID89oPC7GLWKvEb1IcsmxYI0TMNoPjRqtAKn/ygSmqU1x0aftQsULtD01Rzm
         rhiwed8uXJj+08Knx1tb97Bdi+Wlltl2MfcuW5rr+0H/CiIYa6S9dp3pB4rr1Tu7mN43
         jTJ0lvC4tTM+4uhuE3VvDkhu3QYzqCaYi1Z4QYDXK+SQw/RK3N4PXql7SIH1uP3eeHM7
         Rq2P03IUzEe+CEQOGCv9pabzOy+dot0JcLm/fOQjfp42R52KaF4Ecxf80hJqkZBW6MxE
         7F+w==
X-Received: by 10.68.236.41 with SMTP id ur9mr35520778pbc.101.1397348714167;
        Sat, 12 Apr 2014 17:25:14 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id sh5sm24474879pbc.21.2014.04.12.17.25.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 12 Apr 2014 17:25:13 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 5/8] MIPS: Add numa api support
Date:   Sun, 13 Apr 2014 08:24:19 +0800
Message-Id: <1397348662-22502-6-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1397348662-22502-1-git-send-email-chenhc@lemote.com>
References: <1397348662-22502-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Enable sys_mbind()/sys_get_mempolicy()/sys_set_mempolicy() for O32, N32,
and N64 ABIs. By the way, O32/N32 should use the compat version of
sys_migrate_pages()/sys_move_pages(), so fix that.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/scall32-o32.S |    4 ++--
 arch/mips/kernel/scall64-64.S  |    4 ++--
 arch/mips/kernel/scall64-n32.S |   10 +++++-----
 arch/mips/kernel/scall64-o32.S |    8 ++++----
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index fdc70b4..7f7e2fb 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -495,8 +495,8 @@ EXPORT(sys_call_table)
 	PTR	sys_tgkill
 	PTR	sys_utimes
 	PTR	sys_mbind
-	PTR	sys_ni_syscall			/* sys_get_mempolicy */
-	PTR	sys_ni_syscall			/* 4270 sys_set_mempolicy */
+	PTR	sys_get_mempolicy
+	PTR	sys_set_mempolicy		/* 4270 */
 	PTR	sys_mq_open
 	PTR	sys_mq_unlink
 	PTR	sys_mq_timedsend
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index dd99c328..a4baf06 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -347,8 +347,8 @@ EXPORT(sys_call_table)
 	PTR	sys_tgkill			/* 5225 */
 	PTR	sys_utimes
 	PTR	sys_mbind
-	PTR	sys_ni_syscall			/* sys_get_mempolicy */
-	PTR	sys_ni_syscall			/* sys_set_mempolicy */
+	PTR	sys_get_mempolicy
+	PTR	sys_set_mempolicy
 	PTR	sys_mq_open			/* 5230 */
 	PTR	sys_mq_unlink
 	PTR	sys_mq_timedsend
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index f68d2f4..6811d35 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -339,9 +339,9 @@ EXPORT(sysn32_call_table)
 	PTR	compat_sys_clock_nanosleep
 	PTR	sys_tgkill
 	PTR	compat_sys_utimes		/* 6230 */
-	PTR	sys_ni_syscall			/* sys_mbind */
-	PTR	sys_ni_syscall			/* sys_get_mempolicy */
-	PTR	sys_ni_syscall			/* sys_set_mempolicy */
+	PTR	compat_sys_mbind
+	PTR	compat_sys_get_mempolicy
+	PTR	compat_sys_set_mempolicy
 	PTR	compat_sys_mq_open
 	PTR	sys_mq_unlink			/* 6235 */
 	PTR	compat_sys_mq_timedsend
@@ -358,7 +358,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_inotify_init
 	PTR	sys_inotify_add_watch
 	PTR	sys_inotify_rm_watch
-	PTR	sys_migrate_pages		/* 6250 */
+	PTR	compat_sys_migrate_pages	/* 6250 */
 	PTR	sys_openat
 	PTR	sys_mkdirat
 	PTR	sys_mknodat
@@ -379,7 +379,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_sync_file_range
 	PTR	sys_tee
 	PTR	compat_sys_vmsplice		/* 6270 */
-	PTR	sys_move_pages
+	PTR	compat_sys_move_pages
 	PTR	compat_sys_set_robust_list
 	PTR	compat_sys_get_robust_list
 	PTR	compat_sys_kexec_load
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 70f6ace..221abd1 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -473,9 +473,9 @@ EXPORT(sys32_call_table)
 	PTR	compat_sys_clock_nanosleep	/* 4265 */
 	PTR	sys_tgkill
 	PTR	compat_sys_utimes
-	PTR	sys_ni_syscall			/* sys_mbind */
-	PTR	sys_ni_syscall			/* sys_get_mempolicy */
-	PTR	sys_ni_syscall			/* 4270 sys_set_mempolicy */
+	PTR	compat_sys_mbind
+	PTR	compat_sys_get_mempolicy
+	PTR	compat_sys_set_mempolicy	/* 4270 */
 	PTR	compat_sys_mq_open
 	PTR	sys_mq_unlink
 	PTR	compat_sys_mq_timedsend
@@ -492,7 +492,7 @@ EXPORT(sys32_call_table)
 	PTR	sys_inotify_init
 	PTR	sys_inotify_add_watch		/* 4285 */
 	PTR	sys_inotify_rm_watch
-	PTR	sys_migrate_pages
+	PTR	compat_sys_migrate_pages
 	PTR	compat_sys_openat
 	PTR	sys_mkdirat
 	PTR	sys_mknodat			/* 4290 */
-- 
1.7.7.3
