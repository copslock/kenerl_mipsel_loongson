Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 14:39:27 +0200 (CEST)
Received: from p508B493B.dip.t-dialin.net ([80.139.73.59]:43681 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123397AbSJDMj0>; Fri, 4 Oct 2002 14:39:26 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g94CcjF15967;
	Fri, 4 Oct 2002 14:38:45 +0200
Date: Fri, 4 Oct 2002 14:38:45 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Hartvig Ekner <hartvige@mips.com>
Cc: Dominic Sweetman <dom@algor.co.uk>,
	Carsten Langgaard <carstenl@mips.com>,
	linux-mips@linux-mips.org
Subject: Re: Promblem with PREF (prefetching) in memcpy
Message-ID: <20021004143845.A15883@linux-mips.org>
References: <200210041153.MAA12052@mudchute.algor.co.uk> <200210041233.g94CXrQ29071@copfs01.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210041233.g94CXrQ29071@copfs01.mips.com>; from hartvige@mips.com on Fri, Oct 04, 2002 at 02:33:53PM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 04, 2002 at 02:33:53PM +0200, Hartvig Ekner wrote:

> this problem occurs in kernel space (kseg0), not user space. In user space
> there is no problem due to the TLB "protection" of PREFs going outside the
> process working set, but that doesn't help in kernel mode.

Assume a userspace device driver having some hardware mapped immediately
following a ordinary memory mapping.  In that case it would be possible
for prefetch to run from the one into the next mapping - boom.

  Ralf
