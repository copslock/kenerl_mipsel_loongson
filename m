Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Apr 2004 00:25:10 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:60398 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225727AbUDTXZI>;
	Wed, 21 Apr 2004 00:25:08 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i3KNP0x6023838;
	Tue, 20 Apr 2004 16:25:00 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i3KNP0xo023836;
	Tue, 20 Apr 2004 16:25:00 -0700
Date: Tue, 20 Apr 2004 16:25:00 -0700
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [RFC] Separate time support for using cpu timer
Message-ID: <20040420162500.H22846@mvista.com>
References: <20040419180720.H14976@mvista.com> <Pine.LNX.4.55.0404201522220.28193@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.55.0404201522220.28193@jurand.ds.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Apr 20, 2004 at 03:41:32PM +0200
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Apr 20, 2004 at 03:41:32PM +0200, Maciej W. Rozycki wrote:
> On Mon, 19 Apr 2004, Jun Sun wrote:
> 
> > Solution
> > --------
> > 
> > All the boards that I am really concerned right now have cpu count/compare
> > registers.  I believe this will even more so in the future.
> > 
> > Therefore I like to propose a separate time support for systems that use
> > cpu timer as their system timer.
> > 
> > As you can see from the patch, the new code is much simpler.
> 
>  It makes it separate again -- more maintenance burden and a bigger
> opportunity to have functional divergence, sigh...
> 

Pretty much true for lots of improvement we made in the past a couple of
years .... :)

>  Additionally I don't think using the CP0 Count & Compare registers for
> the system timer is the way to go.  It's rather a way to escape when
> there's no other possibility.  A lot of systems have a reliable external
> timer interrupt source and using it actually would free the CP0 registers
> for other uses, like profiling or a programmable interval timer.
> 

I was rather neutral on this point until I started to add HRT/VST support to 
MIPS.  When adding such features you really just want one common timer code.
And the best choice for MIPS is cpu timer.

BTW, I plan to submit MIPS/HRT support based on the cpu-timer patch.  Hopefully 
this will catch more attention to the cpu timer patch....

Jun
