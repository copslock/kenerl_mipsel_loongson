Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2003 00:18:15 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:16120 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225204AbTDVXSO>;
	Wed, 23 Apr 2003 00:18:14 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id QAA08293;
	Tue, 22 Apr 2003 16:18:12 -0700
Subject: Re: Improperly handled case in arch/mips/au1000/common/time.c
From: Pete Popov <ppopov@mvista.com>
To: Jun Sun <jsun@mvista.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Jeff Baitis <baitisj@evolution.com>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>,
	Matthew Dharm <mdharm@momenco.com>
In-Reply-To: <20030422161338.H28544@mvista.com>
References: <20030422125450.E10148@luca.pas.lab>
	 <20030422155625.E28544@mvista.com> <20030423010727.A8410@linux-mips.org>
	 <20030422161338.H28544@mvista.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1051053519.511.355.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Apr 2003 16:18:40 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2003-04-22 at 16:13, Jun Sun wrote:
> On Wed, Apr 23, 2003 at 01:07:27AM +0200, Ralf Baechle wrote:
> > On Tue, Apr 22, 2003 at 03:56:25PM -0700, Jun Sun wrote:
> > 
> > > I think this is a good example to show benefit of code sharing.
> > > There is no good reason for au1x00 boards of not using new time.c.
> > > You get to write less board code, fewer bugs and future proof.
> > 
> > There are just three configurations left using CONFIG_OLD_TIME_C:
> > 
> >  - EV64120 which I guess can be considered abandonded
> >  - Momenco Ocelot (Matthew, feel like you have time to take care of
> >    this?)
> >  - RM200  (semi-maintained, my turn to fix it ...)
> > 
> > Seems like it's time to get rid of CONFIG_OLD_TIME_C.
> >
> 
> If we were going to get rid of CONFIG_OLD_TIME_C, I propose
> to make CONFIG_NEW_TIME_C as the default and therefore removed as well.
> And make other boards using private time_init() functions to use 
> CONFIG_HAVE_PRIVATE_TIME. 
> 
> ... in the spirit of encouraging code sharing. :)

How about just extending the time api so that "have private time" can
just override some functions instead?  That way even then you'll have
some code sharing, even if it's not 100%.

Pete
