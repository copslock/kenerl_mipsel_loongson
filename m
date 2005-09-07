Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2005 17:05:25 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:28684 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225263AbVIGQFF>; Wed, 7 Sep 2005 17:05:05 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j87GBvTv017295;
	Wed, 7 Sep 2005 17:11:57 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j87GBvUd017294;
	Wed, 7 Sep 2005 17:11:57 +0100
Date:	Wed, 7 Sep 2005 17:11:57 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: unkillable process due to setup_frame() failure
Message-ID: <20050907161157.GA11379@linux-mips.org>
References: <20050906184118.GC3102@linux-mips.org> <Pine.LNX.4.61L.0509071011560.4591@blysk.ds.pg.gda.pl> <20050907134717.GA3493@linux-mips.org> <20050907.234413.108737010.anemo@mba.ocn.ne.jp> <Pine.LNX.4.61L.0509071619120.4591@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0509071619120.4591@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 07, 2005 at 04:24:05PM +0100, Maciej W. Rozycki wrote:

> > So my "which is preferred" question was inappropriate.  I had to ask
> > "#1 or #2 or both or other ?"
> 
>  We should be consistent with other platforms -- having a look at e.g. the 
> i386 (as it used to be the reference) and the alpha (as close-enough to 
> MIPS) should reveal the answer.  IIRC, a SIGSEGV that has a handler 
> installed, but which cannot be callled due to a bad stack pointer is 
> forced to SIG_DFL, but you may want to double-check it.

That's what's already happening.  We call force_sigsegv which is like
force_sig unless it's trying to deliver a SIGSEGV in which case it'll
reset the handler to SIG_DFL, return to userspace where it hits the
break instruction and starts all over to process the SIGTRAP.

  Ralf
