Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2008 07:41:01 +0100 (BST)
Received: from monty.telenet-ops.be ([195.130.132.56]:2432 "EHLO
	monty.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20029952AbYFIGk6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jun 2008 07:40:58 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by monty.telenet-ops.be (Postfix) with SMTP id E2C5454012;
	Mon,  9 Jun 2008 08:40:57 +0200 (CEST)
Received: from anakin.of.borg (78-21-204-88.access.telenet.be [78.21.204.88])
	by monty.telenet-ops.be (Postfix) with ESMTP id D51E254022;
	Mon,  9 Jun 2008 08:40:57 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-4) with ESMTP id m596evtr021336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 9 Jun 2008 08:40:57 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id m596evjw021333;
	Mon, 9 Jun 2008 08:40:57 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Mon, 9 Jun 2008 08:40:57 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Luke -Jr <luke@dashjr.org>
cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org
Subject: Re: bcm33xx port
In-Reply-To: <200806081836.42351.luke@dashjr.org>
Message-ID: <Pine.LNX.4.64.0806090839100.25145@anakin>
References: <200806072113.26433.luke@dashjr.org> <200806081527.31221.luke@dashjr.org>
 <Pine.LNX.4.55.0806082249330.15673@cliff.in.clinika.pl> <200806081836.42351.luke@dashjr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sun, 8 Jun 2008, Luke -Jr wrote:
> On Sunday 08 June 2008, Maciej W. Rozycki wrote:
> > On Sun, 8 Jun 2008, Luke -Jr wrote:
> > > >  Not exactly.  Try harder -- this is simple arithmetic and you've got
> > > > all the data given above already. :)
> > >
> > > 200 / 2? I'm not really sure what a 'jiffy' is..
> >
> >  Hmm, I have thought it can be inferred from the code involved or failing
> > that -- Google...  Well, anyway, a jiffy is a tick of the kernel timer or,
> > specifically in this context and to be more precise, the interval between
> > such two consecutive ticks or, in other words, 1/HZ.
                                                     ^^
Look at CONFIG_HZ, which is probably 100, 250, or 1000.

> jiffy = 1 / 200000 HZ = 0.000005 sec/tick
> loop = 200000 instructions / 2 instructions per loop = 100000 loops/sec
> 
> So 0.00000000005 loops per jiffy? But it can't be, since loops_per_jiffy isn't 
> floating point... :/

So loops_per_jiffie is approx. CPU clock frequency / CONFIG_HZ.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
