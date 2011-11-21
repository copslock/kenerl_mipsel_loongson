Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2011 00:53:41 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:48956 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903815Ab1KUXxi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Nov 2011 00:53:38 +0100
Received: from akpm.mtv.corp.google.com (216-239-45-4.google.com [216.239.45.4])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 22E10458;
        Mon, 21 Nov 2011 23:51:44 +0000 (UTC)
Date:   Mon, 21 Nov 2011 15:53:31 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        linux-arch@vger.kernel.org, Robin Holt <holt@sgi.com>
Subject: Re: [patch] hugetlb: remove dummy definitions of HPAGE_MASK and
 HPAGE_SIZE
Message-Id: <20111121155331.a1726ffe.akpm@linux-foundation.org>
In-Reply-To: <4ECAE314.9060209@gmail.com>
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com>
        <alpine.DEB.2.00.1111171520130.20133@chino.kir.corp.google.com>
        <alpine.DEB.2.00.1111171522131.20133@chino.kir.corp.google.com>
        <4ECACF68.3020701@gmail.com>
        <CA+55aFwZxqHfEOemj+OJNKCj2toqGf3rkK-9iuS39L7iZsoH1Q@mail.gmail.com>
        <4ECAE314.9060209@gmail.com>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 31908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18046

On Mon, 21 Nov 2011 15:47:32 -0800
David Daney <ddaney.cavm@gmail.com> wrote:

> Just to expand on this lovely topic...
> 
> On 11/21/2011 02:43 PM, Linus Torvalds wrote:
> > On Mon, Nov 21, 2011 at 2:23 PM, David Daney<ddaney.cavm@gmail.com>  wrote:
> >>
> >> This whole comment strikes me as somewhat dishonest, as at the time David
> >> Rientjes wrote it, he knew that there were dependencies on these symbols in
> >> the linux-next tree.
> >>
> >> Now we can add these:
> >> +#define HPAGE_SHIFT    ({ BUG(); 0; })
> >> +#define HPAGE_SIZE     ({ BUG(); 0; })
> >> +#define HPAGE_MASK     ({ BUG(); 0; })
> >
> > Hell no.
> >
> > We don't do run-time BUG() things. No way, no how.
> >
> 
> These symbols are on dead code paths, so they are eliminated by the 
> compiler's Dead Code Elimination (DCE) optimizations, and the BUG() code 
> never gets emitted to the final executable.
> 
> I agree that it is not the best thing to do, but given the current state 
> of the art in build bug macros, it is the best we could have done.
> 
> What I think we need instead, and for which I will send a patch soon, is 
> something like this:
> 
> extern void you_are_screwed() __attribute__ ((error("BUILD_BUG_ON_USED 
> failed")));
> #define BUILD_BUG_ON_USED() you_are_screwed()
> #define HPAGE_SHIFT    ({ BUILD_BUG_ON_USED(); 0; })
> 
> This allows us to use the symbols in straight line C code without a ton 
> of ugly #ifdefery, but give us build time error checking.

The way we usually handle that is to emit a call to a
this_function_does_not_exist(), so it fails at link time.

I guess we should do that to all those follow_hugetlb_page() and
friends.

gcc has had issues at times where it incorrectly emits references to
this_function_does_not_exist(), but that hasn't happened in a couple of
years as far as I know.
