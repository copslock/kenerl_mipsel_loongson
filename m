Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g12AI9P00933
	for linux-mips-outgoing; Sat, 2 Feb 2002 02:18:09 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g12AI3d00930
	for <linux-mips@oss.sgi.com>; Sat, 2 Feb 2002 02:18:03 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA13347;
	Sat, 2 Feb 2002 10:17:49 +0100 (MET)
Date: Sat, 2 Feb 2002 10:17:50 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jun Sun <jsun@mvista.com>
cc: Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: gcc 3.x, -ansi and "static inline"
In-Reply-To: <20020201115206.A18085@mvista.com>
Message-ID: <Pine.GSO.4.21.0202021015450.24693-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 1 Feb 2002, Jun Sun wrote:
> We are trying to build userland apps with the newer kernel headers.
> Unexpected problems occur with the "static inline" declaration
> when "-ansi" option is used.
> 
> Anybody else is having the problem?
> 
> Also, what are the reasons for us to switch to "static inline" in the
> kernel header?
>
> Here is an example I am talking about:
> 
> In 2.4.2, we have in bitops.h:
> 
> extern __inline__ unsigned long ffz(unsigned long word)
> 
> In 2.4.17, we have instead:
> 
> static inline unsigned long ffz(unsigned long word)
> 
> This problem seems only happening with gcc 3.x.  I start to wonder
> whether we should fix kernel header.  In some case, the fix seems
> to be not exposing to userland (by #ifdef __KERNEL__).  In others,
> the fix might be using __inline__.  

Yes, #ifdef __KERNEL__ is the right fix.

> However, I really like to know what was the original motivation
> to do such a change.

See linux-kernel

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
