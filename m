Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f63BADU25044
	for linux-mips-outgoing; Tue, 3 Jul 2001 04:10:13 -0700
Received: from dea.waldorf-gmbh.de (u-238-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.238])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f63B8cV24796
	for <linux-mips@oss.sgi.com>; Tue, 3 Jul 2001 04:09:02 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f63B5VG15216;
	Tue, 3 Jul 2001 13:05:31 +0200
Date: Tue, 3 Jul 2001 13:05:31 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Raghav P <raghav@ishoni.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Are page tables allocated in KSEG0 or in KSEG2?
Message-ID: <20010703130531.C14665@bacchus.dhis.org>
References: <E0FDC90A9031D511915D00C04F0CCD250399AA@leonoid.in.ishoni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E0FDC90A9031D511915D00C04F0CCD250399AA@leonoid.in.ishoni.com>; from raghav@ishoni.com on Sat, Jun 30, 2001 at 02:51:17PM +0530
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jun 30, 2001 at 02:51:17PM +0530, Raghav P wrote:

> I was going thru the TLB exception for R2300 and had the following doubts
> which I hope someone can help me out with. ( am sorry if this is a newbie
> question but since this is MIPS specific I am posting here)
> 
> The code is in arch/mips/kernel/head.S for user TLB:
> 
>         /* TLB refill, EXL == 0, R[23]00 version */
>         LEAF(except_vec0_r2300)
>         .set    noat
>         .set    mips1
>         mfc0    k0, CP0_BADVADDR
>         lw      k1, current_pgd                 # get pgd pointer
>         srl     k0, k0, 22
>         sll     k0, k0, 2
>         addu    k1, k1, k0
>         mfc0    k0, CP0_CONTEXT
>         lw      k1, (k1)
>         and     k0, k0, 0xffc
>         addu    k1, k1, k0
>         lw      k0, (k1)
>         nop
>         mtc0    k0, CP0_ENTRYLO0
>         mfc0    k1, CP0_EPC
>         tlbwr
>         jr      k1
>         rfe
>         END(except_vec0_r2300)
> 
> My linux book says that pgd and pte entries are not setup by the kernel
> until a pagefault exception occurs.
> The above code will work only if the pgd and pte tables are stored in kseg2;
> if they were stored in kseg0 then if a pgd has an invalid pte entry the
> above code will index into an invalid pte page and get a wrong physical
> address.
> But the pgd_alloc() and pte_alloc() routines seem to be allocating physical
> pages from kseg0 for pgd and pte tables.
> Am I missing something here???

We avoid having to deal with the special case of a non-existant parts of the
page table except the actual ptes themselfes by having making those pgd
pointers point to invalid_pte_table.

  Ralf
