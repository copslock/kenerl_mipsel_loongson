Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAOCsig05045
	for linux-mips-outgoing; Sat, 24 Nov 2001 04:54:44 -0800
Received: from holomorphy (mail@holomorphy.com [216.36.33.161])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAOCsgo05036
	for <linux-mips@oss.sgi.com>; Sat, 24 Nov 2001 04:54:42 -0800
Received: from wli by holomorphy with local (Exim 3.31 #1 (Debian))
	id 167bO4-0004LE-00
	for <linux-mips@oss.sgi.com>; Sat, 24 Nov 2001 03:54:24 -0800
Date: Sat, 24 Nov 2001 03:54:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-mips@oss.sgi.com
Subject: Re: advice on dz.c
Message-ID: <20011124035424.F1048@holomorphy.com>
References: <20011123162710.D1048@holomorphy.com> <Pine.LNX.4.32.0111241140030.16093-100000@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.32.0111241140030.16093-100000@skynet>; from airlied@csn.ul.ie on Sat, Nov 24, 2001 at 11:44:40AM +0000
Organization: The Domain of Holomorphy
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Nov 24, 2001 at 11:44:40AM +0000, Dave Airlie wrote:
> This is unusual I've just taken a run down through a diff of 1.17 and 1.22
> from the MIPS CVS tree and I can't see anything that could cause breakage
> that has been changed... I'd try commentined out the DZ_DEBUG stuff.. this
> isn't meant to be called... unless someone wants to specifically debug
> their dz.c on a decstation.... otherwise it should be switched off..
> 
> Granted to code doesn't look like it would compile with it off..
> 
> Dave.

I took a day out to look at it, I can spend more time on debugging it,
as hacking the kernel into shape on this box is somewhat of a hobby
project for me.

I think the one thing I didn't take a look at was the copy_to_user()
changes, so it could be useful to explore that, and I've got a couple
of other tricks up my sleeve.


Cheers,
Bill
