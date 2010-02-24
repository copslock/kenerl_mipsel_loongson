Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 23:06:25 +0100 (CET)
Received: from elvis.franken.de ([193.175.24.41]:47688 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492481Ab0BXWGV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2010 23:06:21 +0100
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1NkPN4-0008H5-00; Wed, 24 Feb 2010 23:06:18 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
        id 5BBF9C34E5; Wed, 24 Feb 2010 23:00:49 +0100 (CET)
Date:   Wed, 24 Feb 2010 23:00:49 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: RFC: [MIPS] BCM1480HT set mips_io_port_base
Message-ID: <20100224220049.GA20280@alpha.franken.de>
References: <201002241347.07685.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201002241347.07685.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Feb 24, 2010 at 01:47:07PM -0700, Bjorn Helgaas wrote:
> I don't see anywhere that BCM1480HT sets mips_io_port_base (but maybe
> I missed it).  We *do* set bcm1480ht_controller.io_map_base, so pci_iomap()
> should work, but without mips_io_port_base, I don't think inb() et al.
> will work.

there are two hoses on the BCM1480 one is a via the PCI host controller
the other one via the hypertransport. set_io_port_base() is an old hack
to get inX/outX drivers working. Drivers using in/out will only work for
devices on the PCI host controller and will be broken for devies on the
HT side. Your change will make the devices on the HT side working, but
break the one on the PCI bus. Either way isn't too nice, but at least
nobody had a problem with the current behaviour. So it might be better
to not apply your patch.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
