Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2007 15:52:15 +0000 (GMT)
Received: from return.false.org ([66.207.162.98]:37012 "EHLO return.false.org")
	by ftp.linux-mips.org with ESMTP id S20022316AbXCMPwK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Mar 2007 15:52:10 +0000
Received: from return.false.org (localhost [127.0.0.1])
	by return.false.org (Postfix) with ESMTP id 7DF154B26F;
	Tue, 13 Mar 2007 10:51:31 -0500 (CDT)
Received: from caradoc.them.org (dsl093-172-095.pit1.dsl.speakeasy.net [66.93.172.95])
	by return.false.org (Postfix) with ESMTP id 476E54B262;
	Tue, 13 Mar 2007 10:51:27 -0500 (CDT)
Received: from drow by caradoc.them.org with local (Exim 4.63)
	(envelope-from <drow@caradoc.them.org>)
	id 1HR7qx-0000qC-FW; Tue, 13 Mar 2007 10:19:51 -0400
Date:	Tue, 13 Mar 2007 10:19:51 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Peter Watkins <pwatkins@sicortex.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Have sigpoll and sigio band field match glibc for n64
Message-ID: <20070313141951.GA3206@caradoc.them.org>
References: <1173469586997-git-send-email-pwatkins@sicortex.com> <20070310132423.GA1295@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070310132423.GA1295@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 10, 2007 at 01:24:24PM +0000, Ralf Baechle wrote:
> On Fri, Mar 09, 2007 at 02:46:25PM -0500, Peter Watkins wrote:
> 
> > The siginfo field si_fd is incorrect on n64 because the band field does
> > not match glibc.
> 
> Susv3 says:
> 
> [...]
> The <signal.h> header shall define the siginfo_t type as a structure that
> includes at least the following members:
> 
> [...]
> long          si_band   Band event for SIGPOLL. 
> [...]
> 
> So the kernel is right, glibc is wrong I'd say ...

This will break the ABI only for uses of si_band and si_fd, and only
on n64.  Anyone see a reason why I shouldn't change glibc?

Ralf, as I mentioned on IRC, I've got bigger worries about siginfo.
Shouldn't n32 be using the same siginfo as o32?  It's got pointers in it.

-- 
Daniel Jacobowitz
CodeSourcery
