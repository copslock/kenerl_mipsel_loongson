Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2009 10:25:57 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39211 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492488AbZKQJZy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Nov 2009 10:25:54 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAH9Q1kb004405;
	Tue, 17 Nov 2009 10:26:01 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAH9Q1e7004403;
	Tue, 17 Nov 2009 10:26:01 +0100
Date:	Tue, 17 Nov 2009 10:26:01 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	figo zhang <figo1802@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: why it not write those 6bits to entrylo0/1 register?
Message-ID: <20091117092601.GB2923@linux-mips.org>
References: <c6ed1ac50911170012u7a52fbb9h1ae62cabf766122f@mail.gmail.com> <20091117084047.GA2923@linux-mips.org> <c6ed1ac50911170059w600de299kfe4d79916547d809@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ed1ac50911170059w600de299kfe4d79916547d809@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 17, 2009 at 04:59:59PM +0800, figo zhang wrote:

> > > why this right shift 6 bits? this 6 bits contain some important bit, such
> > > as:
> > > C: [bit3~5]: cohereny attribute of page
> >
> > No, the low 6 bits contain other information maintained by the kernel.
> > Shifting right by 6 bits is used to drop these software bits.  The
> > hardware bits are stored in bits 6 and up in a pte so the shift operation
> > is going to move them into the right place.
> >
> 
> But i have see the kernel code: include/asm-mips/pgtable-bits.h:
> #define _CACHE_UNCACHED             (2<<3)
> #define _CACHE_CACHABLE_NONCOHERENT (3<<3)
> #define _CACHE_CACHABLE_COW         (3<<3)  /* Au1x                    */

This is code for the special case where CONFIG_64BIT_PHYS_ADDR and
CONFIG_CPU_MIPS32 are both defined.  In that case tlb-r4k.c also won't do
shifting.

> in include/asm-mips/pgtbale.h:
> #define PAGE_READONLY __pgprot(_PAGE_PRESENT | _PAGE_READ | \
>    PAGE_CACHABLE_DEFAULT)
> 
> so, if i set a page attrubite is PAGE_READONLY, this attribute will set to
> pte , right? so ,
> why it should shift 6 bits?
> 
> >
> > > D:
> > > V:
> > > G:
> > >
> > > and how the kernel write the this 6 bit to entrylo0/1 register?
> >
> > A TLB write instruction about 5 lines further down in the code.
> >
> 
> which function write those 6 bits to register? tlb_write_indexed() ? if i
> want set pages cache attribute is uncached/write-back , how it can set it
> correctly to MIPS?

See drivers/char/mem.c; search for pgprot_noncached().  This is where
for uncached mmaps pick the apropriate page protection and cache bits.
Several other drivers may do equivalent things.

  Ralf
