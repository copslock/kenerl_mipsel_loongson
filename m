Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2003 13:53:11 +0100 (BST)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:27572
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8225280AbTHFMxH>; Wed, 6 Aug 2003 13:53:07 +0100
Received: (qmail 10865 invoked from network); 6 Aug 2003 12:47:53 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by mail.ict.ac.cn with SMTP; 6 Aug 2003 12:47:53 -0000
Message-ID: <3F30FA1E.3000002@ict.ac.cn>
Date: Wed, 06 Aug 2003 20:52:46 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>,
	MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
Subject: Re: RM7k cache_flush_sigtramp
References: <9DFF23E1E33391449FDC324526D1F259017DF091@SJC1EXM02> <3F30DFB7.8030304@ict.ac.cn> <20030806115531.GA12161@linux-mips.org>
In-Reply-To: <20030806115531.GA12161@linux-mips.org>
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips



Ralf Baechle wrote:

>On Wed, Aug 06, 2003 at 07:00:07PM +0800, Fuxin Zhang wrote:
>
>  
>
>> And here I have a question for Mr. Adam: original linux code use 
>>'Writeback_Inv_D"
>>and "Hit_Invalidate_I",not "Writeback_D" and "Hit_Invalidate_I",could it 
>>lead to the
>>problem?
>>    
>>
>
>No.  To synchronize the D-cache and I-cache it's irrelevant if you
>invalidate the D-cache or not.
>  
>
I think so. Just in case the hardware is doing something strange:)

>  
>
>>BTW:
>>  a silly question: how can i make my email show up pretier? I find 
>>that the mailing list
>>often break my lines very badly. I feel guilty for that:) I am using 
>>mozilla composer,the
>>original linebreaks are manually inserted(hit enter when i feel it is 
>>long enough).
>>    
>>
>
>Format your email with hard breaks to about 75 columns.  75 columns
>because god made vt100 with 80 columns so that leaves a bit of space for
>quoting your mail nicely.
>
Thanks:)

>
>Now for your register dumps and information:
>  
>
>>           sr       lo       hi      bad    cause       pc
>>     a004f413 000001b0 00000000 8009c6a0 80000028 7fff75b8
>>    
>>
>[...]
>  
>
>>0x7fff75a0:     li      v0,4119
>>0x7fff75a4:     syscall
>>    
>>
>
>So the pc is pointing just after the trampoline which suspiciously looks
>like the return of an old bug.  Could your application be doing something
>unusual such as forking from a signal handler or similar?  The scenario
>
I am not sure. It is stardard X distribution from debian-woody. Fairly 
easy to reproduce,just move the mouse
around and click here and there then it would die. Will check this 
later,but I think such a giant as Xserver
won't fork frequently.

>is about
>
> - kernel installs signal trampoline on stack
> - kernel forks.  Now the signal trampoline installed in the first step
>   resides on a copy-on-write page.
> - newly created process touches the cow page, thereby resulting in
>   breaking of the cow page.  Now parent and child have their own copy
>   of the page.  BUT: flush_cache_page() doesn't properly flush this page
>  
>
> - Parent executes again on the copy of the page for which caches have
>
If the new process touch the cow page first,shouldn't it get a new page 
and leave the original page for parent?
If so,the parent should be able to see the trampoline content from 
icache anyway(either L2 or memory should
have the value),though the child may not?

>   not been flushed proplerly in the previous step, thereby failing to
>   execute the trampoline - crash.
>
RM7000 has 16k 4-way set-associated primary caches,which are supposed to 
have no cache aliasing problem

Bad news:

oops again:(  while true; do fsck -y -f /dev/hda4 ; done 

after about 5 succeeded run.
So still some  problems lurking somewhere.

It seems I have to switch some hardware...

>
>  Ralf
>
>
>
>  
>
