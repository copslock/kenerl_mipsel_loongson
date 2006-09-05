Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Sep 2006 16:17:46 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:36992 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037585AbWIEPRo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Sep 2006 16:17:44 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id CB26B3EBE; Tue,  5 Sep 2006 08:17:17 -0700 (PDT)
Message-ID: <44FD9587.3030708@ru.mvista.com>
Date:	Tue, 05 Sep 2006 19:19:35 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Rodolfo Giometti <giometti@linux.it>, linux-mips@linux-mips.org,
	rmk+serial@arm.linux.org.uk
Subject: Re: [PATCH] au1x00 serial real interrupt
References: <20060522165244.GA16223@enneenne.com>
In-Reply-To: <20060522165244.GA16223@enneenne.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Rodolfo Giometti wrote:

> Here my patch to enable real interrupts management for the au1x00
> CPUs.

> ------------------------------------------------------------------------
> 
> diff --git a/include/asm-mips/serial.h b/include/asm-mips/serial.h
> index 7b23664..0197062 100644
> --- a/include/asm-mips/serial.h
> +++ b/include/asm-mips/serial.h
> @@ -11,6 +11,14 @@
>  
>  #include <linux/config.h>
>  
> +#ifdef CONFIG_SOC_AU1X00
> +/*
> + * We have to redefine "is_real_interrupt()" for Au1x00 CPUs...
> + */
> +#undef is_real_interrupt
> +#define is_real_interrupt(irq)	((irq) != ~0)
> +#endif
> +
>  /*
>   * This assumes you have a 1.8432 MHz clock for your UART.
>   *

    Ralf, how about this patch? Can it be applied, at least 3 months after 
posting? Alchemy UART0 uses IRQ0 and 0 is treated as "no IRQ" by 
drivers/serial/8250.c which says the macro should be redefined in 
<asm/serial.h> if needed.

WBR, Sergei
