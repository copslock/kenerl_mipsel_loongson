Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5RJv3nC021871
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 27 Jun 2002 12:57:03 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5RJv3HB021870
	for linux-mips-outgoing; Thu, 27 Jun 2002 12:57:03 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5RJulnC021865;
	Thu, 27 Jun 2002 12:56:48 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA29398;
	Thu, 27 Jun 2002 22:00:48 +0200 (MET DST)
Date: Thu, 27 Jun 2002 22:00:47 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, Ladislav Michl <ladis@psi.cz>,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: DBE/IBE handling rewrite
In-Reply-To: <3D1B62A7.6010600@mvista.com>
Message-ID: <Pine.GSO.3.96.1020627212036.21496H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 27 Jun 2002, Jun Sun wrote:

> Here are some of those on top of my mind.  And I am pretty sure I am missing 
> others:
> 
> 1) /proc/cpuinfo and some bootinfo.h change  (I think these two come from one 
> change)

 Well, the addition of a FPU revision was my fault, but it was posted here
for discussion.  Now I am not completely satisfied with it, I admit, as
the implementation level is not reported -- only the revision.  I think
the implementation should be presented in a form of a textual name, like
it's done for the CPU, perhaps in a separate line.

 Others, I am not aware of.

> 2) split of cache and tlb files

 It was justified in my opinion.  Besides it was Ralf who did it, I
believe and that's his right of a MIPS maintainer, like Linus keeps the
right to change whatever he likes to within the kernel without asking
anyone.  That what makes someone a maintainer, after all.

> 3) some kind of flush_cache_LSB() routines.

 I can't recall, sorry.

> It is not big logically.  However, outside all the boards that are in oss 
> tree, I can safely say there are at least twenty MIPS porting efforts going on 
> at various stages.  Next time those people sync up with oss, they will find 
> the missing symbol of bus_error_init().

 Well, they get what they deserve for not releasing early.  Still, I'm
trying my best not to break others' work.  You wouldn't get that luxury
with the official kernel -- once a subsystem gets reorganized, only basic
bits (usually i386 and the platform the author is working on) get adjusted
and the rest is left broken until someone interested fixes it.  There is a
benefit, though -- that's actually a good determinator of bits no one is
interested anymore.  If a configuration keeps impossible to be compiled
for a long time, it's a sign it may probably be scheduled for a removal
soon. 

 OTOH, my private tree differs from the CVS by 36 patches now (a few less
as of today, as they got merged), which are awaiting an approval or are
unfinished or should really go to the official kernelor whatever and I can
live with that.  Occassionally I have to adjust them due to changes in the
CVS, but what's the deal? 

 Also when working on a change I usually don't switch kernels.  I let it
be finished, then try with a current snapshot, adjust as needed and only
then it's ready to be sent here and/or applied to the tree.  E.g. I'm
working on a serious update to the DECstation code and I use a snapshot
from May 30th.  Only when I consider it ready for merging I'll update its
working tree, even though I am already using a snapshot from Jun 25th for
other stuff.  Also I'll not wait for the update to be rock-solid -- I'll
merge it as soon as it's usable to some extent (unstable bits won't affect
existing code) and then I'll debug it myself as well as let others do that
if interested. 

 Plain and simple -- that's how the idea works.

> It wasn't my intention to dampen your MIPS contribution.  In fact, I start to 
> regret about my first email which now looks a little irresponsible.

 Not a problem -- we are all people after all and it's usually better to
express thoughts than to keep them inside.  This way you give others a
chance to clear the situation.

> If anything out of this thread can increase the awareness of open discussion 
> and awareness of the existence of many boards which are not part of oss tree 
> yet, I shall be happy.

 Well, I hope there will be benefits, as there usually are as a result of
good discussions.  For the writers of the external code I'd advise to try
merging as soon as they can, not only after code gets mature.  This way
others may try the code, comment on it and the code will have a chance to
be automatically adjusted whenever a more widespread change happens.  This
also minimizes a risk of a number of people working on the same problem in
parllel without knowing about one another.  There is hardly anything as
frustrating as duplicating somebody's work needlessly.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
