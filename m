Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 19:37:42 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:3060 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225211AbTBEThl>;
	Wed, 5 Feb 2003 19:37:41 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA13592;
	Wed, 5 Feb 2003 11:37:00 -0800
Subject: Re: which kernel tree for Au1500?
From: Pete Popov <ppopov@mvista.com>
To: Tibor Polgar <tpolgar@freehandsystems.com>
Cc: Bruno Randolf <br1@4g-systems.de>, linux-mips@linux-mips.org
In-Reply-To: <3E414F48.8A6D5E74@freehandsystems.com>
References: <200302051234.01252.br1@4g-systems.de>
	 <3E414F48.8A6D5E74@freehandsystems.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1044473868.12615.48.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 05 Feb 2003 11:37:48 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, 2003-02-05 at 09:52, Tibor Polgar wrote:
> > we are developing a board based on the Au1500 SOC and we need to adapt the
> > linux kernel for it. since we need something working soon, we will
> > concentrate on the 2.4 version.
> 
> We are just finishing up an Au1500 project right now.  FCS was yesterday!!!  
> What we did was:
> 
> 
> 1) get from AMD the PB1500 development CD.  It has an "old" 2.4.17 kernel
> along with MontaVista's HardHat Linux toolkit that's cross compiled to work on
> x86 platforms.  If you have the $$$, MontaVista offers great support for the
> Au1500 based stuff.  Their toolkit is top notch.
> 
> 2) If you didn't already get from AMD a PB1500, do it.  The development
> platform is a very nice start and will save you may weeks of code testing
> headaches (and cause a few special ones).  At least for us here in USA, AMD
> "loaned" a board at no charge, i.e. a purchase order is signed but they never
> bill you.  We're projected to buy some 25,000 Au1500s per year from them so
> that probably helped.
> 
> 3) From there, look at the 2.4 latest CVS tree on linux-mips and Pete's own
> 36-bit mods in ftp://ftp.linux-mips.org/pub/linux/mips/people/ppopov/.   
> AMD/MontaVista also released a 2.4.18 "like" linux but its a bit rough.

This was not part of a MV release, or AMD "release" for that matter. I
think the rough port you got was from the working directory of an
engineer at AMD, before I had a chance to update linux-mips.org. MVL 3.0
does support all three Pb1x boards and after the install, you're ready
to go.

> 4) there are lots of other resources and headaches if you plan to cross
> compile X, gtk, etc.
> 
> 5) we are flash based and used the special mods Pete put in to the 2.4.17
> kernel to support zImage flash booting.  We're using YAMON as our monitor and
> with a few changes have a pretty nice setup - boot wise.

The zImage bits are not in linux-mips.org. I suppose I should create a
patch and put it in my directory; one of these days :)

Pete
