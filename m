Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2004 19:43:25 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:25583 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225315AbUBETnY>;
	Thu, 5 Feb 2004 19:43:24 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i15JhG411759;
	Thu, 5 Feb 2004 11:43:16 -0800
Date: Thu, 5 Feb 2004 11:43:16 -0800
From: Jun Sun <jsun@mvista.com>
To: Johannes Stezenbach <js@convergence.de>, linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: Re: [ANNOUNCE] "cvs explorer" for linux-mips CVS tree
Message-ID: <20040205114316.D9885@mvista.com>
References: <20040204150820.H26726@mvista.com> <20040205184008.GC13068@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040205184008.GC13068@convergence.de>; from js@convergence.de on Thu, Feb 05, 2004 at 07:40:08PM +0100
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Feb 05, 2004 at 07:40:08PM +0100, Johannes Stezenbach wrote:
> Jun Sun wrote:
> > 
> > I wrote a CVS tracking tool that tracks CVS changes in patch format
> > and present them with a web interface.  It is now set up to track
> > linux-mips.org tree at the following place.  Enjoy.
> > 
> > http://www.linux-mips.org/xcvs/linux-mips
> > 
> > BTW, if you use this tool for tracking other trees, please drop me a
> > note.  Of course, I also like to have more developers to participate.  
> > Please join us at
> > 
> > http://xcvs.sf.net
> 
> Very good!
> 
> I played with cvsps a few times, but didn't dare to use it
> on such a large tree like the Linux kernel.
> 
> A few nits:
> - I would prefer a "latest first" sort order in the patchset listing
> - IMHO 'diff -up' would make the patchsets much easier to read
> - could you please add a <title> tag for the query page? (For
>   easier bookmarking.)
> 

Good suggestions.  Patches are even more welcome. :)

> The README from the sources mentions some constraints:
> 
>  ". Branching is always a complete branching of the whole tree."
> 
> What happens when only a part of a tree is branched?
> 

Probably does not hurt.

>  ". Commitment only modifies the head of a given branch."
> 
> I don't understand this. CVS commits will always change the head
> of a branch (or the trunk) only, no?
> 

These statements are over paranoid.

> 
> How would one use xcvs on a repository with many different, but
> interdependent CVS modules (e.g. gnome CVS http://cvs.gnome.org/)?
> 

Don't know yet.  Have not given a thought.

BTW, this kind of discussions probably should go to xcvs list.  Pretty
soon I think Ralf will revoke our posting previledges. :)

Jun
