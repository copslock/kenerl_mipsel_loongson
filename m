Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2008 21:56:52 +0100 (BST)
Received: from NaN.false.org ([208.75.86.248]:4833 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S28594755AbYGXU4u (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Jul 2008 21:56:50 +0100
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id DC68698376;
	Thu, 24 Jul 2008 20:56:48 +0000 (GMT)
Received: from caradoc.them.org (22.svnf5.xdsl.nauticom.net [209.195.183.55])
	by nan.false.org (Postfix) with ESMTP id AE2D598337;
	Thu, 24 Jul 2008 20:56:48 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.69)
	(envelope-from <drow@caradoc.them.org>)
	id 1KM7rk-00057s-0i; Thu, 24 Jul 2008 16:56:48 -0400
Date:	Thu, 24 Jul 2008 16:56:48 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	binutils@sourceware.org, gcc@gcc.gnu.org,
	linux-mips@linux-mips.org, rdsandiford@googlemail.com
Subject: Re: RFC: Adding non-PIC executable support to MIPS
Message-ID: <20080724205647.GA18897@caradoc.them.org>
Mail-Followup-To: binutils@sourceware.org, gcc@gcc.gnu.org,
	linux-mips@linux-mips.org, rdsandiford@googlemail.com
References: <87y74pxwyl.fsf@firetop.home> <20080724161619.GA18842@caradoc.them.org> <87ej5j2fov.fsf@firetop.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ej5j2fov.fsf@firetop.home>
User-Agent: Mutt/1.5.17 (2008-05-11)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 24, 2008 at 09:24:48PM +0100, Richard Sandiford wrote:
> > - I've dropped support for a non-fixed $gp.  This is a handy
> > optimization, but it was getting in the way and it was the part of the
> > GCC patch Richard had the most comments on.  I can resubmit it after
> > everything else is merged.
> 
> That's a shame.  It was also the bit I liked best ;)  What went wrong?
> 
> (My comments were only minor.)

Nothing big: but it made up the bulk of our GCC patch, and I was
rebasing on top of yours.  We had a lot of trouble getting that bit to
work, so I took the conservative path and dropped it.  Don't worry - I
definitely will return to this as soon as the remaining patches are
merged; I liked it too.

Originally, we were also going to make small data work with non-PIC
abicalls.  I'd like to discuss that with you at some later date too.
We ran into a lot of trouble combining small data with a non-fixed
$gp; I believe it was because reload may introduce small data loads
very late.  I'd have to try it again before I had anything more
sensible to say, though.

> Sorry for the bugs, and thanks for fixing them.  I'll try to have
> a look at the patches over the weekend.

No problem, and thank you for looking at them - and for your patches;
I'm really pretty happy with the combined work.

-- 
Daniel Jacobowitz
CodeSourcery
