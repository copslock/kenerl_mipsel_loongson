Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2004 18:41:03 +0000 (GMT)
Received: from buserror-extern.convergence.de ([IPv6:::ffff:212.84.236.66]:4233
	"EHLO heck") by linux-mips.org with ESMTP id <S8225463AbUBESlC>;
	Thu, 5 Feb 2004 18:41:02 +0000
Received: from js by heck with local (Exim 3.35 #1 (Debian))
	id 1AooQ4-00046V-00; Thu, 05 Feb 2004 19:40:08 +0100
Date: Thu, 5 Feb 2004 19:40:08 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [ANNOUNCE] "cvs explorer" for linux-mips CVS tree
Message-ID: <20040205184008.GC13068@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
References: <20040204150820.H26726@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204150820.H26726@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:
> 
> I wrote a CVS tracking tool that tracks CVS changes in patch format
> and present them with a web interface.  It is now set up to track
> linux-mips.org tree at the following place.  Enjoy.
> 
> http://www.linux-mips.org/xcvs/linux-mips
> 
> BTW, if you use this tool for tracking other trees, please drop me a
> note.  Of course, I also like to have more developers to participate.  
> Please join us at
> 
> http://xcvs.sf.net

Very good!

I played with cvsps a few times, but didn't dare to use it
on such a large tree like the Linux kernel.

A few nits:
- I would prefer a "latest first" sort order in the patchset listing
- IMHO 'diff -up' would make the patchsets much easier to read
- could you please add a <title> tag for the query page? (For
  easier bookmarking.)

The README from the sources mentions some constraints:

 ". Branching is always a complete branching of the whole tree."

What happens when only a part of a tree is branched?

 ". Commitment only modifies the head of a given branch."

I don't understand this. CVS commits will always change the head
of a branch (or the trunk) only, no?


How would one use xcvs on a repository with many different, but
interdependent CVS modules (e.g. gnome CVS http://cvs.gnome.org/)?


Johannes
