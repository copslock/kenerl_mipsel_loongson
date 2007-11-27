Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2007 17:25:18 +0000 (GMT)
Received: from astra.telenet-ops.be ([195.130.132.58]:57283 "EHLO
	astra.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S28574692AbXK0RZJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Nov 2007 17:25:09 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by astra.telenet-ops.be (Postfix) with SMTP id 24B1638168;
	Tue, 27 Nov 2007 18:25:09 +0100 (CET)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by astra.telenet-ops.be (Postfix) with ESMTP id 54C1038128;
	Tue, 27 Nov 2007 18:25:08 +0100 (CET)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id lARHP8XK015373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 27 Nov 2007 18:25:08 +0100
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id lARHP6k3015370;
	Tue, 27 Nov 2007 18:25:07 +0100
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Tue, 27 Nov 2007 18:25:06 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	"Luis R. Rodriguez" <mcgrof@gmail.com>
Cc:	loswillios <loswillios@gmail.com>, kyle@mcmartin.ca,
	linux-wireless@vger.kernel.org, developers@islsm.org,
	linux-mips@linux-mips.org
Subject: Re: prism54 - MIPS do_be() trap caught
In-Reply-To: <43e72e890711270917o309441a0g99ac435a629b6d5e@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0711271824350.14777@anakin>
References: <43e72e890711270917o309441a0g99ac435a629b6d5e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 27 Nov 2007, Luis R. Rodriguez wrote:
> Changing subject, CC'ing linux-mips, perhaps they can help.
> 
> On Nov 26, 2007 7:54 PM, loswillios <loswillios@gmail.com> wrote:
> > Jan Willies wrote:
> > > Luis R. Rodriguez wrote:
> > >> Actually I've been informed this is not unaligned access problem but
> > >> instead it occurs on do_be() or ip22_be_interrupt() on MIPS. I'll have
> > >> to check how that works, I do not yet understand how this is reached.
> > >
> > > I will try a new build with prism54 in the next days and let you know if
> > > that issue is still present.
> >
> > Still the same problem with 2.6.23.1:
> >
> > root@OpenWrt:/# ifconfig eth1 up
> > eth1: resetting device...
> > eth1: uploading firmware...
> > eth1: firmware version: 1.0.4.3
> > eth1: firmware upload complete
> > eth1: interface reset complete
> >
> > root@OpenWrt:/# iwlist eth1 scanning
> > Data bus error, epc == c011518c, ra == c01146cc
> > Oops[#1]:
> > Cpu 0
> > $ 0   : 00000000 1000b800 abad0000 00000032
> > $ 4   : 00000001 c00c8000 00000013 00000001
> > $ 8   : 0000003c 80102bd4 ffffffff 81e2101c
> > $12   : ffffffff 00000580 2ab8af24 00000498
> > $16   : 81e21680 000000fa 81339380 0000004a
> > $20   : 81339380 00000000 a1e80000 81339000
> > $24   : 00000000 2abd55e0
> > $28   : 813b4000 813b5cc8 00000019 c01146cc
> > Hi    : 00000000
> > Lo    : 00000580
> > epc   : c011518c     Not tainted
> > ra    : c01146cc Status: 1000b803    KERNEL EXL IE
> > Cause : 0000001c
> > PrId  : 00029007
> 
> I can see that this comes from arch/mips/kernel/traps.c do_be() but I
> fail to see when this is triggered. Perhaps someone from linux-mips
> might be able to help shed some light here. I tried looking into the
> stack trace before but I couldn't find any code that made me suspect
> of a possible big endian problem (it seems that may be the problem?).
> The stack trace used to look like this:

BE = bus error, not big endian here.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
