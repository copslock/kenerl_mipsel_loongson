Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Feb 2005 22:45:14 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:59914 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224933AbVBCWo7>; Thu, 3 Feb 2005 22:44:59 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 8B364F597F; Thu,  3 Feb 2005 23:44:47 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02876-06; Thu,  3 Feb 2005 23:44:47 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 45AB8F5979; Thu,  3 Feb 2005 23:44:47 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j13Miq6N030621;
	Thu, 3 Feb 2005 23:44:52 +0100
Date:	Thu, 3 Feb 2005 22:45:06 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Guy Streeter <guy.streeter@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: NR_IRQS and possible irq values on malta
In-Reply-To: <52dd17640502031426660c7196@mail.gmail.com>
Message-ID: <Pine.LNX.4.61L.0502032239430.29325@blysk.ds.pg.gda.pl>
References: <52dd17640502031426660c7196@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/661/Tue Jan 11 02:44:13 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 3 Feb 2005, Guy Streeter wrote:

> In mips_pcibios_iack() the irq number is obtained like this:
> 
> 		irq = GT_READ(GT_PCI0_IACK_OFS);
> 		irq &= 0xff;
> 
> (for coreLV, but similarly for others). This value is used to index
> into an array of size NR_IRQS, which is set in mach-generic/irq.h to
> 128.
>  I realize that when things work right, the value of irq isn't likely
> to get that big, but it seems to me it should be masked down to 127 or
> the NR_IRQS value should be larger. I have no opinion which is the
> right thing to do.

 It looks like a problem in __do_IRQ() (in kernel/irq/handle.c) -- it 
should probably call "BUG_ON(irq >= NR_IRQS)".  MIPS-specific code doesn't 
care.

  Maciej
