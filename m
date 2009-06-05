Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2009 13:06:05 +0100 (WEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34204 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022309AbZFEMF6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Jun 2009 13:05:58 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n55C4Kh4020392;
	Fri, 5 Jun 2009 13:04:24 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n55C4HI8020382;
	Fri, 5 Jun 2009 13:04:17 +0100
Date:	Fri, 5 Jun 2009 13:04:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Arnd Bergmann <arnd@arndb.de>
Cc:	Sam Ravnborg <sam@ravnborg.org>,
	Jaswinder Singh Rajput <jaswinder@kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>,
	Michael Abbott <michael@araneidae.co.uk>
Subject: Re: [PATCH 4/6] headers_check fix: mips, ioctl.h
Message-ID: <20090605120414.GB23433@linux-mips.org>
References: <1244118232.5172.26.camel@ht.satnam> <20090604124631.GB19459@linux-mips.org> <20090604200953.GA13892@uranus.ravnborg.org> <200906051034.01817.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200906051034.01817.arnd@arndb.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 05, 2009 at 10:34:00AM +0100, Arnd Bergmann wrote:

> On Thursday 04 June 2009, Sam Ravnborg wrote:
> > Any specific reason why mips does not use include/asm-generic/ioctl.h?
> > Had mips done so this would not have been an issue.
> 
> The original include/asm-generic/ioctl.h did not allow overriding
> the values of _IOC_{SIZEBITS,DIRBITS,NONE,READ,WRITE}, so it
> was initially not possible to use it.
> 
> Nowadays, you can simply use the same approach as powerpc:
> 
> #ifndef _ASM_MIPS_IOCTL_H
> #define _ASM_MIPS_IOCTL_H
> 
> #define _IOC_SIZEBITS	13
> #define _IOC_DIRBITS	3
> 
> #define _IOC_NONE	1U
> #define _IOC_READ	2U
> #define _IOC_WRITE	4U
> 
> /*
>  * The following are included for compatibility
>  */
> #define _IOC_VOID	0x20000000
> #define _IOC_OUT	0x40000000
> #define _IOC_IN		0x80000000
> #define _IOC_INOUT	(IOC_IN|IOC_OUT)
> 
> #include <asm-generic/ioctl.h>
> 
> #endif	/* _ASM_MIPS_IOCTL_H */
> 
> This would indeed be a cleaner fix.

In fact that's almost identical to what I already have.  But I don't even
recall what _IOC_VOID, _IOC_OUT, _IOC_IN and _IOC_INOUT were meant to be
compatible with.  They were added in 2.1.14 so presumably they've become
irrlevant, so I've dropped them.  I bet nobody will notice.

  Ralf
