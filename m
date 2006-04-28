Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2006 21:15:50 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:47302 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133504AbWD1UPl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Apr 2006 21:15:41 +0100
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1FZZNC-0001JU-T3; Fri, 28 Apr 2006 16:15:31 -0400
Date:	Fri, 28 Apr 2006 16:15:30 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	James E Wilson <wilson@specifix.com>
Cc:	dhunjukrishna@gmail.com, Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: problem with mips-linux gprof
Message-ID: <20060428201530.GA4883@nevyn.them.org>
References: <20060428063712.39756.qmail@web53501.mail.yahoo.com> <1146253927.15759.16.camel@aretha.corp.specifix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146253927.15759.16.camel@aretha.corp.specifix.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 28, 2006 at 12:52:07PM -0700, James E Wilson wrote:
> The above assumes you don't have a profiled C library available.  If you
> did, then you would have at least two profiled functions, main and
> printf, and would have gotten some call graph info emitted.  If you
> don't have a profiled C library available, you could try compiling one
> yourself.  There is a glibc configure option --enable-profile for that. 
> I've never tried this myself.  I'd expect this to be a non-trivial
> exercise.  Besides the issue of compiling glibc, you also need to
> install the profiled library, and arrange to link with it.

Many prebuilt distributions already ship it; FWIW, if you link with
"-profile" instead of "-pg", GCC will automatically attempt to use
-lc_p.

-- 
Daniel Jacobowitz
CodeSourcery
