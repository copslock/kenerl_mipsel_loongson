Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fABAEec10134
	for linux-mips-outgoing; Sun, 11 Nov 2001 02:14:40 -0800
Received: from mail.sonytel.be (main.sonytel.be [195.0.45.167])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fABAEa010130
	for <linux-mips@oss.sgi.com>; Sun, 11 Nov 2001 02:14:36 -0800
Received: from mullein.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id LAA23324;
	Sun, 11 Nov 2001 11:14:26 +0100 (MET)
Date: Sun, 11 Nov 2001 11:14:26 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jun Sun <jsun@mvista.com>
cc: Linux/MIPS Development <linux-mips@oss.sgi.com>,
   Linux/m68k <linux-m68k@lists.linux-m68k.org>,
   Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
In-Reply-To: <20011110231746.B4342@mvista.com>
Message-ID: <Pine.GSO.4.21.0111111107170.10838-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 10 Nov 2001, Jun Sun wrote:
> For many MIPS boards that start to use CONFIG_NEW_TIME_C, two rtc operations
> are implemented, rtc_get_time() and rtc_set_time().
>
> It is possible to write a simple generic RTC driver that is based on
> these two ops and can do simple RTC read&write ops.
>
> In other words, with such a driver, once you implemented rtc_get_time()
> and rtc_set_time(), which is required by the kernel anyway, you will
> automatically get a free /dev/rtc/ driver.
>
> This is the idea behind the generic MIPS rtc driver.  See the patch below.

Oh no, don't tell me we now have (at least) _three_ of these floating around
:-)

  - On m68k, we have drivers/char/genrtc.c (not yet merged, check out CVS, see
    http://linux-m68k-cvs.apia.dhs.org/).
  - On PPC, we have drivers/macintosh/rtc.c.
  - On MIPS, we now have your drivers/char/mips_rtc.c.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
