Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2014 10:14:44 +0200 (CEST)
Received: from mail-pb0-f48.google.com ([209.85.160.48]:39241 "EHLO
        mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822271AbaDDIMuqZo0C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2014 10:12:50 +0200
Received: by mail-pb0-f48.google.com with SMTP id md12so3103997pbc.21
        for <multiple recipients>; Fri, 04 Apr 2014 01:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pRHW5u0KQvzRjgbxBaNAtkpSo85lSwyhbNXZnT3pm34=;
        b=oMblO4BD/lMahAMEw/tCEj6/1RYnbp11SBmcUR5QbQaWI3Jws9Om2tAGTZ392La1yD
         Pi9QC339Id4FglLXIgKduKR6cgG/Mb/MTUPc5E37hsyxWp9jOTBoLpN+OV+UQJg9QMTa
         xl5W1736HrUKQLm7KVKuBI8HWZWdp4AnM249J+WtaQK12LBmrnT9u4ZXH5MkTrMb7Oms
         bATt9OQzSyrs/3WlMeclJvqotkoT95um2mbLWoJyCwTET75MMaLZTS6x9G6w2EXdojhJ
         l42hI9DUTEPlmgv1UJT1A1Fheu15MrU7ys3S03zkMyquOwABsxnRKuY3UgpeEA/nh16t
         D87w==
X-Received: by 10.68.110.165 with SMTP id ib5mr13384950pbb.61.1396599164422;
        Fri, 04 Apr 2014 01:12:44 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id pe3sm16066819pbc.23.2014.04.04.01.12.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 04 Apr 2014 01:12:43 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 5/9] MIPS: Add numa api support
Date:   Fri,  4 Apr 2014 16:11:40 +0800
Message-Id: <1396599104-24370-6-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1396599104-24370-1-git-send-email-chenhc@lemote.com>
References: <1396599104-24370-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39645
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
and N64 ABIs.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/scall32-o32.S |    4 ++--
 arch/mips/kernel/scall64-64.S  |    4 ++--
 arch/mips/kernel/scall64-n32.S |    6 +++---
 arch/mips/kernel/scall64-o32.S |    6 +++---
 4 files changed, 10 insertions(+), 10 deletions(-)

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
index f68d2f4..92db19e 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -339,9 +339,9 @@ EXPORT(sysn32_call_table)
 	PTR	compat_sys_clock_nanosleep
 	PTR	sys_tgkill
 	PTR	compat_sys_utimes		/* 6230 */
-	PTR	sys_ni_syscall			/* sys_mbind */
-	PTR	sys_ni_syscall			/* sys_get_mempolicy */
-	PTR	sys_ni_syscall			/* sys_set_mempolicy */
+	PTR	sys_mbind
+	PTR	sys_get_mempolicy
+	PTR	sys_set_mempolicy
 	PTR	compat_sys_mq_open
 	PTR	sys_mq_unlink			/* 6235 */
 	PTR	compat_sys_mq_timedsend
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 70f6ace..0230429 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -473,9 +473,9 @@ EXPORT(sys32_call_table)
 	PTR	compat_sys_clock_nanosleep	/* 4265 */
 	PTR	sys_tgkill
 	PTR	compat_sys_utimes
-	PTR	sys_ni_syscall			/* sys_mbind */
-	PTR	sys_ni_syscall			/* sys_get_mempolicy */
-	PTR	sys_ni_syscall			/* 4270 sys_set_mempolicy */
+	PTR	sys_mbind
+	PTR	sys_get_mempolicy
+	PTR	sys_set_mempolicy		/* 4270 */
 	PTR	compat_sys_mq_open
 	PTR	sys_mq_unlink
 	PTR	compat_sys_mq_timedsend
-- 
1.7.7.3
