Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jun 2009 18:18:44 +0200 (CEST)
Received: from woodchuck.wormnet.eu ([77.75.105.223]:52303 "EHLO
	woodchuck.wormnet.eu" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492023AbZFKQSI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Jun 2009 18:18:08 +0200
Received: by woodchuck.wormnet.eu (Postfix, from userid 1000)
	id 6B1CC38376F; Thu, 11 Jun 2009 13:41:39 +0100 (BST)
Date:	Thu, 11 Jun 2009 13:41:39 +0100
From:	Alexander Clouter <alex@digriz.org.uk>
To:	linux-serial@vger.kernel.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] 8250: add Texas Instruments AR7 internal UART
Message-ID: <20090611124139.GI2014@woodchuck>
References: <200906041622.47591.florian@openwrt.org> <20090604222020.GA14843@alpha.franken.de> <200906111028.41222.florian@openwrt.org> <20090611093022.GA14510@alpha.franken.de> <n967g6-i6b.ln1@woodchuck.wormnet.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n967g6-i6b.ln1@woodchuck.wormnet.eu>
Organization: diGriz
X-URL:	http://www.digriz.org.uk/
X-JabberID: alex@digriz.org.uk
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <alex@digriz.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

Hi,

* Alexander Clouter <alex@digriz.org.uk> [2009-06-11 12:27:19+0100]:
> 
> > static struct plat_serial8250_port uart0_data = {
> >        .mapbase = AR7_REGS_UART0,
> >        .irq = AR7_IRQ_UART0,
> >        .regshift = 2,
> >        .iotype = UPIO_MEM,
> >        .flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP,
> > };
> > 
> >        uart_port[0].type = PORT_16550A;
> >        uart_port[0].line = 0;
> >        uart_port[0].irq = AR7_IRQ_UART0;
> >        uart_port[0].uartclk = ar7_bus_freq() / 2;
> >        uart_port[0].iotype = UPIO_MEM;
> >        uart_port[0].mapbase = AR7_REGS_UART0 + 3;
> >        uart_port[0].membase = ioremap(uart_port[0].mapbase, 256);
> >        uart_port[0].regshift = 2;
> >        res = early_serial_setup(&uart_port[0]);
> >        if (res)
> >                return res;
> > 
> > 
> > the +3 comes from the fact, that this machine is configured to run big
> > endian.
> >
> Alternatively you could not use the byte ordering macro/functions as per 
> the 'Byte Order' section in:
> 
> http://lwn.net/images/pdf/LDD3/ch11.pdf
> 
> Makes the code portable, understandable and...well neater.
> 
Maybe not, scrap that :)

Cheers

-- 
Alexander Clouter
.sigmonster says: "MOKE DAT YIGARETTE"
                  		-- "The Last Coin", James P. Blaylock
