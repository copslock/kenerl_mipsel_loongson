Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 22:25:04 +0000 (GMT)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:20953 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225223AbTCMWZD>;
	Thu, 13 Mar 2003 22:25:03 +0000
Received: (qmail 21418 invoked by uid 6180); 13 Mar 2003 22:25:00 -0000
Date: Thu, 13 Mar 2003 14:25:00 -0800
From: Jeff Baitis <baitisj@evolution.com>
To: Dan Malek <dan@embeddededge.com>
Cc: Pete Popov <ppopov@mvista.com>, linux-mips@linux-mips.org,
	Hartvig Ekner <hartvig@ekner.info>
Subject: Re: arch/mips/au1000/common/irq.c
Message-ID: <20030313142500.B20129@luca.pas.lab>
Reply-To: baitisj@evolution.com
References: <20030313104704.V20129@luca.pas.lab> <3E70D306.5090608@embeddededge.com> <20030313141331.Y20129@luca.pas.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030313141331.Y20129@luca.pas.lab>; from baitisj@evolution.com on Thu, Mar 13, 2003 at 02:13:31PM -0800
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Hartvig's patch has solved my IRQ storm problems. Thank you all very much for
your attention!

Regards,

Jeff


On Thu, Mar 13, 2003 at 02:13:31PM -0800, Jeff Baitis wrote:
> Dan:
> 
> I just verified that I get an IRQ storm when I plug a 3.3-volt based SMC
> EPIC/100 network card into the PCI slot of the Au1500. Before I bring the
> interface up, I notice that the driver tries to allocate IRQ 1 (INTA). This is
> the same IRQ that the ill-fated CardBus bridge attempts to use. ;)
> 
> As soon as I bring the SMC interface up using ifconfig (and have the interface
> plugged into an active Ethernet network), the IRQ storm ensues.
> 
> I'll try Hartvig's patch, look over the irq.c levels, and see how everything
> fares.
> 
> Thanks all!
> 
> Regards,
> 
> Jeff
> 
> 
> On Thu, Mar 13, 2003 at 01:50:46PM -0500, Dan Malek wrote:
> > Jeff Baitis wrote:
> > 
> > > Pete:
> > > 
> > > I've got a question concerning irq.c. In intc0_req0_irqdispatch() (linux_2_4
> > > branch) on lines 545 thru 552, the code reads:
> > 
> > I'm hacking these functions to use 'clz' and for other updates, so
> > the code will be changing soon, anyway :-)  Comment on the next version :-)
> > 
> > Thanks.
> > 
> > 
> > 	-- Dan
> > 
> > 
> > 
> 
> -- 
>          Jeffrey Baitis - Associate Software Engineer
> 
>                     Evolution Robotics, Inc.
>                      130 West Union Street
>                        Pasadena CA 91103
> 
>  tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
> 
> 

-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
