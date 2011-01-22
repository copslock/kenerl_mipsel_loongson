Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jan 2011 15:31:48 +0100 (CET)
Received: from hall.aurel32.net ([88.191.126.93]:41790 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491865Ab1AVObp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 22 Jan 2011 15:31:45 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.69)
        (envelope-from <aurelien@aurel32.net>)
        id 1PgeVE-00018X-73; Sat, 22 Jan 2011 15:31:44 +0100
Date:   Sat, 22 Jan 2011 15:31:44 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: add CONFIG_VIRTUALIZATION for virtio support
Message-ID: <20110122143144.GA3960@hall.aurel32.net>
References: <1295349645-16805-1-git-send-email-aurelien@aurel32.net> <20110119143049.GA4820@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20110119143049.GA4820@lst.de>
X-Mailer: Mutt 1.5.18 (2008-05-17)
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

On Wed, Jan 19, 2011 at 03:30:49PM +0100, Christoph Hellwig wrote:
> On Tue, Jan 18, 2011 at 12:20:44PM +0100, Aurelien Jarno wrote:
> > Add CONFIG_VIRTUALIZATION to the MIPS architecture and include the
> > the virtio code there. Used to enable the virtio drivers under QEMU.
> > 
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> >  arch/mips/Kconfig |   16 ++++++++++++++++
> 
> > +menuconfig VIRTUALIZATION
> > +	bool "Virtualization"
> > +	default n
> > +	---help---
> > +	  Say Y here to get to see options for using your Linux host to run other
> > +	  operating systems inside virtual machines (guests).
> > +	  This option alone does not add any kernel code.
> > +
> > +	  If you say N, all options in this submenu will be skipped and disabled.
> 
> This item seems rather misleading as you're using virtio drivers as a
> guest.  I think the right fix is to just remove the VIRTUALIZATION
> dependency for the qemu drivers and just include them from
> drivers/Kconfig for all architectures.  There aren't a whole lot Linux
> architectures that don't have a qemu emulation these days.
> 

Pulling drivers/Kconfig from drivers may not be the best option either,
as it only pulls "PCI driver for virtio devices" and "Virtio balloon
driver", which actually doesn't really belong to drivers, but maybe to 
"Bus options (PCI etc.)" and "Processor type and features".

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
