Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2005 17:43:26 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:59267 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S3458461AbVKJRnF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Nov 2005 17:43:05 +0000
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id BF5C3C06E;
	Thu, 10 Nov 2005 18:44:25 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 6E3C91BC07F;
	Thu, 10 Nov 2005 18:44:30 +0100 (CET)
Received: from orionlinux.starfleet.com (cmb58-52.dial-up.arnes.si [153.5.49.52])
	by smtp.triera.net (Postfix) with ESMTP id 816DB1A18BD;
	Thu, 10 Nov 2005 18:44:30 +0100 (CET)
Subject: Re: smc91x support
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	pantelis.antoniou@gmail.com
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
In-Reply-To: <200511101737.09316.pantelis.antoniou@gmail.com>
References: <1131634331.18165.30.camel@localhost.localdomain>
	 <20051111.001543.93019156.anemo@mba.ocn.ne.jp>
	 <200511101737.09316.pantelis.antoniou@gmail.com>
Content-Type: text/plain
Organization: Ultra d.o.o.
Date:	Thu, 10 Nov 2005 18:44:30 +0100
Message-Id: <1131644670.1478.4.camel@orionlinux.starfleet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> > matej> Is there any solution to this?
> > 
> > I have similar problem on my several custom boards with SMC91C111.  I
> > see so many RX overrun, but I can not see why it happens.  Forcing to
> > 10Mbps/HalfDuplex reduced the overrun count (and works better than
> > 100Mbps), but it is not preferable, of course ...

How did you achieve this? By software or by using 10 Mbps switch?

> And yes performance is bad with this chip. 

Probably I'll try and switch it to 10 Mbps, because NFS is terrible
because it gets a lot of timeouts because of dropped packets.

> I'm not sure if DMA would
> help much, since the overrun occurs because the chip does not have
> enough internal buffers. I don't think that we can service the interrupts
> fast enough to prevent the overruns...

I found this mail from Nicolas on ARM mailing list:
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2005-October/031736.html

Maybe we could try DMA and see what happens.
Any hints how to try this, because I haven't worked with DDMA before?

BR,
Matej
