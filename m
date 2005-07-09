Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Jul 2005 22:20:06 +0100 (BST)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:27831 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8226409AbVGIVTu>;
	Sat, 9 Jul 2005 22:19:50 +0100
Received: from port-195-158-170-192.dynamic.qsc.de ([195.158.170.192] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1DrMkP-0002bS-00
	for linux-mips@linux-mips.org; Sat, 09 Jul 2005 23:20:29 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1DrMkP-0001Nw-DV
	for linux-mips@linux-mips.org; Sat, 09 Jul 2005 23:20:29 +0200
Date:	Sat, 9 Jul 2005 23:20:29 +0200
To:	linux-mips@linux-mips.org
Subject: Re: Current SGI Octane status
Message-ID: <20050709212029.GG1586@hattusa.textio>
References: <20050709093403.GB1586@hattusa.textio> <Pine.GSO.4.10.10507091833390.24862-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10507091833390.24862-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Stanislaw Skowronek wrote:
> > - IOC3 networking works, with 2MB/s maximum for a 30MB http transfer
> 
> This is strange. Ask Ralf.

Up to 2.5 Mb actually. Still well below wat it should be.

[snip]
> > - 'echo "foo" >/dev/fb0' kills the machine.
> 
> Oops.
> 
> I return -EINVAL in read and write on ImpactSR. Sick. Do you know where it
> fails, exactly?

Haven't had a closer look yet.


Thiemo
