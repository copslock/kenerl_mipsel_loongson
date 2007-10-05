Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2007 10:09:51 +0100 (BST)
Received: from adicia.telenet-ops.be ([195.130.132.56]:61926 "EHLO
	adicia.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20026952AbXJEJJl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Oct 2007 10:09:41 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by adicia.telenet-ops.be (Postfix) with SMTP id 4C6792300C1;
	Fri,  5 Oct 2007 11:09:41 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by adicia.telenet-ops.be (Postfix) with ESMTP id 059DF2300E9;
	Fri,  5 Oct 2007 11:09:40 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id l9599eJX032425
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 5 Oct 2007 11:09:40 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l9599e4F032422;
	Fri, 5 Oct 2007 11:09:40 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Fri, 5 Oct 2007 11:09:40 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
In-Reply-To: <4705EFE5.7090704@gmail.com>
Message-ID: <Pine.LNX.4.64.0710051102300.32066@anakin>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl>
 <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org>
 <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de>
 <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de>
 <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org>
 <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl>
 <4705EFE5.7090704@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 5 Oct 2007, Franck Bui-Huu wrote:
> Maciej W. Rozycki wrote:
> > On Thu, 4 Oct 2007, Franck Bui-Huu wrote:
> > 
> >> It's just a bit sad to see my TLB handler generated at each boot and
> >> to embed the whole tlbex generator inside the kernel which is quite
> >> big:
> >>
> >>    $ mipsel-linux-size arch/mips/mm/tlbex.o
> >>       text    data     bss     dec     hex filename
> >>      10116    3904    1568   15588    3ce4 arch/mips/mm/tlbex.o
> >>
> >> specially if my cpu doesn't have any bugs.
> > 
> >  Well, most systems are there to work and not to be rebooted repeatedly 
> > all the time. ;-)  All of tlbex.o is discarded after bootstrap.
> > 
> 
> Yes, but some systems out there have some constraints on their boot time
> and others have ones on their persistent storage device size.
> 
> >> Maybe having, 2 default implementations in tlbex-r3k.S, tlbex-r4k.S
> >> for good cpus (the ones which needn't any fixups at all) and otherwise
> >> the tlbex.c is used. And with luck the majority of the cpus are
> >> good...
> > 
> >  Well, most of the differences are not due to CPU bugs, but different cp0 
> > hazards.  The MIPS32r2 and MIPS64r2 architecture specs introduce the "ehb" 
> > and "jr.hb" instructions to sort them out, but most of the processors we 
> > support predate them.
> > 
> >  The existence of the definitions in <asm/war.h> is there so that 
> > workarounds for CPU bugs are optimised away at the kernel build time if 
> > not activated.
> 
> Just to be sure I haven't missed anything, it seems that we _could_ generate
> the whole tlb handler at compile time since the CPU type is known at that
> time, no need to have any fixups at runtime, isn't it ?

For specialized systems, you can always introduce the option to generate
the TLB handler at compile time:
  - Enhance tlbex.c to be able to compile it for the host, and generate
    a fixed TLB handler, based on CONFIG_* options, if
    CONFIG_STATIC_TLB_HANDLER (buried deep in depends on EMBEDDED &&
    ADVANCED && I_KNOW_WHAT_I_AM_DOING) is set.
  - Let the dynamic runtime generator print the required CONFIG_*
    options for the system it runs on, so you know which one to set in
    your .config (a bit like calibrate_delay() prints the lpj=N value to
    pass to avoid calibrating the delay loop)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
