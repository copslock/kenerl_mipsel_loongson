Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2005 19:28:11 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:6837 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8133548AbVL0T1q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Dec 2005 19:27:46 +0000
Received: (qmail 21276 invoked from network); 27 Dec 2005 19:29:31 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 27 Dec 2005 19:29:31 -0000
Message-ID: <43B196A9.8010608@dev.rtsoft.ru>
Date:	Tue, 27 Dec 2005 22:31:53 +0300
From:	Sergei Shtylyov <sshtylyov@dev.rtsoft.ru>
Organization: RTSoft, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Russell King <rmk@arm.linux.org.uk>
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] serial_txx9: forcibly init the spinlock for PCI UART
 used as a console
References: <43B06DB4.409@ru.mvista.com> <20051227.144551.79070832.nemoto@toshiba-tops.co.jp> <43B143EE.6070700@ru.mvista.com> <20051228.003457.74752441.anemo@mba.ocn.ne.jp> <20051227184152.GA4474@flint.arm.linux.org.uk> <43B18DD2.3090206@ru.mvista.com>
In-Reply-To: <43B18DD2.3090206@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@dev.rtsoft.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@dev.rtsoft.ru
Precedence: bulk
X-list: linux-mips

Hello.

Sergei Shtylylov wrote:

>> no need to pre-register all the uart ports at driver initialisation
>> time.  Consequently, there's no need to remove them all when you
>> remove the module.

>    Hm, then the driver would need to keep track of which ports it has 
> registered and which it has not...

    However, it does this already in a way, via port type.

>  > Secondly, the upshot of this is that you only call uart_add_one_port()
>  > when you initialise a PCI card.

>    Not the case as I've said; uart_add_one_port() should be called on 
> driver startup anyway...

>> This should result in a cleaner implementation, and the console will
>> not be started until you detect the PCI card.

>    It will still be started with the console_initcall() in this driver, 
> if that code is not also deleted...

    That doesn't matter. Driver init time uart_add_one_port() calls to 
register SOC UARTs will result in register_console() being called multiple 
times unsuccesfully anyway before we get to the PCI UART to which the console 
is assigned.
    All in all, the problem of uninit'ed PCI port spinlock will remain unless 
serial core is fixed (ot at least the driver). Proposed driver re-design 
wouldn't help as this is actually chicken-before-egg type problem -- 
uart_add_one_port() assumes that the console is setup beforehand, and this 
just can't happen in case of a PCI card.

WBR, Sergei
