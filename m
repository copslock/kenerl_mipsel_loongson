Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2003 15:19:16 +0100 (BST)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:36999
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8225207AbTHAOTM>; Fri, 1 Aug 2003 15:19:12 +0100
Received: (qmail 13850 invoked from network); 1 Aug 2003 14:15:07 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by 159.226.39.4 with SMTP; 1 Aug 2003 14:15:07 -0000
Message-ID: <3F2A76CA.4080904@ict.ac.cn>
Date: Fri, 01 Aug 2003 22:18:50 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Dominic Sweetman <dom@mips.com>,
	Adam Kiepul <Adam_Kiepul@pmc-sierra.com>,
	linux-mips@linux-mips.org
Subject: Re: RM7k cache_flush_sigtramp
References: <9DFF23E1E33391449FDC324526D1F259017DF087@SJC1EXM02> <16170.7179.635988.268987@doms-laptop.algor.co.uk> <20030801092649.GA17624@linux-mips.org>
In-Reply-To: <20030801092649.GA17624@linux-mips.org>
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

I just run a fresh new 2.4.21 kernel on my board, no luck.  The problem 
remains.
But I notice that my hardware may have some problems,especially with the 
add-on
ide card. Keep headaching...

As to the discussion of SYNC, I can't help wondering whether the cache 
management
should be totally hidden from programmers. People tends to write 
"safetest" code because
of all kinds of brain-damage different hardware, which leads to 
inefficient code. And this will
cancel out the potential speed benefit of simpler hardware. Also today's 
hardware seems not
as expensive as it was before...


Ralf Baechle wrote:

>On Fri, Aug 01, 2003 at 08:51:39AM +0100, Dominic Sweetman wrote:
>
>  
>
>>The MIPS32/MIPS64 release 2 architecture includes a useful instruction
>>SYNCI which does the whole job (repeat on each affected cache line)
>>and is legal in user mode; this will take a while to spread but I'd
>>recommend it as a model worth following.
>>    
>>
>
>  
>
>>So I hope that kernels will provide one function for "I've just
>>written instructions and now I want to execute them", and not export
>>the separate writeback-D/invalidate-I interface.
>>    
>>
>
>Linux supports the traditional MIPS UNIX cacheflush(2) syscall through
>a libc interface.  Since I've not seen any other use for the call than
>I/D-cache synchronization.  I'd just make cacheflush(3) use SYNCI where
>available (Or maybe one of the other vendor specific mechanisms ...) and
>fallback to cacheflush(2) where available.  Gcc would be another place
>to teach about SYNCI for it's trampolines.
>
>  Ralf
>
>
>
>  
>
