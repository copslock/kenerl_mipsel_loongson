Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Oct 2008 22:33:44 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:26245 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22449290AbYJZWdg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 26 Oct 2008 22:33:36 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9QMXX2a028695;
	Sun, 26 Oct 2008 22:33:33 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9QMXVd0028693;
	Sun, 26 Oct 2008 22:33:31 GMT
Date:	Sun, 26 Oct 2008 22:33:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Chad Reese <kreese@caviumnetworks.com>
Cc:	ddaney@caviumnetworks.com, linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 35/37] Set c0 status for ST0_KX on Cavium OCTEON.
Message-ID: <20081026223331.GA21572@linux-mips.org>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com> <1224809821-5532-36-git-send-email-ddaney@caviumnetworks.com> <20081026124821.GN25297@linux-mips.org> <49051A78.8080601@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49051A78.8080601@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 26, 2008 at 06:33:44PM -0700, Chad Reese wrote:

> >> -#ifdef CONFIG_64BIT
> >> +#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_CAVIUM_OCTEON)
> >> +	/*
> >> +	 * Note: We always set ST0_KX on Octeon since IO addresses are at
> >> +	 * 64bit addresses. Keep in mind this also moves the TLB handler.
> >> +	 */
> >>  	setup_c0_status ST0_KX 0
> > 
> > That's a bit odd - on 64-bit kernels KX would be set anyway and on 32-bit
> > kernels would be corrupted by exceptions or interrupts, so 64-bit
> > addresses are not safe to use on 32-bit kernels for most part.
> > 
> > 32-bit virtual addresses mapped to a non-compat address otoh will work fine
> > without KX set.
> > 
> >   Ralf
> 
> The Octeon IO space regions are significantly larger than a 32bit kernel
> could tlb map easily. The entire range takes 49 bits to address. As a
> not particularly clean, but working alternative, we enable 64bit
> addressing in the kernel and used XKPHYS to access IO. Every access was
> surrounded by a local_irq_save/local_irq_restore. Since this is ugly to
> the extreme, maybe we should drop being able to boot a 32bit kernel on
> Octeon until something better is worked out.

That address space may be huge but for any given application you're
probably only ever going to access a tiny fraction of it - in particular
one where the kernel model of choice is a 32-bit kernel.

If these assumptions don't hold for the Cavium, then I ditching 32-bit
kernels is the obvious choice.  We've given up on 32-bit kernels for the
SGI O2 for example - it was just too ugly, too painful.  For very small
configurations of SGI Origins it would have been possible similarly for
small Broadcom Sibyte configs - but in practice these days we use 64-bit
kernels.  32-bit is just so yesterday and the 64-bit Linux/MIPS kernels
are now nearly a decade old.

  Ralf
