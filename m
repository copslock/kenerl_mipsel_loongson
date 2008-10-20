Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2008 22:18:32 +0100 (BST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32417 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S21945791AbYJTVSa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Oct 2008 22:18:30 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9KLHpJe020056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 20 Oct 2008 14:17:52 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m9KLHoSd018625;
	Mon, 20 Oct 2008 14:17:50 -0700
Date:	Mon, 20 Oct 2008 14:17:50 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, Tomaso.Paoletti@caviumnetworks.com
Subject: Re: [PATCH] serial: Initialize spinlocks in 8250 and don't clobber
 them.
Message-Id: <20081020141750.d0610586.akpm@linux-foundation.org>
In-Reply-To: <48F51114.2010105@caviumnetworks.com>
References: <48F51114.2010105@caviumnetworks.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Tue, 14 Oct 2008 14:37:24 -0700
David Daney <ddaney@caviumnetworks.com> wrote:

> Initialize spinlocks in 8250 and don't clobber them.

That's actually quite bad.  There's no reason why an all-zeroes pattern
for a spinlock_t correctly represents the unlocked state.  I guess we
got lucky on the architectures which use this code.

> Spinlock debugging fails in 8250.c because the lock fields in
> irq_lists are not initialized.  Initialize them.
> 
> In serial8250_isa_init_ports(), the port's lock is initialized.  We
> should not overwrite it.  Only copy in the fields we need.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
> ---
>  drivers/serial/8250.c |   19 +++++++++++++++++--
>  1 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index d4104a3..0688799 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -2494,6 +2494,9 @@ static void __init serial8250_isa_init_ports(void)
>  		return;
>  	first = 0;
>  
> +	for (i = 0; i < ARRAY_SIZE(irq_lists); i++)
> +		spin_lock_init(&irq_lists[i].lock);

OK..  But serial8250_isa_init_ports() has so many callsites that I'd
worry that we end up running this initialisation multiple times.  Say,
if the right combination of boot options is provided?  This is probably
a benign thing, but it's not desirable.

A simple "fix" would be

static void __init irq_lists_init(void)
{
	static unsigned long done;

	if (!test_and_set_bit(0, &done)) {
		int i;

		for (i = 0; i < ARRAY_SIZE(irq_lists); i++)
			spin_lock_init(&irq_lists[i].lock);
	}
}

A better fix would be to initialise all those spinlocks at compile
time.  But given the need to pass the address of each lock into each
lock's initialiser, that could be tricky.

>  	for (i = 0; i < nr_uarts; i++) {
>  		struct uart_8250_port *up = &serial8250_ports[i];
>  
> @@ -2699,12 +2702,24 @@ static struct uart_driver serial8250_reg = {
>   */
>  int __init early_serial_setup(struct uart_port *port)
>  {
> +	struct uart_port *p;
> +
>  	if (port->line >= ARRAY_SIZE(serial8250_ports))
>  		return -ENODEV;
>  
>  	serial8250_isa_init_ports();
> -	serial8250_ports[port->line].port	= *port;
> -	serial8250_ports[port->line].port.ops	= &serial8250_pops;
> +	p = &serial8250_ports[port->line].port;
> +	p->iobase       = port->iobase;
> +	p->membase      = port->membase;
> +	p->irq          = port->irq;
> +	p->uartclk      = port->uartclk;
> +	p->fifosize     = port->fifosize;
> +	p->regshift     = port->regshift;
> +	p->iotype       = port->iotype;
> +	p->flags        = port->flags;
> +	p->mapbase      = port->mapbase;
> +	p->private_data = port->private_data;
> +	p->ops		= &serial8250_pops;
>  	return 0;
>  }

Having to spell out each member like this is pretty nasty from a
maintainability point of view.  If new fields are added to uart_port,
we surely will forget to update this code.

But yes, copying a spinlock by value is quite wrong.  Perhaps we could
retain the struct assigment and then run spin_lock_init() to get the
spinlock into a sane state?
