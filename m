Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2010 06:36:15 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:36773 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491051Ab0FIEfY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jun 2010 06:35:24 +0200
Received: by pvg11 with SMTP id 11so2082996pvg.36
        for <multiple recipients>; Tue, 08 Jun 2010 21:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=sxIMbqEbQlaXdRJJpxUN+iC0xDVmMBcbjg93wfyITx8=;
        b=P9Nj7CuoxjDezWYKweEAbsuI529ZJC9+IMW9N1ZIPvxQxv9pHFuOL9/50fmigrIsqJ
         1w9WsHyiaJH4myqyPCv5PQgkJrMqyer8aoK5MdMm1XNPpxC77n1zHNJrUu7wU+bnVoUT
         +FKnNKpyIPg2VlS8Tsnhz8w5stMs/rj/8YWqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gC3gzF3MsRK3ulo3zczQzqGya7r+FGOHBlCabYf/l4gvT/s1UIiGzcDUYjcLKzXdbq
         z+92avR0Y/mHFoeftOgZzwcqnGIQeUCpLWQ7VlxBemMPz3MPNZfomnNGjHVYbHKDQvLJ
         UHHBMyxLVLjgWhecybc/yA+SJxtiMuIgUKqk4=
Received: by 10.142.120.3 with SMTP id s3mr3823098wfc.349.1276058116811;
        Tue, 08 Jun 2010 21:35:16 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id 22sm4483464pzk.9.2010.06.08.21.35.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 21:35:16 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v6 2/7] MIPS: use generic atomic64 in non-64bit kernels
Date:   Wed,  9 Jun 2010 12:35:25 +0800
Message-Id: <1276058130-25851-3-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com>
X-archive-position: 27094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6105

64bit kernel has already had its atomic64 functions. Except for that, we
use the generic spinlocked version. The atomic64 types and related
functions are needed for the Linux performance counter subsystem.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/Kconfig              |    1 +
 arch/mips/include/asm/atomic.h |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cdaae94..564e30b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -11,6 +11,7 @@ config MIPS
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select RTC_LIB if !MACH_LOONGSON
+	select GENERIC_ATOMIC64 if !64BIT
 
 mainmenu "Linux/MIPS Kernel Configuration"
 
diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 59dc0c7..485ec36 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -782,6 +782,10 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
  */
 #define atomic64_add_negative(i, v) (atomic64_add_return(i, (v)) < 0)
 
+#else /* !CONFIG_64BIT */
+
+#include <asm-generic/atomic64.h>
+
 #endif /* CONFIG_64BIT */
 
 /*
-- 
1.6.3.3
