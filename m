Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Oct 2002 22:30:34 +0100 (CET)
Received: from gateway-1237.mvista.com ([12.44.186.158]:50426 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1121743AbSJ2Vad>;
	Tue, 29 Oct 2002 22:30:33 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g9TLUMF22618;
	Tue, 29 Oct 2002 13:30:22 -0800
Date: Tue, 29 Oct 2002 13:30:21 -0800
From: Jun Sun <jsun@mvista.com>
To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: Re: make xmenuconfig is broken
Message-ID: <20021029133021.D18288@mvista.com>
References: <20021029103545.K24266@mvista.com> <20021029192436.GA1344@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021029192436.GA1344@excalibur.cologne.de>; from karsten@excalibur.cologne.de on Tue, Oct 29, 2002 at 08:24:36PM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Oct 29, 2002 at 08:24:36PM +0100, Karsten Merker wrote:
> On Tue, Oct 29, 2002 at 10:35:45AM -0800, Jun Sun wrote:
> 
> > In addition, there are two SERIAL and SERIAL_CONSOLE related 
> > setting which should be in drivers/char/Config.in
> > instead of arch/mips/config-shared.in.
> > 
> > The following hack makes xmenuconfig work again, apparently breaking
> > decstation and IP22.  If nobody interested in those two machines
> > move the config, I will make an attempt to do so.
> 
> Why do you want to move the config? Is there any technical reason besides
> grouping the subarch specific character devices below the generic
> character devices instead of having a subarch specific menu ("DECstation
> character devices")?
>

My limited xconfig knowledge seems to tell me that moving to the generic
config file is the only way to make it work.  If you know a better way to fix
this, I will be happy to see it.

Jun
