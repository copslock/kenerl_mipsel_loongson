Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2003 04:39:01 +0100 (BST)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:27333
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8225333AbTHDDi7>; Mon, 4 Aug 2003 04:38:59 +0100
Received: (qmail 15037 invoked from network); 4 Aug 2003 03:34:17 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by 159.226.39.4 with SMTP; 4 Aug 2003 03:34:17 -0000
Message-ID: <3F2DD534.1010905@ict.ac.cn>
Date: Mon, 04 Aug 2003 11:38:28 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>
CC: Ralf Baechle <ralf@linux-mips.org>,
	MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
Subject: Re: RM7k cache_flush_sigtramp
References: <9DFF23E1E33391449FDC324526D1F259017DF091@SJC1EXM02>
In-Reply-To: <9DFF23E1E33391449FDC324526D1F259017DF091@SJC1EXM02>
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

Hi Adam,
   
   My cpu PRID:  0x2732, runs at freq 133x2MHz

disassemble code before patch:

ffffffff8010f2fc <r4k_flush_cache_sigtramp>:
ffffffff8010f2fc:	3c03802c 	lui	v1,0x802c
ffffffff8010f300:	246367ec 	addiu	v1,v1,26604
ffffffff8010f304:	94620010 	lhu	v0,16(v1)
ffffffff8010f308:	94650000 	lhu	a1,0(v1)
ffffffff8010f30c:	00021023 	negu	v0,v0
ffffffff8010f310:	00821024 	and	v0,a0,v0
ffffffff8010f314:	bc550000 	cache	0x15,0(v0)
ffffffff8010f318:	00052823 	negu	a1,a1
ffffffff8010f31c:	00852024 	and	a0,a0,a1
ffffffff8010f320:	bc900000 	cache	0x10,0(a0)
ffffffff8010f324:	03e00008 	jr	ra
ffffffff8010f328:	00000000 	nop

disassemble code after patch:
ffffffff8010ceb0 <r4k_flush_cache_sigtramp>:
ffffffff8010ceb0:	3c03802f 	lui	v1,0x802f
ffffffff8010ceb4:	2463e3ac 	addiu	v1,v1,-7252
ffffffff8010ceb8:	94620010 	lhu	v0,16(v1)
ffffffff8010cebc:	94650000 	lhu	a1,0(v1)
ffffffff8010cec0:	00021023 	negu	v0,v0
ffffffff8010cec4:	00821024 	and	v0,a0,v0
ffffffff8010cec8:	bc550000 	cache	0x15,0(v0)
ffffffff8010cecc:	0000000f 	sync
ffffffff8010ced0:	00052823 	negu	a1,a1
ffffffff8010ced4:	00852024 	and	a0,a0,a1
ffffffff8010ced8:	bc900000 	cache	0x10,0(a0)
ffffffff8010cedc:	03e00008 	jr	ra
ffffffff8010cee0:	00000000 	nop


We do have more than one set of ev64240 and RM7k cpu£¬but it will take 
some time for
me to get another one for test. I will tell you the result once i do it.

Thank you.
 

Adam Kiepul wrote:

>Hi Fuxin,
>
>Could you please provide me with the _original_ Kernel code disassembly snippet around the point where your SYNC patch applies?
>Also, can you check what RM7000 part revision is on your board? You can find it out by reading the PrID register.
>
>I will check if there is an erratum that the code could trigger.
>
>By the way, are you aware of any other ev64240 board that would exhibit the same behavior?
>
>I would be quite careful drawing any conclusions at the moment since we can not preclude the possibility that it is simply a "bad CPU on the board" case. Please note that the SYNC instruction changes a lot in the manner things physically happen in the CPU so it can often mask off various problems, such as a bad part.
>
>Thank you,
>
>Adam
>
>
>-----Original Message-----
>From: Fuxin Zhang [mailto:fxzhang@ict.ac.cn]
>Sent: Thursday, July 31, 2003 9:59 PM
>To: Ralf Baechle
>Cc: Adam Kiepul; MAKE FUN PRANK CALLS
>Subject: Re: RM7k cache_flush_sigtramp
>
>
>I am using a slightly modified 2.4.21-pre4,based on cvs of early this 
>month(?).
>We have merged with latest cvs, I will run it and report the result tonight.
>
>
>Ralf Baechle wrote:
>
>  
>
>>Adam,
>>
>>On Fri, Aug 01, 2003 at 08:40:14AM +0800, Fuxin Zhang wrote:
>>
>> 
>>
>>    
>>
>>>Current linux code does exactly this. But I was seeing all kinds of 
>>>faults occuring around the
>>>sigreturn point on the stack without a sync? And a sync does greatly 
>>>improve the stablity.
>>>
>>>   
>>>
>>>      
>>>
>>>>The ordering does matter however since the Hit_Invalidate_I makes sure the 
>>>>write buffer is flushed.
>>>>     
>>>>
>>>>        
>>>>
>>could there be an errata explaining Fuxin's findings?
>>
>>Fuxin, what version are you running?
>>
>> Ralf
>>
>>
>> 
>>
>>    
>>
>
>
>
>  
>
