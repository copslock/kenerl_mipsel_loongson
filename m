Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jun 2009 18:05:02 +0200 (CEST)
Received: from main.gmane.org ([80.91.229.2]:59309 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491958AbZFKQE5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Jun 2009 18:04:57 +0200
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MEjZa-0004VE-ME
	for linux-mips@linux-mips.org; Thu, 11 Jun 2009 12:40:02 +0000
Received: from woodchuck.wormnet.eu ([77.75.105.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Thu, 11 Jun 2009 12:40:02 +0000
Received: from alex by woodchuck.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Thu, 11 Jun 2009 12:40:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
To:	linux-mips@linux-mips.org
From:	Alexander Clouter <alex@digriz.org.uk>
Subject:  Re: [PATCH 8/8] 8250: add Texas Instruments AR7 internal UART
Date:	Thu, 11 Jun 2009 12:27:19 +0100
Message-ID:  <n967g6-i6b.ln1@woodchuck.wormnet.eu>
References:  <200906041622.47591.florian@openwrt.org> <20090604222020.GA14843@alpha.franken.de> <200906111028.41222.florian@openwrt.org> <20090611093022.GA14510@alpha.franken.de>
Mime-Version:  1.0
Content-Type:  text/plain; charset=ISO-8859-15
Content-Transfer-Encoding:  8bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: woodchuck.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-1-sparc64 (sparc64))
Cc:	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

In gmane.linux.ports.mips.general Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
>
> On Thu, Jun 11, 2009 at 10:28:39AM +0200, Florian Fainelli wrote:
>> Le Friday 05 June 2009 00:20:20 Thomas Bogendoerfer, vous avez écrit :
>> > On Thu, Jun 04, 2009 at 04:22:46PM +0200, Florian Fainelli wrote:
>> > > We discussed that in private, there are a couple of things
>> > > to fix in order to get 8250 working properly with TI AR7 HW.
>> > > If you can still merge that bit, this would ease future work, thanks !
>> >
>> > I still have a tree here, which works without any changes to the 8250
>> > serial driver on a TNETD7300 device.
>> 
>> Could you show me how you register the 8250 driver ? Without the 8250-specific 
> 
> static struct plat_serial8250_port uart0_data = {
>        .mapbase = AR7_REGS_UART0,
>        .irq = AR7_IRQ_UART0,
>        .regshift = 2,
>        .iotype = UPIO_MEM,
>        .flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP,
> };
> 
>        uart_port[0].type = PORT_16550A;
>        uart_port[0].line = 0;
>        uart_port[0].irq = AR7_IRQ_UART0;
>        uart_port[0].uartclk = ar7_bus_freq() / 2;
>        uart_port[0].iotype = UPIO_MEM;
>        uart_port[0].mapbase = AR7_REGS_UART0 + 3;
>        uart_port[0].membase = ioremap(uart_port[0].mapbase, 256);
>        uart_port[0].regshift = 2;
>        res = early_serial_setup(&uart_port[0]);
>        if (res)
>                return res;
> 
> 
> the +3 comes from the fact, that this machine is configured to run big
> endian.
>
Alternatively you could not use the byte ordering macro/functions as per 
the 'Byte Order' section in:

http://lwn.net/images/pdf/LDD3/ch11.pdf

Makes the code portable, understandable and...well neater.

Cheers

-- 
Alexander Clouter
.sigmonster says: Life is like a diaper -- short and loaded.
