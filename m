Received:  by oss.sgi.com id <S553742AbRCDUYB>;
	Sun, 4 Mar 2001 12:24:01 -0800
Received: from aeon.tvd.be ([195.162.196.20]:21801 "EHLO aeon.tvd.be")
	by oss.sgi.com with ESMTP id <S553739AbRCDUXc>;
	Sun, 4 Mar 2001 12:23:32 -0800
Received: from callisto.of.borg (root@cable-195-162-216-133.upc.chello.be [195.162.216.133])
	by aeon.tvd.be (8.9.3/8.9.3/RELAY-1.1) with ESMTP id VAA22146
	for <linux-mips@oss.sgi.com>; Sun, 4 Mar 2001 21:23:29 +0100 (MET)
Received: from localhost (geert@localhost)
	by callisto.of.borg (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id VAA13141
	for <linux-mips@oss.sgi.com>; Sun, 4 Mar 2001 21:21:16 +0100
X-Authentication-Warning: callisto.of.borg: geert owned process doing -bs
Date:   Sun, 4 Mar 2001 21:21:16 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: drivers/sgi/char/linux_logo.h
Message-ID: <Pine.LNX.4.05.10103042119540.12571-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

	Hi,

I'm cleaning up the logo code and found a penguin-with-beer logo (the
politically incorrect version) in drivers/sgi/char/linux_logo.h.

However, it looks like this file is not used anymore. Can I remove it?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
