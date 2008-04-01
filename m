Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2008 17:55:48 +0200 (CEST)
Received: from smtp4.pp.htv.fi ([213.243.153.38]:47307 "EHLO smtp4.pp.htv.fi")
	by lappi.linux-mips.net with ESMTP id S1101815AbYDAPzm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2008 17:55:42 +0200
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id 2E0E65BC007;
	Tue,  1 Apr 2008 18:55:20 +0300 (EEST)
Date:	Tue, 1 Apr 2008 18:55:15 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Florian Fainelli <florian.fainelli@telecomint.eu>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Fix xss1500 compilation
Message-ID: <20080401155515.GA32269@cs181133002.pp.htv.fi>
References: <200804011553.25850.florian.fainelli@telecomint.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200804011553.25850.florian.fainelli@telecomint.eu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 01, 2008 at 03:53:25PM +0200, Florian Fainelli wrote:
> This patch fixes the compilation of the Au1000 XSS1500
> board setup and irqmap code.
>...

Another compile error for this platform is:

<--  snip  -->

...
  CC [M]  drivers/pcmcia/au1000_xxs1500.o
/tmp/linux-2.6.25-rc7/drivers/pcmcia/au1000_xxs1500.c:33:26: error: linux/tqueue.h: No such file or directory
/tmp/linux-2.6.25-rc7/drivers/pcmcia/au1000_xxs1500.c:44:28: error: pcmcia/bus_ops.h: No such file or directory
/tmp/linux-2.6.25-rc7/drivers/pcmcia/au1000_xxs1500.c:51:24: error: asm/au1000.h: No such file or directory
/tmp/linux-2.6.25-rc7/drivers/pcmcia/au1000_xxs1500.c:52:31: error: asm/au1000_pcmcia.h: No such file or directory
...
make[3]: *** [drivers/pcmcia/au1000_xxs1500.o] Error 1

<--  snip  -->

include/linux/tqueue.h was removed on Sep 30, 2002 (sic) which was even 
before 2.6.0 .

Obviously no 2.6 kernel ever ran on these boards.

If you have such a board and want to run kernel 2.6 on it that's fine 
with me, but otherwise i don't see much point in keeping the support 
for this board.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
