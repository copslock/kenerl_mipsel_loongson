Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2013 17:47:43 +0100 (CET)
Received: from mail-ie0-f178.google.com ([209.85.223.178]:45385 "EHLO
        mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827305Ab3LFQrkULLmq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Dec 2013 17:47:40 +0100
Received: by mail-ie0-f178.google.com with SMTP id lx4so1662224iec.37
        for <linux-mips@linux-mips.org>; Fri, 06 Dec 2013 08:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=w+4M4i7pM7BpqJdRmz8xDCjyexklPeZxS1nCYqhBnH8=;
        b=GaQZeuwtXWCJMzQGza+TdJzBBNhI/vPcYLWibn3eQUWWh8QIvphT/u6xljYk/TBf5M
         9XsZqRKsGo/BY/QWGq3J4UJDvpCDsvxae1dZdx9TMPc3cslSX3Py94qSWZ7DxsxkDqdy
         f0L64ydp8rQU0m5SOyYjLrGB5E++xm6PRKhyf5ExSy9haV5OQcN7v9olYEkSGaRqv2RL
         rAup0bvagzJSgbD/H6hbFDAcMsnbqbQDa0Bh6VWNrEJ5yPDWNiovefGlJKUkkxVf86s9
         MEqTXvG5Gz8sGCFNgsHwD5mgi4P8BMf/hvZJEqqufo8S9Y1xFoEjPE/w6QGLP/ZDrcTj
         Ppeg==
X-Received: by 10.42.39.142 with SMTP id h14mr3484579ice.40.1386348453999;
        Fri, 06 Dec 2013 08:47:33 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ri5sm3436011igc.1.2013.12.06.08.47.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 06 Dec 2013 08:47:33 -0800 (PST)
Message-ID: <52A1FFA3.3000909@gmail.com>
Date:   Fri, 06 Dec 2013 08:47:31 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Qais Yousef <Qais.Yousef@imgtec.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mips/include/asm/mipsregs.h: s/u16/unsigned short/
References: <1386321659-30073-1-git-send-email-qais.yousef@imgtec.com> <52A1FC07.8030902@gmail.com> <392C4BDEFF12D14FA57A3F30B283D7D13C5935@LEMAIL01.le.imgtec.org>
In-Reply-To: <392C4BDEFF12D14FA57A3F30B283D7D13C5935@LEMAIL01.le.imgtec.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38676
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

On 12/06/2013 08:35 AM, Qais Yousef wrote:
>> -----Original Message-----
>> From: David Daney [mailto:ddaney.cavm@gmail.com]
>> Sent: 06 December 2013 16:32
>> To: Qais Yousef
>> Cc: linux-mips@linux-mips.org
>> Subject: Re: [PATCH] mips/include/asm/mipsregs.h: s/u16/unsigned short/
>>
>> On 12/06/2013 01:20 AM, Qais Yousef wrote:
>>> I was getting this error when including this header in my driver:
>>>
>>>     arch/mips/include/asm/mipsregs.h:644:33: error: unknown type name ‘u16’
>>>
>>> since the use of u16 is not really necessary, convert it to unsigned short.
>>>
>>> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
>>> Reviewed-by: Steven J. Hill <Steven.Hill@imgtec.com>
>>
>> NAK.
>>
>> Just #include <linux/types.h> at the top of asm/mipsregs.h instead.
>
> Funnily that was my first solution before I changed it to this :)
>
> I'll resend but can you please give some explanation why changing u16 to unsigned short is bad?

This is the linux kernel.  People expect to see fixed width integer type 
definitions using the conventional u8, u16, u32, etc.

If you are doing something tricky enough that you need to explicitly use 
a type of a given width, don't hide the fact, bring it to our attention 
by using the kernel standard type.

If you don't need exactly a u16, just make it an unsigned int and be 
done with it.

It would appear that micro-MIPS instructions are 16 bit, so use u16 
everywhere for them.

Also it looks like this function really should be declared as returning 
type bool, not int.  For the same reason:  It cannot return any integer, 
only truth values.  Don't hide this fact.  Bring it to our attention by 
using the proper types.


David Daney


>
> Thanks,
> Qais
>
>>
>> David Daney
>>
>>
>>> ---
>>>    arch/mips/include/asm/mipsregs.h |    4 ++--
>>>    1 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/mips/include/asm/mipsregs.h
>> b/arch/mips/include/asm/mipsregs.h
>>> index e033141..0a2d6ef 100644
>>> --- a/arch/mips/include/asm/mipsregs.h
>>> +++ b/arch/mips/include/asm/mipsregs.h
>>> @@ -641,9 +641,9 @@
>>>     * microMIPS instructions can be 16-bit or 32-bit in length. This
>>>     * returns a 1 if the instruction is 16-bit and a 0 if 32-bit.
>>>     */
>>> -static inline int mm_insn_16bit(u16 insn)
>>> +static inline int mm_insn_16bit(unsigned short insn)
>>>    {
>>> -	u16 opcode = (insn >> 10) & 0x7;
>>> +	unsigned short opcode = (insn >> 10) & 0x7;
>>>
>>>    	return (opcode >= 1 && opcode <= 3) ? 1 : 0;
>>>    }
>>>
>
