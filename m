Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2004 11:52:38 +0000 (GMT)
Received: from p508B7363.dip.t-dialin.net ([IPv6:::ffff:80.139.115.99]:20818
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225256AbUBCLwh>; Tue, 3 Feb 2004 11:52:37 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i13Bqaex029376
	for <linux-mips@linux-mips.org>; Tue, 3 Feb 2004 12:52:36 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i13Bqa2P029375
	for linux-mips@linux-mips.org; Tue, 3 Feb 2004 12:52:36 +0100
Date: Tue, 3 Feb 2004 12:52:36 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Re: R4600 V1.7 errata
Message-ID: <20040203115236.GB28340@linux-mips.org>
References: <20040129102215.GC17760@ballina> <4018E322.9030801@gentoo.org> <20040131030435.GA24228@linux-mips.org> <20040131141027.GA11048@ballina> <20040201045258.GA4601@linux-mips.org> <20040203113928.GA28340@linux-mips.org> <20040203114252.GA27810@icm.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203114252.GA27810@icm.edu.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 03, 2004 at 12:42:53PM +0100, Dominik 'Rathann' Mierzejewski wrote:

> On Tue, Feb 03, 2004 at 12:39:28PM +0100, Ralf Baechle wrote:
> [...] 
> > Jorik was so friendly to track down the patch in CVS that broke the R4600
> > V1.7 back in time.  With that as a start it was fairly easy to isolate the
> > problem further.  Seems we became victim of some erratum that affects the
> > operation of indexed I-cache flushes only.  Last night I commited a patch
> > that provides an optimized solution for the problem.
> 
> I assume it's safe to test it now? I'll build it for my R4600 V2.0 and
> report in a while. Stay tuned.

2.0 requires different workarounds which are already in place and functional
since quite some time.  We still lacking a fix for one important erratum of
the 2.0 but it seems pretty stable without.

Chip revs later than 2.0 do identify as 2.0 so if you're lucky your processor
is actually a post-2.0 and working just fine ...

  Ralf
