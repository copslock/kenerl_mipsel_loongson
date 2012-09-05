Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2012 23:51:50 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:42192 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903404Ab2IEVvp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2012 23:51:45 +0200
Received: by pbbrq8 with SMTP id rq8so1627462pbb.36
        for <multiple recipients>; Wed, 05 Sep 2012 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xzFpxcv0mcXc6mAa+y/4HofLC97W9dKVxv/o2UBqnOI=;
        b=ipPpLYcWVP/23bK8P+H1Mfr40+Jyp07vQmHK5GThwWwKtKuAUJNz6JxmkFkj8WvdSo
         pvj+ABtGdvl4ZFKYBy4PLnMZcaavWCL+uERVlK12gW3B9CDSq1k5IvbbYDPLIP2UUisJ
         n95u7EBQurGF1aYy1RrA34JpNJ1gFcBWveUr7z6ghyXhNuSi8pKXP7qHO/yxStSbKNo6
         7HSlMXef89mDbdj6nwd6ruhAxzVzZ1vrM03SvokGbTTj3avL6NIwE6NjGGJ1BsJ7WNRi
         1C9rJoKx8FOGYO5d7Ec+6aIymlZXGEdRQZRVrEedRvALIa8QpmOrHPw+bfXPNRl7W5kO
         q07w==
Received: by 10.68.224.161 with SMTP id rd1mr782764pbc.133.1346881898161;
        Wed, 05 Sep 2012 14:51:38 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ou6sm222687pbc.9.2012.09.05.14.51.36
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Sep 2012 14:51:37 -0700 (PDT)
Message-ID: <5047C967.2010709@gmail.com>
Date:   Wed, 05 Sep 2012 14:51:35 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] MIPS: Add base architecture support for RI and XI.
References: <1346876878-25965-1-git-send-email-sjhill@mips.com> <1346876878-25965-2-git-send-email-sjhill@mips.com> <5047BAA0.1010602@gmail.com>
In-Reply-To: <5047BAA0.1010602@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 09/05/2012 01:48 PM, David Daney wrote:
> On 09/05/2012 01:27 PM, Steven J. Hill wrote:
>> From: "Steven J. Hill" <sjhill@mips.com>
>>
>> Originally both Read Inhibit (RI) and Execute Inhibit (XI) were
>> supported by the TLB only for a SmartMIPS core. The MIPSr3(TM)
>> Architecture now defines an optional feature to implement these
>> TLB bits separately. Support for one or both features can be
>> checked by looking at the Config3.RXI bit.
>>
>> Signed-off-by: Steven J. Hill <sjhill@mips.com>
>
> This particular patch seems fine.
>
> Acked-by: David Daney <david.daney@cavium.com>

Sorry, I changed my mind.

NAK.

>
>
> However in order not to break things there has to be a follow-on patch
> that is applied before any of the subsequent patches that sets
> cpu_has_ri and cpu_has_xi to the proper values for OCTEON.
>
> David Daney
>
>
>> ---
>>   arch/mips/include/asm/cpu-features.h |    6 ++++++
>>   arch/mips/include/asm/cpu.h          |    2 ++
>>   arch/mips/include/asm/mipsregs.h     |    1 +
>>   arch/mips/kernel/cpu-probe.c         |   12 +++++++++++-
>>   4 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/include/asm/cpu-features.h
>> b/arch/mips/include/asm/cpu-features.h
>> index 080edd8..c78a77b 100644
>> --- a/arch/mips/include/asm/cpu-features.h
>> +++ b/arch/mips/include/asm/cpu-features.h
>> @@ -98,6 +98,12 @@
>>   #ifndef kernel_uses_smartmips_rixi
>>   #define kernel_uses_smartmips_rixi 0
>>   #endif
>> +#ifndef cpu_has_ri
>> +#define cpu_has_ri        (cpu_data[0].options & MIPS_CPU_RI)
>> +#endif
>> +#ifndef cpu_has_xi
>> +#define cpu_has_xi        (cpu_data[0].options & MIPS_CPU_XI)

Nobody in their right mind would implement only one of RI or XI.  So 
splitting this feature into two parts just adds complication with no 
benefit.  Unless you have evidence that there is actual silicon that 
only implements one of the two, there is no reason to split this, and to 
way to test it.

You can just keep kernel_uses_smartmips_rixi, and the rest of the patch 
set is mostly unneeded.

>> +#endif
>>   #ifndef cpu_has_mmips
>>   #define cpu_has_mmips        (cpu_data[0].options & MIPS_CPU_MICROMIPS)
>>   #endif
>> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
>> index 4889fae..1b928ed 100644
>> --- a/arch/mips/include/asm/cpu.h
>> +++ b/arch/mips/include/asm/cpu.h
>> @@ -323,6 +323,8 @@ enum cpu_type_enum {
>>   #define MIPS_CPU_VEIC        0x00100000 /* CPU supports MIPSR2
>> external interrupt controller mode */
>>   #define MIPS_CPU_ULRI        0x00200000 /* CPU has ULRI feature */
>>   #define MIPS_CPU_MICROMIPS    0x01000000 /* CPU has microMIPS
>> capability */
>> +#define MIPS_CPU_RI        0x02000000 /* CPU has TLB Read Inhibit */
>> +#define MIPS_CPU_XI        0x04000000 /* CPU has TLB Execute Inhibit */

... and only one new bit needed here. ...

>>
>>   /*
>>    * CPU ASE encodings
>> diff --git a/arch/mips/include/asm/mipsregs.h
>> b/arch/mips/include/asm/mipsregs.h
>> index cdb9c87..19430fb 100644
>> --- a/arch/mips/include/asm/mipsregs.h
>> +++ b/arch/mips/include/asm/mipsregs.h
>> @@ -591,6 +591,7 @@
>>   #define MIPS_CONF3_LPA        (_ULCAST_(1) <<  7)
>>   #define MIPS_CONF3_DSP        (_ULCAST_(1) << 10)
>>   #define MIPS_CONF3_DSP2P    (_ULCAST_(1) << 11)
>> +#define MIPS_CONF3_RXI        (_ULCAST_(1) << 12)
>>   #define MIPS_CONF3_ULRI        (_ULCAST_(1) << 13)
>>   #define MIPS_CONF3_ISA        (_ULCAST_(3) << 14)
>>   #define MIPS_CONF3_ISA_OE    (_ULCAST_(1) << 16)
>> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
>> index 009fc13..e85d732 100644
>> --- a/arch/mips/kernel/cpu-probe.c
>> +++ b/arch/mips/kernel/cpu-probe.c
>> @@ -422,8 +422,18 @@ static inline unsigned int decode_config3(struct
>> cpuinfo_mips *c)
>>
>>       config3 = read_c0_config3();
>>
>> -    if (config3 & MIPS_CONF3_SM)
>> +    if (config3 & MIPS_CONF3_SM) {
>>           c->ases |= MIPS_ASE_SMARTMIPS;
>> +        c->options |= MIPS_CPU_RI;
>> +        c->options |= MIPS_CPU_XI;
>> +    }
>> +    if (config3 & MIPS_CONF3_RXI) {
>> +        write_c0_pagegrain(read_c0_pagegrain() | PG_RIE | PG_XIE);
>> +        if (read_c0_pagegrain() & PG_RIE)
>> +            c->options |= MIPS_CPU_RI;
>> +        if (read_c0_pagegrain() & PG_XIE)
>> +            c->options |= MIPS_CPU_XI;
>> +    }

... and this bit becomes a little simpler.


>>       if (config3 & MIPS_CONF3_DSP)
>>           c->ases |= MIPS_ASE_DSP;
>>       if (config3 & MIPS_CONF3_DSP2P)
>>
>
