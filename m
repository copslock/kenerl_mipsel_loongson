Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2006 18:03:25 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:40404 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133548AbWFHRDP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2006 18:03:15 +0100
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1FoNuY-0006Em-I0; Thu, 08 Jun 2006 13:03:10 -0400
Date:	Thu, 8 Jun 2006 13:03:10 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"Joseph S. Myers" <joseph@codesourcery.com>,
	linux-mips@linux-mips.org
Subject: Re: N32 sigset and __COMPAT_ENDIAN_SWAP__
Message-ID: <20060608170310.GA23814@nevyn.them.org>
References: <Pine.LNX.4.64.0606080134480.26638@digraph.polyomino.org.uk> <20060608165136.GA17152@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060608165136.GA17152@linux-mips.org>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 08, 2006 at 05:51:36PM +0100, Ralf Baechle wrote:
> On Thu, Jun 08, 2006 at 01:36:29AM +0000, Joseph S. Myers wrote:
> 
> Interesting that a bug of this sort manages to survive for that long.
> I guess it is proof that barely anybody is using 64-bit little endian,
> yet we're cursed to support it.

I expect more people will be using it someday...

Anyway, I was curious if you knew where this code had come from.  I
didn't see anything to suggest that anyone besides mipsel ever
used it, but it entered linux-mips.org via a merge from kernel.org,
just before git history.

Oh, right, there's a historical import:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commitdiff;h=32ed691a4efbc1c43584b7b7a6d782528241bb27

It was copied from sys32_rt_sigtimedwait, which was wrong at least back
to the initial revision of signal32.c.  I didn't go back any further.


-- 
Daniel Jacobowitz
CodeSourcery
