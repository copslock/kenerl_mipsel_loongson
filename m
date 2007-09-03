Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2007 17:06:45 +0100 (BST)
Received: from adicia.telenet-ops.be ([195.130.132.56]:21459 "EHLO
	adicia.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20022928AbXICQGh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Sep 2007 17:06:37 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by adicia.telenet-ops.be (Postfix) with SMTP id 893032300DD;
	Mon,  3 Sep 2007 18:06:36 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by adicia.telenet-ops.be (Postfix) with ESMTP id 7405C2300D9;
	Mon,  3 Sep 2007 18:06:36 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-8) with ESMTP id l83G6a5I022606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 3 Sep 2007 18:06:36 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l83G6ZXA022603;
	Mon, 3 Sep 2007 18:06:36 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Mon, 3 Sep 2007 18:06:35 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Matteo Croce <technoboy85@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/7] AR7: core support
In-Reply-To: <20070903150444.GC29574@networkno.de>
Message-ID: <Pine.LNX.4.64.0709031803070.17455@anakin>
References: <40101cc30709030623r4fb2d3caw146fa6dec16b283e@mail.gmail.com>
 <20070903150444.GC29574@networkno.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 3 Sep 2007, Thiemo Seufer wrote:
> Matteo Croce wrote:
> > +static int gcd(int x, int y)
> > +{
> > +	if (x > y)
> > +		return (x % y) ? gcd(y, x % y) : y;
> > +	return (y % x) ? gcd(x, y % x) : x;
> > +}

Ugh, recursion...

> > +static inline int ABS(int x)
> > +{
> > +	return (x >= 0) ? x : -x;
> > +}
> 
> Isn't that already available in the generic kernel code?

abs() is in <linux/kernel.h>

gcd() is in net/ipv4/ipvs/ip_vs_wrr.c (case a > b only) and
sound/core/pcm-timer.c (both).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
