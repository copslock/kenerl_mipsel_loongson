Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0SL5GD04240
	for linux-mips-outgoing; Mon, 28 Jan 2002 13:05:16 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0SL5BP04229
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 13:05:11 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0SK3GB03140;
	Mon, 28 Jan 2002 12:03:16 -0800
Message-ID: <3C55AEEA.EC76C0D4@mvista.com>
Date: Mon, 28 Jan 2002 12:04:58 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Phil Thompson <phil@river-bank.demon.co.uk>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: pgd_init() Patch
References: <Pine.GSO.4.21.0201282052240.2836-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Geert Uytterhoeven wrote:
> 
> On Mon, 28 Jan 2002, Phil Thompson wrote:
> > - USER_PTRS_PER_PGD is defined as TASK_SIZE/PGDIR_SIZE. However,
> > because, TASK_SIZE is actually defined as one less that the maximum task
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > size there is a rounding error that means that USER_PTRS_PER_PGD works
>   ^^^^
> > out at 511 rather than 512. This means that entries 511 and 1023 of
> > swapper_pg_dir don't get initialised.
> >
> > The corresponding mips64 code has only the first call to pgd_init() and
> > each implementation of pgd_init() initialises PTRS_PER_PGD entries,
> > where PTRS_PER_PGD is simple defined as 1024.
> >
> > The attached patch applies the mips64 approach to the mips code.
> >
> > Should USER_PTRS_PER_PGD be defined as (TASK_SIZE/PGDIR_SIZE) + 1?
> 
> You mean ((TASK_SIZE)+1)/PGDIR_SIZE?
> 

No.  It should be

+#define USER_PTRS_PER_PGD      ((TASK_SIZE-1)/PGDIR_SIZE + 1)

Mathmatically, 

USER_PTRS_PER_PGD=ceil(TASK_SIZE/PGDIR_SIZE)

I submitted this patch to Ralf on Jan 03.  Ralf, any reason for not applying
this?  This formula ensures PTRS_PER_PGD is always correct irrespect of the
values of TAKS_SIZE and PGDIR_SIZE.

See this patch and other pending patches at

http://linux.junsun.net/patches/oss.sgi.com/submitted

Jun
