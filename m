Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2003 00:30:38 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:21486 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225207AbTDVXai>;
	Wed, 23 Apr 2003 00:30:38 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3MNUYZ31181;
	Tue, 22 Apr 2003 16:30:34 -0700
Date: Tue, 22 Apr 2003 16:30:34 -0700
From: Jun Sun <jsun@mvista.com>
To: Pete Popov <ppopov@mvista.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Jeff Baitis <baitisj@evolution.com>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>,
	Matthew Dharm <mdharm@momenco.com>, jsun@mvista.com
Subject: Re: Improperly handled case in arch/mips/au1000/common/time.c
Message-ID: <20030422163034.I28544@mvista.com>
References: <20030422125450.E10148@luca.pas.lab> <20030422155625.E28544@mvista.com> <20030423010727.A8410@linux-mips.org> <20030422161338.H28544@mvista.com> <1051053519.511.355.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1051053519.511.355.camel@zeus.mvista.com>; from ppopov@mvista.com on Tue, Apr 22, 2003 at 04:18:40PM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Apr 22, 2003 at 04:18:40PM -0700, Pete Popov wrote:
> On Tue, 2003-04-22 at 16:13, Jun Sun wrote:
> > On Wed, Apr 23, 2003 at 01:07:27AM +0200, Ralf Baechle wrote:
> > > On Tue, Apr 22, 2003 at 03:56:25PM -0700, Jun Sun wrote:
> > > 
> > > > I think this is a good example to show benefit of code sharing.
> > > > There is no good reason for au1x00 boards of not using new time.c.
> > > > You get to write less board code, fewer bugs and future proof.
> > > 
> > > There are just three configurations left using CONFIG_OLD_TIME_C:
> > > 
> > >  - EV64120 which I guess can be considered abandonded
> > >  - Momenco Ocelot (Matthew, feel like you have time to take care of
> > >    this?)
> > >  - RM200  (semi-maintained, my turn to fix it ...)
> > > 
> > > Seems like it's time to get rid of CONFIG_OLD_TIME_C.
> > >
> > 
> > If we were going to get rid of CONFIG_OLD_TIME_C, I propose
> > to make CONFIG_NEW_TIME_C as the default and therefore removed as well.
> > And make other boards using private time_init() functions to use 
> > CONFIG_HAVE_PRIVATE_TIME. 
> > 
> > ... in the spirit of encouraging code sharing. :)
> 
> How about just extending the time api so that "have private time" can
> just override some functions instead?  

Right now, the only function you _have_ to use is time_init().  All other
functions you can override (in board_timer_setup()).  And you can even
set up such that your own private routines are called first and in side which
you can call common routines.

New extension might be needed if some common features
are not accommondated by existing functions.  We can look at those 
features and see what is the way to abstract the support.

Jun
