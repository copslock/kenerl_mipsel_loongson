Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2003 13:58:33 +0100 (BST)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:24277
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8225329AbTGaM6W>; Thu, 31 Jul 2003 13:58:22 +0100
Received: (qmail 27990 invoked from network); 31 Jul 2003 12:54:28 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by 159.226.39.4 with SMTP; 31 Jul 2003 12:54:28 -0000
Message-ID: <3F291257.6020704@ict.ac.cn>
Date: Thu, 31 Jul 2003 20:57:59 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
Subject: Re: RM7k cache_flush_sigtramp
References: <3F287738.1040203@ict.ac.cn> <20030731114639.GC2718@linux-mips.org>
In-Reply-To: <20030731114639.GC2718@linux-mips.org>
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips



Ralf Baechle wrote:

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
I have not thought about it further. But
  1. I implement wb_flush for this board,using sync and uncached read. 
Just in case
      so many buffer on the cpu and system bridge will surprise me.
  2. There are still occasionally oops, especially with IO 
activities,e.g.,when fscking a disk.

What would should suggest to look at? Some flushes will go through all 
levels of cache,
I think they should be safe. Will check later.

Thanks.

>
>  Ralf
>
>
>
>  
>
