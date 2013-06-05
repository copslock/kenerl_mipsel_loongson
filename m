Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 23:07:19 +0200 (CEST)
Received: from mail-pb0-f48.google.com ([209.85.160.48]:44996 "EHLO
        mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827506Ab3FEVHO4wP05 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jun 2013 23:07:14 +0200
Received: by mail-pb0-f48.google.com with SMTP id md4so2302728pbc.21
        for <multiple recipients>; Wed, 05 Jun 2013 14:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Zl44ksQMkrkUdaO2X07BHILvOh9vsCCi4KP5Yv8eQow=;
        b=yplT22f/SVHib1mqsF7mwaDgLxHq0YTb6RucOXgQuRTn9eiNJ4E9rHinUt1Y3Qm7Or
         R54A33cNF2YwFvaqDzwpPRXL4D60xor+ecICEJXkCRLs9U7rPzm6n1bxkrdRyMV7Xmxp
         qTKjFCxFRwHEjVhOnvaGj6jYbNI+NI4Yj3MgGI9ZlQp7g9WhZ0D+TsM2pqIVbv4DpZ7w
         MBNXdC9SHkovfmFWtzwgUCAXoSOhd+MNnwYNHUSzQY1LhrAJJLSq0c0kyFIvttd1Lupj
         a5wwHO1kA+dNcMLsI3kFSheRvMGbJAWa//FmqDRfLw6p3EyePpuxKLS+WOCpDpXYfhIW
         NfTg==
X-Received: by 10.68.11.232 with SMTP id t8mr34948299pbb.128.1370466427868;
        Wed, 05 Jun 2013 14:07:07 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id cc15sm74257809pac.1.2013.06.05.14.07.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 05 Jun 2013 14:07:06 -0700 (PDT)
Message-ID: <51AFA879.1010009@gmail.com>
Date:   Wed, 05 Jun 2013 14:07:05 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v6] MIPS: micromips: Fix improper definition of ISA exception
 bit.
References: <1370461798-20296-1-git-send-email-Steven.Hill@imgtec.com> <51AF9923.7000606@cogentembedded.com>
In-Reply-To: <51AF9923.7000606@cogentembedded.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36707
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

On 06/05/2013 01:01 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 06/05/2013 11:49 PM, Steven J. Hill wrote:
>
>> The ISA exception bit selects whether exceptions are taken in classic
>> or microMIPS mode. This bit is Config3.ISAOnExc and was improperly
>> defined as bits 16 and 17 instead of just bit 16. A new function was
>> added so that platforms could set this bit when running a kernel
>> compiled with only microMIPS instructions.
>
>      Ahem, isn't that function a material for another patch?


I think you might be going overboard.  The entire patch relates to 
exactly one bit a config register, can't you let it be a single patch?

David Daney

>
>> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
>> ---
>> Changes from v5:
>> * Make 'set_micromips_exception_mode' function to always be called.
>>
>>   arch/mips/include/asm/mipsregs.h |   18 +++++++++++++++++-
>>   arch/mips/kernel/cpu-probe.c     |    3 ---
>>   arch/mips/kernel/traps.c         |    5 +++++
>>   3 files changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/mipsregs.h
>> b/arch/mips/include/asm/mipsregs.h
>> index 87e6207..cc0f5d7 100644
>> --- a/arch/mips/include/asm/mipsregs.h
>> +++ b/arch/mips/include/asm/mipsregs.h
>> @@ -596,7 +596,7 @@
>>   #define MIPS_CONF3_RXI        (_ULCAST_(1) << 12)
>>   #define MIPS_CONF3_ULRI        (_ULCAST_(1) << 13)
>>   #define MIPS_CONF3_ISA        (_ULCAST_(3) << 14)
>> -#define MIPS_CONF3_ISA_OE    (_ULCAST_(3) << 16)
>> +#define MIPS_CONF3_ISA_OE    (_ULCAST_(1) << 16)
>>   #define MIPS_CONF3_VZ        (_ULCAST_(1) << 23)
>>   #define MIPS_CONF4_MMUSIZEEXT    (_ULCAST_(255) << 0)
>> @@ -1161,6 +1161,22 @@ do {                                    \
>>   #define write_c0_brcm_sleepcount(val)
>> __write_32bit_c0_register($22, 7, val)
>>   /*
>> + * Set exceptions to be taken in microMIPS mode only, otherwise
>> + * set for classic exceptions.
>> + */
>> +static inline void set_micromips_exception_mode(void)
>> +{
>> +    unsigned int config3 = read_c0_config3();
>> +
>> +#ifdef CONFIG_CPU_MICROMIPS
>> +    if (config3 & MIPS_CONF3_ISA)
>> +        write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
>> +    else
>> +#endif
>> +        write_c0_config3(config3 & ~MIPS_CONF3_ISA_OE);
>> +}
>> +
>> +/*
>>    * Macros to access the floating point coprocessor control registers
>>    */
>>   #define read_32bit_cp1_register(source)                    \
> [...]
>> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
>> index a75ae40..151ed59 100644
>> --- a/arch/mips/kernel/traps.c
>> +++ b/arch/mips/kernel/traps.c
>> @@ -1837,6 +1837,11 @@ void __init trap_init(void)
>>               ebase += (read_c0_ebase() & 0x3ffff000);
>>       }
>> +    /*
>> +     * Set microMIPS exceptions for platforms that support it.
>> +     */
>> +    set_micromips_exception_mode();
>
>      If we have reduced the call sites to 1, do we still need the
> function? :-)
>
> WBR, Sergei
>
>
>
>
