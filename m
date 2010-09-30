Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Sep 2010 15:38:02 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:59547 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491149Ab0I3Nh7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Sep 2010 15:37:59 +0200
Received: by pzk32 with SMTP id 32so674343pzk.36
        for <multiple recipients>; Thu, 30 Sep 2010 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=CXwo5ruG7ab8zvD3nN6Ng8W0Z/UMob2uynVADBflXjU=;
        b=No+fH2zix0fxqSr/Quc7ZeVpQE8BI4RApJ4f8WGPHXWAvoNsp/OjVin/o42fyOlA4/
         +vC17DNmzNp49b7Z2k6cHaRJaUB2ytpBVCuVLwYAwCDAK3JRzcwzqrl9/QfHDpZArYcH
         a/FC6hUZBEE851122MgccJ8IHkMdMDfSD9oss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=tKt+LISmW5tyuPGyGmjgryp1J7xqTO34uPgZndcC2Id6TKkM7Y8zmzqbzrQ46qyuAH
         gGTS9Xz0JwM6zOVzDUuS3N7aLXTJwzB1645bCf6j5gUOcjyyhhAtotN2ybYPXKNF4EHu
         Z5vuJT4ed2R8QKfOosehqC2G1wm5nbhF8xF/Y=
Received: by 10.114.102.20 with SMTP id z20mr4254229wab.133.1285853872342;
        Thu, 30 Sep 2010 06:37:52 -0700 (PDT)
Received: from [114.84.80.202] ([114.84.80.202])
        by mx.google.com with ESMTPS id s5sm16635790wak.12.2010.09.30.06.37.40
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:37:51 -0700 (PDT)
Message-ID: <4CA4920C.30401@gmail.com>
Date:   Thu, 30 Sep 2010 21:35:08 +0800
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
MIME-Version: 1.0
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        ddaney@caviumnetworks.com, a.p.zijlstra@chello.nl,
        paulus@samba.org, mingo@elte.hu, acme@redhat.com
Subject: [PATCH resend] Perf-tool/MIPS: support cross compiling of tools/perf
 for MIPS
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-archive-position: 27904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 24211



(Directing this patch to Perf-events maintainers for review.)

With the kernel facility of Linux performance counters, we want the user
level tool tools/perf to be cross compiled for MIPS platform. To do this,
we need to include unistd.h, add rmb() and cpu_relax() in perf.h.

Your review comments are especially required for the definition of rmb():
In perf.h, we need to have a proper rmb() for _all_ MIPS platforms. And
we don't have CONFIG_* things for use in here. Looking at barrier.h,
rmb() goes into barrier() and __sync() for CAVIUM OCTEON and other CPUs,
respectively. What's more, __sync() has different versions as well.
Referring to BARRIER() in dump_tlb.c, I propose the "common" definition
for perf tool rmb() in this patch. Do you have any comments?

In addition, for testing the kernel part code I sent several days
ago, I was using the "particular" rmb() version for 24K/34K/74K cores:

#define rmb()           asm volatile(                           \
                                ".set   push\n\t"               \
                                ".set   noreorder\n\t"          \
                                ".set   mips2\n\t"              \
                                "sync\n\t"                      \
                                ".set   pop"                    \
                                : /* no output */               \
                                : /* no input */                \
                                : "memory")

This is the definition of __sync() for CONFIG_CPU_HAS_SYNC.


Thanks,

Deng-Cheng

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 tools/perf/perf.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 6fb379b..cd05284 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -73,6 +73,18 @@
 #define cpu_relax()	asm volatile("":::"memory")
 #endif
 
+#ifdef __mips__
+#include "../../arch/mips/include/asm/unistd.h"
+#define rmb()		asm volatile(					\
+				".set	noreorder\n\t"			\
+				"nop;nop;nop;nop;nop;nop;nop\n\t"	\
+				".set	reorder"			\
+				: /* no output */			\
+				: /* no input */			\
+				: "memory")
+#define cpu_relax()	asm volatile("" ::: "memory")
+#endif
+
 #include <time.h>
 #include <unistd.h>
 #include <sys/types.h>
