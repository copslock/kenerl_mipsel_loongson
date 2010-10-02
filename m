Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Oct 2010 04:56:57 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:53798 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490949Ab0JBC4y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Oct 2010 04:56:54 +0200
Received: by pzk32 with SMTP id 32so1238806pzk.36
        for <multiple recipients>; Fri, 01 Oct 2010 19:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=j05byqydO1PeiOXcsm/CIWibQdeKQwWX1wlJnl428oY=;
        b=r5HhGkmzthJHbGu32ggA55GBUgEpoUWfQDSpUvoueo2+I+mDGe/GzRu2Elvyt7baQh
         IMT5egmWeHGM7hmraHONY0VFG8dH0fjwH920tE0t2UohArxi6G7hI8jHwnK9RRDKxb+C
         gSV0YC/bVK2+rib169H2zP76Uv7QgI9j3k0l0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Xy0kcMTjjwGMNwtXuPWdUIe7Sn/t6PcOSIHUGCw4K+W2yMl38w8pTowj8tCyZcm3jY
         SVu+i0XlQ8x7Z8BtZVzGjj1dvpgk6WpzSDWeqqypyqytv1yE4S72oaTFQtrm+nhls15W
         +0ZCaK2QdxLgdLptaAF4jkSuC4pVSIkLHcnaI=
Received: by 10.114.46.4 with SMTP id t4mr7511217wat.40.1285988204938;
        Fri, 01 Oct 2010 19:56:44 -0700 (PDT)
Received: from [114.84.73.115] ([114.84.73.115])
        by mx.google.com with ESMTPS id c24sm3068242wam.19.2010.10.01.19.56.38
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 19:56:43 -0700 (PDT)
Message-ID: <4CA69ECC.1070409@gmail.com>
Date:   Sat, 02 Oct 2010 10:54:04 +0800
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com
Subject: Re: [PATCH resend] Perf-tool/MIPS: support cross compiling of tools/perf
 for MIPS
References: <4CA4920C.30401@gmail.com> <4CA6566D.2050003@caviumnetworks.com> <20101002015947.GB9360@linux-mips.org>
In-Reply-To: <20101002015947.GB9360@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips



Thanks guys. So let's turn the patch into the following?

Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>
---
  tools/perf/perf.h |   14 ++++++++++++++
  1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 6fb379b..cd05284 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -73,6 +73,20 @@
  #define cpu_relax()	asm volatile("":::"memory")
  #endif

+#ifdef __mips__
+#include "../../arch/mips/include/asm/unistd.h"
+#define rmb()		asm volatile(					\
+				".set	push\n\t"			\
+				".set	noreorder\n\t"			\
+				".set	mips2\n\t"			\
+				"sync\n\t"				\
+				".set	pop"				\
+				: /* no output */			\
+				: /* no input */			\
+				: "memory")
+#define cpu_relax()	asm volatile("" ::: "memory")
+#endif
+
  #include<time.h>
  #include<unistd.h>
  #include<sys/types.h>


On 2010-10-2 9:59, Ralf Baechle wrote:
> On Fri, Oct 01, 2010 at 02:45:17PM -0700, David Daney wrote:
>
>> In user space the rmb() must expand to a SYNC instruction.  I am not
>> sure what your version in the patch is doing with all those NOPs.  That
>> is not guaranteed to do anything.
> That's a rather old version of the kernel rmb macro I think.  The NOPs
> where there to enforce ordering of a mix of cached and uncached accesses
> on the R4400 (not R4000) where according to my reading the manual leaves
> it a bit unclear if a SYNC is sufficient or if the pipeline needs to be
> drained in addition.  See version 2 of the R4000/R4400 User's Manual.
>
>> The instruction set specifications say that SYNC orders all loads and
>> stores.  This is a heaver operation than rmb() demands, but is the only
>> universally available instruction that imposes ordering.
>>
>> For processors that do not support SYNC, the kernel will emulate it, so
>> it is safe to use in userspace.  I wouldn't worry about emulation
>> overhead though, because processors that lack SYNC probably also lack
>> performance counters, so are not as interesting from a perf-tool point
>> of view.
> Yes, just use SYNC.  SYNC-less processors would only be R2000/R3000
> processors and a few other oddball processors which for performance
> optimization are totally uninteresting since years.
>
>    Ralf
