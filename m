Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2007 09:29:41 +0100 (BST)
Received: from asia.telenet-ops.be ([195.130.137.74]:43451 "EHLO
	asia.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20022855AbXDII3h (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Apr 2007 09:29:37 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by asia.telenet-ops.be (Postfix) with SMTP id 4302ED41B9;
	Mon,  9 Apr 2007 10:29:27 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by asia.telenet-ops.be (Postfix) with ESMTP id 449F3D418E;
	Mon,  9 Apr 2007 10:29:26 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l398TP1Q020259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 9 Apr 2007 10:29:25 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l398TOCn020255;
	Mon, 9 Apr 2007 10:29:24 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Mon, 9 Apr 2007 10:29:24 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Change PCI host bridge setup/resources
In-Reply-To: <20070408230710.GA9092@alpha.franken.de>
Message-ID: <Pine.LNX.4.64.0704091028010.1807@anakin>
References: <20070408113457.GB7553@alpha.franken.de> <4619245F.4030704@ru.mvista.com>
 <20070408230710.GA9092@alpha.franken.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 9 Apr 2007, Thomas Bogendoerfer wrote:
> On Sun, Apr 08, 2007 at 09:20:31PM +0400, Sergei Shtylyov wrote:
> >    This is certainly *not* a PCI or [E]ISA resource. It's decoded by the 
> > *host* bridge.
> 
> so ? It's an IO address no device should use, because it won't work.
> Therefore mark it busy. That's all the code does.

Yep, it's transparently decoded ISA (which is behind PCI) to control the PCI
bus. Just traditional PC legacy hacks :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
