Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2003 17:51:41 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:24053 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225278AbTDPQvk>;
	Wed, 16 Apr 2003 17:51:40 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3GGpZc05684;
	Wed, 16 Apr 2003 09:51:35 -0700
Date: Wed, 16 Apr 2003 09:51:35 -0700
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Kevin D. Kissell" <kevink@mips.com>,
	Hartvig Ekner <hartvig@ekner.info>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>,
	jsun@mvista.com
Subject: Re: MIPS32 cache functions now using c-r4k?
Message-ID: <20030416095135.U1642@mvista.com>
References: <3E9D0C34.38FE2749@ekner.info> <00c401c30418$0d9d1370$10eca8c0@grendel> <20030416160818.E9170@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030416160818.E9170@linux-mips.org>; from ralf@linux-mips.org on Wed, Apr 16, 2003 at 04:08:19PM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Apr 16, 2003 at 04:08:19PM +0200, Ralf Baechle wrote:
> On Wed, Apr 16, 2003 at 02:59:30PM +0200, Kevin D. Kissell wrote:
> 
> > The whole point of creating the generic MIPS32 MMU and cache
> > routines was to have something that would run on both 32-bit and
> > 64-bit processors.  Who decided to throw them away and abandon 
> > support for 32-bit-only CPUs other than the R3000, and why?
> 
> Nobody did dump support for 32-bit only processors.
> 
> The read behind all this was in part that the pile of c-*.c files had
> turned into some sort of barbed wire fence.  Code from c-r4k.c had been
> replicated several times - including hundreds (conservative estimate) of
> lines of dead code, plenty of bugs and lack of understanding how caches
> are working.  At the same time that meant there was no way the old code
> could have supported all available processor configurations on some
> platforms.
>

It is really a Good Thing(tm) to have a more uniformed cache routine
and actually an overall performance gain.  It makes the tree more maintainable
and that new abstraction enables us to accomodate any new wacky CPUs
if there dare to any. :)

This is a long overdue task.  And the first derailed c-* file really should
not be allowed at the first place. :)

Jun
