Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2006 15:28:06 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:42524 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133422AbWBUP16 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Feb 2006 15:27:58 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1LFXDoc015432;
	Tue, 21 Feb 2006 15:33:14 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1LFXALD015429;
	Tue, 21 Feb 2006 15:33:10 GMT
Date:	Tue, 21 Feb 2006 15:33:10 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	Jim Gifford <maillist@jg555.com>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: GLIBC moved mips to Ports
Message-ID: <20060221153310.GA28396@linux-mips.org>
References: <43FA8F04.3040606@jg555.com> <20060221144211.GA19378@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221144211.GA19378@nevyn.them.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 21, 2006 at 09:42:11AM -0500, Daniel Jacobowitz wrote:

> Sigh.  Jim, you are slightly misinterpreting this.
> 
> MIPS has _never_ been a high priority of the glibc maintainers.  What
> happened here is that they admitted it - and moved it to a separate
> repository so that (A) they don't need to deal with it, and (B) people
> who are interested can deal with it.  It's unfortunate, but realistic.
> 
> The ports repository is going to continue to be supported and we're
> going to keep it working.  We just have to do the legwork.  I'll go
> over the MIPS build fixes this week sometime.

Great.  None of my patches in the past years has even received any sort
of feedback.  Maybe time to to look through them again ...

Leave waiting for 386 and gang to move to glibc ports as well.

  Ralf
