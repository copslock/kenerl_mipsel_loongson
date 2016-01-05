Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 21:43:33 +0100 (CET)
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:42847 "EHLO
        lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009376AbcAEUn3GwKSF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jan 2016 21:43:29 +0100
Received: from localhost.localdomain (proxy [81.2.110.250])
        by lxorguk.ukuu.org.uk (8.15.2/8.14.1) with ESMTP id u05LG9SS018011;
        Tue, 5 Jan 2016 21:16:14 GMT
Date:   Tue, 5 Jan 2016 20:43:22 +0000
From:   One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 10/14] serial: pic32_uart: Add PIC32 UART driver
Message-ID: <20160105204322.2dc5ab3f@lxorguk.ukuu.org.uk>
In-Reply-To: <1450133093-7053-11-git-send-email-joshua.henderson@microchip.com>
References: <1450133093-7053-1-git-send-email-joshua.henderson@microchip.com>
        <1450133093-7053-11-git-send-email-joshua.henderson@microchip.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.29; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <gnomes@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnomes@lxorguk.ukuu.org.uk
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


> +#define PIC32_SDEV_NAME		"ttyS"
> +#define PIC32_SDEV_MAJOR	TTY_MAJOR
> +#define PIC32_SDEV_MINOR	64

No. Same goes for you as every one of the forty other people a year who
try and claim their console is ttyS. If it's not an 8250 it isn't.

ttyS is the 8250, use dynamic major and minor and a different name.


> +/* serial core request to change current uart setting */
> +static void pic32_uart_set_termios(struct uart_port *port,
> +				   struct ktermios *new,
> +				   struct ktermios *old)
> +{

You need to clear any termios features requested but not supported. In
your case that appears to be CMSPAR, as you don't seem to support
mark/space parity.

Similarly if you only support 8N1 or 7E1/7O1 you need to force the CSIZE
bits to match what you ended up setting the UART to do.

> +	/* update baud */
> +	baud = uart_get_baud_rate(port, new, old, 0, port->uartclk / 16);
> +	quot = uart_get_divisor(port, baud) - 1;
> +	pic32_uart_write(quot, sport, PIC32_UART_BRG);
> +	uart_update_timeout(port, new->c_cflag, baud);

See the 8250 driver for an example: you probably need to write back the
actual rate you got.

> +/* serial core request to release uart iomem */
> +static void pic32_uart_release_port(struct uart_port *port)
> +{
> +	struct platform_device *pdev = to_platform_device(port->dev);
> +	struct resource *res_mem;
> +	unsigned int res_size;

resource_size_t for resources. Or you could just avoid the pointless
variable in the first place 8)

Other oddments - things like kasprintf() returns should be checked


Alan
