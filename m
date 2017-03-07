Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2017 04:30:28 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:52411 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990552AbdCGDaP5d3Ha (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2017 04:30:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=w8HTh3pLVjUjW2KMQqMSTWEXGAQ/czajN0twvATpKbU=; b=UQFawn6FpNzbZ2YQFuZYMAYnIe
        pLoYlPJS6PAHb8g4i9kLSVqE1Y+Sk3qBSTbR3jI2QJ16mQaGFGChgwSfIho5vwRsfiJnSYfe1/RCk
        chTYaeVtYYoTr2xBKA4pgr90g6hjiqW7pifUpOfTEQgu62oUtc6DwZBwBs9ZNdH9HH9ZhK5rjEHy+
        8OptsC8QfI+8ddi4fzRCW2ICtfvtCOksizuCyU9/s1kRPMov0DWHyoNndna150ic36NRHXCSSSDlv
        4Nl0tiofb79dbeDFbh73tQscBokSziPU+G+xc24g2FG5PpcZ7kerEzjjCvgFgWh9Koo0RYk+xR1Gu
        Ebxnzv6g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:59250 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.87)
        (envelope-from <linux@roeck-us.net>)
        id 1cl5pA-003jRk-Nq; Tue, 07 Mar 2017 03:30:10 +0000
Subject: Re: [PATCH v3] MIPS: Fix build breakage caused by header file changes
To:     James Hogan <james.hogan@imgtec.com>
References: <1488827635-7708-1-git-send-email-linux@roeck-us.net>
 <20170306232019.GG2878@jhogan-linux.le.imgtec.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <146eef7a-44dd-48ff-3f09-0b342d844bd6@roeck-us.net>
Date:   Mon, 6 Mar 2017 19:30:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170306232019.GG2878@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: linux@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 03/06/2017 03:20 PM, James Hogan wrote:
> Hi Guenter,
>
> On Mon, Mar 06, 2017 at 11:13:55AM -0800, Guenter Roeck wrote:
>> Since commit f3ac60671954 ("sched/headers: Move task-stack related
>> APIs from <linux/sched.h> to <linux/sched/task_stack.h>") and commit
>> f780d89a0e82 ("sched/headers: Remove <asm/ptrace.h> from
>> <linux/sched.h>"), various mips builds fail as follows.
>>
>> arch/mips/kernel/smp-mt.c: In function ‘vsmp_boot_secondary’:
>> arch/mips/include/asm/processor.h:384:41: error:
>> 	implicit declaration of function ‘task_stack_page’
>>
>> In file included from
>> 	/opt/buildbot/slave/hwmon-testing/build/arch/mips/kernel/pm.c:
>> arch/mips/include/asm/fpu.h: In function '__own_fpu':
>> arch/mips/include/asm/processor.h:385:31: error:
>> 	invalid application of 'sizeof' to incomplete type 'struct pt_regs'
>
> This one is in an inline function, so I think it'd affect multiple
> includes of <asm/fpu.h> even if __own_fpu isn't used, so I think the
> following patch which adds the include ptrace.h in fpu.h is more robust
> than adding to the individual c files affected:
> https://patchwork.linux-mips.org/patch/15386/
>
Agreed.

> Admitedly it could probably have a more specific subject line since
> there are more similar errors.

Does that fix all compile problems ? Seems to me that we'll still need

-#include <linux/sched.h>
+#include <linux/sched/task_stack.h>

or did you prepare a patch for this as well ?

Thanks,
Guenter

>
> Cheers
> James
>
>>
>> arch/mips/netlogic/common/smp.c: In function 'nlm_boot_secondary':
>> arch/mips/netlogic/common/smp.c:157:2: error:
>> 	implicit declaration of function 'task_stack_page'
>>
>> and more similar errors.
>>
>> Fixes: f3ac60671954 ("sched/headers: Move task-stack related APIs ...")
>> Fixes: f780d89a0e82 ("sched/headers: Remove <asm/ptrace.h> from ...")
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v3: Catch more build errors
>>
>>  arch/mips/cavium-octeon/cpu.c                  | 3 ++-
>>  arch/mips/cavium-octeon/crypto/octeon-crypto.c | 1 +
>>  arch/mips/cavium-octeon/smp.c                  | 2 +-
>>  arch/mips/kernel/pm.c                          | 1 +
>>  arch/mips/kernel/smp-mt.c                      | 2 +-
>>  arch/mips/netlogic/common/smp.c                | 1 +
>>  arch/mips/netlogic/xlp/cop2-ex.c               | 3 ++-
>>  arch/mips/power/cpu.c                          | 1 +
>>  8 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/mips/cavium-octeon/cpu.c b/arch/mips/cavium-octeon/cpu.c
>> index a5b427909b5c..b826b7a87c57 100644
>> --- a/arch/mips/cavium-octeon/cpu.c
>> +++ b/arch/mips/cavium-octeon/cpu.c
>> @@ -10,7 +10,8 @@
>>  #include <linux/irqflags.h>
>>  #include <linux/notifier.h>
>>  #include <linux/prefetch.h>
>> -#include <linux/sched.h>
>> +#include <linux/ptrace.h>
>> +#include <linux/sched/task_stack.h>
>>
>>  #include <asm/cop2.h>
>>  #include <asm/current.h>
>> diff --git a/arch/mips/cavium-octeon/crypto/octeon-crypto.c b/arch/mips/cavium-octeon/crypto/octeon-crypto.c
>> index 4d22365844af..cfb4a146cf17 100644
>> --- a/arch/mips/cavium-octeon/crypto/octeon-crypto.c
>> +++ b/arch/mips/cavium-octeon/crypto/octeon-crypto.c
>> @@ -9,6 +9,7 @@
>>  #include <asm/cop2.h>
>>  #include <linux/export.h>
>>  #include <linux/interrupt.h>
>> +#include <linux/sched/task_stack.h>
>>
>>  #include "octeon-crypto.h"
>>
>> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
>> index 4b94b7fbafa3..d475c0146347 100644
>> --- a/arch/mips/cavium-octeon/smp.c
>> +++ b/arch/mips/cavium-octeon/smp.c
>> @@ -10,8 +10,8 @@
>>  #include <linux/smp.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/kernel_stat.h>
>> -#include <linux/sched.h>
>>  #include <linux/sched/hotplug.h>
>> +#include <linux/sched/task_stack.h>
>>  #include <linux/init.h>
>>  #include <linux/export.h>
>>
>> diff --git a/arch/mips/kernel/pm.c b/arch/mips/kernel/pm.c
>> index dc814892133c..fab05022ab39 100644
>> --- a/arch/mips/kernel/pm.c
>> +++ b/arch/mips/kernel/pm.c
>> @@ -11,6 +11,7 @@
>>
>>  #include <linux/cpu_pm.h>
>>  #include <linux/init.h>
>> +#include <linux/ptrace.h>
>>
>>  #include <asm/dsp.h>
>>  #include <asm/fpu.h>
>> diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
>> index e077ea3e11fb..effc1ed18954 100644
>> --- a/arch/mips/kernel/smp-mt.c
>> +++ b/arch/mips/kernel/smp-mt.c
>> @@ -18,7 +18,7 @@
>>   * Copyright (C) 2006 Ralf Baechle (ralf@linux-mips.org)
>>   */
>>  #include <linux/kernel.h>
>> -#include <linux/sched.h>
>> +#include <linux/sched/task_stack.h>
>>  #include <linux/cpumask.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/irqchip/mips-gic.h>
>> diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
>> index 10d86d54880a..9035558920c1 100644
>> --- a/arch/mips/netlogic/common/smp.c
>> +++ b/arch/mips/netlogic/common/smp.c
>> @@ -37,6 +37,7 @@
>>  #include <linux/init.h>
>>  #include <linux/smp.h>
>>  #include <linux/irq.h>
>> +#include <linux/sched/task_stack.h>
>>
>>  #include <asm/mmu_context.h>
>>
>> diff --git a/arch/mips/netlogic/xlp/cop2-ex.c b/arch/mips/netlogic/xlp/cop2-ex.c
>> index 52bc5de42005..d990b7fc84aa 100644
>> --- a/arch/mips/netlogic/xlp/cop2-ex.c
>> +++ b/arch/mips/netlogic/xlp/cop2-ex.c
>> @@ -13,7 +13,8 @@
>>  #include <linux/irqflags.h>
>>  #include <linux/notifier.h>
>>  #include <linux/prefetch.h>
>> -#include <linux/sched.h>
>> +#include <linux/ptrace.h>
>> +#include <linux/sched/task_stack.h>
>>
>>  #include <asm/cop2.h>
>>  #include <asm/current.h>
>> diff --git a/arch/mips/power/cpu.c b/arch/mips/power/cpu.c
>> index 2129e67723ff..6ecccc26bf7f 100644
>> --- a/arch/mips/power/cpu.c
>> +++ b/arch/mips/power/cpu.c
>> @@ -7,6 +7,7 @@
>>   * Author: Hu Hongbing <huhb@lemote.com>
>>   *	   Wu Zhangjin <wuzhangjin@gmail.com>
>>   */
>> +#include <linux/ptrace.h>
>>  #include <asm/sections.h>
>>  #include <asm/fpu.h>
>>  #include <asm/dsp.h>
>> --
>> 2.7.4
>>
>>
