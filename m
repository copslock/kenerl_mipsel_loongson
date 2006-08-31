Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Aug 2006 08:23:57 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:48619 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038439AbWHaHXz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 31 Aug 2006 08:23:55 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id DD7F53EEA; Thu, 31 Aug 2006 00:23:47 -0700 (PDT)
Message-ID: <44F68EC7.5080205@ru.mvista.com>
Date:	Thu, 31 Aug 2006 11:24:55 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	Russell King <rmk@arm.linux.org.uk>,
	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-serial@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org,
	=?ISO-8859-1?Q?Thomas_K=F6ller?= <thomas@koeller.dyndns.org>
Subject: Re: [PATCH] RM9000 serial driver
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608300100.32836.thomas.koeller@baslerweb.com> <20060830121216.GA25699@flint.arm.linux.org.uk> <200608302328.47944.thomas.koeller@baslerweb.com>
In-Reply-To: <200608302328.47944.thomas.koeller@baslerweb.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Thomas Koeller wrote:

>>iotype is all about the access method used to access the registers of
>>the device, be it by byte or word, and it also takes account of any
>>variance in the addressing of the registers.

>>It does not refer to features or bugs in any particular implementation.

> That's what I assumed, too - it seemed obvious. And it seemed equally
> obvious that it is the port type that encodes the the implementation's
> peculiarities. Among these are the register offset mapping requirements,
> so I assumed these should depend on the port type as well.

    Different mapping requirements actually put the device beyond 8250 
compatibility, so it seems quite natural they're addressed by the different 
entity.
    RM9000 UART is, strictly speaking, *not* 8250 compatible and needs some 
trickery for the 8250 driver to support it (historically, Alchemy UARTs were 
driven by the distinct driver, au1x00_uart.c -- however, its code was for the 
most part copied over from 8250.c).

> Now Sergei strongly insist that it's the iotype that should be checked
> whenever to get to the hardware type. I still do not quite understand how
> that is supposed to work. If I have a PCI device, for example, then the
> iotype will always be either UPIO_MEM or UPIO_PORT, so how could I learn
> something about the hardware implementation by looking at these values?

    I think it's determined by the value of the programming interface register 
of the PCI device. The values 0 to 6 imply full backward compatibility to 8250 
WRT the addressing scheme, IIUC.

> Or is the assumption that devices on a standard bus will always be of
> a standard type?

    For the PCI bus, it is.

> Thomas

WBR, Sergei
