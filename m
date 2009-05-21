Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 07:28:24 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41195 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022721AbZEUG2Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 May 2009 07:28:16 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4L6S2bq017782;
	Thu, 21 May 2009 07:28:03 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4L6S2iR017780;
	Thu, 21 May 2009 07:28:02 +0100
Date:	Thu, 21 May 2009 07:28:02 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg Ungerer <gerg@snapgear.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: system lockup with 2.6.29 on Cavium/Octeon
Message-ID: <20090521062802.GC1656@linux-mips.org>
References: <4A139F50.7050409@snapgear.com> <20090520142604.GA29677@linux-mips.org> <4A14E6A1.4030700@snapgear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A14E6A1.4030700@snapgear.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 21, 2009 at 03:29:05PM +1000, Greg Ungerer wrote:

> Interestingly the definition of MODULE_START is like this:
>
> #if defined(CONFIG_MODULES) && defined(KBUILD_64BIT_SYM32) && \
>         VMALLOC_START != CKSSEG
> /* Load modules into 32bit-compatible segment. */
> #define MODULE_START    CKSSEG
>
>
> If MODULE_START wasn't defined then the module_alloc() code would
> have just called vmalloc() directly - and we wouldn't be in this
> mess :-)

The reason it's done like this is that if the kernel is in CKSEG0 and
modules in CKSEG2 all address references to kernel code and variables are
just 32-bit that is they can be referenced with a much shorter instruction
sequence than for full blown 64-bit code.  This is just one of the
artefacts and I think we can just ignore it.

  Ralf
