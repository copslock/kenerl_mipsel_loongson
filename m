Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2003 16:04:42 +0100 (BST)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:19895
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8225284AbTHFPEk>; Wed, 6 Aug 2003 16:04:40 +0100
Received: (qmail 9200 invoked from network); 6 Aug 2003 14:59:25 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by mail.ict.ac.cn with SMTP; 6 Aug 2003 14:59:25 -0000
Message-ID: <3F3118F3.1030001@ict.ac.cn>
Date: Wed, 06 Aug 2003 23:04:19 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>,
	MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
Subject: Re: RM7k cache_flush_sigtramp
References: <9DFF23E1E33391449FDC324526D1F259017DF091@SJC1EXM02> <3F30DFB7.8030304@ict.ac.cn> <20030806115531.GA12161@linux-mips.org> <3F30FA1E.3000002@ict.ac.cn> <20030806144513.GB12161@linux-mips.org>
In-Reply-To: <20030806144513.GB12161@linux-mips.org>
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips



Ralf Baechle wrote:

>>If the new process touch the cow page first,shouldn't it get a new page 
>>and leave the original page for parent?
>>If so,the parent should be able to see the trampoline content from 
>>icache anyway(either L2 or memory should
>>have the value),though the child may not?
>>    
>>
>
>RM7000 has a physically indexed cache.  That means if the copy of the
>page wasn't explicitly or implicitly written back to L2 the process
>whichever ends up with the copy of the page might fetch stale instructions
>from memory - boom.
>
>  
>
>>> not been flushed proplerly in the previous step, thereby failing to
>>> execute the trampoline - crash.
>>>
>>>      
>>>
>>RM7000 has 16k 4-way set-associated primary caches,which are supposed to 
>>have no cache aliasing problem
>>    
>>
>
>The described scenario is not an aliasing problem; it's the case where the
>copy of the cow page hasn't properly been flushed at all.  When we
>isolated the bug was that neither flush_page_to_ram() nor flush_cache_page()
>were flushing the cache.  I suspect your case must be something fairly
>  
>
After cache rewrite,flush_page_to_ram is null; and in this case 
flush_cache_page
 do nothing for a stack page. (It flushes only when has_dc_aliases or 
exec set).
So  the  one use  the new copy will  have problem ?!  Am I missing 
something?

Thank you very much, great Ralf:).

>similar.
>
>  Ralf
>
>
>  
>
