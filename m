Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2003 00:07:26 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:32245 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225201AbTDVXHZ>;
	Wed, 23 Apr 2003 00:07:25 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3MN7Jd31079;
	Tue, 22 Apr 2003 16:07:19 -0700
Date: Tue, 22 Apr 2003 16:07:19 -0700
From: Jun Sun <jsun@mvista.com>
To: Pete Popov <ppopov@mvista.com>
Cc: Jeff Baitis <baitisj@evolution.com>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>,
	jsun@mvista.com
Subject: Re: Improperly handled case in arch/mips/au1000/common/time.c
Message-ID: <20030422160719.G28544@mvista.com>
References: <20030422125450.E10148@luca.pas.lab> <20030422155625.E28544@mvista.com> <1051052439.2552.352.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1051052439.2552.352.camel@zeus.mvista.com>; from ppopov@mvista.com on Tue, Apr 22, 2003 at 04:00:39PM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Apr 22, 2003 at 04:00:39PM -0700, Pete Popov wrote:
> On Tue, 2003-04-22 at 15:56, Jun Sun wrote:
> > I think this is a good example to show benefit of code sharing.
> > There is no good reason for au1x00 boards of not using new time.c.
> > You get to write less board code, fewer bugs and future proof.
> 
> The I didn't use the generic time.c back then is power management. 

Oh, I see.  My ignorance ... :)

> The
> CP0 counter sleeps when using the 'wait' instruction, so in that case
> you have to use a different counter with a rather poor resolution. The
> modifications I had to make were such that they couldn't go in the
> generic time.c. But that area definitely needs to be revisited and
> cleaned up.
>

Yeah, there might be something interesting to do here.

Jun
