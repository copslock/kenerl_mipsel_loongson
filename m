Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5E81gnC013520
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 14 Jun 2002 01:01:42 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5E81gPT013519
	for linux-mips-outgoing; Fri, 14 Jun 2002 01:01:42 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.sonytel.be (mail2.sonytel.be [195.0.45.172])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5E81anC013510
	for <linux-mips@oss.sgi.com>; Fri, 14 Jun 2002 01:01:37 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA25408;
	Fri, 14 Jun 2002 10:03:15 +0200 (MET DST)
Date: Fri, 14 Jun 2002 10:03:16 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
cc: Roman Zippel <zippel@linux-m68k.org>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>,
   Linux/m68k <linux-m68k@lists.linux-m68k.org>,
   Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC and PATCH] Move the m68k genrtc driver into 2.5 and use on
 PPC
In-Reply-To: <20020613190646.GT13541@opus.bloom.county>
Message-ID: <Pine.GSO.4.21.0206141002430.15725-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 13 Jun 2002, Tom Rini wrote:
> Secondly to the m68k people, does anyone have an objection (or would
> like to do it themselves?) with me trying to get Linus to take the
> changes to include/linux/rtc.h?  radeonfb.c currently conflicts with the

No objection at all :-) Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
