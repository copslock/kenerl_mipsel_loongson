Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2011 02:38:26 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:53874 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491809Ab1FXAiT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Jun 2011 02:38:19 +0200
Received: by ywf9 with SMTP id 9so1130815ywf.36
        for <multiple recipients>; Thu, 23 Jun 2011 17:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=11J3sPnsGdkqaseksJZfCqrUWzifDVO8QLVgV3P9oXY=;
        b=DaqvtvwJ87jO8aTV+OGQzTDLcrUGkjqatZCHIl2WogXqd9lQUHlTsZkn7GWEL5GFGf
         maXDJr5OI1b5V04/RnLXeGIEQfhqMTd9WuG25MpZPcOwUyGff3wyu4EwmMVlZX1ULhBc
         PwBhSjRcxUC1z171QCdOHyryU5gNUjDh0yx/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Cu7SZjN9xg4Rg/Jwps+H+63wKMgC4G75GZcQiuk7inBazsIG6IBIzHqIYep7wbI7Se
         Y4VuZGoOIaATgHjBQtLPhXNhHI3l44AerItNlKyeh61tRZZVVxaqr9VOwrYaHGuxEEZk
         d5GzG5mFB0HvXIpfbl0s/Wg0U91t5dDsWsmhE=
Received: by 10.236.179.6 with SMTP id g6mr4269433yhm.370.1308875893484;
        Thu, 23 Jun 2011 17:38:13 -0700 (PDT)
Received: from localhost.localdomain (adsl-98-87-50-218.bna.bellsouth.net [98.87.50.218])
        by mx.google.com with ESMTPS id e4sm1387867yhm.36.2011.06.23.17.38.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Jun 2011 17:38:13 -0700 (PDT)
From:   Will Drewry <wad@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, djm@mindrot.org,
        segoon@openwall.com, kees.cook@canonical.com, mingo@elte.hu,
        rostedt@goodmis.org, jmorris@namei.org, fweisbec@gmail.com,
        tglx@linutronix.de, scarybeasts@gmail.com,
        Will Drewry <wad@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH v9 09/13] mips: select HAVE_SECCOMP_FILTER and provide seccomp_execve
Date:   Thu, 23 Jun 2011 19:36:48 -0500
Message-Id: <1308875813-20122-9-git-send-email-wad@chromium.org>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1308875813-20122-1-git-send-email-wad@chromium.org>
References: <1308875813-20122-1-git-send-email-wad@chromium.org>
X-archive-position: 30498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wad@chromium.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19998

Facilitate the use of CONFIG_SECCOMP_FILTER by wrapping compatibility
system call numbering for execve and selecting HAVE_SECCOMP_FILTER.

v9: rebase on to bccaeafd7c117acee36e90d37c7e05c19be9e7bf

Signed-off-by: Will Drewry <wad@chromium.org>
---
 arch/mips/Kconfig               |    1 +
 arch/mips/include/asm/seccomp.h |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 653da62..29b0848 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -10,6 +10,7 @@ config MIPS
 	select HAVE_ARCH_KGDB
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
+	select HAVE_SECCOMP_FILTER
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_C_RECORDMCOUNT
diff --git a/arch/mips/include/asm/seccomp.h b/arch/mips/include/asm/seccomp.h
index ae6306e..4014a3a 100644
--- a/arch/mips/include/asm/seccomp.h
+++ b/arch/mips/include/asm/seccomp.h
@@ -6,6 +6,7 @@
 #define __NR_seccomp_write __NR_write
 #define __NR_seccomp_exit __NR_exit
 #define __NR_seccomp_sigreturn __NR_rt_sigreturn
+#define __NR_seccomp_execve __NR_execve
 
 /*
  * Kludge alert:
@@ -19,6 +20,7 @@
 #define __NR_seccomp_write_32		4004
 #define __NR_seccomp_exit_32		4001
 #define __NR_seccomp_sigreturn_32	4193	/* rt_sigreturn */
+#define __NR_seccomp_execve_32		4011
 
 #elif defined(CONFIG_MIPS32_N32)
 
@@ -26,6 +28,7 @@
 #define __NR_seccomp_write_32		6001
 #define __NR_seccomp_exit_32		6058
 #define __NR_seccomp_sigreturn_32	6211	/* rt_sigreturn */
+#define __NR_seccomp_execve_32		6057
 
 #endif /* CONFIG_MIPS32_O32 */
 
-- 
1.7.0.4
