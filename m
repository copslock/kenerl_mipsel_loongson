Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2010 06:38:31 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:35527 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491127Ab0FIEfe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jun 2010 06:35:34 +0200
Received: by mail-pw0-f49.google.com with SMTP id 6so519757pwj.36
        for <multiple recipients>; Tue, 08 Jun 2010 21:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=C18kGU4fpwswHG4cikkH4EgR8m2Rntcq2Fr2mN/gFfY=;
        b=MoDsrj5vCuKIDjIbSQNIGCg7q+F8bSWR4xwOBwF9FqrrtZR1bsK6cOpTrTV8w5oBQu
         stGm5P+6KDLDlH8h2GKPwZFOaWlXgBoBxK33Oc66SatfuNE46WA4/YPk+8nvOpitHjyU
         VSku2kBu2guPRa74BuIEhb2jhoWragb/cLg3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SWQAsxJAmkgfBssBQy2wc6XfpV1+/drs2+PzhNyAENQIn7jCUXcbs/HxJfJperQLCO
         fqt1XnCZhvxhfm2Z3bR0USVvUb1W+6OJnUrFRET3YrjwIQopn8/Rb5ppOfR72ubx7b1d
         sM28B5fm5M3w4P2b7O/voyGjr+trWqPGthqho=
Received: by 10.143.27.37 with SMTP id e37mr556754wfj.250.1276058133559;
        Tue, 08 Jun 2010 21:35:33 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id 22sm4483464pzk.9.2010.06.08.21.35.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 21:35:33 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v6 7/7] MIPS: define local_xchg from xchg_local to atomic_long_xchg
Date:   Wed,  9 Jun 2010 12:35:30 +0800
Message-Id: <1276058130-25851-8-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com>
X-archive-position: 27099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6112

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
1.6.3.3
