Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2007 13:15:19 +0000 (GMT)
Received: from host187-206-dynamic.8-87-r.retail.telecomitalia.it ([87.8.206.187]:5506
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20029976AbXKENPK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Nov 2007 13:15:10 +0000
Received: from 89-96-243-184.ip14.fastwebnet.it ([89.96.243.184] helo=[192.168.215.30])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1Ip1nF-00012L-AU
	for linux-mips@linux-mips.org; Mon, 05 Nov 2007 14:15:07 +0100
Subject: Re: 2.6.24-rc1 does not boot on SGI
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <20071029150625.GB4165@linux-mips.org>
References: <1193468825.7474.6.camel@scarafaggio>
	 <20071029.000713.59464443.anemo@mba.ocn.ne.jp>
	 <1193599031.14874.1.camel@scarafaggio>
	 <20071029150625.GB4165@linux-mips.org>
Content-Type: text/plain
Date:	Mon, 05 Nov 2007 14:15:51 +0100
Message-Id: <1194268551.4842.3.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Il giorno lun, 29/10/2007 alle 15.06 +0000, Ralf Baechle ha scritto:
> On Sun, Oct 28, 2007 at 08:17:11PM +0100, Giuseppe Sacco wrote:
> 
> > Nothing changed using this patch: the system does not boot. Currently I
> > suspect the reason is the change the IRQ handling because it is the main
> > change in arch/mips/sg-ip32.
> 
> All the patch was meant to is to renumber interrupts so interrupts 0 ... 7
> become available for use with cpu_irq.c.  Irq 7 is the cp0 compare interrupt
> which on IP32 is used as the clockevent device that is the source of
> timer interrupts.

The latest git update, gave a bootable 2.6.24-rc1 but now, while
booting, the system start looping and calling function print_irq_desc()
from kernel/irq/internals.h. I can only read "...count:...unhandled:..."
since the text scroll too quickly, but I will try to connect a serial
console in order to send here the complete message.

Bye,
Giuseppe
