Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2007 16:22:16 +0100 (BST)
Received: from hoboe2bl1.telenet-ops.be ([195.130.137.73]:60635 "EHLO
	hoboe2bl1.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20022194AbXJHPWH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Oct 2007 16:22:07 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hoboe2bl1.telenet-ops.be (Postfix) with SMTP id E4E7812403D;
	Mon,  8 Oct 2007 17:21:56 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by hoboe2bl1.telenet-ops.be (Postfix) with ESMTP id C337112402B;
	Mon,  8 Oct 2007 17:21:56 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id l98FLubQ006449
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 8 Oct 2007 17:21:56 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l98FLu5j006446;
	Mon, 8 Oct 2007 17:21:56 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Mon, 8 Oct 2007 17:21:56 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
In-Reply-To: <470A4673.30604@gmail.com>
Message-ID: <Pine.LNX.4.64.0710081720550.1416@anakin>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl>
 <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org>
 <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de>
 <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de>
 <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org>
 <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl>
 <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64.0710051102300.32066@anakin>
 <470A4673.30604@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 8 Oct 2007, Franck Bui-Huu wrote:
> Geert Uytterhoeven wrote:
> > For specialized systems, you can always introduce the option to generate
> > the TLB handler at compile time:
> 
> What do you mean by "specialized system" ?

Embedded.

> If for some platforms we could generate the TLB handlers at compile
> time, we could do it for all platforms, specially if the handler only
> depends on the cpu type, no ?

Can't you currently compile a kernel that run on e.g. all O2s,
irrespective of the actual CPU type?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
