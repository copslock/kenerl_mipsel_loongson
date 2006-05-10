Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 May 2006 04:21:26 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:27825 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S8126484AbWEJCVQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 May 2006 04:21:16 +0200
Received: from ala-mail04.corp.ad.wrs.com (ala-mail04 [147.11.57.145])
	by mail.wrs.com (8.13.6/8.13.3) with ESMTP id k4A2L7V8006878;
	Tue, 9 May 2006 19:21:07 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ala-mail04.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 9 May 2006 19:21:07 -0700
Received: from [192.168.96.26] ([192.168.96.26]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 9 May 2006 19:21:06 -0700
Message-ID: <44614E0F.2000207@windriver.com>
Date:	Wed, 10 May 2006 10:21:03 +0800
From:	"Mark.Zhan" <rongkai.zhan@windriver.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Alex Gonzalez <langabe@gmail.com>, linux-mips@linux-mips.org
Subject: Re: Boot time memory allocation
References: <c58a7a270605090735t8e4f21ax6ca87f97b9143e3b@mail.gmail.com> <20060509163411.GA8528@linux-mips.org>
In-Reply-To: <20060509163411.GA8528@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 May 2006 02:21:07.0061 (UTC) FILETIME=[64F5FA50:01C673D8]
Return-Path: <rongkai.zhan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongkai.zhan@windriver.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, May 09, 2006 at 03:35:14PM +0100, Alex Gonzalez wrote:
> 
>> I have two independent processors with access to a shared memory
>> region, mapped in the 256MB to 512MB region (kseg0).
>>
>> One is running a propietary OS, and the second one is running Linux 2.6.12.
>>
>> How would I arrange to leave that shared memory region out of the
>> scope of Linux's memory management system, but at the same time make
>> it possible for a driver to access it?
>>
>> I have done similar things before with the help of alloc_bootmem, but
>> this time I don't want the kernel to reserve the memory, I want the
>> kernel to be completely unaware of it, and I need to specify its start
>> and end.
> 
> At kernel initialization time just don't tell the kernel about the
> existence of your memory region.  For many systems that just means you
> shrink the memory region passed to the add_memory_region() call to
> something that suits your platform.
> 
>   Ralf
> 

Maybe it is a more flexible way to specify the memory regions via 
command line. You know, this will produce User-defined memory regions to 
kernel.
