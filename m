Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA13038; Mon, 22 Apr 1996 18:40:14 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id SAA02431; Mon, 22 Apr 1996 18:40:08 -0700
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	 id SAA02421; Mon, 22 Apr 1996 18:40:06 -0700
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	 id SAA12769; Mon, 22 Apr 1996 18:40:04 -0700
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id VAA02115; Mon, 22 Apr 1996 21:40:02 -0400
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id VAA03615; Mon, 22 Apr 1996 21:40:01 -0400
Date: Mon, 22 Apr 1996 21:40:01 -0400
Message-Id: <199604230140.VAA03615@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: ariel@cthulhu.engr.sgi.com
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <199604230116.SAA28514@yon.engr.sgi.com> (ariel@yon.engr.sgi.com)
Subject: Re: David Miller is on the list
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: ariel@yon.engr.sgi.com (Ariel Faigon)
   Date: Mon, 22 Apr 1996 18:16:30 -0700 (PDT)

   Great, now you can tell the list what do you need :-)

Oh boy.

   Seriously, we've been thinking about how we could make you most
   productive and not waste your time when you arrive here.

   Here's a recent posting of mine, so you get the idea just in case
   Simon or Bob or Larry didn't tell you about all this yet...

   Feel free to bombard us with requests/questions.
   There are about 20 people on the linux list at SGI
   (you can query majordomo@engr.sgi.com  for the details)

Already did that an hour ago ;)

(note: I looked back over this mail after composing it and I want to
       warn people who are not familiar with me yet that I am very
       sarcastic and am full of ridicule even when discussing
       important topics.  Please don't take it that I lack tact
       or am not being serious, because that simply isn't the case.)

Here is what I need:

	The following utilities I need for development.
	1) CVS/RCS, latest on prep.ai.mit.edu is fine
	2) Emacs-19.31 (rms should release within 2 weeks)
	3) All GNU smidgen-type utilies as the default binaries
	   (this include fileutils/sh-utils/sharutils/diffutils/
	    findutils/...)
	   Actually, Let me just stop short and say, if there is a
	   source tarball for it on prep.ai.mit.edu:/pub/gnu I would
	   like the latest installed on the machine I develop on.
	4) xfishtank (don't laugh)
	5) fvwm
	6) teco (Must support full teco command set as described
	   in original DEC manuals! TECO is _the_ renaissance editor!)

	The following would be nice, but if it will give people
	bladder problems to do these then don't go out of your
	way:
	1) MIPS 4[40]00 manual is some online format (not postscript,
	   something I can cut and paste out of an emacs buffer etc.
	   so maybe info or pure ascii text would be fine, I could
	   care less about the formatting, I just want the words
	   there)
	2) Docs on the ethernet/scsi interfaces and I/O bus
	   architecture for the first machine I will be getting
	   this to work on, again text/info format would be nice.
	   Of course I will probably just stuff in the ready
	   drivers you might be getting to me into Linux but I want
	   to write my own from scratch in the near future after
	   that.
	3) I know as much as a bum on the street about SGI machines
	   and the various lines, a nice "roadmap to sgi workstations
	   and servers, plus the hardware gook thats inside" type
	   thing would be very useful to me.

	I will feel more comfortable if:
	1) I became very familiar with who the heavy low level MIPS
	   assembly level hackers are who I will be dealing with while
	   I am there.  Please tell me who they are, introduce, make
	   us say hello to each other, you get the idea.

	2) I know the policy on loud music in the office I'll be in
	   ;-)

I've thought it over and to me the best plan for things this summer to
me is:
	a) R4400 32-bit "proof of concept, yeah we can pull it off"
	   port happens first, side effect is that I become intimate
	   enough with the chip that I can do things more efficiently.
	b) From here we look into the 64-bit stuff and whether that is
	   is even desirable on 64-bit.  (this would be my first
	   64-bit port outside of my initial UltraSparc hacks)
	c) Also think about the work needed to turn that code into
	   r3000 friendly code.  Should not be too much as I've done
	   the "write it on recent architecture design then backport
	   it to older design which had some limitations" already and
	   this didn't end up being so bad.

Expect more as I think it up... this should keep you guys busy for
now.

(Any dead-head tape traders at SGI engineering?  Just wondering, may
 want to start talking to them now ;-)

Later,
David S. Miller
davem@caip.rutgers.edu
