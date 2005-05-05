Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2005 19:50:32 +0100 (BST)
Received: from smtp005.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.175.82]:58276
	"HELO smtp005.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8225011AbVEESuS>; Thu, 5 May 2005 19:50:18 +0100
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp005.bizmail.sc5.yahoo.com with SMTP; 5 May 2005 18:50:14 -0000
Subject: Re: USB hangs on AU1100
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Thiemo Seufer <ths@networkno.de>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <Pine.LNX.4.61L.0505051847410.21387@blysk.ds.pg.gda.pl>
References: <20050505155435.GA28227@enneenne.com>
	 <1115311361.1614.6.camel@localhost.localdomain>
	 <20050505172017.GC1628@hattusa.textio>
	 <Pine.LNX.4.61L.0505051847410.21387@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Thu, 05 May 2005 11:50:14 -0700
Message-Id: <1115319014.5820.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Thu, 2005-05-05 at 18:51 +0100, Maciej W. Rozycki wrote:
> On Thu, 5 May 2005, Thiemo Seufer wrote:
> 
> > > > I'm just using USB host support on a AU1100 developing board (DB1100
> > > > configuration) and i notice that CPU locks in function
> > > > au1xxx_start_hc():
> > > > 
> > > >         /* wait for reset complete (read register twice; see au1500 errata) */
> > > >         while (au_readl(USB_HOST_CONFIG),
> > > >                 !(au_readl(USB_HOST_CONFIG) & USBH_ENABLE_RD))
> > > >                 udelay(1000);
> > > > 
> > > > while waiting for USB controller to reset. I checked it out and I
> > > > discovered that register USB_HOST_CONFIG is fixed at value 0xe! So the
> > > > controller never reset...
> > > > 
> > > > Linux is 2.6.12-rc3 from CVS.
> > > > 
> > > > Someone knows whats wrong?
> > > 
> > > It sounds like this is a custom Au1100 based board? What 
> oot code are
> > > you running?  I'm guessing the SOC isn't setup correctly or you have a
> > > HW problem.
> > 
> > I wonder if the code works reliable. At least, a comma operator isn't a
> > sequence point, which means the compiler is free to change the execution
> > order.
> 
>  Good point -- even though the code is valid C, it's complete rubbish.  
> I'd suggest rewriting it to get something readable first.

Interesting. I hadn't looked at this chunk of code before.

Pete
