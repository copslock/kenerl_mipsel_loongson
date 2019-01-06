Return-Path: <SRS0=CsrV=PO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5269C43387
	for <linux-mips@archiver.kernel.org>; Sun,  6 Jan 2019 20:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB772070C
	for <linux-mips@archiver.kernel.org>; Sun,  6 Jan 2019 20:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfAFUih (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 6 Jan 2019 15:38:37 -0500
Received: from nbd.name ([46.4.11.11]:35262 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfAFUih (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 6 Jan 2019 15:38:37 -0500
Subject: Re: [PATCH] serial: lantiq: Do not swap register read/writes
To:     Hauke Mehrtens <hauke@hauke-m.de>, gregkh@linuxfoundation.org
Cc:     linux-mips@linux-mips.org, linux-mips@vger.kernel.org,
        jslaby@suse.com, linux-serial@vger.kernel.org,
        songjun.wu@linux.intel.com
References: <20190106185037.18288-1-hauke@hauke-m.de>
From:   John Crispin <john@phrozen.org>
Message-ID: <b629a95a-9845-13e2-5ec5-110e5f71e36e@phrozen.org>
Date:   Sun, 6 Jan 2019 21:38:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190106185037.18288-1-hauke@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org


On 06/01/2019 19:50, Hauke Mehrtens wrote:
> The ltq_r32() and ltq_w32() macros use the __raw_readl() and
> __raw_writel() functions which do not swap the value to little endian.
> On the big endian vrx200 SoC the UART is operated in big endian IO mode,
> the readl() and write() functions convert the value to little endian
> first and then the driver does not work any more on this SoC.
> Currently the vrx200 SoC selects the CONFIG_SWAP_IO_SPACE option,
> without this option the serial driver would work, but PCI devices do not
> work any more.
>
> This patch makes the driver use the __raw_readl() and __raw_writel()
> functions which do not swap the endianness. On big endian system it is
> assumed that the device should be access in big endian IO mode and on a
> little endian system it would be access in little endian mode.
>
> Fixes: 89b8bd2082bb ("serial: lantiq: Use readl/writel instead of ltq_r32/ltq_w32")
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: John Crispin <john@phrozen.org>
> ---
>   drivers/tty/serial/lantiq.c | 36 +++++++++++++++++++-----------------
>   1 file changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index e052b69ceb98..9de9f0f239a1 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
> @@ -114,9 +114,9 @@ struct ltq_uart_port {
>   
>   static inline void asc_update_bits(u32 clear, u32 set, void __iomem *reg)
>   {
> -	u32 tmp = readl(reg);
> +	u32 tmp = __raw_readl(reg);
>   
> -	writel((tmp & ~clear) | set, reg);
> +	__raw_writel((tmp & ~clear) | set, reg);
>   }
>   
>   static inline struct
> @@ -144,7 +144,7 @@ lqasc_start_tx(struct uart_port *port)
>   static void
>   lqasc_stop_rx(struct uart_port *port)
>   {
> -	writel(ASCWHBSTATE_CLRREN, port->membase + LTQ_ASC_WHBSTATE);
> +	__raw_writel(ASCWHBSTATE_CLRREN, port->membase + LTQ_ASC_WHBSTATE);
>   }
>   
>   static int
> @@ -153,11 +153,12 @@ lqasc_rx_chars(struct uart_port *port)
>   	struct tty_port *tport = &port->state->port;
>   	unsigned int ch = 0, rsr = 0, fifocnt;
>   
> -	fifocnt = readl(port->membase + LTQ_ASC_FSTAT) & ASCFSTAT_RXFFLMASK;
> +	fifocnt = __raw_readl(port->membase + LTQ_ASC_FSTAT) &
> +		  ASCFSTAT_RXFFLMASK;
>   	while (fifocnt--) {
>   		u8 flag = TTY_NORMAL;
>   		ch = readb(port->membase + LTQ_ASC_RBUF);
> -		rsr = (readl(port->membase + LTQ_ASC_STATE)
> +		rsr = (__raw_readl(port->membase + LTQ_ASC_STATE)
>   			& ASCSTATE_ANY) | UART_DUMMY_UER_RX;
>   		tty_flip_buffer_push(tport);
>   		port->icount.rx++;
> @@ -217,7 +218,7 @@ lqasc_tx_chars(struct uart_port *port)
>   		return;
>   	}
>   
> -	while (((readl(port->membase + LTQ_ASC_FSTAT) &
> +	while (((__raw_readl(port->membase + LTQ_ASC_FSTAT) &
>   		ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF) != 0) {
>   		if (port->x_char) {
>   			writeb(port->x_char, port->membase + LTQ_ASC_TBUF);
> @@ -245,7 +246,7 @@ lqasc_tx_int(int irq, void *_port)
>   	unsigned long flags;
>   	struct uart_port *port = (struct uart_port *)_port;
>   	spin_lock_irqsave(&ltq_asc_lock, flags);
> -	writel(ASC_IRNCR_TIR, port->membase + LTQ_ASC_IRNCR);
> +	__raw_writel(ASC_IRNCR_TIR, port->membase + LTQ_ASC_IRNCR);
>   	spin_unlock_irqrestore(&ltq_asc_lock, flags);
>   	lqasc_start_tx(port);
>   	return IRQ_HANDLED;
> @@ -270,7 +271,7 @@ lqasc_rx_int(int irq, void *_port)
>   	unsigned long flags;
>   	struct uart_port *port = (struct uart_port *)_port;
>   	spin_lock_irqsave(&ltq_asc_lock, flags);
> -	writel(ASC_IRNCR_RIR, port->membase + LTQ_ASC_IRNCR);
> +	__raw_writel(ASC_IRNCR_RIR, port->membase + LTQ_ASC_IRNCR);
>   	lqasc_rx_chars(port);
>   	spin_unlock_irqrestore(&ltq_asc_lock, flags);
>   	return IRQ_HANDLED;
> @@ -280,7 +281,8 @@ static unsigned int
>   lqasc_tx_empty(struct uart_port *port)
>   {
>   	int status;
> -	status = readl(port->membase + LTQ_ASC_FSTAT) & ASCFSTAT_TXFFLMASK;
> +	status = __raw_readl(port->membase + LTQ_ASC_FSTAT) &
> +		 ASCFSTAT_TXFFLMASK;
>   	return status ? 0 : TIOCSER_TEMT;
>   }
>   
> @@ -313,12 +315,12 @@ lqasc_startup(struct uart_port *port)
>   	asc_update_bits(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
>   		port->membase + LTQ_ASC_CLC);
>   
> -	writel(0, port->membase + LTQ_ASC_PISEL);
> -	writel(
> +	__raw_writel(0, port->membase + LTQ_ASC_PISEL);
> +	__raw_writel(
>   		((TXFIFO_FL << ASCTXFCON_TXFITLOFF) & ASCTXFCON_TXFITLMASK) |
>   		ASCTXFCON_TXFEN | ASCTXFCON_TXFFLU,
>   		port->membase + LTQ_ASC_TXFCON);
> -	writel(
> +	__raw_writel(
>   		((RXFIFO_FL << ASCRXFCON_RXFITLOFF) & ASCRXFCON_RXFITLMASK)
>   		| ASCRXFCON_RXFEN | ASCRXFCON_RXFFLU,
>   		port->membase + LTQ_ASC_RXFCON);
> @@ -350,7 +352,7 @@ lqasc_startup(struct uart_port *port)
>   		goto err2;
>   	}
>   
> -	writel(ASC_IRNREN_RX | ASC_IRNREN_ERR | ASC_IRNREN_TX,
> +	__raw_writel(ASC_IRNREN_RX | ASC_IRNREN_ERR | ASC_IRNREN_TX,
>   		port->membase + LTQ_ASC_IRNREN);
>   	return 0;
>   
> @@ -369,7 +371,7 @@ lqasc_shutdown(struct uart_port *port)
>   	free_irq(ltq_port->rx_irq, port);
>   	free_irq(ltq_port->err_irq, port);
>   
> -	writel(0, port->membase + LTQ_ASC_CON);
> +	__raw_writel(0, port->membase + LTQ_ASC_CON);
>   	asc_update_bits(ASCRXFCON_RXFEN, ASCRXFCON_RXFFLU,
>   		port->membase + LTQ_ASC_RXFCON);
>   	asc_update_bits(ASCTXFCON_TXFEN, ASCTXFCON_TXFFLU,
> @@ -461,13 +463,13 @@ lqasc_set_termios(struct uart_port *port,
>   	asc_update_bits(ASCCON_BRS, 0, port->membase + LTQ_ASC_CON);
>   
>   	/* now we can write the new baudrate into the register */
> -	writel(divisor, port->membase + LTQ_ASC_BG);
> +	__raw_writel(divisor, port->membase + LTQ_ASC_BG);
>   
>   	/* turn the baudrate generator back on */
>   	asc_update_bits(0, ASCCON_R, port->membase + LTQ_ASC_CON);
>   
>   	/* enable rx */
> -	writel(ASCWHBSTATE_SETREN, port->membase + LTQ_ASC_WHBSTATE);
> +	__raw_writel(ASCWHBSTATE_SETREN, port->membase + LTQ_ASC_WHBSTATE);
>   
>   	spin_unlock_irqrestore(&ltq_asc_lock, flags);
>   
> @@ -578,7 +580,7 @@ lqasc_console_putchar(struct uart_port *port, int ch)
>   		return;
>   
>   	do {
> -		fifofree = (readl(port->membase + LTQ_ASC_FSTAT)
> +		fifofree = (__raw_readl(port->membase + LTQ_ASC_FSTAT)
>   			& ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF;
>   	} while (fifofree == 0);
>   	writeb(ch, port->membase + LTQ_ASC_TBUF);
