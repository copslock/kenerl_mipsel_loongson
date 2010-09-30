Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Sep 2010 11:09:24 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:49126 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491149Ab0I3JJE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Sep 2010 11:09:04 +0200
Received: by pwi5 with SMTP id 5so597054pwi.36
        for <multiple recipients>; Thu, 30 Sep 2010 02:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Hlmo6tHRLGi4xA2uWS/f1QhakrNdKKMetLduL6GZm7k=;
        b=Kc2sF9xdSLLZFI3xNecKptp44eUg6704+HtFyTMtZ5rqcr11VqqWFX66g6yIph74XV
         fc0X5WViK7aNh9PGshJAvhwKtspsMflgbp4MqhbCbxbMXB1/Kw2tpDfIDtJvBN+yIYfg
         7hA7VrmhPGSYyQKqQzlFYrEHzp4Y+fAWMfOeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GLi9u4w4+nq1iJw7hzsyizw5gDFJ4bEm94CddF8hPwtCpyIN46yoD2oX/13CSxM32o
         m2nQdS0uhcr89rdmq5yFRx/+IYPriUu1CKVRgEEomMy9UQerGnejNO1HLDsDJHOpGiYl
         4j6TcvVZb8uP/KdNEIjQg7G01VEGWNdci5TIU=
Received: by 10.114.111.12 with SMTP id j12mr3759487wac.95.1285837736970;
        Thu, 30 Sep 2010 02:08:56 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id c10sm16210348wam.1.2010.09.30.02.08.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 02:08:53 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, dengcheng.zhu@gmail.com
Subject: [PATCH v7 1/6] MIPS: define local_xchg from xchg_local to atomic_long_xchg
Date:   Thu, 30 Sep 2010 17:09:15 +0800
Message-Id: <1285837760-10362-2-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1285837760-10362-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1285837760-10362-1-git-send-email-dengcheng.zhu@gmail.com>
X-archive-position: 27896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 24018

Perf-events is now using local_t helper functions internally. There is a
use of local_xchg(). On MIPS, this is defined to xchg_local() which is
missing in asm/system.h. This patch re-defines local_xchg() in asm/local.h
to atomic_long_xchg(). Then Perf-events can pass the build.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/include/asm/local.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index bdcdef0..4d090a0 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -117,7 +117,7 @@ static __inline__ long local_sub_return(long i, local_t * l)
 
 #define local_cmpxchg(l, o, n) \
 	((long)cmpxchg_local(&((l)->a.counter), (o), (n)))
-#define local_xchg(l, n) (xchg_local(&((l)->a.counter), (n)))
+#define local_xchg(l, n) atomic_long_xchg((&(l)->a), (n))
 
 /**
  * local_add_unless - add unless the number is a given value
-- 
1.7.0.4
