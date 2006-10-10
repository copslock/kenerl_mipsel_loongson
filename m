Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 21:03:28 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:17480 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039906AbWJJUD1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Oct 2006 21:03:27 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 34D993ED5; Tue, 10 Oct 2006 13:03:24 -0700 (PDT)
Message-ID: <452BFC8D.8080903@ru.mvista.com>
Date:	Wed, 11 Oct 2006 00:03:25 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: Problem on au1100 USB device support
References: <20061010182747.GA14539@enneenne.com>
In-Reply-To: <20061010182747.GA14539@enneenne.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Rodolfo Giometti wrote:

> I'm just working on adding USB device support for au1100 CPUs.

> I wrote the driver (attached) but I cannot understand why when I
> insert the USB cable I see no activities on the bus... my USB sniffer
> says that the target port is "disconnected/reset".

> USB host controller is working so I suppose the clock is well routed
> to USB device controller too.

    What tree are you testing against? Asking because with the recent deletion 
of the "old" driver (arch/mips/au1000/common/usbdev.c), the setup code 
fiddling with SYS_PINFUNC and SYS_CLKSRC regs is gone...

> Someone may halp me in understing where the problem could be? My
> driver doesn't use DMA, as suggested by the CPU's data sheet... it
> could be wrong?

    Well, errata says you must use DMA for endpoint 0 on Au1100 revs before BE 
-- otherwise you'll be asking for trouble.

> Thanks in advance,

> Rodolfo

WBR, Sergei
