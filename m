Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 19:30:59 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:3561 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133545AbWAXTal (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jan 2006 19:30:41 +0000
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1F1TwR-0006P1-QU; Tue, 24 Jan 2006 14:34:59 -0500
Date:	Tue, 24 Jan 2006 14:34:59 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Kumba <kumba@gentoo.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH]: Fix N32 sigsuspend syscall that causes non-fatal oopses
Message-ID: <20060124193459.GA24479@nevyn.them.org>
References: <20060124191741.GB31197@toucan.gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124191741.GB31197@toucan.gentoo.org>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 24, 2006 at 07:17:41PM +0000, Kumba wrote:
> Fix to the sigsuspend syscall so N32 userlands work without triggering
> non-fatal oopses.  Patch was originally drafted by Daniel Jacobwitz.
> 
> Problem was originally discovered via a configure test in the glib
> package.  When run, the test triggered a segmentation fault and an
> oops, as well as causing the test, and ultimately, configure, to fail.
> 
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> ---
> 
>  linux32.c     |   19 -------------------
>  scall64-n32.S |    4 ++--
>  signal.c      |   42 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+), 21 deletions(-)

If you're going to mess around with sigsuspend, there's a better option
now: take a look at the recently added TIF_RESTORE_SIGMASK (committed
last week).

Everyone really should migrate over to that approach; it fixes (among
other things) a nasty debugging corner case and some code duplication.

-- 
Daniel Jacobowitz
CodeSourcery
