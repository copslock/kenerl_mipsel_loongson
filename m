Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2007 22:09:21 +0000 (GMT)
Received: from ananke.telenet-ops.be ([195.130.137.78]:50621 "EHLO
	ananke.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20032755AbXKOWJN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Nov 2007 22:09:13 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ananke.telenet-ops.be (Postfix) with SMTP id AE74A3923F1;
	Thu, 15 Nov 2007 23:09:02 +0100 (CET)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by ananke.telenet-ops.be (Postfix) with ESMTP id 8661A3923FA;
	Thu, 15 Nov 2007 23:09:02 +0100 (CET)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id lAFM92nP008746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 15 Nov 2007 23:09:02 +0100
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id lAFM92Jf008743;
	Thu, 15 Nov 2007 23:09:02 +0100
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Thu, 15 Nov 2007 23:09:01 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Introduce __fill_user() and kill __bzero() [take #2]
In-Reply-To: <473CB727.8010106@gmail.com>
Message-ID: <Pine.LNX.4.64.0711152308180.8650@anakin>
References: <473C720B.7000100@gmail.com> <Pine.LNX.4.64.0711151744580.31039@anakin>
 <473CB727.8010106@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 15 Nov 2007, Franck Bui-Huu wrote:
> Geert Uytterhoeven wrote:
> > On Thu, 15 Nov 2007, Franck Bui-Huu wrote:
> >>  I put the out of line version of memset in kernel/mips_ksym.c. I
> >>  haven't found a better place. But if you really think we should
> >>  create a lib/memset.c and rename lib/memset.S into lib/fill_user.S, I
> >>  can change it.
> > 
> > kernel/mips_ksym.c is not a good place.
> 
> Sigh... thanks for spotting this.
> 
> So since I've no idea where I could put this function I'll follow
> Thiemo's suggestion but instead of calling the new file lib/memset.c,
> I'll use lib/string.c since we could move or implement other stuffs in
> it.
> 
> Is it ok ?

lib/string.c sounds fine to me. That's where m68k and s390 implement it
as well.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
