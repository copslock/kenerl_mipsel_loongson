Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4G8gjnC015503
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 16 May 2002 01:42:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4G8gjts015502
	for linux-mips-outgoing; Thu, 16 May 2002 01:42:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4G8gZnC015499
	for <linux-mips@oss.sgi.com>; Thu, 16 May 2002 01:42:38 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA11675;
	Thu, 16 May 2002 10:39:16 +0200 (MET DST)
Date: Thu, 16 May 2002 10:39:16 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ken Aaker <kenaaker@silverbacksystems.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: Mangled struct hd_driveid with MIPSEB.
In-Reply-To: <3CE3578C.CF29A2D6@mips.com>
Message-ID: <Pine.GSO.4.21.0205161035150.14918-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 16 May 2002, Carsten Langgaard wrote:
> I send Ralf a fix a couple of weeks ago, which introduced the byteswapping,
> which really is necessary.
> This fix is probably only necessary for bigendian systems with large IDE
> disks (>8GB), which support LBA mode.
> I send this patch over a year ago. I discovered that when I ran on a disk,
> which was larger than 8GB, it was only treated as 8GB.
> The problem with the fix is, it is not backward compatible. After the fix
> I needed to reinstall my bigendian system.
> As I told Ralf, this fix will be a pain for everyone, but I guess we need
> the fix eventually.

Why would you have to reinstall the system?
Isn't this just a problem with ide_fix_driveid() (new field for disks larger
than 8 GiB, which we don't byteswap yet)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
