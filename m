Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3QFKmwJ011689
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 26 Apr 2002 08:20:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3QFKmO4011688
	for linux-mips-outgoing; Fri, 26 Apr 2002 08:20:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3QFKiwJ011683
	for <linux-mips@oss.sgi.com>; Fri, 26 Apr 2002 08:20:45 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id RAA19935
	for <linux-mips@oss.sgi.com>; Fri, 26 Apr 2002 17:21:12 +0200 (MET DST)
Date: Fri, 26 Apr 2002 17:21:12 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: asm type names
Message-ID: <Pine.GSO.4.21.0204261718450.28137-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

	Hi,

include/asm-mips*/unaligned.h uses different terminology for the same sizes,
sometimes even in the same file, making things a bit confusing:
  - double vs. quad
  - word vs. long
  - halfword vs. word

Which set of terms is preferred, so we can increase consistency?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
