Received:  by oss.sgi.com id <S42334AbQFTRaI>;
	Tue, 20 Jun 2000 10:30:08 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:6708 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42328AbQFTR3h>;
	Tue, 20 Jun 2000 10:29:37 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA11953
	for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 10:24:39 -0700 (PDT)
	mail_from (geert@linux-m68k.org)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA96851
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 20 Jun 2000 10:29:07 -0700 (PDT)
	mail_from (geert@linux-m68k.org)
Received: from aeon.tvd.be (aeon.tvd.be [195.162.196.20]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA00478
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Jun 2000 10:29:06 -0700 (PDT)
	mail_from (geert@linux-m68k.org)
Received: from callisto.of.borg (cable-195-162-216-83.upc.chello.be [195.162.216.83])
	by aeon.tvd.be (8.9.3/8.9.3/RELAY-1.1) with ESMTP id TAA02630;
	Tue, 20 Jun 2000 19:29:14 +0200 (MET DST)
Received: from localhost (geert@localhost)
	by callisto.of.borg (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id TAA20101;
	Tue, 20 Jun 2000 19:29:14 +0200
X-Authentication-Warning: callisto.of.borg: geert owned process doing -bs
Date:   Tue, 20 Jun 2000 19:29:14 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     frowand@mvista.com
cc:     Linux kernel <linux-kernel@vger.rutgers.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/MIPS Development <linux@cthulhu.engr.sgi.com>
Subject: Re: Proposal: non-PC ISA bus support
In-Reply-To: <394FA5D1.DDAEA1F6@mvista.com>
Message-ID: <Pine.LNX.4.05.10006201926500.19211-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 20 Jun 2000, Frank Rowand wrote:
> Geert Uytterhoeven wrote:
> > The following patch fixes 2 problems related to ISA bus access on non-PC
> > platforms:

    [...]

> Would it make sense to apply the same sort of fix to the following code in
> __ioremap(), so that ISA space is handled consistently?:
> 
>         /*
>          * If the address lies within the first 16 MB, assume it's in ISA
>          * memory space
>          */
>         if (p < 16*1024*1024)
>             p += _ISA_MEM_BASE;

Yes. I added that correction because the NVRAM driver wants to ioremap() the 
NVRAM region as reported by the OF device tree, while on CHRP boxes with PC
style NVRAM, it's in ISA memory space at 0xe0000 (`nvram@me0000', according to
OF).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
