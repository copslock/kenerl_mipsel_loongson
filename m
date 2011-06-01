Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jun 2011 05:11:12 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:62995 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491108Ab1FADLF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Jun 2011 05:11:05 +0200
Received: by yxh35 with SMTP id 35so2477858yxh.36
        for <multiple recipients>; Tue, 31 May 2011 20:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=n29JH1TGjiFRXdM7KNLghkbfZ4y73MIDKd3oAYdreSg=;
        b=Ff8vEyVst6eA8VleCWKd+eLP0dFjZxBCqJqAbE74xWMJ3ZCngUBWNEjGA+YFQrRiej
         MD9OdsnW682zCXrf4u9WI16kX4akh8SqvI9DPmIfU88TrybQLKELB4zb1+audFpuaoWh
         xo+/2Pe84T6czmTTTgiBg7EJ47ROJwU5nfDAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KNuoOOblS+kRKhvW0eLKJfSNrTCqI9Pl5NXSftMfUrR1mVaguu6zrHHk/nqaJHOsH3
         Fqc3cSCu6ZNiHeLXwaeRTwWa4i9bdPcZ2Eifwy63JxaLkqkDz8zYIcUh39aV6Q6I0FKV
         tcsB7/8zQF62rOE89suGfALb2rLb9RpCAC3hA=
Received: by 10.91.212.15 with SMTP id o15mr5713268agq.189.1306897857760;
        Tue, 31 May 2011 20:10:57 -0700 (PDT)
Received: from localhost.localdomain (adsl-98-87-45-176.bna.bellsouth.net [98.87.45.176])
        by mx.google.com with ESMTPS id c21sm443297ana.24.2011.05.31.20.10.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 May 2011 20:10:57 -0700 (PDT)
From:   Will Drewry <wad@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     kees.cook@canonical.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@elte.hu, rostedt@goodmis.org,
        jmorris@namei.org, Will Drewry <wad@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH v3 09/13] mips: select HAVE_SECCOMP_FILTER and provide seccomp_execve
Date:   Tue, 31 May 2011 22:10:41 -0500
Message-Id: <1306897845-9393-9-git-send-email-wad@chromium.org>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <BANLkTimNcag-ZmVTXjUoTyiuJm6jtW0DgA@mail.gmail.com>
References: <BANLkTimNcag-ZmVTXjUoTyiuJm6jtW0DgA@mail.gmail.com>
X-archive-position: 30175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wad@chromium.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 136

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
