Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2003 14:41:33 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:31665
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225471AbTJXNla> convert rfc822-to-8bit; Fri, 24 Oct 2003 14:41:30 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id JAA18862;
	Fri, 24 Oct 2003 09:41:23 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id JAA17513;
	Fri, 24 Oct 2003 09:41:23 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Fri, 24 Oct 2003 09:41:23 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-mips@linux-mips.org
Subject: Re: configuring 2 ethernet ports
In-Reply-To: <20031024131838.GE12395@lug-owl.de>
Message-ID: <Pine.GSO.4.44.0310240931350.17395-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips


On Fri, 24 Oct 2003, Jan-Benedict Glaw wrote:

> On Fri, 2003-10-24 09:11:26 -0400, David Kesselring <dkesselr@mmc.atmel.com>
> wrote in message <Pine.GSO.4.44.0310240905590.17395-100000@ares.mmc.atmel.com>:
> > I am trying to setup a pci wlan nic on a Malta board. I've compiled the
> > driver into the kernel and I have setup
>
> Which brand of wlan card?

It's an internal card.

>
> > /etc/sysconfig/network-scripts/ifcfg-eth1. After boot, when I look at
> > /proc/pci it looks like the system detected the card fine but ifconfig
> > only shows eth0 (the builtin port). How is the pci id linked to a
> > particular driver? What else do I need to do? I've scoured google but have
>
> In 2.4.x, drivers tend to only have internal knowledge on which hardware
> they work. So you need to give some 'alias eth1 wlanmodulename' in your
> /etc/modules.conf file.
>
I am using 2.4. Why does eth1 need a modules.conf file and eth0 doesn't. I
do not have loadable modules configured for my kernel. Do I have to? I
don't even have a current modules.conf file.
I also checked /etc/sysconfig/hwconf. This has the pci listing for my card
but does not recognize the vendor or id. I did add an entry in the kernel
source pci_ids.h for my card.


> For 2.6.x, drivers export this table and (in theory), the hotplug
> scripts *can* load a driver just upon the card showing up. However,
> normally (for static network cards not handled by the hotplug API),
> you'll just use the exactly same line, but in /etc/modprobe.conf.
>
> MfG, JBG
>
> --
>    Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
>    "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
>     fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!
>    ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA));
>

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587
