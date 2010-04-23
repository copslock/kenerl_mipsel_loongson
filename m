Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2010 12:37:07 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:39598 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492343Ab0DWKgs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Apr 2010 12:36:48 +0200
Received: by pwj3 with SMTP id 3so1853372pwj.36
        for <multiple recipients>; Fri, 23 Apr 2010 03:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=wBhOSAG2XhK5HzeZdDGBf0rIJkrZZB3WL35wC8EjAlM=;
        b=FnZJXl/fQPOVuxUuZEP4DsG8PS22X2xH83kZqqnMX/3F/kk5P7SfKTT+VoSObP6/Xh
         5tWJJKbYgCzeQeUnUe/tTooGQQIi2LVwW73BUenjagRmZo893JJRSZo7urdelBPBwudB
         WvVRCOpiBkxCg9WkcdIf/nRX0BT7xXrdVSn7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        b=dvW5cW6V6G8SJMLAF0Adt1RFfk6Dk2pICGRV5Yy5bPHLtOpVPI7d8qgCtRdAxS3D1t
         IAgR00N4I55oY6spwqV4gg/HTMgYjSj+aXikB+TH1tyztWFgQBIk4QjKtDDESuYMOXVv
         nuqh6LEm707hAgD9IdiXimkQ/TogvKwWTtpg0=
Received: by 10.115.38.23 with SMTP id q23mr1498207waj.212.1272019000492;
        Fri, 23 Apr 2010 03:36:40 -0700 (PDT)
Received: from [192.168.1.100] ([114.84.71.49])
        by mx.google.com with ESMTPS id 33sm4122680wad.17.2010.04.23.03.36.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Apr 2010 03:36:40 -0700 (PDT)
Subject: [PATCH v2 2/4] MIPS: in non-64bit kernel, using the generic
 atomic64 operations for perf counter support
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 23 Apr 2010 18:36:28 +0800
Message-ID: <1272018988.4662.94.camel@fun-lab>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26465
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
index 29e8692..469176c 100644
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
index 519197e..887a881 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -782,6 +782,10 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
  */
 #define atomic64_add_negative(i, v) (atomic64_add_return(i, (v)) < 0)
 
+#else /* CONFIG_64BIT */
+
+#include <asm-generic/atomic64.h>
+
 #endif /* CONFIG_64BIT */
 
 /*
-- 
1.7.0.4
