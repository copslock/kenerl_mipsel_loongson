Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2015 15:53:34 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:53139 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011483AbbAZOxbcphhC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jan 2015 15:53:31 +0100
Date:   Mon, 26 Jan 2015 14:53:31 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Joshua Kinard <kumba@gentoo.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
In-Reply-To: <20150126131621.GB31322@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1501261358540.28301@eddie.linux-mips.org>
References: <54BCC827.3020806@gentoo.org> <54BEDF3C.6040105@gmail.com> <54BF12B9.8000507@gentoo.org> <alpine.LFD.2.11.1501210347180.28301@eddie.linux-mips.org> <20150126131621.GB31322@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, 26 Jan 2015, Ralf Baechle wrote:

> >  Well, several MIPS processors can reverse the user-mode endianness via 
> > the CP0.Status.RE bit; though as you may be aware it has never been 
> > implemented for Linux.  Otherwise it would obviously have to be a 
> > per-process property (and execve(2) could flip it back).
> 
> As posted previously that was why I removed it from /proc/cpuinfo.  And
> yes, I had a simple prototype to use the RE feature.  Even in the limited
> form I had it was impressively ugly and it became clear it would never
> be upstreamable.

 Out of curiosity -- what was there that made it so ugly?  The need for 
case-by-case individual handling of byte-swapping the qualifying members 
of syscall and signal data structures such as `struct stat'?  Obviously 
not alignment trap fixups, these are trivial to handle.  And I think 
pretty much everything else is endianness-agnostic.

> Right now MIPS is not making much use of sysfs.  Endian information and
> other runtime CPU configuration probably should go there.  Detecting the
> size and associativity of cache lines, changing the cache line size, more
> control over VPEs in multithreaded kernels come to mind.

 That sounds reasonable to me.  I thought MT support was dropped though -- 
what do you mean in the latter case?

> >  See:
> > 
> > commit 874124ebb6309433a2e1acf1deb95baa1c34db0b
> > Author: Ralf Baechle <ralf@linux-mips.org>
> > Date:   Sun Dec 2 11:34:32 2001 +0000
> > 
> >     Merge with Linux 2.4.15.
> > 
> > -- which actually makes me wonder what happened here as Linus's 2.4.15 
> > change does not include any of this stuff.  Only 2.4.19 does, 8 months 
> > later -- a CVS to GIT conversion problem?
> 
> In those days I only sent patches upstream very rarely because committing
> to CVS was easy - but extracting patches, breaking the up in useful patches
> and submitting them upstream was so painful.  Honestly, the CVS archive
> only began to be really useful after it was converted to git!

 I know you only sent stuff to Linus for upstreaming every once in a while 
back then.  However, here I've been wondering why a change that clearly 
didn't originate from Linus's 2.4.15 ended up with the merge.  Pretty much 
nothing under arch/mips{,64} came from upstream back then, so any changes 
made there at the time of a merge would only be internal API adjustments 
required for interfacing generic code.  And a change made to /proc/cpuinfo 
clearly wasn't such one.

> The conversion to git is as accurate as I possibly could do it and includes
> the entire tarball and patch history as well as the linux-2.0 repository.
> Linux 2.0 lived in a separate repository because it was created for
> around 2.1.73 when it became clear that 2.2 was still going to take a
> long time.  The conversion was done custom conversion tools due to the
> limitations of the tools that were available at the time.

 Yeah, the big issue was to fold changes made to individual files (that 
CVS did track) back into changesets they were a part of (that CVS didn't 
track) -- i.e. what was supposed to have been included with a single `cvs 
commit' command.  I do remember there was a tool readily available that 
did that by grouping changes made close enough in time to one another; I 
think `cvsps'.  One limitation of course was the consequence of asking 
oneself a question: how close is close enough?  This was especially 
important for large commits, and of course independent of the tool used.

 And I agree that the history carried over from the old repo is much more 
useful these days than it originally was back in CVS.  Thank for going 
through the effort of converting it to GIT!

  Maciej
