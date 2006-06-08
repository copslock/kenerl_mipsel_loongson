Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2006 03:29:00 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:35228 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8126480AbWFHC2v (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2006 03:28:51 +0100
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1FoAGK-0008B1-3h; Wed, 07 Jun 2006 22:28:44 -0400
Date:	Wed, 7 Jun 2006 22:28:44 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Kumba <kumba@gentoo.org>
Cc:	"Joseph S. Myers" <joseph@codesourcery.com>,
	linux-mips@linux-mips.org
Subject: Re: N32 sigset and __COMPAT_ENDIAN_SWAP__
Message-ID: <20060608022844.GA31361@nevyn.them.org>
References: <Pine.LNX.4.64.0606080134480.26638@digraph.polyomino.org.uk> <44878AAA.20007@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44878AAA.20007@gentoo.org>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 07, 2006 at 10:25:46PM -0400, Kumba wrote:
> You might find the attached patch of interest.
> 
> We've been using it gentoo-side for awhile now, as it allowed some N32 
> programs to work correctly.  Namely, a configure test in glib would trigger 
> a non-fatal oops in the kernel due to an issue this patch fixes.  Daniel 
> Jacobwitz wrote it up when he apparently stumbled across the issue 
> (something wonky in n32's sigsuspend, as the name indicates.  I forget the 
> specifics, though), but I'm unsure if the issue is in any way connected to 
> what you're seeing as well.

It's already in the linux-mips.org tree, though, I believe.  That
was a different problem.

-- 
Daniel Jacobowitz
CodeSourcery
