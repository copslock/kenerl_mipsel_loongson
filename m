Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Apr 2010 18:39:34 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:41780 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492434Ab0DOQjC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Apr 2010 18:39:02 +0200
Received: by pvc30 with SMTP id 30so1011890pvc.36
        for <multiple recipients>; Thu, 15 Apr 2010 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=+6pjBhVj0k+jbHNxNp8wm1b8CJ+sAE16vGcSvqQkzoU=;
        b=YUnsuk3Lx44aSF0MzwSIV5uuwENjhRVBcWGFyw2RT6rYFr8+iBRB9oZSR/Dy7Q5TqE
         9lBKqTbmqxOP9JVCjcLh4UEXYU004Qu15cXTZjIVWExudlfhBAdblTamPC73Yu/BN16G
         pTAIrXzxuBaXMhmek15lC8tT+2AwF2Jg/loFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        b=JqKQyTwyXV/zF2t5EmkRMYtfNWGvixyJGcAv7vc8yGR1YISNiG2TE6PytpBiDj5KOt
         /BkNrrQ7v1JwQte9zhHuILbOlVfWIXQE1UgPdknZR5eZfCdH9TnZZI2jx/2DcsVRkMWy
         v+02Ua78H02Cw4YPHFeUPyWQAr/VgizQS6RaA=
Received: by 10.143.21.32 with SMTP id y32mr289921wfi.60.1271349534123;
        Thu, 15 Apr 2010 09:38:54 -0700 (PDT)
Received: from [192.168.1.101] ([114.84.94.52])
        by mx.google.com with ESMTPS id 20sm491399ywh.48.2010.04.15.09.38.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 09:38:53 -0700 (PDT)
Subject: [PATCH 1/3] MIPS: use the generic atomic64 operations for perf
 counter support
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 16 Apr 2010 00:38:45 +0800
Message-ID: <1271349525.7467.420.camel@fun-lab>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Currently we take the generic spinlock'ed atomic64 implementation from the
lib. The atomic64 types and related functions are needed for the Linux
performance counter subsystem.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/Kconfig              |    1 +
 arch/mips/include/asm/atomic.h |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 29e8692..7161751 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,6 +4,7 @@ config MIPS
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_IDE
 	select HAVE_OPROFILE
+	select GENERIC_ATOMIC64
 	select HAVE_ARCH_KGDB
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 519197e..b0a932e 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -21,6 +21,10 @@
 #include <asm/war.h>
 #include <asm/system.h>
 
+#ifdef CONFIG_GENERIC_ATOMIC64
+#include <asm-generic/atomic64.h>
+#endif
+
 #define ATOMIC_INIT(i)    { (i) }
 
 /*
-- 
1.7.0.4
