Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2010 13:54:59 +0200 (CEST)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:37436 "EHLO
        mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492032Ab0D1Lyy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Apr 2010 13:54:54 +0200
Received: by pzk32 with SMTP id 32so9736328pzk.21
        for <multiple recipients>; Wed, 28 Apr 2010 04:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Urea0C5OwSG0P5XgXUturR/rpPSN7yPgqkcsQnmH6+c=;
        b=YNTa7UhHuR+ey+My0bXGHllb8FsdzeY487Zl/HTyTjj6Xd3IgGDqm/7vbohLiXVmDe
         R6ythEXItxsZFRHAEBaRz2KhyjNED76mRpjpDLTSCEG8q/XV4pIoY8sVSamaCk8LJ+EB
         lQpYEUtGEtwTjaaluB6RBY4yNOwJnXxNVfRNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xjL9guklraw6kTxfciqA3HLWe1EiN541IAMRnWoACHrCJCN69dkum3DmURUadhzDmr
         Y96kVVDNN+J3SFAQ6lNnwoDfwrGN/xZUcMR8fEtf6izuLjeGR641SgME7Ip5t9WU443M
         tlGSpDZ5LPdOvARHWvJKL9D87o3JWigGlvOZ8=
Received: by 10.140.57.16 with SMTP id f16mr1221532rva.15.1272455685694;
        Wed, 28 Apr 2010 04:54:45 -0700 (PDT)
Received: from localhost.localdomain ([114.84.90.248])
        by mx.google.com with ESMTPS id 23sm1923736ywh.12.2010.04.28.04.54.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Apr 2010 04:54:45 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     ralf@linux-mips.org, ddaney@caviumnetworks.com,
        linux-mips@linux-mips.org
Cc:     dengcheng.zhu@gmail.com
Subject: [PATCH] Perf-tool/MIPS: support cross compiling of tools/perf for MIPS
Date:   Wed, 28 Apr 2010 19:54:34 +0800
Message-Id: <1272455674-4725-1-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.6.3.3
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

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
@@ -69,6 +69,18 @@
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
-- 
1.7.0.4
