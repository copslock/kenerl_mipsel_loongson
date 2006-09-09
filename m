Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Sep 2006 17:56:37 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:9466 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038492AbWIIQ4f (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 9 Sep 2006 17:56:35 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 20DBF3F61; Sat,  9 Sep 2006 09:56:30 -0700 (PDT)
Message-ID: <4502F2C8.9020107@ru.mvista.com>
Date:	Sat, 09 Sep 2006 20:58:48 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Russell King <rmk@arm.linux.org.uk>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Rodolfo Giometti <giometti@linux.it>, linux-mips@linux-mips.org
Subject: Re: [PATCH] au1x00 serial real interrupt
References: <20060522165244.GA16223@enneenne.com> <44FD9587.3030708@ru.mvista.com> <4502ED14.6080506@ru.mvista.com> <20060909163907.GA24012@flint.arm.linux.org.uk>
In-Reply-To: <20060909163907.GA24012@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Russell King wrote:

>>   Well, after looking at drivers/serial/8250.c a bit more, I think this 
>>   may be even more simlified since that driver seems to treat the negative 
>>values as completely invalid anyway. IOW, we can just:

>>#define is_real_interrupt(irq)	1

>>   Russel, what do you think?

> That's Russell 8)

    I'm sorry. :-)

> Well, if you need IRQ0 to be real then redefining is_real_interrupt()
> is the correct way forward.

> However, Linus' policy is that IRQ0 shall be invalid at least on PCI
> systems, and architectures _should_ remap their real IRQ0 to some other
> number.

   Hm, given that NO_IRQ is #defined as -1 (when it's defined at all)...

>  Personally I don't like this.

    Hm, me neither but I can undestand the reasoning. 0 is the usual default
value of the PCI interrupt line register, meaning interrupt is unassigned.

 > Hence why I prefer to give people the option.

    Thanks for the explanation.
    Would be better probably to have that #define in 8250.c going after 
#include <asm/serial.h> but as this seems the first and only case of the 
override needed, it's good enough this way. :-)
    As for the PCI UARTs possibly plugged into Alchemy board, I really don't 
know... This macro has no provision to check for the UART type. So, skipping 
its invocation in 8250.c for UPIO_AU case might be a better (though not 
cleaner) solution...

WBR, Sergei
