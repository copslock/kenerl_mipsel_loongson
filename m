Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2003 05:59:28 +0100 (BST)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:1513
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8225207AbTHAE70>; Fri, 1 Aug 2003 05:59:26 +0100
Received: (qmail 11912 invoked from network); 1 Aug 2003 04:55:22 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by 159.226.39.4 with SMTP; 1 Aug 2003 04:55:22 -0000
Message-ID: <3F29F394.2030206@ict.ac.cn>
Date: Fri, 01 Aug 2003 12:59:00 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>,
	MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
Subject: Re: RM7k cache_flush_sigtramp
References: <9DFF23E1E33391449FDC324526D1F259017DF087@SJC1EXM02> <3F29B6EE.5070207@ict.ac.cn> <20030801030110.GD4197@linux-mips.org>
In-Reply-To: <20030801030110.GD4197@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

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
