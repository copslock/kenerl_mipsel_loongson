Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2008 18:07:13 +0000 (GMT)
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57990 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S23819558AbYKUSHK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Nov 2008 18:07:10 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.14.2/8.14.2) with ESMTP id mALI7Lg5011602;
	Fri, 21 Nov 2008 18:07:21 GMT
Date:	Fri, 21 Nov 2008 18:07:21 +0000
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash
 interface.
Message-ID: <20081121180721.357f4c99@lxorguk.ukuu.org.uk>
In-Reply-To: <4926EF55.7080004@ru.mvista.com>
References: <49261BE5.2010406@caviumnetworks.com>
	<20081121102137.634616c5@lxorguk.ukuu.org.uk>
	<4926EA6A.7040704@caviumnetworks.com>
	<4926EF55.7080004@ru.mvista.com>
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
X-archive-position: 21371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> >> If you get a request for an odd length you should write an extra word
> >> containing the last byte and one other. See how the standard methods
> >> handle this.
> 
> > OK.
> 
>     I don't think you need to bother doing that with CF.

Look at it the other way around is the best thing to do given an odd
sized I/O (eg if a CF format ATAPI drive comes along) to crash the
machine.

> > Perhaps it would be better to fix the problem at the source.
> 
>     I don't think there's a problem there. The string versions of the 
> functions treat memory as a string of bytes.

Double checking the docs you are right. How dumb, but dumb or not that is
what it is specified to do.

> > Probably nothing.  I will try to sort it out.
> 
>     It's the need for the tasklet that seems doubtful to me...

I was wondering but assumed it was some kind of hardware feature where
the end of IRQ occurs too early to do some of the cleanup.
