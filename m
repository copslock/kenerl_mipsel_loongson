Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 15:05:18 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:48941 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492356Ab0E0NEf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 May 2010 15:04:35 +0200
Received: by pwi2 with SMTP id 2so248113pwi.36
        for <multiple recipients>; Thu, 27 May 2010 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zapDPxM9McxfOF7aholpRH6i3pQJCDExJOHdwAFjaXA=;
        b=T0gksSD3l9yHF3H7JOM0e9xuwY/VeRL7JpWEimF+7ApNz6arGGzUEdLpSTPQUjQ750
         V+e5jGLbJQw0/uB4zHQbU7MZDI6AFqx0xtqCQSKVPFOkww3gkwrGpemfIfJFtJ5ZNl5A
         v/u6n3vczeFs8CoInUGmL1oPTC3k4JKCamQwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cLTvBWsahgmWam3aRjmz6lLFh2saZpek/de3EZ7dsE9vqomdyckVnSLGhc9/jRVxkS
         37uspLVRqkGFYrluGck9fgwGaa3QvyHewRHW6FPl2DPZIS3Cwd0KDCY/h7+n32ZYhvz6
         7g0IK9HWq72y+9HlXnQ+JxHGHHF0y9C4+Pno0=
Received: by 10.142.248.7 with SMTP id v7mr7188657wfh.234.1274965465784;
        Thu, 27 May 2010 06:04:25 -0700 (PDT)
Received: from localhost.localdomain ([114.84.70.124])
        by mx.google.com with ESMTPS id 21sm972927pzk.8.2010.05.27.06.04.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 06:04:25 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v5 02/12] MIPS: use generic atomic64 in non-64bit kernels
Date:   Thu, 27 May 2010 21:03:30 +0800
Message-Id: <1274965420-5091-3-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

64bit kernel has already had its atomic64 functions. Except for that, we
use the generic spinlocked version. The atomic64 types and related
functions are needed for the Linux performance counter subsystem.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/Kconfig              |    1 +
 arch/mips/include/asm/atomic.h |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cdaae94..ef3d8ca 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,6 +4,7 @@ config MIPS
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_IDE
 	select HAVE_OPROFILE
+	select GENERIC_ATOMIC64 if !64BIT
 	select HAVE_ARCH_KGDB
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 59dc0c7..23990cb 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -782,6 +782,10 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
  */
 #define atomic64_add_negative(i, v) (atomic64_add_return(i, (v)) < 0)
 
+#else /* ! CONFIG_64BIT */
+
+#include <asm-generic/atomic64.h>
+
 #endif /* CONFIG_64BIT */
 
 /*
-- 
1.6.3.3
