Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0SLQir06747
	for linux-mips-outgoing; Mon, 28 Jan 2002 13:26:44 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0SLQeP06737
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 13:26:40 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id VAA22777;
	Mon, 28 Jan 2002 21:26:23 +0100 (MET)
Date: Mon, 28 Jan 2002 21:26:24 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jun Sun <jsun@mvista.com>
cc: Phil Thompson <phil@river-bank.demon.co.uk>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: pgd_init() Patch
In-Reply-To: <3C55AEEA.EC76C0D4@mvista.com>
Message-ID: <Pine.GSO.4.21.0201282125380.2836-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 28 Jan 2002, Jun Sun wrote:
> Geert Uytterhoeven wrote:
> > On Mon, 28 Jan 2002, Phil Thompson wrote:
> > > Should USER_PTRS_PER_PGD be defined as (TASK_SIZE/PGDIR_SIZE) + 1?
> > 
> > You mean ((TASK_SIZE)+1)/PGDIR_SIZE?
> > 
> 
> No.  It should be
> 
> +#define USER_PTRS_PER_PGD      ((TASK_SIZE-1)/PGDIR_SIZE + 1)
> 
> Mathmatically, 
> 
> USER_PTRS_PER_PGD=ceil(TASK_SIZE/PGDIR_SIZE)

OK, ((TASK_SIZE+PGDIR_SIZE-1)/PGDIR_SIZE) in that case :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
