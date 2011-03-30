Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2011 11:32:56 +0200 (CEST)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45893 "EHLO
        www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491063Ab1C3Jcw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2011 11:32:52 +0200
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by www.etchedpixels.co.uk (8.14.4/8.14.4) with ESMTP id p2U9XJvv009649;
        Wed, 30 Mar 2011 10:33:20 +0100
Date:   Wed, 30 Mar 2011 10:33:19 +0100
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Felix Fietkau <nbd@openwrt.org>, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH V5 04/10] MIPS: lantiq: add serial port support
Message-ID: <20110330103319.543eb2a6@lxorguk.ukuu.org.uk>
In-Reply-To: <1301470076-17279-5-git-send-email-blogic@openwrt.org>
References: <1301470076-17279-1-git-send-email-blogic@openwrt.org>
        <1301470076-17279-5-git-send-email-blogic@openwrt.org>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEWysKsSBQMIAwIZCwj///8wIhxoRDXH9QHCAAABeUlEQVQ4jaXTvW7DIBAAYCQTzz2hdq+rdg494ZmBeE5KYHZjm/d/hJ6NfzBJpp5kRb5PHJwvMPMk2L9As5Y9AmYRBL+HAyJKeOU5aHRhsAAvORQ+UEgAvgddj/lwAXndw2laEDqA4x6KEBhjYRCg9tBFCOuJFxg2OKegbWjbsRTk8PPhKPD7HcRxB7cqhgBRp9Dcqs+B8v4CQvFdqeot3Kov6hBUn0AJitrzY+sgUuiA8i0r7+B3AfqKcN6t8M6HtqQ+AOoELCikgQSbgabKaJW3kn5lBs47JSGDhhLKDUh1UMipwwinMYPTBuIBjEclSaGZUk9hDlTb5sUTYN2SFFQuPe4Gox1X0FZOufjgBiV1Vls7b+GvK3SU4wfmcGo9rPPQzgIabfj4TYQo15k3bTHX9RIw/kniir5YbtJF4jkFG+dsDK1IgE413zAthU/vR2HVMmFUPIHTvF6jWCpFaGw/A3qWgnbxpSm9MSmY5b3pM1gvNc/gQfwBsGwF0VCtxZgAAAAASUVORK5CYII=
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Wed, 30 Mar 2011 09:27:50 +0200
John Crispin <blogic@openwrt.org> wrote:

> This patch adds the driver for the 2 serial ports found inside the Lantiq SoC family

Several comments, and a NAK to the current version.

Looks like it just needs a bit of bringing up to current tty/serial
interface expectations.

> +static void
> +lqasc_start_tx(struct uart_port *port)
> +{
> +	unsigned long flags;
> +	local_irq_save(flags);
> +	lqasc_tx_chars(port);
> +	local_irq_restore(flags);
> +	return;
> +}

Shouldn't this be using locks ?
(note if the platorm is uniprocessor only then spin_lock_irqsave() turns
into local_irq_save())



> +static void
> +lqasc_rx_chars(struct uart_port *port)
> +{
> +	struct tty_struct *tty = port->state->port.tty;

tty ports are refcounted. Look how drivers use tty_port_tty_get() and
tty_kref_put(). Note that a tty can be NULL at this point and you need to
handle it


> +static irqreturn_t
> +lqasc_err_int(int irq, void *_port)
> +{
> +	struct uart_port *port = (struct uart_port *)_port;
> +	/* clear any pending interrupts */
> +	ltq_w32_mask(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
> +		ASCWHBSTATE_CLRROE, port->membase + LTQ_ASC_WHBSTATE);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t
> +lqasc_rx_int(int irq, void *_port)
> +{
> +	struct uart_port *port = (struct uart_port *)_port;
> +	ltq_w32(ASC_IRNCR_RIR, port->membase + LTQ_ASC_IRNCR);
> +	lqasc_rx_chars(port);
> +	return IRQ_HANDLED;
> +}

The interrupt handlers look like they need to hold the port lock as well ?


> +static void
> +lqasc_set_termios(struct uart_port *port,
> +	struct ktermios *new, struct ktermios *old)
> +{
> +	unsigned int cflag;
> +	unsigned int iflag;
> +	unsigned int divisor;
> +	unsigned int baud;
> +	unsigned int con = 0;
> +	unsigned long flags;
> +
> +	cflag = new->c_cflag;
> +	iflag = new->c_iflag;
> +
> +	switch (cflag & CSIZE) {
> +	case CS7:
> +		con = ASCCON_M_7ASYNC;
> +		break;
> +
> +	case CS5:
> +	case CS6:
> +	default:
> +		con = ASCCON_M_8ASYNC;

If you can't support a request (eg CS5/CS6 or CMSPAR etc) you need to
clear them from the requested settings - ie

	default:
		new->c_cflag &= ~ CSIZE;
		new->c_cflag |= CS8;
		con = ....
> +		break;
> +	}
> +
> +	if (cflag & CSTOPB)
> +		con |= ASCCON_STP;
> +
> +	if (cflag & PARENB) {
> +		if (!(cflag & PARODD))
> +			con &= ~ASCCON_ODD;
> +		else
> +			con |= ASCCON_ODD;
> +	}

CMSPAR ?

> +	local_irq_save(flags);

Again I'd expect locks not this.

> +
> +	/* set up CON */
> +	ltq_w32_mask(0, con, port->membase + LTQ_ASC_CON);
> +
> +	/* Set baud rate - take a divider of 2 into account */
> +	baud = uart_get_baud_rate(port, new, old, 0, port->uartclk / 16);
> +	divisor = uart_get_divisor(port, baud);
> +	divisor = divisor / 2 - 1;

Actual baud also wants writing back if not set to B0 (see 8250.c)


> +static struct console lqasc_console = {
> +	.name =		"ttyS",

ttyS is reserved for the 8250 ports

> +	.write =	lqasc_console_write,
> +	.device =	uart_console_device,
> +	.setup =	lqasc_console_setup,
> +	.flags =	CON_PRINTBUFFER,
> +	.index =	-1,
> +	.data =		&lqasc_reg,
> +};
> +
> +static int __init
> +lqasc_console_init(void)
> +{
> +	register_console(&lqasc_console);
> +	return 0;
> +}
> +console_initcall(lqasc_console_init);
> +
> +static struct uart_driver lqasc_reg = {
> +	.owner =	THIS_MODULE,
> +	.driver_name =	DRVNAME,
> +	.dev_name =	"ttyS",
> +	.major =	TTY_MAJOR,
> +	.minor =	64,

This is existing owned and reserved space - do a dynamic allocation and
use a new name.


Alan
