Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2003 15:08:26 +0100 (BST)
Received: from p508B5469.dip.t-dialin.net ([IPv6:::ffff:80.139.84.105]:57771
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225294AbTDPOIZ>; Wed, 16 Apr 2003 15:08:25 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3GE8JT10873;
	Wed, 16 Apr 2003 16:08:19 +0200
Date: Wed, 16 Apr 2003 16:08:19 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Hartvig Ekner <hartvig@ekner.info>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: MIPS32 cache functions now using c-r4k?
Message-ID: <20030416160818.E9170@linux-mips.org>
References: <3E9D0C34.38FE2749@ekner.info> <00c401c30418$0d9d1370$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <00c401c30418$0d9d1370$10eca8c0@grendel>; from kevink@mips.com on Wed, Apr 16, 2003 at 02:59:30PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 16, 2003 at 02:59:30PM +0200, Kevin D. Kissell wrote:

> The whole point of creating the generic MIPS32 MMU and cache
> routines was to have something that would run on both 32-bit and
> 64-bit processors.  Who decided to throw them away and abandon 
> support for 32-bit-only CPUs other than the R3000, and why?

Nobody did dump support for 32-bit only processors.

The read behind all this was in part that the pile of c-*.c files had
turned into some sort of barbed wire fence.  Code from c-r4k.c had been
replicated several times - including hundreds (conservative estimate) of
lines of dead code, plenty of bugs and lack of understanding how caches
are working.  At the same time that meant there was no way the old code
could have supported all available processor configurations on some
platforms.

So when I was doing some work related to signal handling I finally gave
up and started cleaning the the mess instead of doing the same change
to 42 copies of a function.

The result of the changes aside of a bunch of bugs - at less than 50% of
the binary size and hundreds of kilobytes of less sources a more generic
kernel with for most people dramatically improved performance.  Yes, a
few bugs crept in but I'd do it again at any time.

  Ralf
