Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Dec 2013 19:48:03 +0100 (CET)
Received: from mail-ie0-f178.google.com ([209.85.223.178]:48716 "EHLO
        mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827312Ab3LISsAxs6E6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Dec 2013 19:48:00 +0100
Received: by mail-ie0-f178.google.com with SMTP id lx4so6578826iec.23
        for <linux-mips@linux-mips.org>; Mon, 09 Dec 2013 10:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=//Yp3RK79DrI2IlDUQGSCWvlXYhPIuV32AMyZUOTNXQ=;
        b=iX57DUsH8uEsa8o3CUT88JCVveimfv+hSVmodCeQXPC3QV9NGuKHp5rlo1fTdU7vS9
         PzYFmaOSFyXpcrwjnwtC7x9U8nvEullJ6I49pqXDe9KKmLZDMaPh+9MWKJ7zgEgMgA/U
         PNUV56ksKdi28gaQicBS/oETRciE+7JxNUm8a2cZa47Eu/WHOBzUfg4uFXnThWWLYHn6
         4pRSqZFIrb7g34dpX0ffyxopEwDGeczm2U8jwN3r3ly6TOUdEZICfuerXhTZPd43YAvS
         FyBdqCWIOodRjqUXmtijVInXXX5jy+yfNZv0MYqfo8He9VFmB2ylkUzAfJYGDctUOPd9
         Vvlw==
X-Received: by 10.50.103.6 with SMTP id fs6mr16981127igb.16.1386614874591;
        Mon, 09 Dec 2013 10:47:54 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ft2sm15836954igb.5.2013.12.09.10.47.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Dec 2013 10:47:53 -0800 (PST)
Message-ID: <52A61057.2000804@gmail.com>
Date:   Mon, 09 Dec 2013 10:47:51 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Qais Yousef <Qais.Yousef@imgtec.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mips/include/asm/mipsregs.h: s/u16/unsigned short/
References: <1386321659-30073-1-git-send-email-qais.yousef@imgtec.com> <52A1FC07.8030902@gmail.com> <392C4BDEFF12D14FA57A3F30B283D7D13C5935@LEMAIL01.le.imgtec.org> <52A1FFA3.3000909@gmail.com> <392C4BDEFF12D14FA57A3F30B283D7D13C5FA0@LEMAIL01.le.imgtec.org>
In-Reply-To: <392C4BDEFF12D14FA57A3F30B283D7D13C5FA0@LEMAIL01.le.imgtec.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38687
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

On 12/09/2013 01:35 AM, Qais Yousef wrote:
>> -----Original Message-----
>> From: David Daney [mailto:ddaney.cavm@gmail.com]
>> Sent: 06 December 2013 16:48
>> To: Qais Yousef
>> Cc: linux-mips@linux-mips.org
>> Subject: Re: [PATCH] mips/include/asm/mipsregs.h: s/u16/unsigned short/
>>
>> On 12/06/2013 08:35 AM, Qais Yousef wrote:
>>>> -----Original Message-----
>>>> From: David Daney [mailto:ddaney.cavm@gmail.com]
>>>> Sent: 06 December 2013 16:32
>>>> To: Qais Yousef
>>>> Cc: linux-mips@linux-mips.org
>>>> Subject: Re: [PATCH] mips/include/asm/mipsregs.h: s/u16/unsigned
>>>> short/
>>>>
>>>> On 12/06/2013 01:20 AM, Qais Yousef wrote:
>>>>> I was getting this error when including this header in my driver:
>>>>>
>>>>>      arch/mips/include/asm/mipsregs.h:644:33: error: unknown type name
>> ‘u16’
>>>>>
>>>>> since the use of u16 is not really necessary, convert it to unsigned short.
>>>>>
>>>>> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
>>>>> Reviewed-by: Steven J. Hill <Steven.Hill@imgtec.com>
>>>>
>>>> NAK.
>>>>
>>>> Just #include <linux/types.h> at the top of asm/mipsregs.h instead.
>>>
>>> Funnily that was my first solution before I changed it to this :)
>>>
>>> I'll resend but can you please give some explanation why changing u16 to
>> unsigned short is bad?
>>
>> This is the linux kernel.  People expect to see fixed width integer type definitions
>> using the conventional u8, u16, u32, etc.
>>
>> If you are doing something tricky enough that you need to explicitly use a type of
>> a given width, don't hide the fact, bring it to our attention by using the kernel
>> standard type.
>>
>> If you don't need exactly a u16, just make it an unsigned int and be done with it.
>>
>> It would appear that micro-MIPS instructions are 16 bit, so use u16 everywhere
>> for them.
>
> OK thanks for the explanation. u16 is more safe and future proof for sure.
>
>>
>> Also it looks like this function really should be declared as returning type bool, not
>> int.  For the same reason:  It cannot return any integer, only truth values.  Don't
>> hide this fact.  Bring it to our attention by using the proper types.
>
> I share this view about Booleans to be honest
> http://article.gmane.org/gmane.linux.kernel/1554183/match=bool
>

If you are storing Boolean values in an array, Linus has a point.  For 
function return values, he doesn't convince me.

David Daney

> v2 is on the way.
>
> Thanks,
> Qais
>
>>
>>
>> David Daney
>>
>>
>>>
>>> Thanks,
>>> Qais
>>>
>>>>
>>>> David Daney
>>>>
>>>>
>>>>> ---
>>>>>     arch/mips/include/asm/mipsregs.h |    4 ++--
>>>>>     1 files changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/mips/include/asm/mipsregs.h
>>>> b/arch/mips/include/asm/mipsregs.h
>>>>> index e033141..0a2d6ef 100644
>>>>> --- a/arch/mips/include/asm/mipsregs.h
>>>>> +++ b/arch/mips/include/asm/mipsregs.h
>>>>> @@ -641,9 +641,9 @@
>>>>>      * microMIPS instructions can be 16-bit or 32-bit in length. This
>>>>>      * returns a 1 if the instruction is 16-bit and a 0 if 32-bit.
>>>>>      */
>>>>> -static inline int mm_insn_16bit(u16 insn)
>>>>> +static inline int mm_insn_16bit(unsigned short insn)
>>>>>     {
>>>>> -	u16 opcode = (insn >> 10) & 0x7;
>>>>> +	unsigned short opcode = (insn >> 10) & 0x7;
>>>>>
>>>>>     	return (opcode >= 1 && opcode <= 3) ? 1 : 0;
>>>>>     }
>>>>>
>>>
>
