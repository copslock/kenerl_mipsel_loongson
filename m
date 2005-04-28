Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 16:21:29 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:26900 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225783AbVD1PVO>; Thu, 28 Apr 2005 16:21:14 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3SFLNt2005526;
	Thu, 28 Apr 2005 16:21:23 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3SFLNJb005525;
	Thu, 28 Apr 2005 16:21:23 +0100
Date:	Thu, 28 Apr 2005 16:21:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <KevinK@mips.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: preempt safe fpu-emulator
Message-ID: <20050428152123.GH1276@linux-mips.org>
References: <20050427.143622.77402407.nemoto@toshiba-tops.co.jp> <20050428134118.GC1276@linux-mips.org> <002d01c54bfa$5b913f80$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002d01c54bfa$5b913f80$0deca8c0@Ulysses>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 28, 2005 at 06:58:28AM -0700, Kevin D. Kissell wrote:

> When I first integrated the Algorithmics emulator with the Linux kernel
> several years back, I tried doing something like this but ran into some
> problem that I cannot recall exactly - there may have been some case
> where the system expected threads to "inherit" FCSR changes.  I agree
> that this is an obviously cleaner approach, but be careful.

The global variables definately won't fly anymore in preemptable and SMP
kernels.  Or rather any attempt to get that to work would only make things
worse, so they had to go.

  Ralf
