Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 May 2010 17:38:32 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:52735 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491765Ab0EOPhv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 May 2010 17:37:51 +0200
Received: by mail-pw0-f49.google.com with SMTP id 3so708651pwi.36
        for <multiple recipients>; Sat, 15 May 2010 08:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pi1U1QTq6hnt9D33wI0SSQlMcoP28MnoOmaGQbI2MoM=;
        b=Po48KkfS4atu3riRsB08DCksmlp+JXraFfzXkVuY40mo3DvodW75HxW/XCTSXrxCHR
         k+1b2kSzQdlMtdgVhyz7xeiby7FUhP6kKoabVNUQX7Bx3mSv7Dl1hcZF3lQ3C83ki721
         n+V6MM/cVjP50B3dwq5L7S4nXoo7LIY+ibmeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Kq7C8wNm8z384av5SP+UPK8cvWJx5TtoLkAtA77WDVYFqs1d1NeN7t/D8hf8q+1fl+
         gV3nyvlMM5wWQENiGhrxAoy54b+WZuPC1/xjjUqY4n2UaDymA669KFkWBe5yH5b5iiO4
         Qghnm5wdXDotiaFUQDK7zI/2o1TeaADHbaBMw=
Received: by 10.115.64.18 with SMTP id r18mr2344505wak.182.1273937870017;
        Sat, 15 May 2010 08:37:50 -0700 (PDT)
Received: from localhost.localdomain ([114.84.90.117])
        by mx.google.com with ESMTPS id n32sm30648683wae.10.2010.05.15.08.37.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 08:37:49 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v4 2/9] MIPS: use generic atomic64 in non-64bit kernels
Date:   Sat, 15 May 2010 23:36:48 +0800
Message-Id: <1273937815-4781-3-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1273937815-4781-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1273937815-4781-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26729
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
1.6.3.3
