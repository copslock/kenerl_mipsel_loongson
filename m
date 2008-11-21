Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2008 17:50:00 +0000 (GMT)
Received: from [81.2.110.250] ([81.2.110.250]:6588 "EHLO lxorguk.ukuu.org.uk")
	by ftp.linux-mips.org with ESMTP id S23819411AbYKURts (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Nov 2008 17:49:48 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id mALHnjeD011258;
	Fri, 21 Nov 2008 17:49:45 GMT
Date:	Fri, 21 Nov 2008 17:49:44 +0000
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash
 interface.
Message-ID: <20081121174944.23a4a7d9@lxorguk.ukuu.org.uk>
In-Reply-To: <4926EA6A.7040704@caviumnetworks.com>
References: <49261BE5.2010406@caviumnetworks.com>
	<20081121102137.634616c5@lxorguk.ukuu.org.uk>
	<4926EA6A.7040704@caviumnetworks.com>
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
X-archive-position: 21370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> > Even if you wanted to do it this way you could just use arrays and lookup
> > tables as many other drivers do - ie
> > 
> > 	pio = dev->pio_mode - XFER_PIO_0;
> > 	t1 = data[pio];
> > 
> 
> The timing calculations are based on the CPU clock rate, It is difficult 
> to encapsulate that in a table.

The lookup part of the switch you can however. If you can use the
ata_timing interface then it will also do the clock adjusting for you and
has a FIT() macro that can be quite handy for clipping.

> It appears to be broken.  One would expect ioread16 and ioread16_rep to 
> do endian swapping in the same manner.  On MIPS they do not.  Perhaps it 
> would be better to fix the problem at the source.

I think the MIPS tree needs fixing then.


Alan
