Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jun 2007 05:49:15 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:34711 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021588AbXFHEtN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 Jun 2007 05:49:13 +0100
Received: (qmail 7540 invoked by uid 511); 8 Jun 2007 04:55:48 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 8 Jun 2007 04:55:48 -0000
Message-ID: <4668DF7A.6040807@lemote.com>
Date:	Fri, 08 Jun 2007 12:47:54 +0800
From:	Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Franck Bui-Huu <vagabon.xyz@gmail.com>, linux-mips@linux-mips.org,
	Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH] cheat for support of more than 256MB memory
References: <11811049622818-git-send-email-tiansm@lemote.com> <11811049643791-git-send-email-tiansm@lemote.com> <cda58cb80706052338y461f707fq790e204f55a23cc0@mail.gmail.com> <20070606164018.GA30017@linux-mips.org>
In-Reply-To: <20070606164018.GA30017@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Jun 06, 2007 at 08:38:18AM +0200, Franck Bui-Huu wrote:
>
>   
>>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>>> index 4975da0..62ef100 100644
>>> --- a/arch/mips/kernel/setup.c
>>> +++ b/arch/mips/kernel/setup.c
>>> @@ -509,6 +509,14 @@ static void __init resource_init(void)
>>>                res->end = end;
>>>
>>>                res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>>> +#if defined(CONFIG_LEMOTE_FULONG) && defined(CONFIG_64BIT)
>>> +               /* to keep memory continous, we tell system 0x10000000 - 
>>> 0x20000000 is reserved
>>> +                * for memory, in fact it is io region, don't occupy it
>>> +                *
>>> +                * SPARSEMEM?
>>>       
>> Definetly yes ! It has been designed for such issue and it should save
>> you some memory.
>>     
>
> A hole of 256MB size in the memory address map will cost 3.5MB with a 64-bit
> kernel.  The other reason why I don't like this patch is that it drags
> platform specific code into the generic MIPS code.
>
>   Ralf
>
>
>   
we use 16k page，so it's cheaper than that:)

Before I work out sparse memory solution, I think I can drop this patch 
and make some trivial fix of the first patch.

Subject: [PATCH] simply ignore the memory hole

Signed-off-by: Songmao Tian <tiansm@lemote.com>
---
 arch/mips/lemote/lm2e/setup.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/lemote/lm2e/setup.c b/arch/mips/lemote/lm2e/setup.c
index 3030518..2498bbf 100644
--- a/arch/mips/lemote/lm2e/setup.c
+++ b/arch/mips/lemote/lm2e/setup.c
@@ -112,7 +112,6 @@ void __init plat_mem_setup(void)
     add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
 #ifdef CONFIG_64BIT
     if (highmemsize > 0) {
-        add_memory_region(0x10000000, 0x10000000, BOOT_MEM_RESERVED);
         add_memory_region(0x20000000, highmemsize << 20, BOOT_MEM_RAM);
     }
 #endif
