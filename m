Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jun 2009 17:23:37 +0200 (CEST)
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:41378 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492180AbZFKPXb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Jun 2009 17:23:31 +0200
Received: from wmproxy1-g27.free.fr (wmproxy1-g27.free.fr [212.27.42.91])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 62FD92CD4D
	for <linux-mips@linux-mips.org>; Thu, 11 Jun 2009 11:23:51 +0200 (CEST)
Received: from wmproxy1-g27.free.fr (localhost [127.0.0.1])
	by wmproxy1-g27.free.fr (Postfix) with ESMTP id 4B9546351E;
	Thu, 11 Jun 2009 11:23:46 +0200 (CEST)
Received: from UNKNOWN (imp6-g19.priv.proxad.net [172.20.243.136])
	by wmproxy1-g27.free.fr (Postfix) with ESMTP id 5FF1663273;
	Thu, 11 Jun 2009 11:23:45 +0200 (CEST)
Received: by UNKNOWN (Postfix, from userid 0)
	id 5E3D37F2CF641; Thu, 11 Jun 2009 11:23:45 +0200 (CEST)
Received: from  ([62.210.107.40]) 
	by imp.free.fr (IMP) with HTTP 
	for <castet.matthieu@172.20.243.55>; Thu, 11 Jun 2009 11:23:45 +0200
Message-ID: <1244712225.4a30cd2154cdf@imp.free.fr>
Date:	Thu, 11 Jun 2009 11:23:45 +0200
From:	castet.matthieu@free.fr
To:	Florian Fainelli <florian@openwrt.org>
Cc:	matthieu castet <castet.matthieu@free.fr>, linville@tuxdriver.com,
	Michael Buesch <mb@bu3sch.de>, linux-mips@linux-mips.org,
	netdev@vger.kernel.org, Daniel Mueller <daniel@danm.de>
Subject: Re: [PATCH] bc47xx : fix ssb irq setup
References: <4A11DBD4.7070706@free.fr> <4A1ADBAE.6070101@free.fr> <200906110959.38132.florian@openwrt.org> <200906111009.15080.florian@openwrt.org>
In-Reply-To: <200906111009.15080.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 62.210.107.40
Return-Path: <castet.matthieu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: castet.matthieu@free.fr
Precedence: bulk
X-list: linux-mips

Quoting Florian Fainelli <florian@openwrt.org>:
> Le Thursday 11 June 2009 09:59:36 Florian Fainelli, vous avez écrit :
> > Hi Matthieu, Michael,
> >
> > Le Monday 25 May 2009 19:55:58 matthieu castet, vous avez écrit :
> > > Michael Buesch wrote:
> > > > On Tuesday 19 May 2009 00:06:12 matthieu castet wrote:
> > > >> Hi,
> > > >>
> > > >>
> > > >> [1] http://www.danm.de/files/src/bcm5365p/REPORTED_DEVICES
> > > >>
> > > >> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
> > > >
> > > > If this works on all devices, I'm OK with this. Please submit to
> > > > linville@tuxdriver.com You can add my ack.
> > >
> > > Well I have only a wl500gd.
> > > I have submit it on openwrt project in order to test in more devices.
> >
> > It makes the IPsec core work on my Netgear WGT634U and I did not see any
> > regression on a Linksys WRT54GS.
> >
> > Tested-by: Florian Fainelli <florian@openwrt.org>
>
> One minor thing, please remove the dump_irqs call, it is convenient for
> debugging to print the IRQ routing, but I find it a little too verbose for
> production. This can be a follow-up patch if you prefer not to respin it.

Well all x86 does something similar, with acpi dumping the pci interrupt Routing
Table even in production kernel.
But it can removed if people don't want it.


Matthieu
