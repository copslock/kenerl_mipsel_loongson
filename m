Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2007 13:09:12 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:36227 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28575927AbXJaNIq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 Oct 2007 13:08:46 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9VD8TIV015026;
	Wed, 31 Oct 2007 13:08:29 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9VD8SA6015025;
	Wed, 31 Oct 2007 13:08:28 GMT
Date:	Wed, 31 Oct 2007 13:08:28 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	mips kernel list <linux-mips@linux-mips.org>,
	Martin Michlmayr <tbm@cyrius.com>
Subject: Re: Preliminary patch for ip32 ttyS* device
Message-ID: <20071031130828.GE14187@linux-mips.org>
References: <20071030214015.050b7950.giuseppe@eppesuigoccas.homedns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071030214015.050b7950.giuseppe@eppesuigoccas.homedns.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 30, 2007 at 09:40:15PM +0100, Giuseppe Sacco wrote:

> this is a patch that make ttyS0 and ttyS1 work on my SGI O2. I don't know if it is enough good for a general use since I am also changing code drivers/serial/serial_core.c. Probably the best solution would be to use mapbase instead of membase in arch/mips/sgi-ip32/ip32-platform.c.

> diff --git a/arch/mips/sgi-ip32/ip32-platform.c b/arch/mips/sgi-ip32/ip32-platform.c
> index 7309e48..77febd6 100644
> --- a/arch/mips/sgi-ip32/ip32-platform.c
> +++ b/arch/mips/sgi-ip32/ip32-platform.c
> @@ -42,7 +42,7 @@ static struct platform_device uart8250_device = {
>  static int __init uart8250_init(void)
>  {
>  	uart8250_data[0].membase = (void __iomem *) &mace->isa.serial1;
> -	uart8250_data[1].membase = (void __iomem *) &mace->isa.serial1;
> +	uart8250_data[1].membase = (void __iomem *) &mace->isa.serial2;

The s/isa.serial1/isa.serial2/ part looks reasonable.

> diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
> index 3bb5d24..7caa877 100644
> --- a/drivers/serial/serial_core.c
> +++ b/drivers/serial/serial_core.c
> @@ -2455,6 +2455,8 @@ int uart_match_port(struct uart_port *port1, struct uart_port *port2)
>  	case UPIO_AU:
>  	case UPIO_TSI:
>  	case UPIO_DWAPB:
> +		if (port1->mapbase==0 && port2->mapbase==0)
> +			return (port1->membase == port2->membase);

This hack is only needed because ->mapbase is not initialized.

  Ralf
