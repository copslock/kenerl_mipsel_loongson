Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Mar 2003 03:48:28 +0000 (GMT)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:62126 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225215AbTCADs2>;
	Sat, 1 Mar 2003 03:48:28 +0000
Received: (qmail 21075 invoked by uid 6180); 1 Mar 2003 03:48:20 -0000
Date: Fri, 28 Feb 2003 19:48:20 -0800
From: Jeff Baitis <baitisj@evolution.com>
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: CardBus on DBAu1500
Message-ID: <20030228194820.Z20129@luca.pas.lab>
Reply-To: baitisj@evolution.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Hey Pete and others!

I'm finally working on CardBus support on the DBAu1500. Just got acquainted
with PCI today. :)

I decided that the first step is to plug in a PCI->PCI bridge, and try to see
if it would work, which it did not. After winding around inside of the kernel,
I finally arrived in arch/mips/au1000/db1x00/pci_ops.c:

Inside of config_access(unsigned char access_type, struct pci_dev *dev,
unsigned char where, u32 * data), on line 97, a little surprise:

    if (bus != 0) {
        *data = 0xffffffff;
        return -1;
    }

At this point, I concluded that I cannot traverse a PCI-PCI or CardBus bridge,
since any devices behind the bridge will require Type 1 Configuration Cycles,
and it seems that only Type 0 is currently supported.

I assume that I should add code to handle the case where I need to generate
Type 1 Configuration Cycles inside of config_access. Pete, since you authored
this code, I thought I'd quickly run this by you to make sure that I'm on
track.

Thanks for your suggestions!

-Jeff


On Tue, Feb 25, 2003 at 02:05:43PM -0800, Pete Popov wrote:
> On Tue, 2003-02-25 at 13:54, Jeff Baitis wrote:
> > Yes, the DBAu1500 board does not have CardBus support. We want to support
> > 802.11A/G, so at the moment I have a 3.3V PCI card with a Texas Instruments
> > 1510 CardBus bridge. A lot of modern wireless cards are CardBus-only, so that's
> > why we have decided to incorporate the TI bridge into our boards.
> 
> Ah, yes, that's true.  Just FYI, I had to debug a cardbus problem months
> ago on a different architecture, so I did it on the Pb1500 instead. It
> was a pci-cardbus adapter and I did get it to work,eventually, with a
> cardbus wireless card. Unfortunately I didn't have time to clean it up
> and submit it anywhere, internally or externally, and the bits died at
> some point. 
> 
> So what you're trying to do is not hopeless but it will require some
> debugging :)
> 
> Pete
> 
> > If someone out there has some notes or tips concerning getting PCMCIA working
> > under this architecture, I would greatly appreciate the information.
> > 
> > Take care, and thanks again!
> > 
> > -Jeff
> > 
> > 

-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
