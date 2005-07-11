Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2005 14:56:46 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:14615 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226463AbVGKN4a>; Mon, 11 Jul 2005 14:56:30 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6BDvJUX002838;
	Mon, 11 Jul 2005 14:57:19 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6BDvI4Z002837;
	Mon, 11 Jul 2005 14:57:18 +0100
Date:	Mon, 11 Jul 2005 14:57:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: Origin 200 Status
Message-ID: <20050711135718.GU2765@linux-mips.org>
References: <20050709205406.GF1586@hattusa.textio> <Pine.GSO.4.10.10507100808410.6614-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10507100808410.6614-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jul 10, 2005 at 08:13:56AM +0200, Stanislaw Skowronek wrote:

> > [4294678.019000] IOC3 part: [], serial: [] => class IP27 BaseIO
> 
> This is not really weird, the IOC3 on the IP27 board has no NICs. We'd
> have to trace the BRIDGE NICs or even HUB NICs to get the serials, so I
> decided that it's an overkill. Although it will be required for reliably
> detecting MENET (which has a serial# NIC on the BRIDGE).

Of course there's a NIC.  The driver has no special handling for IP27 and
is capable of reading the NICs on some machines at least.  That would be
a rather suprising ability if there was no NIC associated with that IOC3 ;-)

(A while ago I recall a few second hand Origins were being sold on eBay
with NICs removed ...)

> > [4294678.020000] ioc3_probe : request_irq fails for IRQ 0x4
> 
> This is weird. This means the keyboard will not be operational, and I wish
> somebody (Ralf) looks into this. The IOC3 on IP27 BaseIO is a dual-slot
> device (takes two IRQs, the INTA and INTA+2).

All information that I have says only INTA is being used for IP27.  It
will probably take a bit of testing.

I haven't yet had any complaints about keyboard and mouse being non-
functional on IP27 - even though my Origin has 4 keyboard and 4 mouse
ports ;-)

   Ralf
