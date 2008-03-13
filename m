Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2008 09:05:22 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:64486 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28581690AbYCMJEz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Mar 2008 09:04:55 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JZjMs-000321-01; Thu, 13 Mar 2008 10:04:54 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 8CFF7DE5B3; Thu, 13 Mar 2008 10:01:09 +0100 (CET)
Date:	Thu, 13 Mar 2008 10:01:09 +0100
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips@linux-mips.org,
	Florian Fainelli <florian@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Message-ID: <20080313090109.GB6012@alpha.franken.de>
References: <200803120221.25044.technoboy85@gmail.com> <200803120230.06420.technoboy85@gmail.com> <20080312111629.0fa15d9c@the-village.bc.nu> <200803130131.54570.technoboy85@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200803130131.54570.technoboy85@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Thu, Mar 13, 2008 at 01:31:54AM +0100, Matteo Croce wrote:
> Il Wednesday 12 March 2008 12:16:29 Alan Cox ha scritto:
> > On Wed, 12 Mar 2008 02:30:06 +0100
> > Matteo Croce <technoboy85@gmail.com> wrote:
> > 
> > > Ugly but we need it
> > 
> > Too ugly - NAK
> > 
> > However please send an explanation of the problem and lets find a nicer
> > way to do it or bury it in arch code.
> > 
> > 
> 
> This is my problem:
> 
> ffi_cmdset_000: DDisabling erae-ssuspend-progrm ddue to code bokeenness.
> cmdlinparrt partition arssing not avaiabll
> RedBoo ppartition parsngg not availabl
> NET: Rgiistered protocl  family 1
> NET: Regsteered protocol ammily 10
> IPv6 overIPPv4 tunnelingdriiver
> NET: Regsteered protocolfammily 17
> FS:: Mounted roo (ssquashfs filessttem) readonly.
> Freeing nuused kernel meorry: 120k freed
> 
> I'll try to find a nicer way to fix it

don't use AFE mode and treat it like a normal 16550 (PORT_16550A). You
could also try to use UPIO_MEM32. That's how my console driver
(different OS) works for AR7 without the hack to wait for LSR_TEMP and 
LSR_THRE.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
