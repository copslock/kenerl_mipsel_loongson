Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g11Dl5R03600
	for linux-mips-outgoing; Fri, 1 Feb 2002 05:47:05 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g11Dl2d03597
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 05:47:02 -0800
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 16Wd5m-000695-00; Fri, 01 Feb 2002 13:46:58 +0100
Date: Fri, 1 Feb 2002 13:46:06 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: George Gensure <werkt@csh.rit.edu>
Cc: linux-mips@lists.debian.org
Subject: Re: Newport XZ
Message-ID: <20020201134606.A22880@gandalf.physik.uni-konstanz.de>
References: <20020131111144.A14922@gandalf.physik.uni-konstanz.de> <Pine.SOL.4.31.0201311537330.11295-100000@fury.csh.rit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.4.31.0201311537330.11295-100000@fury.csh.rit.edu>; from werkt@csh.rit.edu on Thu, Jan 31, 2002 at 03:43:04PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jan 31, 2002 at 03:43:04PM -0500, George Gensure wrote:
> It's definitely not a dual head board, however, attached to the sgi bus
> (s-bus?) these two cards are stacked on top of one another.  The top one
> has the display adapter.  I only say it is a XZ because of a hardware site
GIO Bus. You misunderstood me here. I'm not taling about two video outs
on one card. I actually ment:
 http://www.reputable.com/indytech.html#DualHead
This "dual head graphics option board"(as it is called there) looks
very much like a XL. Is that what you have?

> that I found that showed all the different Newport cards, and this was the
> only one that matched it.  I don't have a problem doing the serial (found
> a cord), but I looked at the kernel source for the graphics and gconsole
> drivers, and it looked like they work now by some dark black magic.  There
> is no probing of the card of any kind, and even the code that looks as
> though it might be able to run on more than one machine has been #if 0 -ed
> out.  Would only the base address for the XZ be different, or would it be
> a completely different arrangement for the card as opposed to the XLs?
GIO bus probing is being worked at. The current "probing" is crap and
let's an I2 halt immediately with a bus error. As I said before: if both
of these cards are XL(aka newport, although the "lower" one might be a
slight variation to allow for the daughter board) and not XZ(aka
fullhouse) you might have chances to get this working by only adjusting
the base addresses(the likely ones are in include/video/newport.h).
 -- Guido
