Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2004 11:39:30 +0000 (GMT)
Received: from p508B7363.dip.t-dialin.net ([IPv6:::ffff:80.139.115.99]:7250
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225219AbUBCLja>; Tue, 3 Feb 2004 11:39:30 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i13BdSex029083
	for <linux-mips@linux-mips.org>; Tue, 3 Feb 2004 12:39:28 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i13BdS1p029082
	for linux-mips@linux-mips.org; Tue, 3 Feb 2004 12:39:28 +0100
Date: Tue, 3 Feb 2004 12:39:28 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Re: R4600 V1.7 errata
Message-ID: <20040203113928.GA28340@linux-mips.org>
References: <20040129102215.GC17760@ballina> <4018E322.9030801@gentoo.org> <20040131030435.GA24228@linux-mips.org> <20040131141027.GA11048@ballina> <20040201045258.GA4601@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201045258.GA4601@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 01, 2004 at 05:52:58AM +0100, Ralf Baechle wrote:

> > Well, it a little 'better'. It now hangs while configurating the network
> > device, while in earlier versions the freeze appeared while calibrating the
> > delay loop, or mounting the root fs.
> > Is there something else I could try?
> > Until I know what's going on, I am going to look for a kernel with proper
> > VINO support which is 'old' enough to run without the freeze..
> 
> Seems I lost the R4600 V1.7 errata documents I used to have so all
> information that is left to me is what's documented in the Linux code.
> I've removed all the mentioned instructions and the kernel which
> otherwise is running fine on R5000 systems or R4600 V2.0 keeps crashing.
> I suspect I'm becoming victim of some of the other of the chip's errata;
> it has at least 18 ...
> 
> Anybody still got errata information for the R4600 V1.7 around?

Jorik was so friendly to track down the patch in CVS that broke the R4600
V1.7 back in time.  With that as a start it was fairly easy to isolate the
problem further.  Seems we became victim of some erratum that affects the
operation of indexed I-cache flushes only.  Last night I commited a patch
that provides an optimized solution for the problem.

Still, knowing the errata sheet of this processor has at least 18 items
on it I'd not place bets on it being totally reliable.  Therefore I'm
still interested, just in case somebody happens to run over a dusty errata
sheet somewhere :-)

  Ralf
