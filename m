Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 18:09:31 +0100 (BST)
Received: from ananke.telenet-ops.be ([195.130.137.78]:6546 "EHLO
	ananke.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20021686AbXJJRJW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Oct 2007 18:09:22 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ananke.telenet-ops.be (Postfix) with SMTP id 4208F3923F4;
	Wed, 10 Oct 2007 19:09:12 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by ananke.telenet-ops.be (Postfix) with ESMTP id D7CE83923D2;
	Wed, 10 Oct 2007 19:09:09 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id l9AH99fW028259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 10 Oct 2007 19:09:09 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l9AH99RD028256;
	Wed, 10 Oct 2007 19:09:09 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Wed, 10 Oct 2007 19:09:09 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Franck Bui-Huu <fbuihuu@gmail.com>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/6] tlbex.c: Remove relocs[] and labels[] from the
 init.data section
In-Reply-To: <Pine.LNX.4.64N.0710101759590.9821@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.64.0710101909020.23818@anakin>
References: <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de>
 <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org>
 <4705004C.5000705@gmail.com> <20071005115151.GA16145@linux-mips.org>
 <470BE58A.9070709@gmail.com> <470BE61F.5020108@gmail.com>
 <20071010142755.GA9325@linux-mips.org> <Pine.LNX.4.64N.0710101715380.9821@blysk.ds.pg.gda.pl>
 <20071010164236.GB10243@linux-mips.org> <Pine.LNX.4.64.0710101854260.23818@anakin>
 <Pine.LNX.4.64N.0710101759590.9821@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 10 Oct 2007, Maciej W. Rozycki wrote:
> On Wed, 10 Oct 2007, Geert Uytterhoeven wrote:
> > Or e.g. static struct label labels[128] __initdata = { 0, };
> > Cfr. the old rule `always initialize initdata, even if it must be 0'.
> 
>  But this will not reduce the size of the kernel image, which is the 
> objective here.

That's true.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
