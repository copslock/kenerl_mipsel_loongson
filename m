Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 01:15:17 +0000 (GMT)
Received: from zok.sgi.com ([IPv6:::ffff:204.94.215.101]:51594 "EHLO
	zok.sgi.com") by linux-mips.org with ESMTP id <S8225240AbTBEBPQ>;
	Wed, 5 Feb 2003 01:15:16 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h150MBKp012345;
	Tue, 4 Feb 2003 16:22:11 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id MAA29131; Wed, 5 Feb 2003 12:15:12 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h151EjMd029087;
	Wed, 5 Feb 2003 12:14:46 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h151EiJG029085;
	Wed, 5 Feb 2003 12:14:44 +1100
Date: Wed, 5 Feb 2003 12:14:44 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Jason Ormes <jormes@wideopenwest.com>
Cc: linux-mips@linux-mips.org
Subject: Re: kernel boot error.
Message-ID: <20030205011444.GL27302@pureza.melbourne.sgi.com>
References: <200302041841.10507.jormes@wideopenwest.com> <20030205004345.GI27302@pureza.melbourne.sgi.com> <200302041912.28491.jormes@wideopenwest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302041912.28491.jormes@wideopenwest.com>
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

On Tue, Feb 04, 2003 at 07:12:28PM -0600, Jason Ormes wrote:
> Its an ip27 origin 200 with what hinv -v reports as a 
> 
> adapter IOC3 Rev 1, (pci id 2)
>         controller multi function SuperIO
>         controller Ethernet Rev 1
> 
> I did a little searching online 
> anhttp://www.scd.ucar.edu/nets/docs/procs/SGI-100mbps/SGI-auto.htmld found a 
> lot of references to origins having problems with the autonegotiation timing 
> out to fast, but the only fix that I've found has to do with editing part of 
> the kernel.  here's a link to one that I found. 
> http://www.scd.ucar.edu/nets/docs/procs/SGI-100mbps/SGI-auto.html 
> 
> could this be part of the problem?

I doubt it.  This problem is a PCI bus issue.  I'm still
investigating... but it could be a multitude of things.
Have a look in mips/sgi-ip27/ip27-pci.c at all the functions
with "fixup" in their name.  Things like byte-swapping, configuring
IO addresses, etc.  I suspect we need something like this for
other cards.

Cheers,
Andrew
