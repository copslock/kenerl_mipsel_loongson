Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3P8BdwJ011861
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Apr 2002 01:11:39 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3P8BdBW011860
	for linux-mips-outgoing; Thu, 25 Apr 2002 01:11:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3P8BWwJ011847;
	Thu, 25 Apr 2002 01:11:33 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA16985;
	Thu, 25 Apr 2002 10:11:55 +0200 (MET DST)
Date: Thu, 25 Apr 2002 10:11:55 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Pete Popov <ppopov@mvista.com>, linux-mips <linux-mips@oss.sgi.com>
Subject: Re: reiserfs
In-Reply-To: <20020425005128.A26673@dea.linux-mips.net>
Message-ID: <Pine.GSO.4.21.0204251011190.1401-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 25 Apr 2002, Ralf Baechle wrote:
> On Wed, Apr 24, 2002 at 04:13:06PM -0700, Pete Popov wrote:
> > Has anyone been able to run reiserfs on big endian systems?
> 
> I've seen reports of people running Reiserfs on MIPS but I don't know what
> endianess.

Some people run it on PowerPC, which is big endian as far as Linux is
concerned.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
