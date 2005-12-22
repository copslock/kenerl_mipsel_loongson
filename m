Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Dec 2005 08:36:55 +0000 (GMT)
Received: from 252.237.98-84.rev.gaoland.net ([84.98.237.252]:58940 "EHLO
	serveurSMTP") by ftp.linux-mips.org with ESMTP id S8133516AbVLVIgh
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Dec 2005 08:36:37 +0000
Received: from [192.168.150.1] by serveurSMTP
  (ArGoSoft Mail Server Freeware, Version 1.8 (1.8.8.2)); Thu, 22 Dec 2005 09:39:35 +0100
Message-ID: <43AA653B.6050207@avilinks.com>
Date:	Thu, 22 Dec 2005 09:35:07 +0100
From:	Yoann Allain <yallain@avilinks.com>
Organization: Avilinks
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To:	Fuxin Zhang <fxzhang@ict.ac.cn>
CC:	Srinivas Kommu <kommu@hotmail.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Preempted interrupt handler
References: <43A6F155.7080402@avilinks.com> <20051220131829.GB3376@linux-mips.org> <20051221193906.GB1456@sjc-xdm-007.cisco.com> <43A9F76A.4080305@ict.ac.cn>
In-Reply-To: <43A9F76A.4080305@ict.ac.cn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <yallain@avilinks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yallain@avilinks.com
Precedence: bulk
X-list: linux-mips


Fuxin Zhang a écrit :

>>Is it normal for the modules to be loaded at 0xc0000000 (this is
>>highmem, isn't it)? I see the same on my bcm1250 box. I've been wondering
>>why they can't be loaded in kseg0. Or is it because of bad
>>modutils/compiler flags?
>>    
>>
>It is not necessary highmem. 0xc0000000 is a MAPPED(i.e. use TLB) kernel
>segment,
>used by vmalloc to allocate a large virtually continous memory area for
>modules. Use kseg0 you have to get a large physically continuous area,
>and that is difficult unless you reserve some memory.
>  
>
I've just found in LDD 2nd version book (page 218), that on MIPS, 
addresses returned by vmalloc belong to a completely different address 
range from kmalloc addresses, whereas on x86 platforms they belong to 
the same.

Concerning the clues given by Ralf, I've tried insmoding the module by a 
recent version of modutils instead of using the insmod brought with 
Busybox : the kernel behaved the same, it doesn't want to use the 
handler of my kernel.
I've also checked that I was compiling with the mlong-calls flag...

Therefore, I think I will compile my module into the kernel, until I 
found a solution to this problem...

Thanks everyone!
