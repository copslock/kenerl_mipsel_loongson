Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0VLhEX06407
	for linux-mips-outgoing; Thu, 31 Jan 2002 13:43:14 -0800
Received: from mcp.csh.rit.edu (mcp.csh.rit.edu [129.21.60.9])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0VLhAd06404
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 13:43:10 -0800
Received: from fury.csh.rit.edu (fury.csh.rit.edu [129.21.60.5])
	by mcp.csh.rit.edu (Postfix) with ESMTP
	id BD6D010D; Thu, 31 Jan 2002 15:43:04 -0500 (EST)
Date: Thu, 31 Jan 2002 15:43:04 -0500 (EST)
From: George Gensure <werkt@csh.rit.edu>
To: Guido Guenther <agx@sigxcpu.org>
Cc: <linux-mips@oss.sgi.com>
Subject: Re: Newport XZ
In-Reply-To: <20020131111144.A14922@gandalf.physik.uni-konstanz.de>
Message-ID: <Pine.SOL.4.31.0201311537330.11295-100000@fury.csh.rit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

It's definitely not a dual head board, however, attached to the sgi bus
(s-bus?) these two cards are stacked on top of one another.  The top one
has the display adapter.  I only say it is a XZ because of a hardware site
that I found that showed all the different Newport cards, and this was the
only one that matched it.  I don't have a problem doing the serial (found
a cord), but I looked at the kernel source for the graphics and gconsole
drivers, and it looked like they work now by some dark black magic.  There
is no probing of the card of any kind, and even the code that looks as
though it might be able to run on more than one machine has been #if 0 -ed
out.  Would only the base address for the XZ be different, or would it be
a completely different arrangement for the card as opposed to the XLs?

-George

On Thu, 31 Jan 2002, Guido Guenther wrote:

> On Wed, Jan 30, 2002 at 06:30:38PM -0500, George Gensure wrote:
> > Does the current kernel support the 2 board Newport XZ?  I have it in one
> > of my machines, and I can't even get console, let alone get in there to
> > run X. (no serial terminal available... damn the mac style serial)
> If this is a 2 board XL, chances might be good to get this working
> fairly easily. My impression was always that these are basically two XL
> boards located at different base addresses, but I never ever got my
> hands on such a board myself. Anyway you'll need a serial cable to debug
> things anyway.
> As for the XZ, there are no docs neither for single headed nor dual
> head(I didn't know there's a dual head XZ too).
>  -- Guido
>

-- 
George R. Gensure       Computer Science House Member
werkt@csh.rit.edu       Sophomore, Rochester Institute of Technology
Computer Science
