Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2005 18:51:45 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:53518 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225009AbVEERva>; Thu, 5 May 2005 18:51:30 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id CD06EF59C4; Thu,  5 May 2005 19:51:23 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25637-09; Thu,  5 May 2005 19:51:23 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 8AF31E1C7A; Thu,  5 May 2005 19:51:23 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j45HpReH016425;
	Thu, 5 May 2005 19:51:27 +0200
Date:	Thu, 5 May 2005 18:51:38 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: USB hangs on AU1100
In-Reply-To: <20050505172017.GC1628@hattusa.textio>
Message-ID: <Pine.LNX.4.61L.0505051847410.21387@blysk.ds.pg.gda.pl>
References: <20050505155435.GA28227@enneenne.com> <1115311361.1614.6.camel@localhost.localdomain>
 <20050505172017.GC1628@hattusa.textio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/871/Thu May  5 15:50:45 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 5 May 2005, Thiemo Seufer wrote:

> > > I'm just using USB host support on a AU1100 developing board (DB1100
> > > configuration) and i notice that CPU locks in function
> > > au1xxx_start_hc():
> > > 
> > >         /* wait for reset complete (read register twice; see au1500 errata) */
> > >         while (au_readl(USB_HOST_CONFIG),
> > >                 !(au_readl(USB_HOST_CONFIG) & USBH_ENABLE_RD))
> > >                 udelay(1000);
> > > 
> > > while waiting for USB controller to reset. I checked it out and I
> > > discovered that register USB_HOST_CONFIG is fixed at value 0xe! So the
> > > controller never reset...
> > > 
> > > Linux is 2.6.12-rc3 from CVS.
> > > 
> > > Someone knows whats wrong?
> > 
> > It sounds like this is a custom Au1100 based board? What boot code are
> > you running?  I'm guessing the SOC isn't setup correctly or you have a
> > HW problem.
> 
> I wonder if the code works reliable. At least, a comma operator isn't a
> sequence point, which means the compiler is free to change the execution
> order.

 Good point -- even though the code is valid C, it's complete rubbish.  
I'd suggest rewriting it to get something readable first.

  Maciej
