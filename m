Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2003 16:43:03 +0100 (BST)
Received: from mother.pmc-sierra.com ([IPv6:::ffff:216.241.224.12]:42687 "HELO
	mother.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8225230AbTHAPm5>; Fri, 1 Aug 2003 16:42:57 +0100
Received: (qmail 17586 invoked by uid 104); 1 Aug 2003 15:42:46 -0000
Received: from Adam_Kiepul@pmc-sierra.com by mother by uid 101 with qmail-scanner-1.15 
 (uvscan: v4.1.40/v4281.  Clear:. 
 Processed in 0.585858 secs); 01 Aug 2003 15:42:46 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by mother.pmc-sierra.com with SMTP; 1 Aug 2003 15:42:45 -0000
Received: from bby1exi01.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.12.9/8.12.7) with ESMTP id h71G9epD030282;
	Fri, 1 Aug 2003 09:09:40 -0700
Received: by bby1exi01 with Internet Mail Service (5.5.2656.59)
	id <P4MMVFK4>; Fri, 1 Aug 2003 08:42:43 -0700
Message-ID: <9DFF23E1E33391449FDC324526D1F259017DF091@SJC1EXM02>
From: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>
To: "'Fuxin Zhang'" <fxzhang@ict.ac.cn>,
	Ralf Baechle <ralf@linux-mips.org>
Cc: MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
Subject: RE: RM7k cache_flush_sigtramp
Date: Fri, 1 Aug 2003 08:42:33 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Adam_Kiepul@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Adam_Kiepul@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi Fuxin,

Could you please provide me with the _original_ Kernel code disassembly snippet around the point where your SYNC patch applies?
Also, can you check what RM7000 part revision is on your board? You can find it out by reading the PrID register.

I will check if there is an erratum that the code could trigger.

By the way, are you aware of any other ev64240 board that would exhibit the same behavior?

I would be quite careful drawing any conclusions at the moment since we can not preclude the possibility that it is simply a "bad CPU on the board" case. Please note that the SYNC instruction changes a lot in the manner things physically happen in the CPU so it can often mask off various problems, such as a bad part.

Thank you,

Adam


-----Original Message-----
From: Fuxin Zhang [mailto:fxzhang@ict.ac.cn]
Sent: Thursday, July 31, 2003 9:59 PM
To: Ralf Baechle
Cc: Adam Kiepul; MAKE FUN PRANK CALLS
Subject: Re: RM7k cache_flush_sigtramp


I am using a slightly modified 2.4.21-pre4,based on cvs of early this 
month(?).
We have merged with latest cvs, I will run it and report the result tonight.


Ralf Baechle wrote:

>Adam,
>
>On Fri, Aug 01, 2003 at 08:40:14AM +0800, Fuxin Zhang wrote:
>
>  
>
>>Current linux code does exactly this. But I was seeing all kinds of 
>>faults occuring around the
>>sigreturn point on the stack without a sync? And a sync does greatly 
>>improve the stablity.
>>
>>    
>>
>>>The ordering does matter however since the Hit_Invalidate_I makes sure the 
>>>write buffer is flushed.
>>>      
>>>
>
>could there be an errata explaining Fuxin's findings?
>
>Fuxin, what version are you running?
>
>  Ralf
>
>
>  
>
