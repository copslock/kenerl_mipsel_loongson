Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6C9MwRw017253
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 02:22:58 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6C9Mw9I017252
	for linux-mips-outgoing; Fri, 12 Jul 2002 02:22:58 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.sonytel.be (mail2.sonytel.be [195.0.45.172])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6C9MdRw017237;
	Fri, 12 Jul 2002 02:22:42 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id LAA15525;
	Fri, 12 Jul 2002 11:26:41 +0200 (MET DST)
Date: Fri, 12 Jul 2002 11:26:41 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Sedjai, Mohamed" <MSedjai@tee.toshiba.de>
cc: Jon Burgess <Jon_Burgess@eur.3com.com>, Ralf Baechle <ralf@oss.sgi.com>,
   "Gleb O. Raiko" <raiko@niisi.msk.ru>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>, carstenl@mips.com
Subject: RE: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
In-Reply-To: <CEEE372345CE51438B0EC15F09ADE2710910F8@dus04a.tsb-eu.com>
Message-ID: <Pine.GSO.4.21.0207121125190.13307-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 12 Jul 2002, Sedjai, Mohamed wrote:
> If you run instruction cache flushing cached, then the cache will be dirty
> when the routine returns. At least the line(s) containing the routine itself ?
> Or am I missing something ?

Since the contents of the instruction cache are never changed (except by a
cache load), an instruction cache line can never become dirty.

Dirty cache lines and cache line write back are an exclusive privilege of write
back data caches.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
