Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Nov 2004 01:34:05 +0000 (GMT)
Received: from [IPv6:::ffff:159.226.39.7] ([IPv6:::ffff:159.226.39.7]:39908
	"HELO ict.ac.cn") by linux-mips.org with SMTP id <S8225221AbUKNBd7>;
	Sun, 14 Nov 2004 01:33:59 +0000
Received: (qmail 20350 invoked by uid 507); 14 Nov 2004 01:03:53 -0000
Received: from unknown (HELO ict.ac.cn) (fxzhang@159.226.40.187)
  by ict.ac.cn with SMTP; 14 Nov 2004 01:03:53 -0000
Message-ID: <4196B593.40307@ict.ac.cn>
Date: Sun, 14 Nov 2004 09:32:03 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
X-Accept-Language: zh-cn, en-us
MIME-Version: 1.0
To: emblinux@macrohat.com
CC: linux-mips <linux-mips@linux-mips.org>
Subject: Re: 
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips



macrohat wrote:

>Dear linux-mips:
>
>Thanks!
>
>So,Could I think that BCM1250 is not a type of high performance CPU? as in ARM or Power PC ARCH system,Bogomips is almost equal to CPU clock 
>
Intel P4 has 2X Bogomips than the frequency:)

I think we could not conclude just by this: performance of a CPU is a
complex topic,
its architects may think ALU latency is not important enough for them to
implement
full bypass,instead put their energy on other issues.Nowadays, the
memory hierarchy
performance often dominates.

Of course you can benmark it, for general purpose CPU, SPEC CPU2000 may
be a good choice(www.spec.org)
and there are numerous other free benchmarks too.

>frequency.Is there any way to inprove it with software?
>  
>
The compiler may help a bit by scheduling instructions around.

>	
>
>Regards!
>
>======= 2004-11-13 22:01:00 艇壓栖佚嶄亟祇��=======
>
>  
>
>>macrohat wrote:
>>
>>    
>>
>>>Hello linux-mips:
>>>
>>>I have a question to ask you: why BCM1250 CPU Bogomips is so much lower than CPU clock frequency,such as:
>>>CPU 700MHz - 465.30 Bogomips, CPU 800MHZ - 532.48 BogoMIPS.And i find out that CPU Bogomips is a fixed value regardless L2 cache open or closed,
>>>
>>> 
>>>
>>>      
>>>
>>This indicates the ALU ops of that CPU have more than one cycle latency.
>>To achieve higher frequency,
>>the pipeline is becoming longer...
>>
>>Bogomips calculation is a short loop which fits well in L1 caches, so L2
>>won't affect the performance.
>>
>>    
>>
>>>Enclosed is the log from the console
>>>
>>>Regards!
>>>				
>>>
>>>　　　　　　　　macrohat
>>>　　　　　　　　emblinux@macrohat.com
>>>　　　　　　　　　　2004-11-13
>>> 
>>>
>>>      
>>>
>
> 
>				 
>　　　　　　　　macrohat
>　　　　　　　　emblinux@macrohat.com
>　　　　　　　　　　2004-11-13
>
>  
>
