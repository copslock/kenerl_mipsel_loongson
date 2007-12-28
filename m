Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Dec 2007 12:13:40 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:4636 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20024574AbXL1MNb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Dec 2007 12:13:31 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id A28AD3EC9; Fri, 28 Dec 2007 04:12:56 -0800 (PST)
Message-ID: <4774E865.2000608@ru.mvista.com>
Date:	Fri, 28 Dec 2007 15:13:25 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
References: <200712271919.23577.technoboy85@gmail.com> <200712271927.06146.technoboy85@gmail.com>
In-Reply-To: <200712271927.06146.technoboy85@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Matteo Croce wrote:

> Signed-off-by: Matteo Croce <technoboy85@gmail.com>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> Signed-off-by: Felix Fietkau <nbd@openwrt.org>
> Signed-off-by: Nicolas Thill <nico@openwrt.org>

> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index f94109c..94253b7 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
[...]
> @@ -2453,7 +2460,11 @@ static void serial8250_console_putchar(struct uart_port *port, int ch)
>  {
>  	struct uart_8250_port *up = (struct uart_8250_port *)port;
>  
> +#ifdef CONFIG_AR7

    No board specific #ifdef's here please. You should use the driver's bug 
mechanism for this.

> +	wait_for_xmitr(up, BOTH_EMPTY);
> +#else
>  	wait_for_xmitr(up, UART_LSR_THRE);
> +#endif
>  	serial_out(up, UART_TX, ch);
>  }
>  
> diff --git a/include/linux/serialP.h b/include/linux/serialP.h
> index e811a61..cf71de9 100644
> --- a/include/linux/serialP.h
> +++ b/include/linux/serialP.h
> @@ -135,6 +135,10 @@ struct rs_multiport_struct {
>   * the interrupt line _up_ instead of down, so if we register the IRQ
>   * while the UART is in that state, we die in an IRQ storm. */
>  #define ALPHA_KLUDGE_MCR (UART_MCR_OUT2)
> +#elif defined(CONFIG_AR7)
> +/* This is how it is set up by bootloader... */
> +#define ALPHA_KLUDGE_MCR (UART_MCR_OUT2 | UART_MCR_OUT1 \
> +			| UART_MCR_RTS | UART_MCR_DTR)

    I don't think you should load the driver with forced RTS and DTR.

>  #else
>  #define ALPHA_KLUDGE_MCR 0
>  #endif
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 9963f81..10af5a2 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -40,6 +40,7 @@
>  #define PORT_NS16550A	14
>  #define PORT_XSCALE	15
>  #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
> +#define PORT_AR7	16

    Obviously, this should have been 16. :-)

WBR, Sergei
