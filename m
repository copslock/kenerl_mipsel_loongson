Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2008 19:13:26 +0200 (CEST)
Received: from [63.81.120.155] ([63.81.120.155]:31811 "EHLO imap.sh.mvista.com")
	by lappi.linux-mips.net with ESMTP id S1102049AbYDARNS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2008 19:13:18 +0200
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 309B13ECA; Tue,  1 Apr 2008 09:17:21 -0700 (PDT)
Message-ID: <47F25FE7.5000406@ru.mvista.com>
Date:	Tue, 01 Apr 2008 20:16:39 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Adrian Bunk <bunk@kernel.org>
Cc:	Florian Fainelli <florian.fainelli@telecomint.eu>,
	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Fix xss1500 compilation
References: <200804011553.25850.florian.fainelli@telecomint.eu> <20080401155515.GA32269@cs181133002.pp.htv.fi>
In-Reply-To: <20080401155515.GA32269@cs181133002.pp.htv.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Adrian Bunk wrote:

>>This patch fixes the compilation of the Au1000 XSS1500
>>board setup and irqmap code.
>>...

> Another compile error for this platform is:
> 
> <--  snip  -->

> ...
>   CC [M]  drivers/pcmcia/au1000_xxs1500.o
> /tmp/linux-2.6.25-rc7/drivers/pcmcia/au1000_xxs1500.c:33:26: error: linux/tqueue.h: No such file or directory
> /tmp/linux-2.6.25-rc7/drivers/pcmcia/au1000_xxs1500.c:44:28: error: pcmcia/bus_ops.h: No such file or directory
> /tmp/linux-2.6.25-rc7/drivers/pcmcia/au1000_xxs1500.c:51:24: error: asm/au1000.h: No such file or directory
> /tmp/linux-2.6.25-rc7/drivers/pcmcia/au1000_xxs1500.c:52:31: error: asm/au1000_pcmcia.h: No such file or directory
> ...
> make[3]: *** [drivers/pcmcia/au1000_xxs1500.o] Error 1

> <--  snip  -->

> include/linux/tqueue.h was removed on Sep 30, 2002 (sic) which was even 
> before 2.6.0 .

> Obviously no 2.6 kernel ever ran on these boards.

    Not true -- there have been 2.6 patches from MyCable, the board vendor.
According to them, the last version supported version (on request) was 2.6.22.

WBR, Sergei
