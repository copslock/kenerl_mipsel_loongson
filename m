Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2003 18:27:48 +0100 (BST)
Received: from p508B7959.dip.t-dialin.net ([IPv6:::ffff:80.139.121.89]:58056
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225073AbTDAR1r>; Tue, 1 Apr 2003 18:27:47 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h31HRii19587;
	Tue, 1 Apr 2003 19:27:44 +0200
Date: Tue, 1 Apr 2003 19:27:44 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Hartvig Ekner <hartvig@ekner.info>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Patch to make c-mips32.c compile when HW coherency is used
Message-ID: <20030401192743.A31459@linux-mips.org>
References: <3E898800.450410D3@ekner.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E898800.450410D3@ekner.info>; from hartvig@ekner.info on Tue, Apr 01, 2003 at 02:37:20PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 01, 2003 at 02:37:20PM +0200, Hartvig Ekner wrote:

> The patch totally removes the dma_cache functions and the function
> pointers when the kernel is compiled for HW coherency. Previously it
> didn't compile at all since the function pointers are non-existant in
> this case.
> 
> The same problem exists in all the other c-*.c files in arch/mips/mm,
> so maybe there is something which I don't understand?

The reason is trivial - to this date only two platforms do support hw
coherency for I/O, the R10000-based Origin 200/2000 aka SGI IP27 and
Sibyte SB1-based platforms.

Fortunately the number of coherent platforms is increasing.  The
extra hardware costs very little these days but it dramatically helping
to guarantee system performance and correctness of system software.

  Ralf
