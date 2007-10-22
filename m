Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2007 15:30:32 +0100 (BST)
Received: from ananke.telenet-ops.be ([195.130.137.78]:40867 "EHLO
	ananke.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20024689AbXJVOaY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 Oct 2007 15:30:24 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ananke.telenet-ops.be (Postfix) with SMTP id BDC6A392413;
	Mon, 22 Oct 2007 16:30:23 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by ananke.telenet-ops.be (Postfix) with ESMTP id 949FE3923E4;
	Mon, 22 Oct 2007 16:30:23 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id l9MEUNGW003437
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Oct 2007 16:30:23 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l9MEUN6j003434;
	Mon, 22 Oct 2007 16:30:23 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Mon, 22 Oct 2007 16:30:23 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Wolfgang Denk <wd@denx.de>, linux-mips@linux-mips.org
Subject: Re: MIPS Makefile not picking up CROSS_COMPILE from environment
 setting
In-Reply-To: <20071022132131.GA31311@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0710221630050.30734@anakin>
References: <20071018184636.48637242E9@gemini.denx.de>
 <Pine.LNX.4.64.0710190915130.23164@anakin> <Pine.LNX.4.64.0710211036540.6155@anakin>
 <20071022132131.GA31311@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 22 Oct 2007, Ralf Baechle wrote:
> On Sun, Oct 21, 2007 at 10:37:29AM +0200, Geert Uytterhoeven wrote:
> > > BTW, currently there's a discussion about such things on lkml under the
> > > subject `Make m68k cross compile like every other architecture.'.
> > > 
> > > As you can probably guess, MIPS is unlike every other architecture, too ;-)
> > 
> > cc-cross-prefix got into mainline:
> > 910b40468a9ce3f2f5d48c5d260329c27d45adb5
> 
> So then here is a followup patch also unlike any other ;-)
> 
> As a convenience for MIPS hacking I keep ARCH hardweired to mips though.

Of course, same here for m68k ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
