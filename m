Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 23:19:08 +0100 (CET)
Received: from gateway-1237.mvista.com ([12.44.186.158]:27630 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224847AbSLDWTH>;
	Wed, 4 Dec 2002 23:19:07 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gB4MJ0V29567;
	Wed, 4 Dec 2002 14:19:00 -0800
Date: Wed, 4 Dec 2002 14:19:00 -0800
From: Jun Sun <jsun@mvista.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: possible Malta 4Kc cache problem ...
Message-ID: <20021204141900.U4363@mvista.com>
References: <20021203224504.B13437@mvista.com> <007501c29b78$f34680e0$10eca8c0@grendel> <3DEDD414.3854664F@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DEDD414.3854664F@mips.com>; from carstenl@mips.com on Wed, Dec 04, 2002 at 11:08:20AM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Dec 04, 2002 at 11:08:20AM +0100, Carsten Langgaard wrote:
> I have just tried your test on a 4Kc and I see no problems.
> However I'm running on our internal kernel sources, and as Kevin mention we have
> changed a fixed a few things in this area.
> As Kevin also mention it sure look more like a I-cache invalidation problem,
> rather than a D-cache flush problem, as the 4Kc has a write-through cache.
> One think you could try, is our latest kernel release. You can find it here:
> ftp://ftp.mips.com/pub/linux/mips/kernel/2.4/images/
>

Yes, the problem still exists with this kernel.

Try to move the source tree to /root/, rename top dir to "try18", 
re-make the binary, and try again.

This problem is tricky to reproduce.  The location of the tree
definitely matters.  I am testing 32bit LE version.  Have not
tried BE.

I think I have pinned down the problem.  See my other follow-up posting.

Jun
