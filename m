Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Apr 2004 18:26:43 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:36857 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225837AbUDUR0m>;
	Wed, 21 Apr 2004 18:26:42 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i3LHQdx6032445;
	Wed, 21 Apr 2004 10:26:39 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i3LHQdZG032443;
	Wed, 21 Apr 2004 10:26:39 -0700
Date: Wed, 21 Apr 2004 10:26:39 -0700
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [RFC] Separate time support for using cpu timer
Message-ID: <20040421102639.G32072@mvista.com>
References: <20040419180720.H14976@mvista.com> <Pine.LNX.4.55.0404201522220.28193@jurand.ds.pg.gda.pl> <20040420162500.H22846@mvista.com> <Pine.LNX.4.55.0404211445470.28167@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.55.0404211445470.28167@jurand.ds.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Apr 21, 2004 at 03:19:45PM +0200
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Apr 21, 2004 at 03:19:45PM +0200, Maciej W. Rozycki wrote:
> On Tue, 20 Apr 2004, Jun Sun wrote:
> 
> > >  It makes it separate again -- more maintenance burden and a bigger
> > > opportunity to have functional divergence, sigh...
> > 
> > Pretty much true for lots of improvement we made in the past a couple of
> > years .... :)
> 
>  Hmm, s/improvement/hacks/, perhaps?
> 
> > >  Additionally I don't think using the CP0 Count & Compare registers for
> > > the system timer is the way to go.  It's rather a way to escape when
> > > there's no other possibility.  A lot of systems have a reliable external
> > > timer interrupt source and using it actually would free the CP0 registers
> > > for other uses, like profiling or a programmable interval timer.
> > 
> > I was rather neutral on this point until I started to add HRT/VST support to 
> > MIPS.  When adding such features you really just want one common timer code.
> > And the best choice for MIPS is cpu timer.
> 
>  Well, with the _hpt_ abstraction layer you have one common timer code,
> regardless of the actual timer hardware used.  If there's some
> functionality you miss there, we may discuss about possible solutions.
> 

Current high resolution timer code calls for two logic timers, one for
the old jiffy timer and one for intra-jiffy timer interrupt.

Even if you can extend hpt interface to accomondate this, each board
would still end up implementing a lot of complex code.

With cpu timer, however, we can "multiplex" the same timer to 
emulate both logical timers.  All boards using cpu timer can have HRT without 
any code change.

Jun
