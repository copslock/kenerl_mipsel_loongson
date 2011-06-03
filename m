Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2011 22:32:40 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:55622 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491189Ab1FCUce (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jun 2011 22:32:34 +0200
Received: by ywf9 with SMTP id 9so1146209ywf.36
        for <multiple recipients>; Fri, 03 Jun 2011 13:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=n29JH1TGjiFRXdM7KNLghkbfZ4y73MIDKd3oAYdreSg=;
        b=W76YO/VWcOfUN0VrALLI2kpJHmbbR4lHjPweC4YC2Rfb1kgLNoqXu+SuxptmuFaLtO
         FXnk4JZ55QO/8PsStZnphgxUls3gyMBtdMgQKN438ikXz7z6c2ADvA8gx9/CB25aHT3O
         aSJbtKlVOAJXivecY1A571y2EheUZYWkwdjbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gWvKt5rJb9fouUM8U11I5NsH8YxrJqNGVWquTYk6SkldCLFLFQNB3i7yQnbKflezgy
         Be6sTEINRwhup+S2HhcEE6uTglOV7lsVaVG8F+Qvb7kVaM/DEA5Fri4V7VFAZ4flMZP3
         m8OLNXY4wDYNFJ0+5z97Ma/Rwe+TixXlKrq6o=
Received: by 10.151.28.1 with SMTP id f1mr2274252ybj.51.1307133148205;
        Fri, 03 Jun 2011 13:32:28 -0700 (PDT)
Received: from localhost.localdomain (adsl-98-87-45-176.bna.bellsouth.net [98.87.45.176])
        by mx.google.com with ESMTPS id i62sm1611097yhm.24.2011.06.03.13.32.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Jun 2011 13:32:27 -0700 (PDT)
From:   Will Drewry <wad@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     kees.cook@canonical.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@elte.hu, rostedt@goodmis.org,
        jmorris@namei.org, paulmck@linux.vnet.ibm.com,
        Will Drewry <wad@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH v4 09/13] mips: select HAVE_SECCOMP_FILTER and provide seccomp_execve
Date:   Fri,  3 Jun 2011 15:34:08 -0500
Message-Id: <1307133252-23259-9-git-send-email-wad@chromium.org>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1307133252-23259-1-git-send-email-wad@chromium.org>
References: <1307133252-23259-1-git-send-email-wad@chromium.org>
X-archive-position: 30210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wad@chromium.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2957

Facilitate the use of CONFIG_SECCOMP_FILTER by wrapping compatibility
system call numbering for execve and selecting HAVE_SECCOMP_FILTER.

Signed-off-by: Will Drewry <wad@chromium.org>
---
 arch/mips/Kconfig               |    1 +
 arch/mips/include/asm/seccomp.h |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8e256cc..d376f68 100644
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
