Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2003 00:13:40 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:48375 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225208AbTDVXNk>;
	Wed, 23 Apr 2003 00:13:40 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3MNDcQ31102;
	Tue, 22 Apr 2003 16:13:38 -0700
Date: Tue, 22 Apr 2003 16:13:38 -0700
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Jeff Baitis <baitisj@evolution.com>,
	Pete Popov <ppopov@mvista.com>, linux-mips@linux-mips.org,
	Matthew Dharm <mdharm@momenco.com>, jsun@mvista.com
Subject: Re: Improperly handled case in arch/mips/au1000/common/time.c
Message-ID: <20030422161338.H28544@mvista.com>
References: <20030422125450.E10148@luca.pas.lab> <20030422155625.E28544@mvista.com> <20030423010727.A8410@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030423010727.A8410@linux-mips.org>; from ralf@linux-mips.org on Wed, Apr 23, 2003 at 01:07:27AM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Apr 23, 2003 at 01:07:27AM +0200, Ralf Baechle wrote:
> On Tue, Apr 22, 2003 at 03:56:25PM -0700, Jun Sun wrote:
> 
> > I think this is a good example to show benefit of code sharing.
> > There is no good reason for au1x00 boards of not using new time.c.
> > You get to write less board code, fewer bugs and future proof.
> 
> There are just three configurations left using CONFIG_OLD_TIME_C:
> 
>  - EV64120 which I guess can be considered abandonded
>  - Momenco Ocelot (Matthew, feel like you have time to take care of
>    this?)
>  - RM200  (semi-maintained, my turn to fix it ...)
> 
> Seems like it's time to get rid of CONFIG_OLD_TIME_C.
>

If we were going to get rid of CONFIG_OLD_TIME_C, I propose
to make CONFIG_NEW_TIME_C as the default and therefore removed as well.
And make other boards using private time_init() functions to use 
CONFIG_HAVE_PRIVATE_TIME. 

... in the spirit of encouraging code sharing. :)

Jun
