Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Feb 2004 04:53:00 +0000 (GMT)
Received: from p508B577C.dip.t-dialin.net ([IPv6:::ffff:80.139.87.124]:5416
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224793AbUBAExA>; Sun, 1 Feb 2004 04:53:00 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i114qwex005567
	for <linux-mips@linux-mips.org>; Sun, 1 Feb 2004 05:52:59 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i114qw18005566
	for linux-mips@linux-mips.org; Sun, 1 Feb 2004 05:52:58 +0100
Date: Sun, 1 Feb 2004 05:52:58 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: R4600 V1.7 errata
Message-ID: <20040201045258.GA4601@linux-mips.org>
References: <20040129102215.GC17760@ballina> <4018E322.9030801@gentoo.org> <20040131030435.GA24228@linux-mips.org> <20040131141027.GA11048@ballina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131141027.GA11048@ballina>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 31, 2004 at 03:10:27PM +0100, Jorik Jonker wrote:

> 
> On Sat, Jan 31, 2004 at 04:04:35AM +0100, Ralf Baechle wrote:
> > Over the past days a few fixes went into CVS, the last only a few minutes
> > ago.  Can you retry and let me know?
> 
> Well, it a little 'better'. It now hangs while configurating the network
> device, while in earlier versions the freeze appeared while calibrating the
> delay loop, or mounting the root fs.
> Is there something else I could try?
> Until I know what's going on, I am going to look for a kernel with proper
> VINO support which is 'old' enough to run without the freeze..

Seems I lost the R4600 V1.7 errata documents I used to have so all
information that is left to me is what's documented in the Linux code.
I've removed all the mentioned instructions and the kernel which
otherwise is running fine on R5000 systems or R4600 V2.0 keeps crashing.
I suspect I'm becoming victim of some of the other of the chip's errata;
it has at least 18 ...

Anybody still got errata information for the R4600 V1.7 around?

  Ralf
