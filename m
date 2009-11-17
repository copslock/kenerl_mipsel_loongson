Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2009 09:40:47 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34314 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492293AbZKQIkn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Nov 2009 09:40:43 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAH8em9j003327;
	Tue, 17 Nov 2009 09:40:49 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAH8el63003325;
	Tue, 17 Nov 2009 09:40:47 +0100
Date:	Tue, 17 Nov 2009 09:40:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	figo zhang <figo1802@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: why it not write those 6bits to entrylo0/1 register?
Message-ID: <20091117084047.GA2923@linux-mips.org>
References: <c6ed1ac50911170012u7a52fbb9h1ae62cabf766122f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ed1ac50911170012u7a52fbb9h1ae62cabf766122f@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 17, 2009 at 04:12:03PM +0800, figo zhang wrote:

> hi, all,
> i have a qusetion , in arch/mips/mm/tlb-r4k.c, __update_tlb() function:
>  321<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l321>#if
> defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
> 322<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l322>
>                write_c0_entrylo0(ptep->pte_high);
> 323<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l323>
>                ptep++;
> 324<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l324>
>                write_c0_entrylo1(ptep->pte_high);
> 325<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l325>#else
> 326<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l326>
>                write_c0_entrylo0(pte_val(*ptep++) >> 6);
> 327<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l327>
>                write_c0_entrylo1(pte_val(*ptep) >> 6);
> 328<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/mm/tlb-r4k.c;h=d73428b18b0a41da13e81c64021e62505200ff2d;hb=317c68c04d53198f38314d29ba28b8fc632eccab#l328>#endif
> 
> why this right shift 6 bits? this 6 bits contain some important bit, such
> as:
> C: [bit3~5]: cohereny attribute of page

No, the low 6 bits contain other information maintained by the kernel.
Shifting right by 6 bits is used to drop these software bits.  The
hardware bits are stored in bits 6 and up in a pte so the shift operation
is going to move them into the right place.

> D:
> V:
> G:
> 
> and how the kernel write the this 6 bit to entrylo0/1 register?

A TLB write instruction about 5 lines further down in the code.

  Ralf
