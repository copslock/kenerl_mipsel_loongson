Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2005 18:50:36 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:9902 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8133560AbVL0SuQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Dec 2005 18:50:16 +0000
Received: (qmail 20876 invoked from network); 27 Dec 2005 18:51:47 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 27 Dec 2005 18:51:47 -0000
Message-ID: <43B18DD2.3090206@ru.mvista.com>
Date:	Tue, 27 Dec 2005 21:54:10 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Russell King <rmk@arm.linux.org.uk>
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] serial_txx9: forcibly init the spinlock for PCI UART
 used as a console
References: <43B06DB4.409@ru.mvista.com> <20051227.144551.79070832.nemoto@toshiba-tops.co.jp> <43B143EE.6070700@ru.mvista.com> <20051228.003457.74752441.anemo@mba.ocn.ne.jp> <20051227184152.GA4474@flint.arm.linux.org.uk>
In-Reply-To: <20051227184152.GA4474@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Russell King wrote:

> On Wed, Dec 28, 2005 at 12:34:57AM +0900, Atsushi Nemoto wrote:
> 
>>Thanks for your comment.
>>
>>
>>>>>>>On Tue, 27 Dec 2005 16:38:54 +0300, Sergei Shtylylov <sshtylyov@ru.mvista.com> said:
>>
>>>>The problem is not just only spin_lock_init.  The parameters of
>>>>"console=" option (baudrate, etc.) are not passed for PCI UART.
>>
>>sshtylyov>     They are -- uart_add_one_port() calls console setup
>>sshtylyov> once more when registering PCI UART with serial code.
>>
>>Yes, you are right.  I missed the register_console call in
>>uart_add_one_port().  So your patch will fix the problem.  But I
>>suppose the spinlock should be initialized in serial_core.  How about
>>this?

> I think you're layering work-around on top of work-around on top of
> work-around here.

> I think the first thing you need to resolve is the way you're
> registering your ports.  Firstly, if you're solely PCI-based, there's

    No, this is not the case. The driver serves Toshiba TX39xx/49xx SOC UARTs 
as well as the compatible PCI UART (GOKU-S).

> no need to pre-register all the uart ports at driver initialisation
> time.  Consequently, there's no need to remove them all when you
> remove the module.

    Hm, then the driver would need to keep track of which ports it has 
registered and which it has not...

 > Secondly, the upshot of this is that you only call uart_add_one_port()
 > when you initialise a PCI card.

    Not the case as I've said; uart_add_one_port() should be called on driver 
startup anyway...

> This should result in a cleaner implementation, and the console will
> not be started until you detect the PCI card.

    It will still be started with the console_initcall() in this driver, if 
that code is not also deleted...

WBR, Sergei
