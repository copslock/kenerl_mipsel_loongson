Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4E9QVnC016071
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 14 May 2002 02:26:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4E9QUel016070
	for linux-mips-outgoing; Tue, 14 May 2002 02:26:30 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4E9QOnC016040
	for <linux-mips@oss.sgi.com>; Tue, 14 May 2002 02:26:24 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA03372
	for <linux-mips@oss.sgi.com>; Tue, 14 May 2002 02:26:33 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id LAA16262;
	Tue, 14 May 2002 11:15:05 +0200 (MET DST)
Date: Tue, 14 May 2002 11:15:04 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Robert Rusek <rrusek@teknuts.com>
cc: Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: dump/Restore issues on Indy
In-Reply-To: <C0F41630CD8B9C4680F2412914C1CF070164C9@WH-EXCHANGE1.AD.WEIDERPUB.COM>
Message-ID: <Pine.GSO.4.21.0205141114180.2438-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 13 May 2002, Robert Rusek wrote:
> I am having problems doing a restore after a dump.  The dump finishes
> without any problems.  I get an invalid header when doing a restore.
> When I use tar it works great so I know that it is not a hardware
> problem.  I have compiled the lates dump/restore and ef2progs.  

Probably not related to the problem, but using dump on Linux (>= 2.4.x) is
unsafe due to the way the buffer cache works.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
