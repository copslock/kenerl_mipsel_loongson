Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4REDmnC006848
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 27 May 2002 07:13:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4REDlxi006847
	for linux-mips-outgoing; Mon, 27 May 2002 07:13:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4REDenC006844
	for <linux-mips@oss.sgi.com>; Mon, 27 May 2002 07:13:40 -0700
Message-Id: <200205271413.g4REDenC006844@oss.sgi.com>
Received: (qmail 9771 invoked from network); 27 May 2002 14:06:35 -0000
Received: from unknown (HELO foxsen) (159.226.40.150)
  by 159.226.39.4 with SMTP; 27 May 2002 14:06:35 -0000
Date: Mon, 27 May 2002 22:13:37 +0800
From: "Zhang Fuxin" <fxzhang@ict.ac.cn>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: PCI Graphics/Video Card for Malta Board?
X-mailer: Foxmail 4.1 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g4REDfnC006845
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

======= 2002-05-27 15:37:00 you wrote��=======

>On Mon, 27 May 2002, Steven J. Hill wrote:
>> Kevin D. Kissell wrote:
>> > I'd like to get a video-capable graphics card up
>> I can think of two things. First, a lot of graphics cards
>> rely on BIOS calls to be set up before the operating system
>> even boots. Second, I would stick to graphics cards that
>> have framebuffer support in the kernel as you stand at least
>> half a chance that those cards don't rely so heavily on a
>> peecee bios. Just my $.02.
>
>Even then, most frame buffer device drivers rely on the firmware (PC BIOS or
>SPARC/PPC Open Firmware) having set up the video card.
i have made vesa frame buffer & vga text console work for a pile of cards with 
x86emu code i posted days ago.but i think he want video-capable,that may leave
few candidates
>
>One of the exceptions is matroxfb, which is able to initialize older Matrox
>cards. This should cover all their PCI cards (Matrox didn't release any new PCI
>cards during the last few years).
It is expensive now:) I bought two G450pci last year,they are hard to find.
>
>Gr{oetje,eeting}s,
>
>						Geert
>
>--
>Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
>In personal conversations with technical people, I call myself a hacker. But
>when I'm talking to journalists I just say "programmer" or something like that.
>							    -- Linus Torvalds

= = = = = = = = = = = = = = = = = = = =
			

Best Regards
---------------------------------------
Zhang Fuxin
System Architecture Lab
Institute of Computing Technology
Chinese Academy of Sciences,China
http://www.ict.ac.cn
 
			　　　　　　　　　2002-05-27
