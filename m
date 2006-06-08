Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2006 18:37:13 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:31125 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133548AbWFHRhF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2006 18:37:05 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k58Hb1NA004403;
	Thu, 8 Jun 2006 18:37:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k58HawOS004402;
	Thu, 8 Jun 2006 18:36:58 +0100
Date:	Thu, 8 Jun 2006 18:36:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	"Joseph S. Myers" <joseph@codesourcery.com>,
	linux-mips@linux-mips.org
Subject: Re: N32 sigset and __COMPAT_ENDIAN_SWAP__
Message-ID: <20060608173658.GA4056@linux-mips.org>
References: <Pine.LNX.4.64.0606080134480.26638@digraph.polyomino.org.uk> <20060608165136.GA17152@linux-mips.org> <20060608170310.GA23814@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060608170310.GA23814@nevyn.them.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 08, 2006 at 01:03:10PM -0400, Daniel Jacobowitz wrote:

> Anyway, I was curious if you knew where this code had come from.  I
> didn't see anything to suggest that anyone besides mipsel ever
> used it, but it entered linux-mips.org via a merge from kernel.org,
> just before git history.
> 
> Oh, right, there's a historical import:
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commitdiff;h=32ed691a4efbc1c43584b7b7a6d782528241bb27

> It was copied from sys32_rt_sigtimedwait, which was wrong at least back
> to the initial revision of signal32.c.  I didn't go back any further.

I can further track it into 2.4 or even pre-2.4 where such
__MIPSEB__ / __MIPSEL__ dependencies did exist under arch/mips64/.
I think it was right until a certain point in 2.5 when
get_sigset and put_sigset were implement in a clever way that
automatically takes care of the endianess issue - but the swapping code
outside arch/mips got forgotten.

  Ralf
