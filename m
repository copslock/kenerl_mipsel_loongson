Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Oct 2010 13:35:53 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:42299 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491071Ab0JLLfE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Oct 2010 13:35:04 +0200
Received: by pwi2 with SMTP id 2so914596pwi.36
        for <multiple recipients>; Tue, 12 Oct 2010 04:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cVLF7uUpDopjxUa7IbpL60GtRhEtXm7w1g9LhAy4ca0=;
        b=Tht1KDQoEUhoLUWYVUk7dfGUcPFbuAGNB4c7dH7IipZv8QJo1JuNXoZZRWOx58+92P
         AxUuaBESQQ62M3SB9csoT5yhGGYVOiWAcKseXCWBfEFEs3CfwyHUnMOOmXQO/j5OviFF
         kEtmvwVSCOFfybi1vYWAwvoZbsiiS//Oi0kj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WbIDkPBvwgIia5pZ7078S7mw6SFJFSbt06kIXnppu8hCm5S7VhSGAyy3WSAGqQPx9e
         +X8DmqtDSV1hF4U0lJLo7ESUkmsrTfV5fhB2606j3EWhPE7UyFlMmMZO6rkOE5VNTJZe
         2BNUVEMcrP0UtJrM0NNuXTImYoFLMoSYT9uNw=
Received: by 10.114.131.19 with SMTP id e19mr8396673wad.147.1286883298190;
        Tue, 12 Oct 2010 04:34:58 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id p6sm10434885wal.19.2010.10.12.04.34.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 04:34:56 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com,
        ddaney@caviumnetworks.com, matt@console-pimps.org,
        dengcheng.zhu@gmail.com
Subject: [PATCH v8 1/5] MIPS: define local_xchg from xchg_local to atomic_long_xchg
Date:   Tue, 12 Oct 2010 19:37:20 +0800
Message-Id: <1286883444-31913-2-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1286883444-31913-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1286883444-31913-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Perf-events is now using local_t helper functions internally. There is a
use of local_xchg(). On MIPS, this is defined to xchg_local() which is
missing in asm/system.h. This patch re-defines local_xchg() in asm/local.h
to atomic_long_xchg(). Then Perf-events can pass the build.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/include/asm/local.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index bdcdef0..fffc830 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -117,7 +117,7 @@ static __inline__ long local_sub_return(long i, local_t * l)
 
 #define local_cmpxchg(l, o, n) \
 	((long)cmpxchg_local(&((l)->a.counter), (o), (n)))
-#define local_xchg(l, n) (xchg_local(&((l)->a.counter), (n)))
+#define local_xchg(l, n) (atomic_long_xchg((&(l)->a), (n)))
 
 /**
  * local_add_unless - add unless the number is a given value
-- 
1.7.0.4
