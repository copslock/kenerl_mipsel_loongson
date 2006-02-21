Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2006 14:35:20 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:15009 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133422AbWBUOfM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Feb 2006 14:35:12 +0000
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1FBYiR-00057A-TD; Tue, 21 Feb 2006 09:42:12 -0500
Date:	Tue, 21 Feb 2006 09:42:11 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Jim Gifford <maillist@jg555.com>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: GLIBC moved mips to Ports
Message-ID: <20060221144211.GA19378@nevyn.them.org>
References: <43FA8F04.3040606@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FA8F04.3040606@jg555.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 20, 2006 at 07:54:44PM -0800, Jim Gifford wrote:
> Just an FYI, I've been working trying to keep MIPS updated in glibc. 
> Again some changes were made that broke the MIPS build with the current 
> snapshot. I guess all of Daniel's and my work just got thrown away. As 
> of today MIPS is no longer going to be support in trunk. Here's the 
> message I received today.
> 
> In my opinion this seems to mean that MIPS is not a high priority in 
> their book.
> 
> ------- Additional Comments From roland at gnu dot org  2006-02-21 02:14 
> -------
> For the trunk, mips has moved to the ports repository.
> Daniel should be able to commit his fixes there directly.
> Items needing merge in the 2.3 branch can be reassigned to me.

Sigh.  Jim, you are slightly misinterpreting this.

MIPS has _never_ been a high priority of the glibc maintainers.  What
happened here is that they admitted it - and moved it to a separate
repository so that (A) they don't need to deal with it, and (B) people
who are interested can deal with it.  It's unfortunate, but realistic.

The ports repository is going to continue to be supported and we're
going to keep it working.  We just have to do the legwork.  I'll go
over the MIPS build fixes this week sometime.

-- 
Daniel Jacobowitz
CodeSourcery
