Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2003 01:40:38 +0100 (BST)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:45794
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8225207AbTHAAkg>; Fri, 1 Aug 2003 01:40:36 +0100
Received: (qmail 23439 invoked from network); 1 Aug 2003 00:36:37 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by 159.226.39.4 with SMTP; 1 Aug 2003 00:36:37 -0000
Message-ID: <3F29B6EE.5070207@ict.ac.cn>
Date: Fri, 01 Aug 2003 08:40:14 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>,
	MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
Subject: Re: RM7k cache_flush_sigtramp
References: <9DFF23E1E33391449FDC324526D1F259017DF087@SJC1EXM02>
In-Reply-To: <9DFF23E1E33391449FDC324526D1F259017DF087@SJC1EXM02>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips


Adam Kiepul wrote:

>Hi,
>
>If this is just to ensure the I Cache coherency for modified code then the following should be sufficient:
>
>cache Hit_Writeback_D, offset(base_register)
>cache Hit_Invalidate_I, offset(base_register)
>  
>
Current linux code does exactly this. But I was seeing all kinds of 
faults occuring around the
sigreturn point on the stack without a sync? And a sync does greatly 
improve the stablity.

>The ordering does matter however since the Hit_Invalidate_I makes sure the write buffer is flushed.
>
>Kind Regards,
>
>_______________________________
>
>Adam Kiepul
>Sr. Applications Engineer
>
>PMC-Sierra, Microprocessor Division
>Mission Towers One
>3975 Freedom Circle
>Santa Clara, CA 95054, USA
>Direct: 408 239 8124
>Fax: 408 492 9462
>
>
>
>-----Original Message-----
>From: Ralf Baechle [mailto:ralf@linux-mips.org]
>Sent: Thursday, July 31, 2003 4:47 AM
>To: Fuxin Zhang
>Cc: MAKE FUN PRANK CALLS
>Subject: Re: RM7k cache_flush_sigtramp
>
>
>On Thu, Jul 31, 2003 at 09:56:08AM +0800, Fuxin Zhang wrote:
>  
>
>>Date:	Thu, 31 Jul 2003 09:56:08 +0800
>>From:	Fuxin Zhang <fxzhang@ict.ac.cn>
>>To:	MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
>>    
>>
>        ^^^^^^^^^^^^^^^^^^^^
>
>Funny name for the list :-)
>
>  
>
>>r4k_cache_flush_sigtrap seems not enough for RM7000 cpus because
>>there is a writebuffer between L1 dcache & L2 cache,so the written back
>>block may not be seen by icache. This small patch fixes crashes of my
>>Xserver on ev64240.
>>    
>>
>
>It would seem a similar fix is also needed in other places then?
>
>  Ralf
>
>
>  
>
