Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0SKrZw02789
	for linux-mips-outgoing; Mon, 28 Jan 2002 12:53:35 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0SKrSP02785
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 12:53:29 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id UAA21184;
	Mon, 28 Jan 2002 20:53:14 +0100 (MET)
Date: Mon, 28 Jan 2002 20:53:15 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Phil Thompson <phil@river-bank.demon.co.uk>
cc: Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: pgd_init() Patch
In-Reply-To: <3C5553E7.7DFDBB55@river-bank.demon.co.uk>
Message-ID: <Pine.GSO.4.21.0201282052240.2836-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 28 Jan 2002, Phil Thompson wrote:
> - USER_PTRS_PER_PGD is defined as TASK_SIZE/PGDIR_SIZE. However,
> because, TASK_SIZE is actually defined as one less that the maximum task
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> size there is a rounding error that means that USER_PTRS_PER_PGD works
  ^^^^
> out at 511 rather than 512. This means that entries 511 and 1023 of
> swapper_pg_dir don't get initialised.
> 
> The corresponding mips64 code has only the first call to pgd_init() and
> each implementation of pgd_init() initialises PTRS_PER_PGD entries,
> where PTRS_PER_PGD is simple defined as 1024.
> 
> The attached patch applies the mips64 approach to the mips code.
> 
> Should USER_PTRS_PER_PGD be defined as (TASK_SIZE/PGDIR_SIZE) + 1?

You mean ((TASK_SIZE)+1)/PGDIR_SIZE?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
