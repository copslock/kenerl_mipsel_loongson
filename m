Received:  by oss.sgi.com id <S553994AbRBNNVD>;
	Wed, 14 Feb 2001 05:21:03 -0800
Received: from mail.sonytel.be ([193.74.243.200]:2219 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S553906AbRBNNVC>;
	Wed, 14 Feb 2001 05:21:02 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id OAA27622;
	Wed, 14 Feb 2001 14:19:32 +0100 (MET)
Date:   Wed, 14 Feb 2001 14:19:31 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Steve Johnson <stevej@ridgerun.com>
cc:     ldavies@oz.agile.tv, linux-mips <linux-mips@oss.sgi.com>
Subject: Re: Ooops in kmalloc from request_region
In-Reply-To: <3A8A8518.F66EBFA3@ridgerun.com>
Message-ID: <Pine.GSO.4.10.10102141418550.8142-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 14 Feb 2001, Steve Johnson wrote:
>     You can't call kmalloc that early in the startup process.  Look at main.c,
> and init_IRQ comes before any of the memory initialization.
> 
>     Steve
> 
> Liam Davies wrote:
> 
> > I am currently at the stage of calling request_region in my irq_setup
> > function.
> > The call to request_region does a kmalloc which oops. The box has 256Mb Ram.
> >
> > Is this the right stage to be doing this call? Is there something that I
> > have missed
> > in setting up the memory regions or paging?

Hence use request_resource() while passing a statically allocated and
initialized struct resource instead.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
