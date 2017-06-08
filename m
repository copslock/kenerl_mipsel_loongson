Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 09:31:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35909 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990519AbdFHHbUUByEs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 09:31:20 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 746CD6B1B13A;
        Thu,  8 Jun 2017 08:31:12 +0100 (IST)
Received: from [10.80.2.5] (10.80.2.5) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 8 Jun
 2017 08:31:14 +0100
Subject: Re: [PATCH 06/15] serial: 8250_ingenic: Parse earlycon options
To:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linux-clk@vger.kernel.org>
References: <20170607200439.24450-1-paul@crapouillou.net>
 <20170607200439.24450-7-paul@crapouillou.net>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <939febde-f962-6e2b-3657-a9b6c719dac1@imgtec.com>
Date:   Thu, 8 Jun 2017 09:31:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170607200439.24450-7-paul@crapouillou.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Hi Paul,

On 07.06.2017 22:04, Paul Cercueil wrote:
> In the devicetree, it is possible to specify the baudrate, parity,
> bits, flow of the early console, by passing a configuration string like
> this:
> 
> aliases {
> 	serial0 = &uart0;
> };
> 
> chosen {
> 	stdout-path = "serial0:57600n8";
> };
> 
> This, for instance, will configure the early console for a baudrate of
> 57600 bps, no parity, and 8 bits per baud.
> 
> This patches implements parsing of this configuration string in the
> 8250_ingenic driver, which previously just ignored it.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>   drivers/tty/serial/8250/8250_ingenic.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
> index b31b2ca552d1..59f3e632df49 100644
> --- a/drivers/tty/serial/8250/8250_ingenic.c
> +++ b/drivers/tty/serial/8250/8250_ingenic.c
> @@ -99,14 +99,24 @@ static int __init ingenic_early_console_setup(struct earlycon_device *dev,
>   					      const char *opt)
>   {
>   	struct uart_port *port = &dev->port;
> -	unsigned int baud, divisor;
> +	unsigned int divisor;
> +	int baud = 115200;
>   
>   	if (!dev->port.membase)
>   		return -ENODEV;
>   
> +	if (opt) {
> +		char options[256];
> +		unsigned int parity, bits, flow; /* unused for now */
> +
> +		strlcpy(options, opt, sizeof(options));

Rather than adding this extra local copy maybe you could instead:

-void uart_parse_options(char *options, int *baud, int *parity, int *bits,
+void uart_parse_options(const char *options, int *baud, int *parity, 
int *bits,

I cannot see any reason why uart_parse_options shouldn't take 'const 
char *options' as an argument.

> +		uart_parse_options(options, &baud, &parity, &bits, &flow);
> +	}
> +
>   	ingenic_early_console_setup_clock(dev);
>   
> -	baud = dev->baud ?: 115200;
> +	if (dev->baud)
> +		baud = dev->baud;
>   	divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * baud);
>   
>   	early_out(port, UART_IER, 0);
> 


Marcin
