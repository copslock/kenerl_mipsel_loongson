Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 19:33:07 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.228]:12809 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039280AbWI2SdF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Sep 2006 19:33:05 +0100
Received: by wx-out-0506.google.com with SMTP id h30so1099325wxd
        for <linux-mips@linux-mips.org>; Fri, 29 Sep 2006 11:33:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=Lm7Fo35+NL1D3NqUcT5c/98kBMQvJ3+BdvXdzd1zali9nqaqhng3uLX/ApwRZ0QyuKomYdo/PfYdJOqHJA+1hN/YMXDyca3/95B+6E0FivcNnpEtMViiWkhSpOj1vqGFweYECvoNsY6aqp8eUK+9kAXnEuKa1UheK9HaWWu33f8=
Received: by 10.90.55.19 with SMTP id d19mr1927527aga;
        Fri, 29 Sep 2006 11:33:04 -0700 (PDT)
Received: from ?192.168.1.3? ( [61.125.212.22])
        by mx.gmail.com with ESMTP id 37sm2640291nzf.2006.09.29.11.33.02;
        Fri, 29 Sep 2006 11:33:03 -0700 (PDT)
In-Reply-To: <20060930.025956.108739154.anemo@mba.ocn.ne.jp>
References: <C140DCAC.7A1C%girishvg@gmail.com> <20060928232956.GE3394@linux-mips.org> <B3C723F6-A2B3-4A0E-88BB-FF36AB58FFB4@gmail.com> <20060930.025956.108739154.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8D501155-BC7A-471A-9374-9EB8D48BE307@gmail.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Transfer-Encoding: 7bit
From:	girish <girishvg@gmail.com>
Subject: Re: PATCH] cleanup hardcoding __pa/__va macros etc. (take-5)
Date:	Sat, 30 Sep 2006 03:33:01 +0900
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Mailer: Apple Mail (2.749)
Return-Path: <girishvg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: girishvg@gmail.com
Precedence: bulk
X-list: linux-mips


On Sep 30, 2006, at 2:59 AM, Atsushi Nemoto wrote:

> On Fri, 29 Sep 2006 23:45:12 +0900, girish <girishvg@gmail.com> wrote:
>>>> Please find attached patch created from 2.6.18 (kernel.org) tree.
>>>> Let me
>>>> know if this is alright.
>>>>
>>>> Signed-off-by: Girish V. Gulawani <girishvg@gmail.com>
>>>
>>> -#ifdef CONFIG_ISA
>>> -	if (low < max_dma)
>>> +	if (low < max_dma) }
>>>
>>> This doesn't quite compile.
>>>
>>
>> Stupid mistake. Fixed & resending.
>
> Looks good to me, except for page.h part.

I agree, but as of now, I do not have any better solution. If & when  
I will implement kernel page table for memory above 2000_0000, I plan  
to give it a through mapping. That is to say, 4000_0000 physical  
mapped to 4000_0000 virtual. In that case the page.h __pa/__va macros  
stand a chance (^_^;)

If somebody has already done kernel page table implementation, could  
you please pass on the relevant patch? Thanks.
