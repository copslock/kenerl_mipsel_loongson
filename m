Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 10:33:21 +0000 (GMT)
Received: from p508B65B9.dip.t-dialin.net ([IPv6:::ffff:80.139.101.185]:17310
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225194AbTA1KdV>; Tue, 28 Jan 2003 10:33:21 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0SAXL125632
	for linux-mips@linux-mips.org; Tue, 28 Jan 2003 11:33:21 +0100
Date: Tue, 28 Jan 2003 11:33:21 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Re: [PATCH 2.5] FPU
Message-ID: <20030128113321.E20541@linux-mips.org>
References: <Pine.LNX.4.21.0301260251300.15950-100000@melkor> <20030126033529.GA4296@greglaptop.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030126033529.GA4296@greglaptop.attbi.com>; from lindahl@keyresearch.com on Sat, Jan 25, 2003 at 07:35:29PM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 25, 2003 at 07:35:29PM -0800, Greg Lindahl wrote:

> One good way to start with 2.5 bugs is to compare the code to the 2.4
> kernel. Often you can see places where bugs were fixed in 2.4 but the
> fixes were not also made to the equivalent 2.5 code. This will keep
> 2.4 and 2.5 as close as possible, just like we want to keep the 64-bit
> and 32-bit kernels as close as possible.

While that is fundamentaly true in reality it's often made much harder
because the 2.4 and 2.5 codebases have diverged so much and will diverge
even more so.

  Ralf
