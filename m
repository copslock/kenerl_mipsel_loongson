Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA07685; Wed, 29 May 1996 20:02:52 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA16701 for linux-list; Thu, 30 May 1996 03:02:47 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA16690 for <linux@cthulhu.engr.sgi.com>; Wed, 29 May 1996 20:02:46 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA07679; Wed, 29 May 1996 20:02:45 -0700
Date: Wed, 29 May 1996 20:02:45 -0700
Message-Id: <199605300302.UAA07679@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: nn@lanta.engr.sgi.com
CC: lmlinux@neteng.engr.sgi.com, sparclinux-cvs@caipfs.rutgers.edu,
        alan@cymru.net, torvalds@cs.helsinki.fi
In-reply-to: <199605300036.RAA09665@lanta.engr.sgi.com> (nn@lanta)
Subject: Re: linux needs bsd networking stack
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   Date: Wed, 29 May 1996 17:36:19 -0700
   From: nn@lanta (Neal Nuckolls)

   >> The "unique" tcp/ip implementation is a liability to linux.
   >
   > It could also be one of it's greatest assets, and I think this will
   > turn out to be the case.

   Most unix and internet R&D community protocol development has
   been and continues to be within a BSD environment which means that
   BSD-based kernel networking code is prevalent. If I'm doing some
   work in this area I can readily grab many free BSD-based protocol
   pieceparts off the net. New routing protocols, ATM signalling, TCP
   conjestion improvements, realtime protocol stacks, etc. are all
   developed in a BSD kernel networking environment.  Have been for
   years. That's not likely to change. There are hundreds of people
   out there that really know BSD networking. This availability of
   people and code makes it the standard.

Actually, whats funny is that this is exactly what the people doing
work on the linux stack have in fact done.  Check out the ideas people
have put into various berkeley based ventures and research, place our
own implementation of the idea into the linux stack, and then improve
upon it.  The idea behind publicly available standards (at least I
believe) was to promote no single entity to have this "defacto" thing
which controlled the protocol or what have you, the berkeley
phenomenon is not encouraging this idea and is in fact against it.
Here the berkeley interpretation and implementation is being
considered "the" interpretation and "the" implementation.  The Linux
code in general moves at an advanced rate, it is constantly evolving
and changing for the purposes of improvement.  One could argue that
this is what makes it so hard to pin down and become very acquainted
with it and not just the fact that it's objects and interfaces are not
as well defined (as lm mentions, of which I whole heartedly agree, I
would some day like to see the Linux networking be as intuitive and
seamless as the vm/mm Linux layers, Linus has mentioned moves in this
direction via fully integrating the socks more completely into the
inode among other things).

   Actually, for the startups that I mentioned - those interested in
   shipping a commercial product - there is no choice, it's FreeBSD,
   because it comes without the GPL kiss of death.

I wish it wouldn't come down to a discussion about "what license is
better for who and why", I'd rather this be about technical merit.
But, I am beginning to realize that this may not be possible.  I want
Linux to strive and always be on the bleeding edge, as it has been,
personally I believe that the "GPL kiss of death" is what makes that
possible and will guarentee that this capability cannot be taken
away.

   I think that basing any improvements on a 4.4BSD-based linux stack
   would result in something more usable.  Also, as a side effect, it
   would encourage more talented networking people to participate and
   isn't this what freeware is all about?

You are correct, this is what "free software" (there is a distinction)
is all about.  However what it is not about, and what could kill free
software is if the "BSD kiss of death" allowed someone to make
significant improvements to the Linux code and due to the berkeley
license allowed that entity to keep those improvements to themselves
so that the free software community loses out.  This is precisely what
the GPL tries to avoid...  Very frequently, Linus himself mentions
that the GPL is what has made Linux as powerful as it now is, and he
also frequently mentions that GPL'ing the Linux code is the best
decision he has ever made.  I tend to agree with him.

But like I said, I'd rather such a decision be made based upon a
technical decision not a "who has the viable licensing terms"
decision.

It was mentioned that you are more familiar with the berkeley code and
many people are.  I am more familiar with the Linux code and the
work/research which has gone into it, do I have an argument as well?
I would not present it this way or drive an argument in that fashion I
think.  There exists a significant group of people who are in my
position and as well there are many in the position you speak of.
However, I have been making a significant effort over the past year or
so to become familiar with the berkeley code so that I possess the
ability to tackle decisions like this based on technical merit, and
not turn it into a GPL vs. BSD discussion.  Are people supportive of
the berkeley side of this argument willing to do the same?  I know a
few such as lm etc., I would not say they exist within the majority
though.

Later,
David S. Miller
dm@sgi.com
