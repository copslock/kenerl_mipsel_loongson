Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2008 17:46:53 +0000 (GMT)
Received: from [81.2.110.250] ([81.2.110.250]:5308 "EHLO lxorguk.ukuu.org.uk")
	by ftp.linux-mips.org with ESMTP id S23819380AbYKURqg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Nov 2008 17:46:36 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id mALHkhOK011212;
	Fri, 21 Nov 2008 17:46:43 GMT
Date:	Fri, 21 Nov 2008 17:46:42 +0000
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash
 interface.
Message-ID: <20081121174642.2fdaac4f@lxorguk.ukuu.org.uk>
In-Reply-To: <4926E467.9020305@ru.mvista.com>
References: <49261BE5.2010406@caviumnetworks.com>
	<4926E467.9020305@ru.mvista.com>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.12; x86_64-redhat-linux-gnu)
Organization: Red Hat UK Cyf., Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE, Y Deyrnas Gyfunol. Cofrestrwyd yng Nghymru a
 Lloegr o'r rhif cofrestru 3798903
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> > +                iowrite16(*(uint16_t *)buffer, data_addr);
> 
>     Not seeing the reason to use iowrite16() and not writew() as registers are 
> always memory mapped...

iomap uses iowrite/ioread, writew is for the older ioremap stuff. Mixing
them up is not guaranteed to work for all ports.

> > + * Get the status of the DMA engine. The results of this function
> > + * must emulate the BMDMA engine expected by libata.
> 
>     Ugh... At least the IDE core is not so retarded.

Nor is libata, but he is piggybacking on the SFF code hence this.

Alan
