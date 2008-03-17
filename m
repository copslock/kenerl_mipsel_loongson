Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2008 08:05:42 +0000 (GMT)
Received: from host194-211-dynamic.20-79-r.retail.telecomitalia.it ([79.20.211.194]:4491
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S28599661AbYCQIFk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Mar 2008 08:05:40 +0000
Received: from router-wag54gp2 ([192.168.1.33] helo=[192.168.2.7])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1JbALY-0001GQ-EY; Mon, 17 Mar 2008 09:05:30 +0100
Subject: Re: Compiler error? [was: Re: new kernel oops in recent kernels]
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20080316233619.GA29511@alpha.franken.de>
References: <1205664563.3050.4.camel@localhost>
	 <1205699257.4159.14.camel@casa>  <20080316233619.GA29511@alpha.franken.de>
Content-Type: text/plain
Date:	Mon, 17 Mar 2008 09:05:42 +0100
Message-Id: <1205741142.3515.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi Thomas,

Il giorno lun, 17/03/2008 alle 00.36 +0100, Thomas Bogendoerfer ha
scritto:
> On Sun, Mar 16, 2008 at 09:27:37PM +0100, Giuseppe Sacco wrote:
> > the gcc I am using in versione 4.1.2. Any help is really appreciated.
> 
> 4.2.1 generates nearly the same (reasonable) code. The major difference
> between the version with printk and the version without is the size
> of the local stack. I guess this prevents killing of *cd.
> Could you try the hack below and tell me, if it helps ? This hack
> ensures, that the buffer given to the scsi driver is one cache
> line big (at least on R5k O2s). If this helps, there are more
> places to fix for non-coherent machines...
[...]

The patch you proposed, that use a larger buffer, does not seems to
trigger the bug.

Thanks,
Giuseppe
