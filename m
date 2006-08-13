Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2006 18:07:49 +0100 (BST)
Received: from witte.sonytel.be ([80.88.33.193]:56741 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S20039220AbWHMRHr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2006 18:07:47 +0100
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id k7DH7hQe001780;
	Sun, 13 Aug 2006 19:07:43 +0200 (MEST)
Date:	Sun, 13 Aug 2006 19:07:43 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Kaz Kylheku <kaz@zeugmasystems.com>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: RE: [PATCH 2/6] setup.c: move initrd code inside dedicated functions
In-Reply-To: <66910A579C9312469A7DF9ADB54A8B7D33AF4A@exchange.ZeugmaSystems.local>
Message-ID: <Pine.LNX.4.62.0608131905060.22076@pademelon.sonytel.be>
References: <66910A579C9312469A7DF9ADB54A8B7D33AF4A@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 11 Aug 2006, Kaz Kylheku wrote:
> Franck Bui-Huu wrote:
> > Atsushi Nemoto wrote:
> > >> +	printk(KERN_INFO "Initial ramdisk at: 0x%p (%lu bytes)\n",
> > >> +	       (void *)initrd_start, initrd_size);
> > > 
> > > You can use "0x%lx" for initrd_start and remove the cast.  
> > I know this
> > > fragment are copied from corrent code as is, but it would be a good
> > > chance to clean it up.
> > > 
> > 
> > You're right.
> 
> Actually the cast that is there is only pedantic. ANSI C says that
> %p must be met with a void *, which might be important on some
> exotic machine where pointers have a different representation
> based on their type. Elsewhere, it would be very surprising
> if omitting the (void *) caused a problem with %p.

Except that initrd_start is not a pointer, but an unsigned long...

> And you have to cast to an integer that is wide enough for the
> pointer.  If you are compiling for 64 bit, that means
> "unsigned long long", unless you are sure that the upper
> 32 bits are all zero. 

unsigned long is 64-bit on LP64 systems, i.e. on all 64-bit Linux systems.
That excludes (why am I not surprised) Win64, which is P64.

> Ideally, you should just be able to use %p to print pointers,
> and I'd love to recommend that. It should be smart enough to
> know that they are 64 bits wide. I'm looking at the vsprintf
> in 2.6.17 and see that, sadly, it converts the void * pulled
> from the va_arg to "unsigned long".

%p works fine for pointers, on both 32-bit and 64-bit Linux.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
