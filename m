Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 09:54:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64763 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859954AbaGRHya7PWOt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 09:54:30 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EFFF77DC79009;
        Fri, 18 Jul 2014 08:54:21 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 18 Jul
 2014 08:54:23 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 18 Jul 2014 08:54:23 +0100
Received: from [192.168.154.103] (192.168.154.103) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 18 Jul
 2014 08:54:22 +0100
Message-ID: <53C8D2AE.3020300@imgtec.com>
Date:   Fri, 18 Jul 2014 08:54:22 +0100
From:   Jeffrey Deans <jeffrey.deans@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 7/7] MIPS: GIC: Fix GICBIS macro
References: <1405585259-24941-1-git-send-email-markos.chandras@imgtec.com> <1405585259-24941-8-git-send-email-markos.chandras@imgtec.com> <53C7C5E2.1020307@cogentembedded.com>
In-Reply-To: <53C7C5E2.1020307@cogentembedded.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.103]
Return-Path: <Jeffrey.Deans@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeffrey.deans@imgtec.com
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

Hi Sergei,

On 17/07/14 13:47, Sergei Shtylyov wrote:
> Hello.
>
> On 07/17/2014 12:20 PM, Markos Chandras wrote:
>
>> From: Jeffrey Deans <jeffrey.deans@imgtec.com>
>
>> The GICBIS macro could update the GIC registers incorrectly, depending
>> on the data value passed in:
>
>> * Bits were only OR'd into the register data, so register fields could
>>    not be cleared.
>
>> * Bits were OR'd into the register data without masking the data to the
>>    correct field width, corrupting adjacent bits.
>
>> Signed-off-by: Jeffrey Deans <jeffrey.deans@imgtec.com>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> ---
>>   arch/mips/include/asm/gic.h | 21 +++++++++++----------
>>   1 file changed, 11 insertions(+), 10 deletions(-)
>
>> diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
>> index 8b30befd99d6..3f20b2111d56 100644
>> --- a/arch/mips/include/asm/gic.h
>> +++ b/arch/mips/include/asm/gic.h
>> @@ -43,18 +43,17 @@
>>   #ifdef GICISBYTELITTLEENDIAN
>>   #define GICREAD(reg, data)    ((data) = (reg), (data) =
>> le32_to_cpu(data))
>>   #define GICWRITE(reg, data)    ((reg) = cpu_to_le32(data))
>> -#define GICBIS(reg, bits)            \
>> -    ({unsigned int data;            \
>> -        GICREAD(reg, data);        \
>> -        data |= bits;            \
>> -        GICWRITE(reg, data);        \
>> -    })
>> -
>>   #else
>>   #define GICREAD(reg, data)    ((data) = (reg))
>>   #define GICWRITE(reg, data)    ((reg) = (data))
>> -#define GICBIS(reg, bits)    ((reg) |= (bits))
>>   #endif
>> +#define GICBIS(reg, mask, bits)            \
>> +    do { u32 data;                \
>> +        GICREAD((reg), data);        \
>
>     Why () only around 'reg', not around 'data'?

Brackets aren't necessary around "data" because it is declared at the 
start of the "do" code block, so it can't expand to anything else within 
that scope.

>
>> +        data &= ~(mask);        \
>> +        data |= ((bits) & (mask));    \
>
>     Outer () not needed.

Agreed.

>
>> +        GICWRITE((reg), data);        \
>
>     Again, why no () around 'data'?
>
>> +    } while (0)

As above.

>
> WBR, Sergei
>

Thanks for reviewing!

Jeffrey
