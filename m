Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2003 02:14:27 +0000 (GMT)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:31926 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225251AbTCDCOZ>;
	Tue, 4 Mar 2003 02:14:25 +0000
Received: (qmail 6562 invoked by uid 6180); 4 Mar 2003 02:14:21 -0000
Date: Mon, 3 Mar 2003 18:14:21 -0800
From: Jeff Baitis <baitisj@evolution.com>
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: CardBus on DBAu1500
Message-ID: <20030303181421.C20129@luca.pas.lab>
Reply-To: baitisj@evolution.com
References: <20030228194820.Z20129@luca.pas.lab> <1046499358.12356.2.camel@adsl.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <1046499358.12356.2.camel@adsl.pacbell.net>; from ppopov@mvista.com on Fri, Feb 28, 2003 at 10:15:58PM -0800
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Pete and others:

Thanks! I can access CardBus-enabled cards... but only if I plug the CardBus
card into a PCI bridge device. 

For those who might be interested in hearing, here's my current status:

I tested the PCI->PCI bridge code by copying pb1500/pci_ops.c into
db1x00/pci_ops.c. It seemed to work. Great!

After noticing that yenta_socket driver still locked up, I plugged a PCI-PCI
bridge board in between the Au1500 dev board and the CardBus bridge. CardBus
didn't work quite right, so I checked the PCI configuration registers on all
devices on my PCI bus.

I noticed the PCI bridge device's SUBORDINATE_BUS value was set to 01, which
is completely incorrect. It should have been at *least* 11, given that
the CardBus bridge's SECONDARY_BUS register was set to 10. 

So, I used setpci to change the PCI bridge's SUBORDINATE_BUS to 1f. I started
the CardBus services, and it seems that everything worked with CardBus cards.
Eject, insert, and status all good -- and I can look at all the PCI
configuration registers on the CardBus card.

***

It seems like the issue with plugging in the CardBus bridge directly into
PCI bus 0 (no PCI-PCI bridge) has to do with 16-bit CardBus support.
I enabled debugging on yenta_socket, and here's some results. First, I present
information *without* the PCI bridge, and then *with* PCI bridge.


Without PCI bridge:

dmesg gives:

  Autoconfig PCI channel 0x8029fc38°°
    Scanning bus 00, I/O 0x00000300:0x00100000, Mem 0x40000000:0x44000000
    00:0c.0 Class 0104: 1103:0007 (rev 01)°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°                                                                
            I/O at 0x00000300 [size=0x8]°°                         
            I/O at 0x00000308 [size=0x4]
            I/O at 0x00000310 [size=0x8]
            I/O at 0x00000318 [size=0x4]
            I/O at 0x00000400 [size=0x100]
    00:0d.0 Class 0607: 104c:ac56°°°°°°°°°                         
            Mem at 0x40000000 [size=0x1000]                        
            Mem unavailable -- skipping°°°°                        
            I/O at 0x00000500 [size=0x4]                           
            Mem at 0x40001000 [size=0x1000]                        
            Mem at 0x40002000 [size=0x1000]                        
            Mem at 0x40003000 [size=0x1000]                        
  
lspci -v gives:
  
  00:0c.0 RAID bus controller: Triones Technologies, Inc.: Unknown device 0007
  (rev 01)
          Subsystem: Triones Technologies, Inc.: Unknown device 0001
          Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 1
          I/O ports at 0300 [size=8]
          I/O ports at 0308 [size=4]
          I/O ports at 0310 [size=8]
          I/O ports at 0318 [size=4]
          I/O ports at 0400 [size=256]
          Expansion ROM at <unassigned> [disabled] [size=128K]   
          Capabilities: [60] Power Management version 2          
  
  00:0d.0 CardBus bridge: Texas Instruments: Unknown device ac56 
          Subsystem: Unknown device 5678:1234                    
          Flags: bus master, medium devsel, latency 128, IRQ 1   
          Memory at 40000000 (32-bit, non-prefetchable) [size=4K]
          Bus: primary=00, secondary=05, subordinate=00, sec-latency=0      
          Memory window 0: 40001000-40002000 (prefetchable)      
          I/O window 0: 00000000-00000003                        
          I/O window 1: 00000000-00000003                        
          16-bit legacy interface ports at 0001                  


root@10.1.1.154:~# modprobe yenta_socket                       

  Linux Kernel Card Services 3.1.22
    options:  [pci] [cardbus]°°°°°°
  config_writel: c0112bd0 0044 00000000
  config_writel: c0112bd0 0010 40000000
  config_writew: c0112bd0 0004 0087°°°°
  config_writeb: c0112bd0 000c 08°°
  config_writeb: c0112bd0 000d a8
  config_writel: c0112bd0 0018 b0000500
  config_readw: c0112bd0 003e 0340°°°°°
  config_writew: c0112bd0 003e 0580
  exca_writeb: c0112bd0 001e 00°°°°
  exca_writeb: c0112bd0 0016 00
  cb_writel: c0112bd0 000c 00004000
  cb_writel: c0112bd0 0004 00000000
  config_readl: c0112bd0 001c 40001000
  config_readl: c0112bd0 0020 40002000
  config_readl: c0112bd0 0024 40003000
  config_readl: c0112bd0 0028 00000000
  config_writel: c0112bd0 0024 40400000
  config_writel: c0112bd0 0028 407fffff
  config_readl: c0112bd0 002c 00000000°
  config_readl: c0112bd0 0030 00000000
  config_writel: c0112bd0 002c 00004000
  config_writel: c0112bd0 0030 000040ff
  config_readl: c0112bd0 0034 00000000°
  config_readl: c0112bd0 0038 00000000
  config_writel: c0112bd0 0034 00004400
  config_writel: c0112bd0 0038 000044ff
  cb_readl: c0112bd0 0000 00000006°°°°°
  cb_writel: c0112bd0 0000 00000006
  exca_readb: c0112bd0 0004 00°°°°°
  exca_readb: c0112bd0 0003 00
  cb_readl: c0112bd0 0000 00000000
  cb_writel: c0112bd0 0000 00000000
  exca_readb: c0112bd0 0004 00°°°°°
  exca_readb: c0112bd0 0003 00
  cb_readl: c0112bd0 0000 00000000
  cb_writel: c0112bd0 0000 00000000
  exca_readb: c0112bd0 0004 00°°°°°
  exca_readb: c0112bd0 0003 00
  cb_readl: c0112bd0 0000 00000000
  cb_writel: c0112bd0 0000 00000000
  exca_readb: c0112bd0 0004 00°°°°°
  exca_readb: c0112bd0 0003 00
  cb_readl: c0112bd0 0000 00000000
  cb_writel: c0112bd0 0000 00000000
  exca_readb: c0112bd0 0004 00°°°°°
  exca_readb: c0112bd0 0003 00
  cb_readl: c0112bd0 0000 00000000
  cb_writel: c0112bd0 0000 00000000
  exca_readb: c0112bd0 0004 00°°°°°
  exca_readb: c0112bd0 0003 00
    ** following portion loops indefinitely **
  cb_readl: c0112bd0 0000 00000000
  cb_writel: c0112bd0 0000 00000000
  exca_readb: c0112bd0 0004 00°°°°°
  exca_readb: c0112bd0 0003 00

With PCI bridge:

  Autoconfig PCI channel 0x8029fc38°°
  Scanning bus 00, I/O 0x00000300:0x00100000, Mem 0x40000000:0x44000000
  00:0c.0 Class 0104: 1103:0007 (rev 01)°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
          I/O at 0x00000300 [size=0x8]°°
          I/O at 0x00000308 [size=0x4]
          I/O at 0x00000310 [size=0x8]
          I/O at 0x00000318 [size=0x4]
          I/O at 0x00000400 [size=0x100]
  00:0d.0 Class 0604: 1011:0022 (rev 02)
          Bridge: primary=00, secondary=01
  Scanning sub bus 01, I/O 0x00001000, Mem 0x40000000
  01:07.0 Class 0607: 104c:ac56°°°°°°°°°°°°°°°°°°°°°°
          Mem at 0x40000000 [size=0x1000]
          Mem unavailable -- skipping°°°°
          I/O at 0x00001000 [size=0x4]
          Mem at 0x40001000 [size=0x1000]
          Mem at 0x40002000 [size=0x1000]
          Mem at 0x40003000 [size=0x1000]
  Back to bus 00°°°°°°°°°°°°°°°°°°°°°°°°°

lspci -v gives:
  
  00:0c.0 RAID bus controller: Triones Technologies, Inc.: Unknown device 0007
  (rev 01)
          Subsystem: Triones Technologies, Inc.: Unknown device 0001
          Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 1
          I/O ports at 0300 [size=8]
          I/O ports at 0308 [size=4]
          I/O ports at 0310 [size=8]
          I/O ports at 0318 [size=4]
          I/O ports at 0400 [size=256]
          Expansion ROM at <unassigned> [disabled] [size=128K]
          Capabilities: [60] Power Management version 2
  
  00:0d.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 02)
  (prog-if 00 [Normal decode])
          Flags: bus master, medium devsel, latency 0
          Bus: primary=00, secondary=01, subordinate=1f, sec-latency=0
          I/O behind bridge: 00001000-00001fff     
          Memory behind bridge: 40000000-400fffff  
          Prefetchable memory behind bridge: 0000000000000000-0000000000000000
  
  01:07.0 CardBus bridge: Texas Instruments: Unknown device ac56
          Subsystem: Unknown device 5678:1234      
          Flags: bus master, medium devsel, latency 128, IRQ 255
          Memory at 40000000 (32-bit, non-prefetchable) [size=4K]
          Bus: primary=00, secondary=10, subordinate=00, sec-latency=0
          Memory window 0: 40001000-40002000 (prefetchable)
          I/O window 0: 00000000-00000003
          I/O window 1: 00000000-00000003
          16-bit legacy interface ports at 0001    

root@10.1.1.154:~# modprobe yenta_socket                       

  Linux Kernel Card Services 3.1.22
    options:  [pci] [cardbus]°°°°°°
  config_writel: c0112bd0 0044 00000000
  config_writel: c0112bd0 0010 40000000
  config_writew: c0112bd0 0004 0087°°°°
  config_writeb: c0112bd0 000c 08°°
  config_writeb: c0112bd0 000d a8
  config_writel: c0112bd0 0018 b0001000
  config_readw: c0112bd0 003e 0340°°°°°
  config_writew: c0112bd0 003e 0580
  exca_writeb: c0112bd0 001e 00°°°°
  exca_writeb: c0112bd0 0016 00
  cb_writel: c0112bd0 000c 00004000
  cb_writel: c0112bd0 0004 00000000
  config_readl: c0112bd0 001c 40001000
  config_readl: c0112bd0 0020 40002000
  config_readl: c0112bd0 0024 40003000
  config_readl: c0112bd0 0028 00000000
  config_writel: c0112bd0 0024 10000000
  config_writel: c0112bd0 0028 103fffff
  config_readl: c0112bd0 002c 00000000°
  config_readl: c0112bd0 0030 00000000
  config_writel: c0112bd0 002c 00004000
  config_writel: c0112bd0 0030 000040ff
  config_readl: c0112bd0 0034 00000000°
  config_readl: c0112bd0 0038 00000000
  config_writel: c0112bd0 0034 00004400
  config_writel: c0112bd0 0038 000044ff
  config_readw: c0112bd0 003e 05c0°°°°°
  cb_writel: c0112bd0 0000 ffffffff
  cb_writel: c0112bd0 0004 00000001
  exca_writeb: c0112bd0 0005 00°°°°
  warning: end_irq 60 did not enable (6)
  warning: end_irq 59 did not enable (6)
  warning: end_irq 58 did not enable (6)
  warning: end_irq 57 did not enable (6)
  warning: end_irq 55 did not enable (6)
  warning: end_irq 52 did not enable (6)
  warning: end_irq 48 did not enable (6)
  warning: end_irq 46 did not enable (6)
  warning: end_irq 45 did not enable (6)
  warning: end_irq 44 did not enable (6)
  warning: end_irq 43 did not enable (6)
  warning: end_irq 42 did not enable (6)
  warning: end_irq 41 did not enable (6)
  warning: end_irq 40 did not enable (6)
  warning: end_irq 39 did not enable (6)
  warning: end_irq 38 did not enable (6)
  warning: end_irq 31 did not enable (6)
  warning: end_irq 27 did not enable (6)
  warning: end_irq 18 did not enable (6)
  warning: end_irq 14 did not enable (6)
  warning: end_irq 5 did not enable (6)°
  warning: end_irq 4 did not enable (6)
  warning: end_irq 2 did not enable (6)
  warning: end_irq 1 did not enable (6)
  warning: end_irq 60 did not enable (16)
  warning: end_irq 59 did not enable (16)
  warning: end_irq 58 did not enable (16)
  warning: end_irq 57 did not enable (16)
  warning: end_irq 55 did not enable (16)
  warning: end_irq 52 did not enable (16)
  warning: end_irq 48 did not enable (16)
  warning: end_irq 46 did not enable (16)
  warning: end_irq 45 did not enable (16)
  warning: end_irq 44 did not enable (16)
  warning: end_irq 43 did not enable (16)
  warning: end_irq 42 did not enable (16)
  warning: end_irq 41 did not enable (16)
  warning: end_irq 40 did not enable (16)
  warning: end_irq 39 did not enable (16)
  warning: end_irq 38 did not enable (16)
  warning: end_irq 27 did not enable (16)
  warning: end_irq 18 did not enable (16)
  warning: end_irq 5 did not enable (16)°
  warning: end_irq 4 did not enable (16)
  warning: end_irq 2 did not enable (16)
  warning: end_irq 1 did not enable (16)
  exca_writeb: c0112bd0 0005 31°°°°°°°°°
  cb_writel: c0112bd0 000c 00000001
  cb_writel: c0112bd0 0000 ffffffff
  exca_writeb: c0112bd0 0005 91°°°°
  cb_writel: c0112bd0 000c 00000001
  cb_writel: c0112bd0 0000 ffffffff
  exca_writeb: c0112bd0 0005 a1°°°°
  cb_writel: c0112bd0 000c 00000001
  cb_writel: c0112bd0 0000 ffffffff
  exca_writeb: c0112bd0 0005 b1°°°°
  cb_writel: c0112bd0 000c 00000001
  cb_writel: c0112bd0 0000 ffffffff
  cb_writel: c0112bd0 0004 00000000
  exca_writeb: c0112bd0 0005 00°°°°
  config_writew: c0112bd0 003e 0540
  Yenta IRQ list 0000, PCI irq0°°°°
  cb_readl: c0112bd0 0008 30000020
  Socket status: 30000020°°°°°°°°°
  config_writel: c0112bd0 0044 00000000
  config_writel: c0112bd0 0010 40000000
  config_writew: c0112bd0 0004 0087°°°°
  config_writeb: c0112bd0 000c 08°°
  config_writeb: c0112bd0 000d a8
  config_writel: c0112bd0 0018 b0001000
  config_readw: c0112bd0 003e 0540°°°°°
  config_writew: c0112bd0 003e 0580
  exca_writeb: c0112bd0 001e 00°°°°
  exca_writeb: c0112bd0 0016 00
  cb_writel: c0112bd0 000c 00004000
  cb_readl: c0112bd0 0010 00000400°
  cb_writel: c0112bd0 0010 00000000
  config_readw: c0112bd0 003e 05c0°
  cb_readl: c0112bd0 0008 30000820
  exca_readb: c0112bd0 0003 00°°°°
  exca_writeb: c0112bd0 0003 00
  config_writew: c0112bd0 003e 0580
  cb_writel: c0112bd0 0000 ffffffff
  cb_writel: c0112bd0 0004 00000006
  exca_readb: c0112bd0 0006 00°°°°°
  exca_writew: c0112bd0 0008 0000
  exca_writew: c0112bd0 000a 0001
  exca_readb: c0112bd0 0007 00°°°
  exca_writeb: c0112bd0 0007 00
  exca_readb: c0112bd0 0006 00°
  exca_writew: c0112bd0 000c 0000
  exca_writew: c0112bd0 000e 0001
  exca_readb: c0112bd0 0007 00°°°
  exca_writeb: c0112bd0 0007 00
  exca_readb: c0112bd0 0006 00°
  exca_writeb: c0112bd0 0040 00
  exca_writew: c0112bd0 0010 0000
  exca_writew: c0112bd0 0012 0000
  exca_writew: c0112bd0 0014 0000
  ..... etc etc 
  
Thanks, all, for the information. I hope someone finds this useful!
I'm gonna get remote kgdb goin' here, so I can hopefully fix the obnoxious
infinite loop...

-Jeff


On Fri, Feb 28, 2003 at 10:15:58PM -0800, Pete Popov wrote:
> On Fri, 2003-02-28 at 19:48, Jeff Baitis wrote:
> > Hey Pete and others!
> > 
> > I'm finally working on CardBus support on the DBAu1500. Just got acquainted
> > with PCI today. :)
> > 
> > I decided that the first step is to plug in a PCI->PCI bridge, and try to see
> > if it would work, which it did not. After winding around inside of the kernel,
> > I finally arrived in arch/mips/au1000/db1x00/pci_ops.c:
> > 
> > Inside of config_access(unsigned char access_type, struct pci_dev *dev,
> > unsigned char where, u32 * data), on line 97, a little surprise:
> > 
> >     if (bus != 0) {
> >         *data = 0xffffffff;
> >         return -1;
> >     }
> > 
> > At this point, I concluded that I cannot traverse a PCI-PCI or CardBus bridge,
> > since any devices behind the bridge will require Type 1 Configuration Cycles,
> > and it seems that only Type 0 is currently supported.
> > 
> > I assume that I should add code to handle the case where I need to generate
> > Type 1 Configuration Cycles inside of config_access. Pete, since you authored
> > this code, I thought I'd quickly run this by you to make sure that I'm on
> > track.
> > 
> > Thanks for your suggestions!
> 
> Take a look at arch/mips/au1000/pb1500/pci_ops.c for type 1 config
> access. The patch was courtesy of David Gathright and apparently I
> missed adding it in the db1500. Actually, we need to combine that code
> because it's the same. Let me get through my eternal struggle of getting
> the 36 bit patch applied (with Ralf's help I think a modified patch
> should be ready this weekend) and then I'll worry about clean ups :)
> 
> Pete
> 
> 

-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
