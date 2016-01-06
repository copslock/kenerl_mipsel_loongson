Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jan 2016 23:00:54 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:55112 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010011AbcAFWAwcJw1w convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Jan 2016 23:00:52 +0100
Received: from CHN-SV-EXMX01.mchp-main.com ([fe80::453e:263d:be10:ebe8]) by
 CHN-SV-EXCH01.mchp-main.com ([fe80::9840:ffdf:ec5:1335%29]) with mapi id
 14.03.0181.006; Wed, 6 Jan 2016 15:00:44 -0700
From:   <Paul.Thacker@microchip.com>
To:     <gnomes@lxorguk.ukuu.org.uk>, <Joshua.Henderson@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, <Andrei.Pistirica@microchip.com>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>, <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 10/14] serial: pic32_uart: Add PIC32 UART driver
Thread-Topic: [PATCH v2 10/14] serial: pic32_uart: Add PIC32 UART driver
Thread-Index: AQHRNsCME92lzOY7V0e3fYiKG2XSEA==
Date:   Wed, 6 Jan 2016 22:00:43 +0000
Message-ID: <F2D704DDA6AE8B4A87FF87509480F4A449E46187@CHN-SV-EXMX01.mchp-main.com>
References: <1450133093-7053-1-git-send-email-joshua.henderson@microchip.com>
        <1450133093-7053-11-git-send-email-joshua.henderson@microchip.com>
 <20160105204322.2dc5ab3f@lxorguk.ukuu.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.215.90]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Paul.Thacker@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Paul.Thacker@microchip.com
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

On 01/05/2016 03:50 PM, One Thousand Gnomes wrote:
>
>> +#define PIC32_SDEV_NAME		"ttyS"
>> +#define PIC32_SDEV_MAJOR	TTY_MAJOR
>> +#define PIC32_SDEV_MINOR	64
>
> No. Same goes for you as every one of the forty other people a year who
> try and claim their console is ttyS. If it's not an 8250 it isn't.
>
> ttyS is the 8250, use dynamic major and minor and a different name.

Ok. Is there a naming convention documented anywhere? How about ttyPIC?

>
>
>> +/* serial core request to change current uart setting */
>> +static void pic32_uart_set_termios(struct uart_port *port,
>> +				   struct ktermios *new,
>> +				   struct ktermios *old)
>> +{
>
> You need to clear any termios features requested but not supported. In
> your case that appears to be CMSPAR, as you don't seem to support
> mark/space parity.

Ack.

>
> Similarly if you only support 8N1 or 7E1/7O1 you need to force the CSIZE
> bits to match what you ended up setting the UART to do.

Ack.

>
>> +	/* update baud */
>> +	baud = uart_get_baud_rate(port, new, old, 0, port->uartclk / 16);
>> +	quot = uart_get_divisor(port, baud) - 1;
>> +	pic32_uart_write(quot, sport, PIC32_UART_BRG);
>> +	uart_update_timeout(port, new->c_cflag, baud);
>
> See the 8250 driver for an example: you probably need to write back the
> actual rate you got.

Ack.

>
>> +/* serial core request to release uart iomem */
>> +static void pic32_uart_release_port(struct uart_port *port)
>> +{
>> +	struct platform_device *pdev = to_platform_device(port->dev);
>> +	struct resource *res_mem;
>> +	unsigned int res_size;
>
> resource_size_t for resources. Or you could just avoid the pointless
> variable in the first place 8)

Pointless variable removed.

>
> Other oddments - things like kasprintf() returns should be checked

Ack.

>
>
> Alan

Thanks,
Paul
