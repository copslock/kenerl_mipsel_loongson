Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g52AxinC006589
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 2 Jun 2002 03:59:44 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g52AxiYm006588
	for linux-mips-outgoing; Sun, 2 Jun 2002 03:59:44 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g52AxenC006583
	for <linux-mips@oss.sgi.com>; Sun, 2 Jun 2002 03:59:40 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id MAA05572;
	Sun, 2 Jun 2002 12:57:53 +0200 (MET DST)
Date: Sun, 2 Jun 2002 12:57:54 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Brian Murphy <brian@murphy.dk>
cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: Patch for support of Lasat 100 and 200 machines (~60k)
In-Reply-To: <3CF7C9B0.20808@murphy.dk>
Message-ID: <Pine.GSO.4.21.0206021256440.13419-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 31 May 2002, Brian Murphy wrote:
> The files not patched (not existing in the oss CVS) are
> in lasat.tar.gz. This includes arch/mips/lasat and
> include/asm-mips/lasat - one file to support r5000 cache

About <asm/lasat/vrc5074.h>: Vrc-5074 definitions already exist in
<asm/nile4.h>.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
