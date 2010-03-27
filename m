Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Mar 2010 00:18:16 +0100 (CET)
Received: from mail.lemote.com ([222.92.8.141]:57163 "EHLO lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492208Ab0C0XSM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Mar 2010 00:18:12 +0100
Received: from localhost (localhost [127.0.0.1])
        by lemote.com (Postfix) with ESMTP id B92AE31C96F;
        Sun, 28 Mar 2010 07:15:12 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
        by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AyF34IhnFHE1; Sun, 28 Mar 2010 07:14:58 +0800 (CST)
Received: from [172.16.1.86] (unknown [222.92.8.142])
        by lemote.com (Postfix) with ESMTP id 0AA2931C968;
        Sun, 28 Mar 2010 07:14:56 +0800 (CST)
Message-ID: <4BAE920A.90404@lemote.com>
Date:   Sun, 28 Mar 2010 07:17:30 +0800
From:   zhangfx <zhangfx@lemote.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20091120)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Shinya Kuribayashi <shinya.kuribayashi@necel.com>,
        zhangfx@lemote.com
Subject: Re: [PATCH v3 2/3] Loongson-2F: Enable fixups of binutils 2.20.1
References: <cover.1268453720.git.wuzhangjin@gmail.com> <ecc51ee134ab84c95b6b02534544df3731bb9562.1268453720.git.wuzhangjin@gmail.com> <20100317135223.GA4554@linux-mips.org> <20100327162900.GA19154@woodpecker.gentoo.org> <20100327172059.GC19154@woodpecker.gentoo.org>
In-Reply-To: <20100327172059.GC19154@woodpecker.gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-Path: <zhangfx@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangfx@lemote.com
Precedence: bulk
X-list: linux-mips

The revision with these bugs fixed is 2F03. Up to now all processors 
used in current products are 2F01/02.
2F03 is in production and expected in this summer.

Zhang Le wrote:
> On 16:29 Sat 27 Mar     , Zhang Le wrote:
>   
>> On 14:52 Wed 17 Mar     , Ralf Baechle wrote:
>>     
>>> On Sat, Mar 13, 2010 at 12:34:16PM +0800, Wu Zhangjin wrote:
>>>
>>>       
>>>> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
>>>> index 2f2eac2..5ae342e 100644
>>>> --- a/arch/mips/Makefile
>>>> +++ b/arch/mips/Makefile
>>>> @@ -135,7 +135,9 @@ cflags-$(CONFIG_CPU_LOONGSON2)	+= -Wa,--trap
>>>>  cflags-$(CONFIG_CPU_LOONGSON2E) += \
>>>>  	$(call cc-option,-march=loongson2e,-march=r4600)
>>>>  cflags-$(CONFIG_CPU_LOONGSON2F) += \
>>>> -	$(call cc-option,-march=loongson2f,-march=r4600)
>>>> +	$(call cc-option,-march=loongson2f,-march=r4600) \
>>>> +	$(call as-option,-Wa$(comma)-mfix-loongson2f-nop,) \
>>>> +	$(call as-option,-Wa$(comma)-mfix-loongson2f-jump,)
>>>>         
>>> Shouldn't these options be used unconditionally?  It seems a kernel build
>>> should rather fail than a possibly unreliable kernel be built - possibly
>>> even without the user noticing the problem.
>>>       
>> Zhangjin has been busy preparing for his graduation paper.
>> I just talked to him. He said later batches of 2F processor is not affected by
>> these two problems, according to Zhang Fuxin, manager of Lemote.
>>
>> I am not sure on which model of Fuloong and Yeeloong these "good" 2F processors
>> have been used. I think Fuxin should know this.
>>
>> If Fuxin could told us now, we can make a new patch. In this patch, we decide
>> whether to add these options or not base on the model number.
>>
>> Otherwise, for now, I think we should enable these options unconditionally.
>>     
>
> Sorry, I got Zhang Fuxin's email wrong. Now fixed.
>
> Zhang, Le
>
>   

-- 
张福新 Zhang Fuxin
龙芯梦兰 管理部 总经理 Lemote General Manager 
zhangfx@lemote.com
