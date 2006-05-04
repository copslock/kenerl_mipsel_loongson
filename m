Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 15:29:18 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:41709 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133769AbWEDO3D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 15:29:03 +0100
Received: (qmail 26685 invoked from network); 4 May 2006 18:34:03 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 4 May 2006 18:34:03 -0000
Message-ID: <445A0F65.8060803@ru.mvista.com>
Date:	Thu, 04 May 2006 18:27:49 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Rodolfo Giometti <giometti@linux.it>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Physical addresses fix for au1x00 serial driver
References: <20060504101112.GC19913@gundam.enneenne.com> <4459F72D.4010408@ru.mvista.com> <20060504132413.GD19913@gundam.enneenne.com> <20060504135837.GF19913@gundam.enneenne.com>
In-Reply-To: <20060504135837.GF19913@gundam.enneenne.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Rodolfo Giometti wrote:

>>>   This is not quite correct. The UARTs take up 1 MB of memory each.

> The patch:

>    diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
>    index 8365d5b..3473e7a 100644
>    --- a/drivers/serial/8250.c
>    +++ b/drivers/serial/8250.c
>    @@ -1935,8 +1935,10 @@ static int serial8250_request_std_resour
>     	int ret = 0;
>     
>     	switch (up->port.iotype) {
>    -	case UPIO_MEM:
>     	case UPIO_AU:
>    +		size = 0x100000;
>    +		/* fall thru */
>    +	case UPIO_MEM:
>     		if (!up->port.mapbase)
>     			break;

> I'll merge this patch with my previous one ASAP...

    Better just use my patch. There's no sense in calling ioremp() on UART 
addresses.

> Ciao,
> 
> Rodolfo

WBR, Sergei
