Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Dec 2007 11:01:46 +0000 (GMT)
Received: from hoboe1bl1.telenet-ops.be ([195.130.137.72]:4774 "EHLO
	hoboe1bl1.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20031501AbXLDLBd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Dec 2007 11:01:33 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hoboe1bl1.telenet-ops.be (Postfix) with SMTP id 81DAED4051;
	Tue,  4 Dec 2007 12:01:22 +0100 (CET)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by hoboe1bl1.telenet-ops.be (Postfix) with ESMTP id F13AED4036;
	Tue,  4 Dec 2007 12:01:21 +0100 (CET)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id lB4B1LCE024122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Dec 2007 12:01:21 +0100
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id lB4B1KD5024119;
	Tue, 4 Dec 2007 12:01:20 +0100
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Tue, 4 Dec 2007 12:01:20 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Andy Whitcroft <apw@shadowen.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] SC26XX: New serial driver for SC2681 uarts
In-Reply-To: <20071204082534.GA5938@alpha.franken.de>
Message-ID: <Pine.LNX.4.64.0712041201080.22756@anakin>
References: <20071202194346.36E3FDE4C4@solo.franken.de>
 <20071203155317.772231f9.akpm@linux-foundation.org>
 <20071203155746.2dc4506d@laptopd505.fenrus.org> <20071204082534.GA5938@alpha.franken.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 4 Dec 2007, Thomas Bogendoerfer wrote:
> On Mon, Dec 03, 2007 at 03:57:46PM -0800, Arjan van de Ven wrote:
> > > > +#define SC26XX_MAJOR         204
> > > > +#define SC26XX_MINOR_START   205
> > > > +#define SC26XX_NR            2
> > 
> > did lanana assign these numbers officially?
> 
> I tried to numbers several months ago and didn't get any response :-(

What about a dynamic number?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
