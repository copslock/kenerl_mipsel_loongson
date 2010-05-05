Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 May 2010 15:56:53 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:60246 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492165Ab0EEN4g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 May 2010 15:56:36 +0200
Received: by pvg7 with SMTP id 7so311016pvg.36
        for <multiple recipients>; Wed, 05 May 2010 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1pC2DJcFV+wyveRrqy8A19S/wuSd+/p442trJrgrulE=;
        b=Bxn7xaNAPClF+Kpe34/nrhTem/O5jSl73i9uolZGRG5EGtfJkG3xX/hV8Ckk1UwENH
         ILfvy0LiF4j05p2kbqt4j0QinNORO+n5UlKi+9CsNQyBgzvx8WKAaQnEJD8MWAD1ElwJ
         ycP6jqPW3Lz4k+zvXvc0v5VLZj5L05XioHKng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CnJJXLnClooOTZGWcBzPsCNuv/09fLk7w58z8QOTW9OP7fxkCkc22co9txhO4Lkgez
         79RzAqEWWLy5KRnfhDCnOyBbqPb9yzoWIK8nBsJAe6HufSfdiIkf7Tyb/NjTOqB4wp8i
         XkPkmEcrhKM+KLYOrqNolF1mf4GV/T0uENAmI=
Received: by 10.143.20.30 with SMTP id x30mr1048574wfi.57.1273067788556;
        Wed, 05 May 2010 06:56:28 -0700 (PDT)
Received: from localhost.localdomain ([114.84.73.209])
        by mx.google.com with ESMTPS id 23sm6598217pzk.2.2010.05.05.06.56.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 May 2010 06:56:27 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v3 2/4] MIPS: use generic atomic64 in non-64bit kernels
Date:   Wed,  5 May 2010 21:55:32 +0800
Message-Id: <1273067734-4758-3-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1273067734-4758-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1273067734-4758-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26599
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
index 7e6fd1c..7d19c62 100644
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
index 519197e..afe6e79 100644
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
1.7.0.4
