Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2009 14:03:13 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:11687 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21365126AbZA3ODL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2009 14:03:11 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n0UE39FF019462;
	Fri, 30 Jan 2009 14:03:09 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0UE39W4019460;
	Fri, 30 Jan 2009 14:03:09 GMT
Date:	Fri, 30 Jan 2009 14:03:09 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: GCC-4.3.3 sillyness
Message-ID: <20090130140309.GA17050@linux-mips.org>
References: <20090130074407.GA12368@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090130074407.GA12368@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 30, 2009 at 08:44:07AM +0100, Manuel Lauss wrote:

> Can't build kernel because gcc-4.3.3 comes up with this gem:
> 
>   CC      arch/mips/kernel/traps.o
> cc1: warnings being treated as errors
> /linux-2.6.git/arch/mips/kernel/traps.c: In function 'set_uncached_handler':
> /linux-2.6.git/arch/mips/kernel/traps.c:1599: error: format not a string literal and no format arguments
> 
> The fastest fix is the patch below, but I don't know whether it is
> the right thing to do.

Is this new with 4.3.3?  I've not ran into this problem with 4.3.2 so far.
Or it could be configuration dependent ...

This seems a gcc bug so could you extract a test case and file a gcc bug
report?

  Ralf
