Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA8HjGx12227
	for linux-mips-outgoing; Thu, 8 Nov 2001 09:45:16 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA8HjA012221;
	Thu, 8 Nov 2001 09:45:10 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fA8Hj4jV015200;
	Thu, 8 Nov 2001 09:45:04 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fA8Hj3Vv015196;
	Thu, 8 Nov 2001 09:45:04 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Thu, 8 Nov 2001 09:45:02 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
cc: linux-mips@oss.sgi.com, ralf@oss.sgi.com,
   linux-mips-kernel@lists.sourceforge.net
Subject: Re: i8259.c in big endian
In-Reply-To: <20011108.154702.74756496.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.LNX.4.10.10111080943230.13456-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Also I like to see away to pass in a base offset. I have a mips device
which has a i8259 chip but its io is offseted by 0xb0000000.

On Thu, 8 Nov 2001, Atsushi Nemoto wrote:

> arch/mips/kernel/i8259.c seems not working in big endian.
> 
> Here is a patch to fix this.
> 
> --- linux-sgi-cvs/arch/mips/kernel/i8259.c	Mon Sep 10 02:43:01 2001
> +++ linux.new/arch/mips/kernel/i8259.c	Thu Nov  8 15:40:03 2001
> @@ -70,8 +70,13 @@
>  static unsigned int cached_irq_mask = 0xffff;
>  
>  #define __byte(x,y) 	(((unsigned char *)&(y))[x])
> +#ifdef __BIG_ENDIAN
> +#define cached_21	(__byte(1,cached_irq_mask))
> +#define cached_A1	(__byte(0,cached_irq_mask))
> +#else
>  #define cached_21	(__byte(0,cached_irq_mask))
>  #define cached_A1	(__byte(1,cached_irq_mask))
> +#endif
>  
>  void disable_8259A_irq(unsigned int irq)
>  {
> ---
> Atsushi Nemoto
> 
