Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2008 19:15:36 +0200 (CEST)
Received: from smtp4.pp.htv.fi ([213.243.153.38]:24800 "EHLO smtp4.pp.htv.fi")
	by lappi.linux-mips.net with ESMTP id S1102060AbYDARP1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2008 19:15:27 +0200
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id 4969C5BC08F;
	Tue,  1 Apr 2008 19:38:34 +0300 (EEST)
Date:	Tue, 1 Apr 2008 19:38:29 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Florian Fainelli <florian.fainelli@telecomint.eu>,
	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Fix xss1500 compilation
Message-ID: <20080401163829.GB32269@cs181133002.pp.htv.fi>
References: <200804011553.25850.florian.fainelli@telecomint.eu> <20080401155515.GA32269@cs181133002.pp.htv.fi> <47F25FE7.5000406@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47F25FE7.5000406@ru.mvista.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 01, 2008 at 08:16:39PM +0400, Sergei Shtylyov wrote:
> Adrian Bunk wrote:
>
>>> This patch fixes the compilation of the Au1000 XSS1500
>>> board setup and irqmap code.
>>> ...
>
>> Another compile error for this platform is:
>>
>> <--  snip  -->
>
>> ...
>>   CC [M]  drivers/pcmcia/au1000_xxs1500.o
>> /tmp/linux-2.6.25-rc7/drivers/pcmcia/au1000_xxs1500.c:33:26: error: linux/tqueue.h: No such file or directory
>> /tmp/linux-2.6.25-rc7/drivers/pcmcia/au1000_xxs1500.c:44:28: error: pcmcia/bus_ops.h: No such file or directory
>> /tmp/linux-2.6.25-rc7/drivers/pcmcia/au1000_xxs1500.c:51:24: error: asm/au1000.h: No such file or directory
>> /tmp/linux-2.6.25-rc7/drivers/pcmcia/au1000_xxs1500.c:52:31: error: asm/au1000_pcmcia.h: No such file or directory
>> ...
>> make[3]: *** [drivers/pcmcia/au1000_xxs1500.o] Error 1
>
>> <--  snip  -->
>
>> include/linux/tqueue.h was removed on Sep 30, 2002 (sic) which was even 
>> before 2.6.0 .
>
>> Obviously no 2.6 kernel ever ran on these boards.
>
>    Not true -- there have been 2.6 patches from MyCable, the board vendor.

When I talk about a "2.6 kernel" I'm talking about what is on
ftp.kernel.org, not what is hidden in some vendor patches.

> According to them, the last version supported version (on request) was 2.6.22.

Why is it not being submitted, and how much does it actually have in 
common with the code currently in the kernel?

After all, e.g. the pcmcia driver was added in 2003 with the
#include <linux/tqueue.h> and a "Copyright 2003 MontaVista Software Inc.".

And 2003 is one year *after* include/linux/tqueue.h was removed.

If MyCable submits their patches for 2.6.22 (adapted to 2.6.25 if 
required) that would be great.

But otherwise there's simply no point in trying to fix the compilation 
of this kernel 2.4 code that was dumped into kernel 2.6.

> WBR, Sergei

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
