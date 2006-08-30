Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Aug 2006 13:40:32 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:26317 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037655AbWH3Mka (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 30 Aug 2006 13:40:30 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id D8A7B3EE6; Wed, 30 Aug 2006 05:40:26 -0700 (PDT)
Message-ID: <44F5877E.2070300@ru.mvista.com>
Date:	Wed, 30 Aug 2006 16:41:34 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] 8250_early console support for au1x00 (again)
References: <20060504134509.GE19913@gundam.enneenne.com> <445A114B.4040404@ru.mvista.com> <20060504152048.GG19913@gundam.enneenne.com> <445A225F.7090300@ru.mvista.com> <20060504163301.GH19913@gundam.enneenne.com> <20060522205036.GB16223@enneenne.com> <44F302D5.8050809@ru.mvista.com> <20060830105312.GF27010@gundam.enneenne.com>
In-Reply-To: <20060830105312.GF27010@gundam.enneenne.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Rodolfo Giometti wrote:

>>   Sorry for follwing up 2 month ago, I just happen to stumble on some 

    I was going to type "3 months ago" since 3 months have apssed indeed. :-<

>>   issues addresses by these patches as well. I assume you haven't tried 
>>sending them to Russel King?

> Not yet, I just waiting for some comments. :)

    Now you have some at last. :-)

>>>+	case UPIO_MEM32:
>>>+	case UPIO_AU:
>>>+		return readl(port->membase + offset);

>>   NAK. readl() can't be used to read from Alchemy SOC peripherals because 
>>it'll break in BE mode.  Alchemy automagically handles byteswap for the SOC 
>>peripherals.

> Ok. I'm going to fix it by using au_readl() but in this case I have to
> add an ifdef with au1xxx include file. Can it be acceptable?

    I think so. But it's Russel who will decide. :-)

>>>+			(port->iotype == UPIO_MEM) ? "MMIO" : \
>>>+			(port->iotype == UPIO_AU)  ? "AU"   : "I/O port",
>>>+			(port->iotype == UPIO_MEM) || \
>>>+			(port->iotype == UPIO_AU) ? port->mapbase :
>>>			    (unsigned long) port->iobase);

>>   I'd simply map UPIO_AU to "MMIO" in the message because it's memory 
>>   mapped UART after all...

> Yes, but in the kernel command line we must supply "au"... That's why
> I used different string, so the user can verify whatever he/she passed
> to the kernel.

    I can also suggest something like "Au1xx0 MMIO"... :-)

>>>index 17839e7..9e27aee 100644
>>>--- a/drivers/serial/serial_core.c
>>>+++ b/drivers/serial/serial_core.c
>>>@@ -2367,6 +2367,7 @@ int uart_match_port(struct uart_port *po
>>>		return (port1->iobase == port2->iobase) &&
>>>		       (port1->hub6   == port2->hub6);
>>>	case UPIO_MEM:
>>>+	case UPIO_AU:

>>   Also needs cases for UPIO_MEM32 and UPIO_TSI.

> I just added the code for au1xxx. Why should I consider those cases
> also?

    It seems that you can remove this hunk altogether now -- Russel has 
accepted my patch adding cases for UPIO_MEM32, UPIO_AU and UPIO_TSI...

>>>-#ifdef CONFIG_SERIAL_8250_AU1X00
>>>	case UPIO_AU:
>>>-		__raw_writel(value, up->port.membase + offset);
>>>+		writel(value, up->port.membase + offset);
>>>		break;
>>>-#endif

>>   Ditto writel().

> Is __raw_writel() correct?

    It should be.

> Thanks for your suggestions.

> Ciao,

> Rodolfo

WBR, Sergei
