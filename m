Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 16:50:05 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:60815 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133518AbWEDPty (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 16:49:54 +0100
Received: (qmail 27896 invoked from network); 4 May 2006 19:54:54 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 4 May 2006 19:54:54 -0000
Message-ID: <445A225F.7090300@ru.mvista.com>
Date:	Thu, 04 May 2006 19:48:47 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Rodolfo Giometti <giometti@linux.it>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] 8250_early console support for au1x00
References: <20060504134509.GE19913@gundam.enneenne.com> <445A114B.4040404@ru.mvista.com> <20060504152048.GG19913@gundam.enneenne.com>
In-Reply-To: <20060504152048.GG19913@gundam.enneenne.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Rodolfo Giometti wrote:
> On Thu, May 04, 2006 at 06:35:55PM +0400, Sergei Shtylyov wrote:

>>   The following 2 fragments are kind of contradictory:

> I see, but I decided to keep it different since the kernel message is:

>    Adding console on ttyS0 at MMIO 0x11100000 (options '115200')

> and setting it as:

>    Adding console on ttyS0 at AU 0x11100000 (options '115200')

> sounds bad to me. :)

    Yes. But the error msg emmitted by your patch would look this way, i.e. 
AU, not MMIO. No symmetry. :-)

>>And, as I said. there's not much sense in calling iomap() on Alchemy UART, 
>>UPIO_IOREMAP flag wasn't really needed...
> 
> 
> Mmm... to be «coherent» I think it should be done...

    Wouldn't hurt, just useless. So, I think no special checks are needed to 
avoid it. :-)

> Ciao,
> 
> Rodolfo

WBR, Sergei
