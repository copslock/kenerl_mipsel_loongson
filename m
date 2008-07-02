Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2008 13:08:42 +0100 (BST)
Received: from NaN.false.org ([208.75.86.248]:40081 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S62072498AbYGBMIf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 Jul 2008 13:08:35 +0100
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id B5B83982C3;
	Wed,  2 Jul 2008 12:08:30 +0000 (GMT)
Received: from caradoc.them.org (22.svnf5.xdsl.nauticom.net [209.195.183.55])
	by nan.false.org (Postfix) with ESMTP id 765F598243;
	Wed,  2 Jul 2008 12:08:30 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.69)
	(envelope-from <drow@caradoc.them.org>)
	id 1KE18P-0003RW-97; Wed, 02 Jul 2008 08:08:29 -0400
Date:	Wed, 2 Jul 2008 08:08:29 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	binutils@sourceware.org, gcc@gcc.gnu.org,
	linux-mips@linux-mips.org, rdsandiford@googlemail.com
Subject: Re: RFC: Adding non-PIC executable support to MIPS
Message-ID: <20080702120829.GA12595@caradoc.them.org>
Mail-Followup-To: binutils@sourceware.org, gcc@gcc.gnu.org,
	linux-mips@linux-mips.org, rdsandiford@googlemail.com
References: <87y74pxwyl.fsf@firetop.home> <20080701202236.GA1534@caradoc.them.org> <87zlp149ot.fsf@firetop.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zlp149ot.fsf@firetop.home>
User-Agent: Mutt/1.5.17 (2008-05-11)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 01, 2008 at 09:43:30PM +0100, Richard Sandiford wrote:
> I suppose I still support the trade-off between the 5-insn MIPS I stubs
> (with extra-long variation for large PLT indices) and the absolute
> .got.plt address I used.  And I still think it's shame we're treating
> STO_MIPS_PLT and STO_MIPS16 as separate; we then only have 1 bit of
> st_other unclaimed.

I'm undecided about the MIPS I issue, but I completely agree about
STO_MIPS16/STO_MIPS_PLT.  I wish we'd thought of that too.  At least
our implementation didn't have STO_MIPS_PIC; so there's one bit left,
and assuming we add support for ld -r (likely) we can do it your way.

For the final merged versions of these patches, even if they implement
"our" version, I hope to draw heavily on your work.  It's always high
quality and the GOT cleanups in particular look very useful.

> TBH, the close relationship between CodeSourcery and MTI
> make it difficult for a non-Sourcerer and non-MTI employee
> to continue to be a MIPS maintainer.  I won't be in-the-know
> about this sort of thing.
> 
> I've been thinking about that a lot recently, since I heard about
> your implementation.  I kind-of guessed it had been agreed with MTI
> beforehand (although I hadn't realised MTI themselves had written
> the specification).  Having thought it over, I think it would be best
> if I stand down as a MIPS maintainer and if someone with the appropriate
> commercial connections is appointed instead.  I'd recommend any
> combination of yourself, Adam Nemet and David Daney (subject to
> said people being willing, of course).

I'm sorry you feel this way.  I believe strongly that corporate
affiliation is not a useful indicator for maintainership; the system
we have set up here relies more on individual knowledge and experience
than affiliation.

We could have done more to keep everyone informed of our progress; I
could write an essay on why we didn't, but I'd rather not.  We're
talking internally about how to avoid this unfortunate coincidence in
the future.  Anyway, there's plenty of blame to go around.

I think you're doing an excellent job as a GCC maintainer, and so does
everyone I spoke to about this at CS.  If you no longer have the time
or incentive to do it, I won't argue with you about stepping down, but
please don't because of this incident.

[In any case, I'd decline; I'm trying to shed some of my existing
maintenance responsibilities so that I can spend more time on the ones
I care most about.  Anyone else want to be binutils release manager?]

-- 
Daniel Jacobowitz
CodeSourcery
