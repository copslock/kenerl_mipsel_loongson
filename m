Received:  by oss.sgi.com id <S554102AbRBVGrt>;
	Wed, 21 Feb 2001 22:47:49 -0800
Received: from sovereign.org ([209.180.91.170]:20914 "EHLO lux.homenet")
	by oss.sgi.com with ESMTP id <S554098AbRBVGro>;
	Wed, 21 Feb 2001 22:47:44 -0800
Received: (from jfree@localhost)
	by lux.homenet (8.11.2/8.11.2/Debian 8.11.2-1) id f1M6mO502934;
	Wed, 21 Feb 2001 23:48:24 -0700
From:   Jim Freeman <jfree@sovereign.org>
Date:   Wed, 21 Feb 2001 23:48:24 -0700
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: sync plea
Message-ID: <20010221234824.A2820@sovereign.org>
References: <20010221060711.A26654@sovereign.org> <20010221160418.A21995@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010221160418.A21995@bacchus.dhis.org>; from ralf@oss.sgi.com on Wed, Feb 21, 2001 at 04:04:18PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Feb 21, 2001 at 04:04:18PM +0100, Ralf Baechle wrote:
> On Wed, Feb 21, 2001 at 06:07:11AM -0700, Jim Freeman wrote:
...
> > The recent mips update into 2.4.2pre2 (thankyouthankyouthankyou...)
> > has helped in this task, but the diff between any 2.4.2pre[n>=2] or
> > 2.4.1-ac[n>=9] tree vs the MIPS cvs tree is still huge, and painful
> > to cull through to wind up with a sane mips patch (should be fairly
> > small since the update into 2.4.2pre2) against a 2.4.*{pre*|-ac*} tree.
> > 
> > A sync of mips cvs to any 2.4.1{pre*|-ac*} kernel post 2.4.2pre2
> > would be of great use, but I don't know how much pain that entails
> > for the maintainers.
> > 
> > In lieu of that, can anyone clue me in to newbie tricks (CVS or
> > otherwise) for syncing 2 trees less painfully than culling diffs?
> 
> Imagine, that's what we do on a daily base.  The most easy recipe to make
> diffs less painful is half a gig of RAM which brings time for diffing
> two kernel trees down to ~ 2s on an Origin or decent PC.
> 
> Unfortunately Linus dropped piles of additional patches I sent to him.
> That's the standard way this works, so just wait ...

The problem was not the mips-related changes that didn't make it into
2.4.2pre, but the non-mips changes that the mips cvs tree wasn't sync'd
to.

The merge of 2.4.2 into mips cvs will solve this - then the diff will
be just mips-related changes.

Many thanks,
...jfree
