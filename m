Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2005 18:20:39 +0100 (BST)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:63623 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8225008AbVEERUY>;
	Thu, 5 May 2005 18:20:24 +0100
Received: from port-195-158-168-232.dynamic.qsc.de ([195.158.168.232] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1DTk1J-0005vj-00
	for linux-mips@linux-mips.org; Thu, 05 May 2005 19:20:17 +0200
Received: from ths by hattusa.textio with local (Exim 4.50)
	id 1DTk1J-00032D-9T
	for linux-mips@linux-mips.org; Thu, 05 May 2005 19:20:17 +0200
Date:	Thu, 5 May 2005 19:20:17 +0200
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: USB hangs on AU1100
Message-ID: <20050505172017.GC1628@hattusa.textio>
References: <20050505155435.GA28227@enneenne.com> <1115311361.1614.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115311361.1614.6.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Pete Popov wrote:
> On Thu, 2005-05-05 at 17:54 +0200, Rodolfo Giometti wrote:
> > Hello,
> > 
> > I'm just using USB host support on a AU1100 developing board (DB1100
> > configuration) and i notice that CPU locks in function
> > au1xxx_start_hc():
> > 
> >         /* wait for reset complete (read register twice; see au1500 errata) */
> >         while (au_readl(USB_HOST_CONFIG),
> >                 !(au_readl(USB_HOST_CONFIG) & USBH_ENABLE_RD))
> >                 udelay(1000);
> > 
> > while waiting for USB controller to reset. I checked it out and I
> > discovered that register USB_HOST_CONFIG is fixed at value 0xe! So the
> > controller never reset...
> > 
> > Linux is 2.6.12-rc3 from CVS.
> > 
> > Someone knows whats wrong?
> 
> It sounds like this is a custom Au1100 based board? What boot code are
> you running?  I'm guessing the SOC isn't setup correctly or you have a
> HW problem.

I wonder if the code works reliable. At least, a comma operator isn't a
sequence point, which means the compiler is free to change the execution
order.


Thiemo
